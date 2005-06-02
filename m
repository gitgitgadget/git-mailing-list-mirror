From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-log: cleanup line wrapping by using bash internals
Date: Thu, 02 Jun 2005 13:01:08 -0700
Message-ID: <7vacm834vv.fsf@assigned-by-dhcp.cox.net>
References: <20050602144621.GB16143@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 22:00:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddvpr-0005bF-RK
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFBUBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFBUBY
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 16:01:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22932 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261256AbVFBUBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 16:01:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602200109.JUOC26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 16:01:09 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050602144621.GB16143@diku.dk> (Jonas Fonseca's message of
 "Thu, 2 Jun 2005 16:46:21 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JF" == Jonas Fonseca <fonseca@diku.dk> writes:

JF> BTW, I noticed the following errors:

JF> 	fatal: internal error in diffcore: unmodified entry remains
JF> 	fatal: internal error in diffcore: unmodified entry remains
JF> 	fatal: internal error in diffcore: unmodified entry remains

JF> with both current cogito and git.

If you have acquired this fix and still see the above please let
me know.

Commit    67574c403f1e27660bbd0348b81b31adc9889b20
Author    Junio C Hamano <junkio@cox.net>, Wed Jun 1 11:38:07 2005 -0700
Committer Linus Torvalds <torvalds@ppc970.osdl.org>, Wed Jun 1 13:24:03 2005 -0700

[PATCH] diff: mode bits fixes

The core GIT repository has trees that record regular file mode
in 0664 instead of normalized 0644 pattern.  Comparing such a
tree with another tree that records the same file in 0644
pattern without content changes with git-diff-tree causes it to
feed otherwise unmodified pairs to the diff_change() routine,
which triggers a sanity check routine and barfs.  This patch
fixes the problem, along with the fix to another caller that
uses unnormalized mode bits to call diff_change() routine in a
similar way.

Without this patch, you will see "fatal error" from diff-tree
when you run git-deltafy-script on the core GIT repository
itself.

Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

