From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Fri, 02 Dec 2005 00:25:00 -0800
Message-ID: <7v8xv39a8z.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
	<7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 09:26:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei6E7-00058Y-HT
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 09:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVLBIZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 03:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLBIZE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 03:25:04 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13263 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932329AbVLBIZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 03:25:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202082413.MKNY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 03:24:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslte1y5z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 Nov 2005 21:51:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13104>

Junio C Hamano <junkio@cox.net> writes:

>  2. merge-one-file leaves unmerged index entries.
>
> Regarding #2, in an earlier message you said something about
> "patch to do that was just broken" which I did not understand; I
> think your patch I am replying to is doing the right thing.  That
> case arm is dealing with a path that exists in "our" branch and
> the working tree blob should be the same as recorded in the
> HEAD, so I did not have to do the unpack-cat-chmod like I did in
> mine.  Am I simply confused?

The only difference is that, from the old tradition, we are
supposed to allow the merge to happen in an unchecked-out
working tree [*1*].  The version you did and I merged in the
master branch breaks that, while the patch I posted keeps that
premise.

I can throw in my change on top of what is already commited for
now to "fix" this, but do we still care about the "merge should
succeed in an unchecked-out working tree" rule, or does it not
matter anymore these days?

One thing is that the check with "git diff" to show diff between
half-merged and stage2 after a failed merge does not work very
well in a sparsely checked out working tree, because the real
change is buried among tons of deletes ("diff --diff-filter=UM"
helps, though [*2*]).

[Footnote]

*1* ... and that is why we special case a non-existent working
tree file as if it is clean with the index.  After a merge, you
would end up with a sparsely checked-out working tree that
contains only the files that were involved in the merge.

*2* Maybe --diff-filter should always include U in the output,
because it is rare and when an unmerged entry exists the user
would always want to see it.
