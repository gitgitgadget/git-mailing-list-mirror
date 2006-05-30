From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 20:04:50 -0700
Message-ID: <7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 30 05:05:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkuXZ-0004NU-Ld
	for gcvg-git@gmane.org; Tue, 30 May 2006 05:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWE3DEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 23:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWE3DEx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 23:04:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61073 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750804AbWE3DEw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 23:04:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530030451.JEYZ15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 23:04:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605291739430.5623@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 May 2006 17:42:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21008>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 29 May 2006, Junio C Hamano wrote:
>> 
>> Sorry for having you have done this -- last night I've merged
>> the series without rebasing and have the result in "next".  I'll
>> compare to see if you have spotted my mismerges there tonight.
>
> It was interesting. I cleaned up the series and switched the order of some 
> commits in my tree by doing first a "git rebase" and then cherry-picking 
> them into another branch, and using "git commit --amend" to fix up some of 
> the things I had missed.

I just did this (readers on the list needs to disect "next" if
they are interested to reproduce this, since I do not publish
individual topic heads, but each of the merge commits on "next"
tells which topics are merged, so that should be trivial):

	$ git checkout -b lt/tree-2 master
        $ apply your 10-patch series
	$ git show-branch lt/tree lt/tree-2 jc/lt-tree-n-cache-tree next

Your yesterday's series is on lt/tree, and jc/lt-tree-n-cache-tree
is my "evil merge" branch to adjust it to the cache-tree that I had
in "next".  It's tip has cache-tree and lt/tree merged, so
it should match the early parts of today's 10-patch series.  I
used show-branch to find that lt/tree-2~5 is the one to match
yesterday's series:

	$ git diff --name-only lt/tree~4..lt/tree |
	  xargs git diff lt/tree-2~5 jc/lt-tree-n-cache-tree --

This shows only cosmetic differences, which is good.

> Pretty powerful, although at one point I was wondering about having a "git 
> rebase" that could switch commits around or drop unwanted ones (ie let the 
> user edit the cherry-picking list before the actual rebase).

I think true power users would just do the last two lines of
git-rebase.sh by hand in two steps.  By stashing away the
format-patch output, and using git-am interactively, you can
easily drop unwanted ones, and then re-run git-am on the same
format-patch output to apply the ones you dropped on the first
run practically amounts to reordering the patches ;-).
