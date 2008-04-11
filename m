From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-bisect annoyances
Date: Fri, 11 Apr 2008 07:41:40 +0200
Message-ID: <200804110741.40732.chriscool@tuxfamily.org>
References: <20080409101428.GA2637@elte.hu> <20080410114739.GA15229@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Apr 11 07:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkBwg-00070X-SQ
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 07:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbYDKFgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 01:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYDKFgW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 01:36:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54054 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYDKFgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 01:36:20 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 842121AB2CD;
	Fri, 11 Apr 2008 07:36:18 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 15F641AB2C3;
	Fri, 11 Apr 2008 07:36:18 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080410114739.GA15229@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79264>

Le jeudi 10 avril 2008, Ingo Molnar a =E9crit :
> Ok, just in case i dont bore people with "stupid user" experiences an=
d
> logs of sessions of confusion, here's another session i just had with
> Git.

Thanks, this is very much appreciated.

> This time it's with our good friend git-bisect - which i thought to
> master pretty well and which i already used successfully to bisect
> kernel bugs up to a hundred times already (at least).
>
> The 'v' repository is a vanilla clone of Linus's upstream linux-2.6.g=
it
> kernel tree with no other modifications done to it.
>
>  dione:~> git-clone v linux-tmp4
>  Initialized empty Git repository in /home/mingo/linux-tmp4/.git/
>  0 blocks
>  Checking out files: 100% (23809/23809), done.
>  dione:~> cd linux-tmp4/
>  dione:~/linux-tmp4> ls
>  COPYING        MAINTAINERS     arch     fs       kernel  samples   u=
sr
>  CREDITS        Makefile        block    include  lib     scripts   v=
irt
>  Documentation  README          crypto   init     mm      security
>  Kbuild         REPORTING-BUGS  drivers  ipc      net     sound
>
>  #
>  # ok, so far so good. done this a thousand times before.
>  #
>  # Now lets check out v2.6.24 and check whether the bug i'm intereste=
d
>  # in triggers on v2.6.24. I dont create an extra branch for it, beca=
use
>  # this is pure temporary work, i use a plain git-checkout as a
>  # throwaway temporary branch:
>  #
>
>  dione:~/linux-tmp4> git-checkout v2.6.24
>  Note: moving to "v2.6.24" which isn't a local branch
>  If you want to create a new branch from this checkout, you may do so
>  (now or later) by using -b with the checkout command again. Example:
>    git checkout -b <new_branch_name>
>  HEAD is now at 4991408... Linux 2.6.24
>
>  #
>  # i build that kernel and boot it - the bug doesnt trigger - good.
>  # We've got all prerequisites for a bisection session - a 'good' ker=
nel
>  # [v2.6.24] and a 'bad' kernel [HEAD].
>  #
>  #
>
>  dione:~/linux-tmp4> git-bisect start
>  fatal: ref HEAD is not a symbolic ref
>  won't bisect on seeked tree

Yeah, it seems that this is a left over from cogito.=20
There has been some work on it lately but it seems not enough. See:

http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D0f497e75f05cd=
f0c0c1278eaba898cda6f118d71

>  #
>  # Hm. It's not a symbolic ref, and git-bisect just wont do it. Ok bu=
t
>  # then what, and what can the user do to progress? It should be rath=
er
>  # clear to Git what i'm intending to do here. I'm not interested in
>  # HEAD at all, i want to start bisection and i'll feed the good/bad
>  # points to git-bisect - once it lets me do that.
>  #
>  # Ok, lets see where we are:
>  #
>
>  dione:~/linux-tmp4> git-branch -a
>  * (no branch)
>    master
>    origin/HEAD
>    origin/master
>    origin/new_branch
>
>  #
>  # So perhaps this new, unnamed branch is what is causing the trouble=
?
>  # Lets try a specific branch then:
>  #
>
>  dione:~/linux-tmp4> git-checkout master
>  Previous HEAD position was 4991408... Linux 2.6.24
>  Switched to branch "master"
>
>  dione:~/linux-tmp4> git-bisect start
>  won't bisect on seeked tree

This seems to work for me with git 1.5.5 on the git tree:

$ git checkout master
Switched to branch "master"
Your branch is ahead of the tracked remote branch 'origin/master' by 4=20
commits.
$ git bisect start
$             =20

What git version do you have ?

>  #
>  # Hm, still no go. Lets see what git-bisect has to offer:
>  #
>
>  dione:~/linux-tmp4> git-bisect
>  Usage: /usr/bin/git-bisect
>  [start|bad|good|skip|next|reset|visualize|replay|log|run]
>
>  #
>  # Ah, it has a reset thing, lets try it:
>  #
>
>  dione:~/linux-tmp4> git-bisect reset
>  Note: moving to "49914084e797530d9baaf51df9eda77babc98fa8" which isn=
't a
>  local branch
>  If you want to create a new branch from this checkout, you may do so
>  (now or later) by using -b with the checkout command again. Example:
>    git checkout -b <new_branch_name>
>  HEAD is now at 4991408... Linux 2.6.24
>
>  dione:~/linux-tmp4> git-bisect start
>  fatal: ref HEAD is not a symbolic ref

