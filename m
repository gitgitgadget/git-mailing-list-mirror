From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git  --  how to revert build to as-originally-cloned?
Date: Fri, 20 May 2011 12:16:27 +1000
Message-ID: <SNT124-W51D709B129B6A940ED17F2C4710@phx.gbl>
References: <4DD44DCD.7010508@hotmail.com>
 <SNT124-W3827431D13C320A4C9BF9DC48F0@phx.gbl>,<4DD536EC.3060308@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: <johnlumby@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 04:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNFGX-0001rx-WC
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 04:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420Ab1ETCQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 22:16:32 -0400
Received: from snt0-omc1-s12.snt0.hotmail.com ([65.55.90.23]:27957 "EHLO
	snt0-omc1-s12.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756734Ab1ETCQb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 22:16:31 -0400
Received: from SNT124-W51 ([65.55.90.8]) by snt0-omc1-s12.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 19 May 2011 19:16:30 -0700
X-Originating-IP: [27.32.25.138]
Importance: Normal
In-Reply-To: <4DD536EC.3060308@hotmail.com>
X-OriginalArrivalTime: 20 May 2011 02:16:30.0994 (UTC) FILETIME=[EED67F20:01CC1693]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174033>


I think I'll just give a brief answer to each of your points, then give
you a wall of text at the end.


> From: johnlumby@hotmail.com
> On 05/18/11 19:26, Tim Mazid wrote:
> > Normally in order to undo a merge, you would simply do a "git reset
> > --hard HEAD^". Take note of the carat(is that correct?) character; =
that
> > means the commit BEFORE head.

HEAD points at the commit where you are checked out now.
The carat character '^' tells git to look at the commit BEFORE the one=20
that's specified.
See below.


> > Can you please post the commit message that you see in the first co=
mmit
> > when doing a git log?
>
> Here are the first three. I assume (not sure) they are what was merge=
d
> into the newer clone, /b, just before I cloned it
>
> ---------------------------------------------------------------------=
---------
> commit 89c64d755fbf04d7541d526931dc4b38301946d1
> Merge branch 'master' of
> master.kernel.org:/pub/scm/linux/kernel/git/jkirsher/net-next-2.6
>
> commit 4dc6ec26fe7d9f89349d4c0c654e2f07420f4b27
> Merge branch 'batman-adv/next' of
> git://git.open-mesh.org/ecsv/linux-merge
>
> commit 5c5095494fb545f53b80cbb7539679a10a3472a6
> ---------------------------------------------------------------------=
---------

You actually skipped the message of the third message there. :P

But I can see that the first two are actually merges. Were they both=20
your doing? If so, doing a git reset --hard HEAD^ will only take you
back one commit.
See above, and then below.


> So I now think I see the problem with using a reset based on somethin=
g
> relating to commits -
> apparently (??) there is nothing in the git log to distinguish commit=
s
> done by my last merge versus commits prior to that. I.e. the "merge"
> does not appear to be logged as an event in its own right, only as th=
e
> commits inside it??

Two points:
=A0- in git, you have commits and "pointers to commits"; and
=A0- the commit itself IS the merge.
See below.


> > Also, if you just want to go back to a particular branch, you can
> > specify it to git reset, in the form of "git reset --hard
> > origin/master". This will reset (discarding any changes) YOUR branc=
h to
> > wherever origin/master happens to be, which, from reading your mess=
age
> > seems to be where you want to go?
>
> Ah - that did it, thanks Tim. I had seen that one but wasn't
> sure whether it would reset me back to what I cloned or the master of
> that clone i.e. way back to the "original" origin of this build.
>
> It seems if I had not created a separate branch -- I would now be
> completely sunk?

Your branches are completely separate to the branches of other repos.
See below.


> It would be nice if there was a "git undo" which undid whatever chang=
es
> to files+index were made by the immediately preceding git command,
> whatever it was and whatever it did.

I believe (speculation) that the reason this hasn't been done is that
there are too many things you can _DO_ in git in order to have a simple
"undo" button. Compare it to having an "undo" button in real life; what
and how much would it actually undo? There are simply too many differen=
t
situations to have something as simple as undo.
Having said that, there are ways to recover from almost every situation
in git (most of which I'm yet to learn). See below.


> > Be careful if you have made changes you want to keep, though.
> No worries there although thanks for the warning.

I've lost data a few times not thinking about what I was doing. :P


Alright, so I promised you a crack at an explanation. List, please feel
free to chime in and correct me where I am mistaken.

All changes that you make to your repository are stored in what are
called "commits"; these are, essentially diffs, and point to "parent"
and "child" commits, so that you can trace a path along commits and see
your code change along the way.

Now, branches and tags are actually "pointers to commits"[*] in a way.
A branch or a tag in itself does not actually contain any changes or
code.=A0 When you reference a branch or tag, you're actually referencin=
g
the commit that they point to.

When you create a tag, you give it a commit that it should point to (if
you do not provide a commit, it actually defaults to where you are now)=
,
and then the tag never changes. This is why it is useful for
"tagging"[*] releases. You put it there and it will stay there so that
other people can see it. In this way, it is permanent[*] (unless you
really want to delete it).

Branches, however, are different; whenever you checkout a branch,
whatever you do, whether it may be resetting, creating new commits, or
merges, the branch follows you around, such that it records your action=
s
as being part of that branch. So a branch will "flow"[*] over time as
you add more code. Thus, branches are semi-permanent[*], as the commits
they point to change, but they stay in the "past" of the branch.

Things like HEAD and FETCH_HEAD are similar in that they too "point at
commits", but unlike branches (which are semi-permanent) and tags (whic=
h
are permanent), they are temporary. HEAD moves around; a _lot_. What
HEAD really does is point to the commit that you are checked out on.
Whenever you switch branches, move around, make commits, merges, and
whatever else, HEAD keeps changing to point at the commit you are now
on, whether it be a previously existing one, or a newly created one.

So, in your repository, you have branches, and tags, and a bunch of
temporary pointers, such as HEAD. So does everybody else. How do you
tell which is which?

Well, that is why when I told you to git reset, I told you to tell it t=
o
point to "origin/master". What that means is the pointer named "master"
on the remote repository called "origin". (More on remote repositories
later). If you had said "git reset --hard master" it actually would hav=
e
reset you to _your_ master branch. If you were already checked out on
master, you would've gone nowhere.

So, "git reset --hard branch-name" takes whatever branch you're on, and
makes it point to the same place as branch-name, which exists in your
local repository.
As a corollary, "git reset --hard remote-name/branch-name" takes the
branch you're on, and makes it point to the same place as branch-name o=
n
the _remote_ repository named remote-name. (More on remote repositories
shortly).

If you were to do, however, "git reset --hard HEAD", you don't actually
move to anywhere; but what it does do, because you've supplied the
"--hard" option, is *discards* _all_ changes made from the commit that
HEAD points at. This means that if you have made any changes, but have
not committed them, they will be lost.
This is useful if you made some changes which you decide you don't need=
,
or if you were merely testing something in your code. But use it with
caution, as you will _all_ changes; so if you made some changes, but
decided you didn't want to keep some, commit what you want to keep
first.

But what if you did a merge or already committed some changes, and want
to undo that? Well, that is where the modifiers[*] come in. The one
you've already been introduced to is the carat character (^). What this
actually means is point to the commit _before_ the one referenced.
So, saying HEAD^ means the commit before HEAD. And because merges are
actually commits, you can easily undo a merge by going to the commit
just before it.
You can also chain carats together; HEAD^^^ means the commit *three*
before where HEAD points.
You can also use carats for other commit references[*], such as branche=
s
and tags. Want to go to the commit just before v1.0 (for whatever
reason)? No problem. Just do a "git checkout v1.0^".

But, what if you want to go to the commit ten or twenty before v1.0? Th=
e
first thing I would say is that is far too specific without actually
knowing where you're going and you should reconsider your strategy.
However, if that is what you wish to do, you could easily stack twenty
carats together.
You can see that this would be very unwieldy; that is
why git provides us with another modifier: the tilde (~). You must
always follow the tilde with a number. What it says is that you want to
go X commits before the referenced one. So, "git checkout v1.0~17" will
take you to the commit *17* before v1.0.

I said before that that you have your local repository and the remote
repository. You can actually have any number of remote repositories
referenced. Initially, though, the only remote repository you have is
the one where you checked out from (unless you created a clean repo
yourself).
You can add and remove remote repositories through the "git remote"
command.

You were afraid about not creating a branch and being sunk. The
important thing to realise is that whatever you do in _your_ repository
does not affect the _remote_ repository. The information in the remote
repository will stay there until _they_ decide to change it. So the onl=
y
way for you to affect the remote repository is for them to take what yo=
u
did and apply it to their repository.

Secondly, even given that, your remote pointers (the origin/* pointers)
cannot be changed by you. All you can do is remove them (you can add
them back at any point; this is not a loss) and synchronise[*] them wit=
h
the remote, if they've changed there.

This means that no matter what you did, unless you actually deleted the
origin/master remote branch (which you could easily get back anyway),
the "git reset --hard origin/master" command will always take you back
to your happy place, or, more correctly, where the remote was pointing
its master branch to when you last synchronised.

You can view all the remote branches you can reference by using the "gi=
t
branch -r" command, without any arguments. You can also view all your
local branches by using "git branch" (without the -r). It works
similarly for "git tag".

I hope I've covered everything you wanted. If not, there are plenty of
resources, and you can always ask here.

It also helps to visualise these things, and there are several tools
that help you in this regard. The first is "git log --graph", which wil=
l
show you lines on the side, showing you how commits are connected.
Then, there are a number of external programs. I personally use gitk,
but I know there are others, if it doesn't suit your tastes.


And have a read through the documentation. You probably won't
understand most of it the first time, but the more you read it, the mor=
e
you'll understand.


Good luck,
Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  