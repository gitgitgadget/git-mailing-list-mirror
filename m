From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: svn user trying to recover from brain damage
Date: Wed, 9 May 2007 09:57:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705090856220.4062@woody.linux-foundation.org>
References: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua Ball <sciolizer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 18:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpU9-00012l-CF
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbXEIQ5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbXEIQ5r
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:57:47 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60063 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754305AbXEIQ5q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 12:57:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l49GvDfM027731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 09:57:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l49GvCR6028368;
	Wed, 9 May 2007 09:57:12 -0700
In-Reply-To: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
X-Spam-Status: No, hits=-2.982 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46749>



On Wed, 9 May 2007, Joshua Ball wrote:
> 
> What the heck do these terms mean?
> 
> HEAD
> HEAD REF

These are the same thing. HEAD is basically a special local branch, which 
usually (but not always) points to one of the local branches. I say 
"usually", because you *can* make it an independent branch in its own 
right, in which case you are using what is now called a "detached" HEAD.

But even when HEAD is "detached", and it's thus really an independent 
branch in its own right, it's still special: it's the branch that your 
current working tree is associated with.

So if you think of "HEAD" as just "current branch", you'll be in good 
shape.

> working tree

This is just your files - both untracked (ie you may be building stuff in 
the working tree) and tracked (ie the ones that git knows about).

It's *not* necessarily going to match the state that HEAD describes: HEAD 
describes the last *committed* state, while your working tree obviously 
can have changes to the tracked files (along with files that aren't 
tracked at all), but the working tree state is certainly _associated_ with 
HEAD, in that HEAD would point to the most recent commit that the working 
tree is all about.

> object

This is just an internal git term. It's how git stores all revision 
history information - as a set of objects in a content-addressable 
filesystem. As a pure user, you generally never need to worry about this 
term, although you might notice in the case you have corruption, and run 
"git fsck" and it starts talking about corrupt or missing objects.

> branch

A "branch" is just any "tip of development". It's *literally* defined by 
its name (which git doesn't care about, but you do), and the name of the 
top-most commit (the SHA1) of that developmet series. That SHA1 is all 
that git really cares about - the name is purely for your enjoyment and to 
clarify what the branch is about.

Git can track an arbitrary number of branches, but your working tree would 
be associated with just one of them, and HEAD points to that branch. The  
default branch is called "master", but that doesn't really have any 
special meaning per se, and as mentioned, HEAD might even be a detached 
branch and not associated with any "real" branch at all!

> merge

That's the act of bringing in the contents of another branch (possibly 
from an external repository) into your current branch. If you merge from 
something external, you need to "fetch" that other branch first, and the 
combination of "fetch+merge" is called a "pull".

It sounds like you may have never worked with branches before, in which 
case you can just ignore *all* of this. Git will set up one branch for you 
at "git init" time (the "master" branch) and you don't actually ever have 
to use any more than that one branch, in which case you can literally 
ignore everything about branches and merging.

> master

See above: it's just the default name of the initial branch. It has no 
other meaning - git itself doesn't care about branch names at all, and 
it's literally nothing more than a "default branch name".

> commit (as in the phrase "bring the working tree to a given commit")

Any development series is just a series of "commits". They point to the 
"parent" commit(s) and can thus form a series (or more generally a DAG: 
directed acyclic graph). 

So a "branch" is really just a named pointer to a commit, and that commit 
will in turn point to its parent commit, which will point to its parent 
etc. Which is why I started by explaining a branch as a "tip of 
development", because you'd see a branch as the top-most commit that it 
points to, and you'd normally *change* the branch by committing to it, 
which will create a new commit (and move the branch to point to it), and 
make that new commit point to the old commit as its parent.

One of the best ways to visualize this is probably to just do

 - clone git itself if you haven't already

	git clone git://git.kernel.org/pub/scm/git/git.git git

 - use "gitk" to see the commit history and see the branches as pointers 
   into that commit history. With "--all -d", it will show you all 
   branches, and the "-d" shows the commit history in date order, so while 
   it's a bit messier than the default cleaned-up format that tries to 
   show branches on their own, it's perhaps also a bit more instructive:

	gitk --all -d