This probably come from previous failures.

>  #
>  # hm, still no go. I'm not interested in a new branch at all, but i
>  # want to bisect, so lets try what was suggested then and name the
>  # branch:
>  #
>
>  dione:~/linux-tmp4> git-checkout -b tmp
>  Switched to a new branch "tmp"
>
>  #
>  # Looks good so far - can i bisect?
>  #
>
>  dione:~/linux-tmp4> git-bisect start
>  won't bisect on seeked tree

This too.

>  #
>  # Hm, still no go. Ok, lets forget this whole temporary branch thing
>  # that looked good and try a more pristine state:
>  #
>
>  dione:~/linux-tmp4> git-checkout -b tmp2 master
>  Previous HEAD position was 4991408... Linux 2.6.24
>  Switched to a new branch "tmp2"
>
>  dione:~/linux-tmp4> git-bisect start
>
>  #
>  # Halleluya! While i have typed much more than i wanted, and ended u=
p
>  # with two extra branches that i have to throw away, it seems to be
>  # working! Although the command printing nothing is not really
>  # reassuring - did it really do something?
>  #
>  # Ok, lets get the bisection going now:
>  #
>
>  dione:~/linux-tmp4> git-bisect good v2.6.24 bad HEAD
>  dione:~/linux-tmp4>

This is really bad, because, as you can see from the man page or "git=20
bisect -h" (see also the patch I just sent), "git bisect good" can take=
=20
many known good revisions:=20

git bisect good [<rev>...]
        mark <rev>... known-good revisions.

So you marked also "bad" and HEAD as "good".

This is really strange, because here I get for example:

$ git-bisect good bad HEAD
Bad rev input: bad HEAD

So you must have something tagged as "bad" or have a "bad" branch, and=20
that's why the command works for you but does the wrong thing.

If you wanted to do it all in one command you could have done:

$ git bisect start HEAD v2.6.24

That would have marked HEAD as "bad" and v2.6.24 as "good":

git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
        reset bisect state and start bisection.

>  #
>  # Hm, no indication about what happened, and no "middle" bisection
>  # point offered. No way to figure out what's wrong.

Right, we probably need to have at look at this more closely, maybe war=
n if=20
a "bad" or a "good" tag or branch exists or something like that.

>  # Ok, backtrack one more step - something's wrong here. Lets start
>  # again with a completely new tree:
>  #
>
>  dione:~> git-clone v linux-tmp5
>  Initialized empty Git repository in /home/mingo/linux-tmp5/.git/
>  0 blocks
>  Checking out files: 100% (23809/23809), done.
>  dione:~> cd linux-tmp5/
>  dione:~/linux-tmp5> git-checkout -b tmp master
>  Switched to a new branch "tmp"
>  dione:~/linux-tmp5> git-bisect start good v2.6.24

This marked "good" as "bad" and "v2.6.24" as "good".

Again this should "work" only if you have a "good" tag or branch in you=
r=20
repo.

>  dione:~/linux-tmp5> cd
>  dione:~> cd linux-tmp5/
>  dione:~/linux-tmp5> git-bisect start good v2.6.24 bad master

This marked "good" as "bad", and "v2.6.24", "bad" and "master" as "good=
".

>  dione:~/linux-tmp5>
>
>  #
>  # Hm, nothing. Ho hum. Do i suck this much? One more tree than i wan=
ted
>  # and three more branches that i wanted and still no bisection?
>  #
>  # Ah, i must have switched the arguments?
>  #
>
>  dione:~/linux-tmp5> git-bisect start v2.6.24 good master bad
>  won't bisect on seeked tree

This marked "v2.6.24" as "bad", and "good", "master" and "bad" as "good=
".
So it's wrong too.

>  #
>  # Nope.
>  #
>
>  dione:~/linux-tmp5> git-bisect visualize
>  You need to give me at least one good and one bad revisions.
>  (You can use "git bisect bad" and "git bisect good" for that.)
>  dione:~/linux-tmp5> git bisect bad HEAD
>  dione:~/linux-tmp5> git bisect good v2.6.24
>  Bisecting: -1 revisions left to test after this
>  [eb36f4fc019835cecf0788907f6cab774508087b] fix oops on rmmod capidrv

That's much better but you didn't "reset" or "start" again before givin=
g it=20
correctly the good and bad revs, so there are still some wrong left ove=
r=20
from your previous start above.

>  #
>  # -1 revisions left to test? Ouch ...
>  #
>  # But why did "git bisect" make a difference to "git-bisect" ?

It should not have made any difference.

