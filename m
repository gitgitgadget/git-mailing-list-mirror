From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin: t3200-branch.sh fails with "List form of pipe open not implemented at -e line 22."
Date: Sun, 16 Oct 2005 00:46:49 -0700
Message-ID: <7vbr1peweu.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
	<434FF189.3080806@zytor.com> <20051015211808.GA3497@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 09:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ER3En-0004LK-21
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVJPHq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVJPHq5
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 03:46:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4572 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751305AbVJPHq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 03:46:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016074625.SUHU11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Oct 2005 03:46:25 -0400
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10155>

Alex Riesen <raa.lkml@gmail.com> writes:

>> >The message comes from one of the hooks, which are executed even
>> >though they never meant to, because cygwin apparently uses file
>> >content or name to detect executability (on FAT).

Is this one of the hooks we ship as examples?  If so, that
means worse brokenness than just test failing.  It means that
the hook is not usable in your environment.

I presume it is this line in pre-commit sample hook:

    open $fh, "-|", qw(git-diff-index -p -M --cached HEAD);

Is Perl on Cygwin incapable of handle this in general, or is it
just what is on your machine being behind?

In the meantime, I've changed two things:

 - Earlier, tests run in a trash/ repository that was
   initialized with user's random templates.  This was *wrong*.
   It now uses freshly built templates that came from the
   source.

 - Further, hooks are disabled in the trash/ repository used for
   tests.  When we later add tests for hooks (HINTS, anybody
   ;-)), they can add their own anyway.