In particular, you should see a commit that has both a green-boxed 
"master" pointer pointing to it, and a "remotes/origin/master" (colored in 
a mixed brown/green box). Those are examples of branches: the "master" 
branch is your local (and normally current) brach, while the 
"remotes/origin/master" thing is a so-called "remote branch", which means 
that you cannot check it out, but you can see it and you can update it by 
fetching new versions from the remote.

> Is there a difference between HEAD and the working tree?

Yes, see above.

> Does HEAD change when I cg-switch/git-checkout?

Yes. But it switches by making it point to a different branch, while 
something like "git reset" will *also* potentially change HEAD, but do so 
by still staying on the same branch, but making that branch "reset" (aka 
jump) to another point in history.

So you can literally change HEAD two fundamentally different ways:

 - by switching branches (which includes making HEAD be a detached branch 
   of its own)

 - by changing the state of the current branch (the most common form of 
   this is just "git commit" - it will update HEAD by creating a new 
   commit, but as mentioned, "git reset" can also do this by jumping 
   around in history, and that's how you'd undo work entirely, for 
   example).

> What is an object? Is it a set of patches? A tree snapshot?

An object is the lowest-level of git information. It's an indivisible and 
unchanging "thing", that can potentially point to other objects. You 
can kind of think of it as an "inode" in a UNIX filesystem, and like an 
inode, it can point to file data or be a directory (but unlike an inode, 
it's immutable by design, and it can also be a "commit" or a "tag" 
object).

So internally, git does have "tree snapshots" (not patches - git is 
*purely* based on snapshotting states of the project), but they are not a 
single object, they are built up from "tree objects" that point to other 
tree objects or to "blob objects".

And a commit is literally a "commit object" that points to the snapshot 
(the "tree object") that it's associated with, and the previous commits 
(the "parents") that build up the history.

> What the heck is a branch? (Why does it have so many different
> definitions? I feel like every time I come across "branch" in the man
> pages, it means something different.)

Ok, hope I clarified that.

> More on branches: The wiki says that a group of commits linked
> together form a DAG. Does that mean every fork/clone/branch-create
> possibly doubles the number of branches. So if I fork and then
> remerge, do I have two branches?

Yes and no. When you do a clone, you do get your totally own set of 
branches, but a branch is just a *pointer*. So it does _not_ duplicate 
history in any way, you do *not* get:

> A -> B -> D
> A -> C -> D

But instead you get

	A -> B -> C -> D

as commits, and you now have a new pointer to D.

So creating a branch *literally* just creates a new pointer.

In fact, you can still create a new branch manually by doing

	echo "sha1-of-branch-goes-here" > .git/refs/heads/my-new-branch

and that is how the git scripts literally used to do it (well, slightly 
simplified: verifying that the SHA1 is valid, and that the branch didn't 
already exist).

So the branch really *is* just a named commit.

> Would D be the head of this branch? If so, then heads do not uniquely
> identify a branch?

A branch uniquely identify a particular commit, but many branches can 
point to the same commit (and the branches are considered "identical" when 
they do that - you can have two different branches, but if they point to 
the same thing they are identical in all respectcs except for naming).

> Is there a standard revision notation? (Where my definition of
> "revision" is a tree snapshot. In SVN, it would be identified by a
> number.) `cg-diff -r A..B` works fine if A and B are branches, but how
> do I diff from an older revision to a newer revision? Can I diff
> between two revisions which haven't shared the same parent since 2006?

The "standard" revision notation is the SHA1 of the commit, but quite 
frankly, you'd never use it.

If you have two branches named A and B, you'd generate the diff with

	git diff A..B

and it doesn't matter if they share a parent since yesterday, since five 
years ago or whether they are related AT ALL. Git will happily diff 
totally unrelated branches (if you imported two tar-balls independently, 
they may not have any common history at all, but you may still want to 
diff them if they are from the same project!)

> What about the master branch? Is there anything special about it? By
> special I mean, do any of the git or cogito commands implicitly assume
> that you are working with master? If git is truly decentralized, then
> wouldn't master be on an equal footing with all other branches?

Correct. 

The only thing that is special about master is that it's the one that is 
created by "git init" (or "git clone", for that matter).

> What is a merge? My understanding of merge comes from the SVN book,

