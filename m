From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin: t3200-branch.sh fails with "List form of pipe open not implemented at -e line 22."
Date: Fri, 14 Oct 2005 09:09:04 -0700
Message-ID: <7vpsq8rsgv.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 18:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQS7L-0000vu-E7
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 18:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJNQJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 12:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVJNQJH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 12:09:07 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22472 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750777AbVJNQJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 12:09:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014160855.MMHO9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 12:08:55 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
	(Alex Riesen's message of "Fri, 14 Oct 2005 14:46:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10111>

Alex Riesen <raa.lkml@gmail.com> writes:

> Now, how broken is that:
>
> The message comes from one of the hooks, which are executed even
> though they never meant to, because cygwin apparently uses file
> content or name to detect executability (on FAT).
>
> I just remove the hooks from repositories atm.

Ah, that indeed is broken.

We probably should fix it at two levels.

Unless a test is trying to make sure the hook mechanism works, I
think we should not have them in the t/trash/ test repository.
The initial git-init-db done at the end of t/test-lib.sh should
be changed to run with an explicit --template= parameter to not
copy templates from random places.  If somebody is going to do
this and supply a tested patch to me, it will also be nice to
add tests to specifically check the hook mechanism while she is
at it.

I think the original idea of using executable bit to control
whether the hook is enabled or not is still sound, but it may be
safer to have hooks in templates to have a suffix such as
.sample in their names *and* be executable --- the set of hooks
copied from default templates are still disabled, but now
instead of asking users to "chmod +x foo-hook", we ask them to
"mv foo-hook.sample foo-hook" if she wants to enable it.
