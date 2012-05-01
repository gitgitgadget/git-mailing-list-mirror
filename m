From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 14:05:05 -0700
Message-ID: <86mx5rmx32.fsf@red.stonehenge.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKG4-0005zB-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab2EAVFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:05:09 -0400
Received: from lax-gw15.mailroute.net ([199.89.0.115]:39651 "EHLO
	gw15.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab2EAVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:05:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 4F555E362FA;
	Tue,  1 May 2012 21:05:08 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw15.lax01.mailroute.net ([199.89.0.115])
	by localhost (gw15.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id 4U2J4eNwoK3k; Tue,  1 May 2012 21:05:06 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id B2BB5E36287;
	Tue,  1 May 2012 21:05:06 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id A7CD0132C; Tue,  1 May 2012 14:05:05 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.6; tzolkin = 4 Cimi; haab = 9 Uo
In-Reply-To: <4FA04D02.6090702@palm.com> (Rich Pixley's message of "Tue, 01
	May 2012 13:52:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196750>

>>>>> "Rich" == Rich Pixley <rich.pixley@palm.com> writes:

Rich> I want to be able to fetch changes to the branch I currently have checked out.
Rich> Git blocks this because it doesn't know how to cope with the working directory
Rich> in that situation.

It does?  I can always "git fetch origin" in my repo, and the remote
branches are in "origin/master, origin/foo, origin/bar".  Totally
separate from my working tree.

If I want to *examine* them, I can make a WIP commit, or use "git
stash", and then check them out headless:

  git stash save
  git checkout origin/master
  ## examine
  ## now go back
  git checkout master
  git stash pop

and now I can see what the upstream looks like.  Or just diff them:

  git diff ..origin/master

Rich>   Merging is straightforward. Even updating, (checkout), is fairly
Rich> straightforward.  But the insistence on a single tip means that if
Rich> I commit directly to a non-tip commit, git doesn't know what to do
Rich> with the branch pointer.  If it leaves it at my commit, then the
Rich> other changes are essentially orphaned. If it leaves it at the
Rich> other changes, then my commit is essentially orphaned.  While it's
Rich> probably possible to force git to do this anyway, including
Rich> orphaning one set of changes, doing so is of limited value since
Rich> the git interface makes the assumption that branches have a single
Rich> tip anyway.

So, make a set of related names for your branches.  It's better with
names anyway.

Rich> Pushing is blocked in git.  Git simply refuses some push requests
Rich> which have obvious and fairly straightforward semantics.

 git push master:from-merlyn/master

And now someone can look at "from-merlyn/master", and know that it's
from me, and related to master, and either incorporate it into the real
master, or cherry-pick from it, or whatever.  Solved.

Rich> You and I want to share a branch and we each have local,
Rich> unattended cache/mirror repositories that we would like to use to
Rich> pass data between us.  This doesn't work in git because the first
Rich> time you and I make simultaneous changes, whether they collide or
Rich> not, the unattended repositories become wedged.  They each refuse
Rich> to talk to the other until someone manually unwedges them.

No, you do it like above.  Some *person* has to sign off the merge each
time.  But we can share the unmerged changeset through other branches.

Rich> I want that if you and say, Sitaram commit conflicting changes to
Rich> a shared branch, it's easy for me to recognize that the conflict
Rich> exist and easy for me to resolve that conflict in my own
Rich> repository.  I want the source code control system to keep track
Rich> of those things, show them to me/us, and to track and show my
Rich> resolution to you.  This stuff should all be automatic.  It
Rich> shouldn't require explicit testing, manual pulling, nor explicit
Rich> discussion between the three of us.  It shouldn't prohibit that
Rich> either, but it shouldn't require it.

You're asking a lot of an automated system.  I think you're trying to
get a system to replace the communication you should be doing as a
developer.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
