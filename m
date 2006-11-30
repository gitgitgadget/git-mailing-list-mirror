X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS22107 204.16.104.0/24
X-Spam-Status: No, score=0.3 required=3.0 tests=AWL,BAYES_00,
	MSGID_FROM_MTA_HEADER shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Path: news.gmane.org!not-for-mail
From: Michael Haggerty <mhagger@alum.mit.edu>
Newsgroups: gmane.comp.version-control.subversion.cvs2svn.devel,gmane.comp.version-control.git
Subject: Re: Some tips for doing a CVS importer
Date: Thu, 30 Nov 2006 01:35:18 +0100
Message-ID: <456E2746.4050707@alum.mit.edu>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456ACAF3.1050608@alum.mit.edu> <456AD137.8060209@bluegap.ch> <456B61FE.7060100@alum.mit.edu> <456C5363.6040409@bluegap.ch>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060008090705040906010407"
X-Trace: sea.gmane.org 1164846949 20409 80.91.229.2 (30 Nov 2006 00:35:49 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 30 Nov 2006 00:35:49 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        dev@cvs2svn.tigris.org, Shawn Pearce <spearce@spearce.org>
Original-X-From: dev-return-1878-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Nov 30 01:35:44 2006
Return-path: <dev-return-1878-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GpZtj-0003fb-E8
	for gcvscd-dev@gmane.org; Thu, 30 Nov 2006 01:35:32 +0100
Received: (qmail 30971 invoked by uid 5000); 30 Nov 2006 00:35:29 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Received: (qmail 30961 invoked from network); 30 Nov 2006 00:35:28 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAHq2bUXAbSoIh2dsb2JhbACMbQEBCQ4q
X-IronPort-AV: i="4.09,476,1157353200"; 
   d="sh'?scan'208"; a="37802536:sNHT24000424"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061117 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Markus Schiltknecht <markus@bluegap.ch>
In-Reply-To: <456C5363.6040409@bluegap.ch>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Xref: news.gmane.org gmane.comp.version-control.subversion.cvs2svn.devel:1843 gmane.comp.version-control.git:32689
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32689>
X-Mailing-List: git@vger.kernel.org

--------------060008090705040906010407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Markus Schiltknecht wrote:
> Michael Haggerty wrote:
>> This is the part that can get quite expensive for large repositories, as
>> there can be orders of magnitude more symbol creations than revisions.
>> According to Daniel Jacobowitz:
>>
>>> [...] at one point I believe the GCC repository was gaining up
>>> to four tags a day (head, two supported release branches, and one
>>> vendor branch).  I've been using the principal that the number of tags
>>> might be unworkable, but the number of branches generally is not.
>>
>> This means that the number of tag events is O(number-of-days *
>> total-number-of-files-in-repo), where the gcc repo has about 50000
>> files.  By contrast, only a small fraction of files is typically touched
>> in any day.
> 
> Yeah, 50'000 * 1825 (5 years) * say 100 bytes -> 8GB  sounds like a lot.
> OTOH, I certainly don't need 100 bytes per tag and one tag per day over
> five years is really a lot. Repositories that large are probably not
> converted to CVS on an old Pentium III...

...times 4 (tags per day) -> 32GB.  If I understand correctly, the tags
were created nightly by automated scripts.

I admit that this is an extreme example, but the philosophy of the
cvs2svn project (a philosophy that I inherited from my predecessors, by
the way) is to be able to handle the most absurd repositories out there.

> Well, almost. I meant a whole repository with these branches. If one
> file included all the branches it's getting easy to resolve. But for my
> example, I had something like that in mind:

I am glad that we are getting into concrete examples.  But your example
needs some clarifications (see below).

> fileA:
> 
> A = 1.2.2
> (no changes for branch B)
> C = 1.2.4      --> makes A a possible parent of branch C

In this case, ROOT can also be C's parent.

> D = 1.2.2.5.2  --> makes A a possible parent of branch D

This implies that A is *necessarily* the parent of D.  If there were a
E=1.2.2.5.4, then the parent of E would be ambiguous but the parent of D
would still unambiguously be A.

> X = 1.2.4      --> makes C a possible parent of tag X

Wait a minute.  A tag always has an even number of integers.  Do you
mean X=1.2 or X=1.2.4.1?  The same below.

> fileB:
> 
> A = 1.2.2
> B = 1.2.4      --> makes A a possible parent of branch B

or ROOT

> C = 1.2.6      --> makes B a possible parent of branch C

or A or ROOT

> D = 1.2.2.5.2  --> makes A a possible parent of branch D

A is unambiguously the parent of D

> X = 1.2.2.5.2  --> makes D a possible parent of tag X
>
> fileC:
> A = 1.2.2
> X = 1.2.2      --> makes A a possible parent of tag X
> 
> fileD:
> A = 1.2.2
> B = 1.2.4
> X = 1.2.4      --> makes B a possible parent of tag X
> 
>>> The symbol blob for branch A: has only one possible parent: ROOT. Thus I
>>> assign A->parent_branch = ROOT.
>>>
>>> Next comes the blob for branch C: it has two possible parents: branch B
>>> and branch A.
>>
>> Why is ROOT not considered as a possible parent of C?
> 
> Those were just examples. In my CVS-repository-in-mind, none of the
> files were branching from ROOT directly into C.

In your example, ROOT *is* a possible parent of C.

>>> At that point we know that A is derived from ROOT, but we
>>> don't have assigned a parent to B, yet. Thus we can not resolve C this
>>> time.
>>>
>>> Then comes branch B: one parent: A. Mark it.

In your example, ROOT is also a possible parent of B.

>>> Next round, we process C again: this time, we know B is branched from A.
>>> Thus we can remove the possible parent A. Leaving only one possible
>>> parent branch: B.
>>
>> But the fact that B preceded C chronologically does not mean that C is
>> derived from B.
> 
> No. And I don't assume so in any place. Given the files above, I can
> however clearly say that C got branched off from B, no?

No.  C is nowhere unambiguously derived from B, therefore its parent
could be ROOT, A, or B.  See my example below.

>> If I branch from ROOT or A after creating branch B, the
>> result as stored in CVS looks exactly the same as if I branch from B
>> (unless a file was modified between the creation of the parent branch
>> and the creation of the child branch).
> 
> Sure. That would result in an unresolvable symbol.
> 
>>> Now, say we have a tag 'X', which ended up in a blob having A, B, C and
>>> D as possible parent branches. I currently remove A and B, as they are
>>> parents of C. But C and D still remain and conflict. I'm unable to
>>> resolve that symbol. I'm thinking about leaving such conflicts to the
>>> user to resolve.

I don't know how to deal with tag X because the numbers that you
assigned to it above can't be correct.


Consider the attached script.  It unambiguously creates branches A1 and
A2 from ROOT and branch B from A1, then adds tag X on branch B.  But in
the files:

fileA symbols
        X:1.1
        B:1.1.0.6
        A2:1.1.0.4
        A1:1.1.0.2;

fileB symbols
        X:1.1.2.1
        B:1.1.2.1.0.2
        A2:1.1.0.4
        A1:1.1.0.2;

fileC symbols
        X:1.1.6.1
        B:1.1.0.6
        A2:1.1.0.4
        A1:1.1.0.2;

fileD symbols
        X:1.1
        B:1.1.0.4
        A2:1.2.0.2
        A1:1.1.0.2;

Note that from looking at fileA alone, there is no way to tell whether
A2 was created from ROOT or A1, or whether B was created from ROOT, A1,
or A2.  And tag X is all over the place, even though for each file it
was created from branch B.

If only information from fileA,v is considered, any of the following
branching topologies would give identical fileA,v contents:

      ROOT
      /|\
     / | \
    A1 A2 B


      ROOT
      / \
     /   \
    A1   A2
    |
    B


      ROOT
      / \
     /   \
    A1   A2
          |
          B


      ROOT
      / \
     /   \
    A1    B
    |
    A2


      ROOT
       |
       A1
      / \
     /   \
    A2    B


      ROOT
       |
       A1
       |
       A2
       |
       B

And from the information present in fileA,v, it is not possible to tell
whether tag X was applied to ROOT, A1, A2, or B.

(Some topologies *are* ruled out because the revision numbers are
ordered incorrectly; for example:

      ROOT
       |
       B
      / \
     /   \
    A1   A2

      ROOT
       |
       A2
       |
       A1
       |
       B

are not consistent with fileA,v.)

If we also consider the information in fileB, it is clear that branch
B's parent is branch A1, but it is still not clear whether branch A2's
parent is ROOT or A1, or whether tag X was applied to branch A1, A2, or B.

Similarly, fileC,v tells us that tag X was applied to branch B, and
fileD,v tells us that A2's parent is ROOT.

Each file alone is quite ambiguous, but in this case putting the
information from all files together (with the assumption that they have
a mutually-consistent history) is enough to reconstruct the entire
branching topology.

What's worse in real life?  Each file rules out some possible histories
and the goal is to find a history that is consistent with all files.  But...

- There can easily be cases where even the total information from all
files is still not enough to choose a unique history.  In such cases we
need a way to select between the possible histories.

- Since files in CVS don't necessarily *have* a globally consistent
branching/tagging history, heuristics have to be used in such cases to
find histories that apply to subsets of the repository in some
reasonable way (i.e., the one that is most likely considering the way
people typically work with CVS).

- "Unlabeled branches": often users have removed the label from a
branch, but the branch is still used as a source for other branches.
Figuring out this situation is a real mess.

I imagine that the best results (never mind whether it is practical)
would be obtained by recording the topology constraints implied by each
*,v file, then trying to map the topologies onto each other pair by pair
to (1) combine the constraints and thereby limit the possible histories
and (2) deduce which unlabeled branches correspond to one another.  But
I still don't know how to deal with inconsistent histories.  I think a
bottom-up approach would be the most sensible, given that people are
probably more likely to tag a whole subdirectory rather than files
scattered here and there.

The second step is to decide at what point in time a branch or tag
should be created, with the goal of being able to create it as a
snapshot of the source branch at that moment.  This is not always
possible, even if the branch topologies are compatible.

Michael


--------------060008090705040906010407
Content-Type: application/x-shellscript;
 name="makerepo.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="makerepo.sh"

IyEgL2Jpbi9zaAoKQ1ZTUk9PVD1gcHdkYC9jdnMKZXhwb3J0IENWU1JPT1QKCmN2cyBpbml0
CgpjdnMgY28gLWQgd2MgLgpjZCB3YwoKbWtkaXIgZGlyCmN2cyBhZGQgZGlyCmN2cyBjb21t
aXQgLW0gJ0FkZGluZyBkaXInCgpjZCBkaXIKCmVjaG8gJzEuMScgPmZpbGVBCmVjaG8gJzEu
MScgPmZpbGVCCmVjaG8gJzEuMScgPmZpbGVDCmVjaG8gJzEuMScgPmZpbGVECgpjdnMgYWRk
IGZpbGVBIGZpbGVCIGZpbGVDIGZpbGVECmN2cyBjb21taXQgLW0gJ2luaXRpYWwgdmVyc2lv
bnMnCgpjdnMgdGFnIC1iIEExCgplY2hvICcxLjInID5maWxlRApjdnMgY29tbWl0IC1tICdy
ZXZpc2lvbiAxLjIgb2YgZmlsZUEnCgpjdnMgdGFnIC1iIEEyCgojIFN3aXRjaCB0byBicmFu
Y2ggIkExIjoKY3ZzIHVwZGF0ZSAtciBBMQoKZWNobyAnMS4xLjIuMScgPmZpbGVCCmN2cyBj
b21taXQgLW0gJ3JldmlzaW9uIDEuMS4yLjEgb2YgZmlsZUInCgojIENyZWF0ZSBicmFuY2gg
IkIiIGFuZCBzd2l0Y2ggdG8gYnJhbmNoOgpjdnMgdGFnIC1iIEIKY3ZzIHVwZGF0ZSAtciBC
CgplY2hvICcxLjEuMi4xLjIuMScgPmZpbGVDCmN2cyBjb21taXQgLW0gJ3JldmlzaW9uIDEu
MS4yLjEuMi4xIG9mIGZpbGVDJwoKY3ZzIHRhZyBYCgo=

--------------060008090705040906010407--

