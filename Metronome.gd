extends MarginContainer

onready var bpmDisplay = $VerticalBox/BpmContainer/BPM
onready var slider = $VerticalBox/BpmControl/BpmSlider
onready var less = $VerticalBox/BpmControl/Less
onready var more = $VerticalBox/BpmControl/More
onready var timer = $MetronomeTimer
onready var playBtn = $VerticalBox/Control/Play
onready var pauseBtn = $VerticalBox/PauseControl/Pause
onready var msgDisplay = $VerticalBox/Message

var bpm = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bpm = slider.value
	bpmDisplay.text = str(bpm)
	setMessage()
	
	slider.connect("value_changed", self, "onSliderChanged")
	less.connect("pressed", self, "less")
	more.connect("pressed", self, "more")
	timer.connect("timeout", self, "click")
	playBtn.connect("pressed", self, "play")
	pauseBtn.connect("pressed", self, "pause")

func onSliderChanged(value):
	bpm = slider.value
	bpmDisplay.text = str(bpm)
	
	timer.wait_time = 60 / bpm
	
	setMessage()

func less():
	bpm = bpm - 1
	slider.value = bpm
	bpmDisplay.text = str(bpm)
	
	timer.wait_time = 60 / bpm
	
	setMessage()

func more():
	bpm = bpm + 1
	slider.value = bpm
	bpmDisplay.text = str(bpm)
	
	timer.wait_time = 60 / bpm
	
	setMessage()

func setMessage():
	if bpm <= 40:
		msgDisplay.text = "slow and solemn"
	elif bpm <= 45:
		msgDisplay.text = "slowly"
	elif bpm <= 50:
		msgDisplay.text = "broady"
	elif bpm <= 65:
		msgDisplay.text = "slow and stately"
	elif bpm <= 70:
		msgDisplay.text = "rather slow"
	elif bpm <= 80:
		msgDisplay.text = "at a walking pace"
	elif bpm <= 100:
		msgDisplay.text = "moderately"
	elif bpm <= 110:
		msgDisplay.text = "moderaely fast"
	elif bpm <= 130:
		msgDisplay.text = "fast, quickly and bright"
	elif bpm <= 140:
		msgDisplay.text = "lively"
	elif bpm <= 180:
		msgDisplay.text = "very fast"
	else:
		msgDisplay.text = "out of this world"

func click():
	$Click.play()

func play():
	timer.start()

func pause():
	timer.stop()
