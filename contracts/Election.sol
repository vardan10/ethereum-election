pragma solidity ^0.4.2;

contract Election{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that vote
    mapping(address => bool) public voters;

    // Fetch candidate
    mapping(uint => Candidate) public Candidates;

    // Store candidate count
    uint public CandidatesCount;
    
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    event votedEvent (
        uint indexed _candidateId
    );

    function addCandidate(string _name) public{
        CandidatesCount++;
        Candidates[CandidatesCount] = Candidate(CandidatesCount,_name,0);
    }

    function vote(uint _candidateId) public{
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= CandidatesCount);

        voters[msg.sender] = true;
        Candidates[_candidateId].voteCount++;

        emit votedEvent(_candidateId);
    }
}