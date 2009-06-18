From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify the git-branch documentation of default start-point
Date: Thu, 18 Jun 2009 00:33:39 -0700
Message-ID: <7v63eu0ze4.fsf@alter.siamese.dyndns.org>
References: <1245303673.24201.3.camel@localhost.localdomain>
	<7vprd2148u.fsf@alter.siamese.dyndns.org>
	<1245305061.24201.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHC88-000264-AA
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbZFRHdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 03:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZFRHdi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:33:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64630 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZFRHdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:33:37 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618073340.HLZN18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 18 Jun 2009 03:33:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 5KZf1c00A4aMwMQ04KZfYL; Thu, 18 Jun 2009 03:33:39 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=pSkz-GRO83QA:10 a=pGLkceISAAAA:8
 a=rFl6U_VTcRl2gK-pkKAA:9 a=iLQ4e-BNfQaAj6_h7TgA:7
 a=Z2C77R04QAjtIYYo0c_NPoZSqNoA:4 a=jhgndwU2KtcA:10 a=MSl-tDqOz04A:10
 a=UoY_LbphyI2PwWXv:21 a=45651JotvDQY2Wpn:21
X-CM-Score: 0.00
In-Reply-To: <1245305061.24201.12.camel@localhost.localdomain> (Martin Nordholts's message of "Thu\, 18 Jun 2009 08\:04\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121799>

Martin Nordholts <enselic@gmail.com> writes:

> On Wed, 2009-06-17 at 22:48 -0700, Junio C Hamano wrote:
>> Martin Nordholts <enselic@gmail.com> writes:
>> 
>> > -	is omitted, the current branch is assumed.
>> > +	is omitted, the current branch is assumed.  Note that checking
>> > +	out a remote branch does not make it the current branch.  If a
>> > +	remote branch is desired as start-point it must be an explicity
>> > +	specified.
>> 
>> [...] "it" in the second new sentence is unclear.
>> 
>> You probably wanted to answer "If I wanted to have _my own 'next' branch_
>> that tracks 'next' from the remote, what should I do?"
>
> What I am trying to clarify is that a remote branch will never be the
> default for the start-point argument to git-branch, so if someone wants
> a remote branch as start-point, then the branch must be explicitly
> specified.

Because I misread your updated documentation, somehow I thought you were
talking about "checkout -b".  Sorry for getting confused (and perhaps
giving a confusing answer).

There are two concepts you seem to be confused about: <start-point> and
branch tracking.

<start-point>, the term being explained in the part your patch touched, is
only about what commit the newly created branch points at.  In git, a
branch is a label that attaches to an existing commit [*1*].  The form
was originally:

	git branch <branchname> [<start-point>]

which is very straight-forward.  The branch is created and points at the
commit your HEAD points at.  The description was later changed to "the
current branch" in order to cater to new people who can easily be confused
by the mention of HEAD, hoping that new people, while they are prone to
confusion about "HEAD", won't be dealing with detached HEAD.

Much later, --track was tacked on, but this is a very different concept.
A branch you are creating can be marked to always merge from another
branch (be it local or remote).  The branch creation command syntax
conflates these two different concepts, because they are often used
together.

It is incorrect to say that <start-point> needs to be explicitly spelled
out.  You can detach HEAD to point at the tip of a remote branch, and then
say "git branch new" to create a branch "new".

	git checkout origin/next
        git branch new

It will start that branch at the tip of the remote branch (which points at
the same commit as your HEAD points at).

The resulting "new" branch won't be tracking the remote branch (iow, you
are correct if you said that a remote branch won't be tracked without
being named).  But the branch still starts at the commit HEAD points at,
which is the same as the one at the tip of the remote branch in the above
example.

In git, a branch is a label that attaches to an existing commit [*1*] and
because of that, you cannot go from a commit to a branch (a commit can be
part of any number of branches).  Detached HEAD points only at a commit
without being associated with any particular branch, either local or
remote.  And because you cannot go from a commit to a branch, "git branch
new" can start the new branch at the correct commit, but it cannot make it
track the remote branch you detached your HEAD at.

I think _you_ understand all of the above, but because you (and probably
the documentation updates made after --track was introduced) are confused
about the two distinct concepts, the patch talks about the detached HEAD
in the description of <start-point>, which is _not_ affected by the
detachedness of the HEAD.  What needs clarification is --tracked part.

Perhaps the attached patch may be an improvement.

But having to explain "checking out anything but a local branch will make
you not on _any_ branch" (possibly repeating my explanation above as well)
every time we say "this command uses the current branch in this way" feels
very wrong.  The description should make it clear what we mean by "the
current branch" --- and things like "when your HEAD is detached, you are
not on any branch and by definition you do not have 'the current branch'"
should be best left in the introductory "concepts" document that is a
required reading before the reader goes to descriptions of individual
commands.

This is a tangent, not directly related to your patch, but I see that the
conflation between start-point and branch tracking made some things very
cumbersome to do.

Suppose you came up with a neat idea, and wanted to experiment first,
because you did not know if the idea will pan out.  You detach at my
'next', hack a while, and ended up with something wonderful.  Because you
do not want to lose the work you did, you create a branch there:

	git checkout origin/next ;# detach!
        hack hack; git commit
        git branch my-hack-on-next

The start point of the new branch is the commit you recorded your hacks
with.  And it does not track origin/next, as detached HEAD is not
associated with any particular branch.  But as far as I can see, there is
no easy way to retroactively mark this new branch _track_ origin/next,
short of doing the "git config" yourself.

[Footnote]

*1* Technically speaking, there is an exception.  Immediately after "git
init" in an empty repository, HEAD says you are _on_ master branch that
does not exist yet.

-- >8 --

 Documentation/git-branch.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ae201de..8033506 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -113,8 +113,11 @@ OPTIONS
 
 -t::
 --track::
-	When creating a new branch, set up configuration to mark the
-	start-point branch as "upstream" from the new branch. This
+	When creating a new branch starting from <start-point> that is
+	explicitly given by naming an existing branch, or implicitly
+	starting at the current branch (i.e. you cannot be on a detached
+	HEAD for the latter to take effect), set up configuration to mark
+	another branch as "upstream" for the newly created branch.  The
 	configuration will tell git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
@@ -146,9 +149,9 @@ start-point is either a local or remote branch.
 	may restrict the characters allowed in a branch name.
 
 <start-point>::
-	The new branch will be created with a HEAD equal to this.  It may
+	The new branch will be created to point at this commit.  It may
 	be given as a branch name, a commit-id, or a tag.  If this option
-	is omitted, the current branch is assumed.
+	is omitted, HEAD is assumed.
 
 <oldbranch>::
 	The name of an existing branch to rename.
