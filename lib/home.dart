import 'package:flutter/material.dart';

import 'answer.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionarioIndex = 0;
  int _temaIndex = 0;
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool buttonDisabled = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      _scoreTracker.add(
        answerScore
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.clear, color: Colors.red),
      );
      //Fim do quiz
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
    });
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  void _perguntaAnterior() {
    setState(() {
      _questionIndex--;
    });
  }

  final _questions = const [
    {
      'question': 'How long is New Zealands Ninety Mile Beach?',
      'answers': [
        {'answerText': '88km, so 55 miles long.', 'score': true},
        {'answerText': '55km, so 34 miles long.', 'score': false},
        {'answerText': '90km, so 56 miles long.', 'score': false},
      ],
    },
    {
      'question':
          'In which month does the German festival of Oktoberfest mostly take place?',
      'answers': [
        {'answerText': 'January', 'score': false},
        {'answerText': 'October', 'score': false},
        {'answerText': 'September', 'score': true},
      ],
    },
    {
      'question': 'Who composed the music for Sonic the Hedgehog 3?',
      'answers': [
        {'answerText': 'Britney Spears', 'score': false},
        {'answerText': 'Timbaland', 'score': false},
        {'answerText': 'Michael Jackson', 'score': true},
      ],
    },
    {
      'question':
          'In Georgia (the state), it’s illegal to eat what with a fork?',
      'answers': [
        {'answerText': 'Hamburgers', 'score': false},
        {'answerText': 'Fried chicken', 'score': true},
        {'answerText': 'Pizza', 'score': false},
      ],
    },
    {
      'question':
          'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
      'answers': [
        {'answerText': 'His tongue', 'score': true},
        {'answerText': 'His leg', 'score': false},
        {'answerText': 'His butt', 'score': false},
      ],
    },
    {
      'question': 'In which country are Panama hats made?',
      'answers': [
        {'answerText': 'Ecuador', 'score': true},
        {'answerText': 'Panama (duh)', 'score': false},
        {'answerText': 'Portugal', 'score': false},
      ],
    },
    {
      'question': 'From which country do French fries originate?',
      'answers': [
        {'answerText': 'Belgium', 'score': true},
        {'answerText': 'France (duh)', 'score': false},
        {'answerText': 'Switzerland', 'score': false},
      ],
    },
    {
      'question': 'Which sea creature has three hearts?',
      'answers': [
        {'answerText': 'Great White Sharks', 'score': false},
        {'answerText': 'Killer Whales', 'score': false},
        {'answerText': 'The Octopus', 'score': true},
      ],
    },
    {
      'question': 'Which European country eats the most chocolate per capita?',
      'answers': [
        {'answerText': 'Belgium', 'score': false},
        {'answerText': 'The Netherlands', 'score': false},
        {'answerText': 'Switzerland', 'score': true},
      ],
    },
    {
      'question': 'Which European country eats the most chocolate per capita?',
      'answers': [
        {'answerText': 'Belgium', 'score': false},
        {'answerText': 'The Netherlands', 'score': false},
        {'answerText': 'Switzerland', 'score': true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Quiz',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              if (_scoreTracker.length == 0)
                SizedBox(
                  height: 25.0,
                ),
              if (_scoreTracker.length > 0) ..._scoreTracker
            ],
          ),
          Container(
            width: double.infinity,
            height: 130.0,
            margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                _questions[_questionIndex]['question'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ...(_questions[_questionIndex]['answers']
                  as List<Map<String, Object>>)
              .map(
            (answer) => Answer(
              answerText: answer['answerText'],
              answerColor: answerWasSelected
                  ? answer['score']
                      ? Colors.green
                      : Colors.red
                  : null,
              answerTap: () {
                if (answerWasSelected) {
                  return;
                }
                _questionAnswered(answer['score']);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40)),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Por favor, Selecione uma resposta !')));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Reiniciar Quiz' : 'Próxima')),
          SizedBox(
            height: 5.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40)),
              onPressed: () {
                if (_questionIndex > 0) {
                  _perguntaAnterior();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Essa é a primeira pergunta !')));
                }
              },
              child: Text('Anterior')),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              '${_totalScore.toString()}/${_questions.length}',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          if (answerWasSelected && !endOfQuiz)
            Container(
              height: 50,
              width: double.infinity,
              color: correctAnswerSelected ? Colors.green : Colors.red,
              child: Center(
                child: Text(
                  correctAnswerSelected ? 'Muito bem !' : 'Errou !',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          if (endOfQuiz)
            Container(
                height: 50,
                width: double.infinity,
                color: Color.fromARGB(255, 250, 239, 239),
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Parabéns ! ' + 'Sua nota final é ${_totalScore} !'
                        : 'Sua nota final é ${_totalScore} !',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ))
        ],
      )),
    );
  }
}
