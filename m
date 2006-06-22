From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 00:19:52 -0700
Message-ID: <7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 09:20:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJTo-0006cB-KG
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFVHTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWFVHTy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:19:54 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33270 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751090AbWFVHTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 03:19:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622071953.ZINY8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 03:19:53 -0400
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <0J1800MC1NKJD2C0@mxout2.netvision.net.il> (Yakov Lerner's
	message of "Thu, 22 Jun 2006 04:47 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22305>

Yakov Lerner <iler.ml@gmail.com> writes:

> Before this patch, -DDEFAULT_GIT_TEMPLATE_DIR was passed on compilation
> command line to all and every %c compiled. In fact the macro
> is used by only one .c file, and unused by all other .c files.
> Remove -DDEFAULT_GIT_TEMPLATE_DIR where unused. Follow the examlpe of 
> exec_cmd.o. Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used. 

Thanks.

By the way, I really started hating that we have $(GIT_VERSION)
in $(TRACK_CFLAGS).  Since the version string is tied to the
HEAD commit object name, having it in $(TRACK_CFLAGS) means that
every time I switch branches, make a new commit on top of the
current branch, or checkout-compile-and-then-make-local-change
sequence would force pretty much everything to be rebuilt.

Do you think of any downside if I remove it from the list of
symbols in TRACK_CFLAGS?

For that matter, I do not think tracking prefix_SQ makes much
sense since what matters are bindir, gitexecdir and template_dir
which are already covered, and prefix is merely a convenience to
set these three (four, counting GIT_PYTHON_DIR; we probably
should add it to TRACK_CFLAGS).

Thoughts?
