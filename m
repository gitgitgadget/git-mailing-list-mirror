From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 16:20:59 -0700
Message-ID: <7vbqtx4kv8.fsf@assigned-by-dhcp.cox.net>
References: <20060516055815.GA4572@c165.ib.student.liu.se>
	<7vhd3qebuv.fsf@assigned-by-dhcp.cox.net>
	<20060516065452.GA5540@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0605160821570.3866@g5.osdl.org>
	<Pine.LNX.4.64.0605160906150.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 01:21:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8qm-0001mJ-Ky
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWEPXVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWEPXVB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:21:01 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8190 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932206AbWEPXVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 19:21:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516232100.NJDD27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 19:21:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20148>

Linus Torvalds <torvalds@osdl.org> writes:

>  - In contrast, for git (current master branch), the numbers are 35 out of 
>    540, and there are lots of merges with many LCA's:
>
>     505 o
>      15 oo
>      13 ooo
>       2 oooo
>       3 ooooo
>       2 ooooooo
>
> I think the difference is that Junio does a lot of these branches where he 
> keeps on pulling from them, and never syncs back (which is a great 
> workflow). In contrast, the kernel tends to try to avoid that because the 
> history gets messy enough as it is ;)
>
> Anyway, the two commits that apparently have seven (!) LCA's in the git 
> tree should probably be checked out. They are probably a good thing to see 
> if git-merge-base really _really_ does the right thing, and whether they 
> really are true LCA's.
>
> They are commits ad0b46bf.. and e6a933bd.. respectively.

The first one is because at 1.3.0 I pulled everything from
"next" to "master".

Usually "next" incorporates topic branches that stem from
different commits on "master", and when a new topic is merged to
"next", it gets the updates to "master" up to that point along
with the new topic.  When topics graduate (i.e. merged back) to
"master", they do so at different pace.


      topic2          o---o---o---o---H---.
                     /                 \   \
      next   -----------o---o---E---o---I-------B
                   /   /       /             \   \
      topic1      /   /   o---D---.           \   \
                 /   /   /         \           \   \
      master ---G---o---C---o---o---F---o---o---A---X

The above illustration shows that two topics branched from
master were cooked in next.  Topic 1 branched from master at C,
added two commits (its tip is at D), merged to next at E and
then later merged to master at F.  Similarly, topic 2 branched
from master at G, added five commits (its tip is at H), merged
to next at I and then later merged to master at A.

When merging "next" into "master" by merging A and B to produce
X, tips of topics 1 and 2 (D and H, respectively) become the
merge base.

Merging "next" wholesale to "master" is hopefully a rare event,
but the seven bases you are seeing are the topic tips.

The other one is the other way around.  From time to time,
"next" itself gets updates from "master" to keep it in sync with
fixes that occurred on "master" directly.  Such a merge into
"next" will have this picture but the principles are the same.

      topic2          o---o---o---o---H---.
                     /                 \   \
      next   -----------o---o---E---o---I-------B---Y
                   /   /       /             \     /
      topic1      /   /   o---D---.           \   /
                 /   /   /         \           \ /
      master ---G---o---C---o---o---F---o---o---A
