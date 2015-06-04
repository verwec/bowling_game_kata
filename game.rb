describe 'the bowling game' do
  let(:g) { Game.new }

  it 'rolls' do
    g.roll(0)
  end

  it 'rolls a gutter game' do
    roll_many(20, 0)
    expect(g.score).to eq(0)
  end

  it 'rolls all ones' do
    roll_many(20, 1)
    expect(g.score).to eq(20)
  end

  it 'rolls a spare' do
    g.roll(5)
    g.roll(5)
    g.roll(3)
    roll_many(17, 0)
    expect(g.score).to eq(16)
  end

  it 'rolls a strike' do
    g.roll(10)
    g.roll(3)
    g.roll(4)
    roll_many(16, 0)
    expect(g.score).to eq(24)
  end

  def roll_many(n, pins)
    n.times { g.roll(pins) }
  end
end

class Game

  def initialize
    @score = 0
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    score = 0
    frame = 0
    i = 0
    while frame < 10
      if strike?(i)
        score += count_strike(i)
        i+= 1
      elsif spare?(i)
        score += count_spare(i)
        i+= 2
      else
        score += count_frame(i)
      i+= 2
      end
      frame += 1
    end
    score
  end

  def count_frame(i)
    @rolls[i] + @rolls[i+1]
  end

  def count_spare(i)
    10 + @rolls[i+2]
  end

  def count_strike(i)
    10 + @rolls[i+1] + @rolls[i+2]
  end

  def strike?(i)
    @rolls[i] == 10
  end

  def spare?(i)
    @rolls[i] + @rolls[i+1] == 10
  end
end
