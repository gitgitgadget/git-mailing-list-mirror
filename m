From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and post-update hooks
Date: Sat, 07 Oct 2006 22:00:32 -0700
Message-ID: <7v64evpfkf.fsf@assigned-by-dhcp.cox.net>
References: <20061008000808.1128.36962.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 07:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWQmD-0006T6-1z
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 07:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWJHFAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 01:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWJHFAe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 01:00:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50390 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWJHFAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 01:00:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008050033.MHAE22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 01:00:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xh0Q1V00P1kojtg0000000
	Sun, 08 Oct 2006 01:00:24 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061008000808.1128.36962.stgit@machine.or.cz> (Petr Baudis's
	message of "Sun, 08 Oct 2006 02:08:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28521>

Petr Baudis <pasky@suse.cz> writes:

> Someone raised a concern that the update and post-update hooks are not
> invoked at fetch time in the similar way as they are invoked at push
> time, and the idea sort of makes sense. But this patch goes further - it
> makes Git invoke those hooks each time a ref is updated in a repository
> using the git-update-ref command, which I believe makes a lot of sense as
> well - the behaviour is consistent with the current pushing behaviour
> and you suddenly finally get a hook where you can properly notify even
> about fast-forwards etc.

In principle I do not have problem with this approach per-se,
but I wonder if we were to do this we might want to make
receive-pack.c::update() and cmd_update_ref() call the same
underlying function, and make that underlying function implement
this "ask the hook if updating is ok" dance.  It might even make
sense to have update-ref honor deny_non_fast_forwards for that
matter (I am mildly doubtful of this last point, though).
