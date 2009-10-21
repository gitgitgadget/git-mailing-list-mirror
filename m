From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 05:06:08 +0200
Message-ID: <20091021030608.GA18997@atjola.homenet>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 05:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0RWn-0002A4-O1
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 05:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbZJUDGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 23:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbZJUDGL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 23:06:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:40876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752892AbZJUDGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 23:06:09 -0400
Received: (qmail invoked by alias); 21 Oct 2009 03:06:12 -0000
Received: from i59F57083.versanet.de (EHLO atjola.homenet) [89.245.112.131]
  by mail.gmx.net (mp037) with SMTP; 21 Oct 2009 05:06:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX191rgoP00112nLgN5HKLazC+IOp9CoadgMcMMsq3n
	oklSpyi9AUoQhZ
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130879>

On 2009.10.20 19:56:01 -0400, Daniel Barkalow wrote:
> But I don't really know; are there IRC logs you can quote or referenc=
e=20
> with people making the mistake you're trying to help them avoid?

"git pull" is kind of a jack of all trades WRT user errors, so I'll jus=
t
pick up examples of all kinds, this might get long...

[If you read this and find out that you're quoted/referenced here: I
don't mean to blame or embarrass you, or to point out that you're stupi=
d
or whatever. Quite contrary, I just want to show how git's pull UI _mig=
ht_
be responsible for your mistakes. The comments I made are purely my,
possibly biased, reaction to what happened.]

That said, here we go:

1) Unexpected fast-forward even with --no-ff

"git pull --no-ff abc:abc" with "abc" being checked out.