>  # Lets see whether it's all from the same package:
>  #
>
>  dione:~> type git
>  git is hashed (/usr/bin/git)
>  dione:~> type git-bisect
>  git-bisect is hashed (/usr/bin/git-bisect)
>  dione:~> rpm -qf /usr/bin/git-bisect
>  git-core-1.5.4.3-2.fc8
>  dione:~> rpm -qf /usr/bin/git
>  git-core-1.5.4.3-2.fc8
>
>  #
>  # Yup, it is. 20 minutes spent on this already and no bisection.
>  # I really suck today :-)
>  #
>
>  #
>  # So i started suspecting my kernel and my hardware. Are timestamps
>  # maybe messed up and confusing Git? Since the commands dont return
>  # success nor failure i was unsure what Git thought about my attempt=
s.
>  #
>  # So i rebooted the box and created a new tree. No go.
>  #
>
>  #
>  # Just to be sure i also waited through a full git-fsck, only 10
>  # minutes runtime:
>  #
>
>  dione:~/linux-tmp4> git-fsck --full --strict
>  dangling commit f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed
>  dione:~/linux-tmp4>
>
>  #
>  # [ Sidenote #1: git-fsck is such a heavy operation that it should
>  #   really return some indication by default that it's all appears O=
K.
>  #   A user typically only runs git-fsck if in deep doubt about some
>  #   git detail - so while silence is often good for a comment, it's
>  #   counter-intuitive here. Especially since the "breakage" of
>  #   git-bisect is "silence" too, so the user is unable to trust thes=
e
>  #   different modal forms of silence and gets frustrated ... ]
>  #

I cannot comment on "git fsck" but I think it has nothing to do with=20
bisect "breakages".

>  #
>  # [ Sidenote #2: git-fsck --full --strict is slow and we always knew
>  #   this - it's a last-ditch thing for the truly hopeless. But this =
is
>  #   a 3.2 GHz quad box that is only 25% utilized during git-fsck but
>  #   takes 10 minutes to finish. Presumably git-fsck could run multip=
le
>  #   threads/tasks to be sped up? Making the slowest possible operati=
on
>  #   of a tool significantly faster is a good way to reduce user
>  #   frustration IMO. A user is already frustrated enough when he tri=
es
>  #   --full --strict. And i _bet_ a parallel version of git-fsck woul=
d
>  #   also be an fantastic bad-RAM checker ;-) ]
>  #
>
>  #
>  # Then, many other silly attempts later and at linux-tmp8, by chance=
 -
>  # 30 minutes down the line - i got it going:
>  #
>  # I updated my Linus tree on the (rather pathetic) theory that maybe=
 a
>  # specific layout of the repo breaks bisection - and that seems to h=
ave
>  # made a difference:
>  #
>
>  dione:~/linux-tmp8> git-checkout -b tmp2 master
>  Switched to a new branch "tmp2"
>  dione:~/linux-tmp8> git-bisect start
>  won't bisect on seeked tree
>  dione:~/linux-tmp8> git-bisect reset
>  Switched to branch "master"
>  dione:~/linux-tmp8> git-bisect bad master
>  You need to start by "git bisect start"
>  Do you want me to do it for you [Y/n]? Y
>  dione:~/linux-tmp8> git-bisect good v2.6.24
>  Bisecting: 6270 revisions left to test after this
>  [4814bdbd590e835ecec2d5e505165ec1c19796b2] [NETNS]: Lookup in FIB
>  semantic hashes taking into account the namespace.
>
>  #
>  # But i dont understand why.

I hope you understand better now.

>  #=A0Before updating Linus's tree i saved away=20
>  # the commit ID that showed the breakage, just in case it matters:
>  #
>
>  commit 7180c4c9e09888db0a188f729c96c6d7bd61fa83
>  Merge: 4c3b01f... 869ab51...
>  Author: Linus Torvalds <torvalds@linux-foundation.org>
>  Date:   Mon Apr 7 19:15:35 2008 -0700
>
>  #
>  # .. but couldnt reproduce this weirdness with specifically checking
>  # out 7180c4c9e09888db0a188f729c96c6d7bd61fa83. But i still have the
>  # linux-tmp4 repository that shows this behavior reliably. It's all
>  # quite weird. Either this repo is corrupted in some special way, or=
 my
>  # hardware has some really strange runtime failure, or i'm missing
>  # something very obvious ;-)
>  #
>
>  #
>  # One more minor sidenote. Git-bisect creates its own branch:
>  #
>
>  dione:~/linux-tmp12> git-branch -a
>  * bisect
>    master
>    tmp
>    tmp2
>    origin/HEAD
>    origin/master
>    origin/new_branch
>
>  #
>  # So i assumed that i could get rid of that 'bisect' branch by doing
>  # the obvious: "git-bisect stop", but no go:
>  #
>
>   dione:~/linux-tmp12> git-bisect stop
>   Usage: /usr/bin/git-bisect
> [start|bad|good|skip|next|reset|visualize|replay|log|run]
>
>  #
>  # After some experimentation "git-bisect reset" did the trick - but
>  # it's a bit counter-intuitive IMO, because the logical extension of
>  # 'start' is 'stop', and i often use 'git-bisect reset' to just rest=
art
>  # bisection anew. (it chimes in on 'restart')
>  #

"git bisect start" also does a "restart" if a bisect is already started=
=2E
But yes, we could add "stop" as a synonym for "reset" and "restart" as =
a=20
synonym for "start".

Thanks,
Christian.

>  #
>  # Ok, that's all for today. :-)
>  #
>
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