Forget SVN merges. SVN cannot do merges (SVN also cannot really do 
branches - what SVN calls branches is some abhorrent and stupid copy of a 
working tree with copying of the limited notion of history that SVN 
knows about).

> where it was described as diff+apply. Diff takes 2 arguments, and
> apply takes a 1 argument (if the patch is implicit). However, cg-merge
> only appears to take one branch. (There again a use of the word
> branch! Wouldn't commit or revision be a more accurate term?)

(You're likely better off using just "raw git" rather than cg these days, 
so I'll talk about "git merge").

A "git merge" actually does have two branches: the current one, aka HEAD, 
and the one you want to merge _into_ the current one.

So when you do

	git merge other-branch

it will merge 'other-branch' into the current branch (HEAD).

And no, it's not a "diff+apply" (although early and *very* broken versions 
of cg implemented the data part that way), it's a much more interesting 
operation that figures out the last common point from the history, and 
does a series of three-way merges (especially if there were *multiple* 
independent common history points), and then records the set of parents 
in the result.

That, btw, is why SVN cannot do merges. It really *does* do a fancy 
"diff+apply" that probably involves three-way operations too, but since it 
doesn't actually remember the resulting history, it cannot be considered a 
"merge". It didn't really merge the history - it just smushed the 
*contents* of two branches together, and then totally threw out all the 
really important bits.

> Lastly, the most important question of all, which may answer many of
> the questions above:
> 
> Can you fill in the missing pieces, making corrections where
> necessary? (recommend unispace font)
> 
> Command     |   Reads               |   Writes
> cg-fetch    | remote branch         | corresponding branch in local respository
> cg-commit   | working copy          | HEAD
> cg-update   | remote branch         | working copy AND HEAD
> cg-merge    | branch & working copy | working copy
> cg-diff     | arguments             | STDOUT
> cg-push     |                       | remote branch (usually origin)
> cg-pull     | remote branch         |
> cg-restore  |                       |

I'll use the git names (which are generally the same)

  Command	| reads			| writes
  --------------+-----------------------+-----------
  git fetch	| remote branch(es)	| local branch(es)
  git commit	| local data		| HEAD
  git pull	| remote branch(es)	| HEAD
  git merge	| local branch(es)	| HEAD
  git diff	| local data		|
  git push	| local branch(es)	| remote branch(es)
  git reset	| ---			| HEAD

and everything that writes HEAD implicitly will always also update the 
working tree too (with the obvious exception of "git commit" - since it's 
filling in the HEAD with the current state, it's obviously not going to 
update the working tree).

The "local data" is really a combination of "local branches, staging area 
and working tree": neither "git diff" and "git commit" really work purely 
on the working tree, they both will mix using the staging area, the 
working tree, and pure branch information depending on exact flags.

And note that most of the operations really can work on multiple branches 
(that's not true in cg). IOW, you can actually merge multiple branches in 
one go (the end result is called an "octopus merge", because it looks cool 
and has many "legs" when you see the merge history in a bottom-to-top kind 
of thing like gitk).

> On cg-fetch, is the remote branch necessarily remote? Or can you fetch
> from local

You can always consider the local tree to be a remote one: just use ".".

So

	git merge other-branch

is basically the same as

	git pull . other-branch

> cg-switch-branches? What does "corresponding branch in local
> repository" mean? Does cg-fetch touch your working copy?

Confusing cogito terminology.

The pure git stuff is actually clearer. And in git, you can specify what 
the "corresponding" branch is for any local branch. For example, if you 
just do the "git clone" of the git repository, then assuming you have a 
recent enough git, you can look into the ".git/config" file of the result, 
and you should see something like this:

	[remote "origin"]
		url = master.kernel.org:/pub/scm/git/git.git
		fetch = +refs/heads/*:refs/remotes/origin/*

	[branch "master"]
		remote = origin
		merge = refs/heads/master

which describes a remote repository ("origin") and tells you what branches 
should be fetched when you do a "git fetch origin", but it *also* 
describes the local branch "master", and says that when you do a "git 
pull", it should merge the *remote* branch "refs/heads/master" from 
"origin".

> What is the difference between cg-restore and cg-seek?

Don't use them. Cogito confusion.

			Linus