As pull explicitly allows fetches into the checked out branch head, thi=
s
first fast-forwards abc, and updates the working tree/index. And then
the --no-ff merge is a no-op.

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-20#l2080
(Should be a catchable special case, and the special --update-head-ok
handling of "git pull" is from times where git didn't have remote
tracking branches. I'd argue that that support should be dropped or at
least disabled when you're using the modern setup, might be kept for
oldtimers still using .git/remotes/*. Dunno...)


2) "git pull" taken as "reset --hard"
git checkout -b foo; git pull origin bar

The user actually just wanted to look at things and thus was ok with:
git fetch origin; git checkout origin/bar

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-20#l1807
(user seemed to be so inclined to use "pull" that he initially didn't
even realize that he didn't want to merge when I asked whether that's
what he wants)


3) User expects "pull" to update all branch heads that have a configure=
d
upstream

08:31 	dimsuz 	hi guys! suppose i'm currently on master. then run git
		fetch. which delivers updates to master and other
		branches. I don't merge anything, but do checkout some
		branch (which is not master).  Question: will these new
		updates get into this branch automatically after i check
		it out? question2: will branch master contain those
		updates when i ckeck it out later?
08:32 	Circuitsoft 	dimsuz. After a fetch, no.
08:33 	Circuitsoft 	However, if you pull, any branches that were set
			up as local tracking branches will get updated.
08:33 	Circuitsoft 	Otherwise, only remote tracking branches will be
			updated.

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-20#l969
(No idea about that one, have seen that once before, but it's definitel=
y
not even remotely as common as the others)


4) User expects "pull" to create branches

07:25 	fynn 	Hey, I just pulled a branch from remote, and I don't see
		it in "git branch"
07:25 	doener 	fynn: if you "pull" that means "fetch this and merge it
		to what I have checked out"
07:25 	fynn 	doener: hm, I just did "git pull" and it showed the new
		branch
07:26 	fynn 	but I don't see it in my branches...
07:26 	fynn 	doener: should I create that branch as a tracking branch
		first?
07:26 	doener 	fynn: you're looking at "git branch -r" or "git branch
		-a", right?
07:26 	fynn 	doener: yeah, I'm seeing it in origin/foo, but not
		local.
07:26 	doener 	fynn: the "git fetch" should have created a remote
		tracking branch, as usual, not a local branch head
		(which would be shown by just "git branch")
07:27 	fynn 	doener: OK, what should I do to create it locally then?
07:28 	doener 	fynn: just the usual "git branch foo origin/foo", or to
		checkout at the same time: "git checkout -b foo
		origin/foo" or "git checkout -t origin/foo" (shortcut)

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-19#l830
(Note how my "fetch this and merge it" is actually inaccurate for just
"git pull", there is no "this" and that case. I took "pulled a branch"
to mean that he did "git pull <remote> <branch>", which wouldn't have
created/update the remote tracking branch [or did patches for that go
in? I lost track...])


4b) User expects pull to create a branch head

09:58 	araujo 	git pull origin <new_branch>
09:58 	araujo 	will get me the new branch from repo right?
10:00 	charon 	araujo: no, that will fetch *and merge* that branch
10:00 	araujo 	charon, how to just pull?

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-19#l1152
(Note how he asked "how to just pull?", even after being told that pull
isn't what he wants)


5) User possibly expecting "pull" to be able to act as "reset --hard"

21:01 	aidan 	What do I do about this: html/config/core.php: needs
		update
21:02 	aidan 	git pull (gives that)
21:02 	Ilari 	aidan: You have uncommitted changes to that file...
21:15 	aidan 	Ilari: how can I just pull master and overwrite any
		changes?

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-18#l2130
(I'm not sure about that one, "overwrite any changes" might mean "drop
uncommitted changes and merge" or "just get me the remote's state,
dropping my commits and uncommitted changes". Most of the time I've see=
n
similar requests, the user wanted the latter).


6) User says "pull" but probably means "fetch"

14:08 	Alien_Freak 	once I have a clone of a repo I know you can do
			a checkout tag but is there anyway to pull just
			the tag?

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-16#l1664
(There was no answer, thus it's hard to tell, but I guess he wanted
something like:
git init; git fetch --no-tags url tag <tag>; git checkout <tag>
At least I'm quite sure he didn't mean "pull" as in "git pull")


7) User expecting "pull" to just do fast-forwards (or so)

13:18 	ohadlevy 	I'm getting a merge commit message after each
			time i do git pull, i didnt have it before,
			where should I look?
13:20 	charon 	ohadlevy: pull merges; you may just have hit lucky so
		far, and always had a fast-forward merge
13:20 	ohadlevy 	charon: any way I could avoid these commits?
			just rebasing? its a pure RO repo

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-16#l1579
(Apparently, user was tricked by the fast-forward behaviour he
experienced earlier. I don't see any solution to this, except for
defaulting to fast-forward-only and requiring a --merge flag (which
might imply --no-ff), but I'm likely influenced by the "git update"
stuff here)


8) "reset --hard" again

20:10 	roger_padactor 	i commited then did a pull how do i get back to
			my commit. the pull over wrote the files
20:11 	merlin83 	roger_padactor: you can't, pull =3D=3D fetch + hard
			reset to latest commit

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-14#l2306
(Someone being told that pull is fetch + reset --hard is actually new t=
o
me. Only saw that as an expectation previously.)


9) More "git pull <remote> A:A"

19:10 	_hp_ 	another question, how do I add the remote branch to
		track so I don't have to constantly do git pull origin
		masterA:masterA ?
19:11 	Ilari 	_hp_: Don't use that src:dest with pull!
(discussion died)

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-12#l2427


10) "pull" mistaken for "cvs update"

07:25 	Avrem 	how do I use "git pull" to do something like what "cvs
		update" does ?
07:25 	Avrem 	which is, replaces files I've deleted
07:25 	Avrem 	from that from the central repository
07:30 	omega 	I'm not sure, but can't you git checkout <deleted files>
		to get them back?

http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-11#l545
(This adds a new twist to the "scm update" stuff, although svn/hg don't
seem to have "restore individual files" in their "update" command, so
this might be cvs-only. But it's so long since I used cvs, I don't even
know whether this is correct. But it somehow got me thinking about how
"update" is actually also "downgrade" in svn/hg, something git does via
"checkout" [which happens to make more sense to me]. And I think it
shows how "git pull" is taken to mean "update", even when ignoring the
special behaviour described here. It's not taken to mean "merge this",
but just "update to upstream").


So that's ten days of #git. I left out a bunch of duplications (most
were "pull =3D=3D fetch", "pull =3D=3D update" and "pull to update
non-checked-out branch").

Bj=F6rn
