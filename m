From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop making git-merge-recur
Date: Sun, 01 Oct 2006 21:41:13 -0700
Message-ID: <7vu02nz5w6.fsf@assigned-by-dhcp.cox.net>
References: <45207D32.8040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 06:41:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUFcW-0007ND-Qk
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 06:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWJBElQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 00:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWJBElQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 00:41:16 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49837 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932419AbWJBElP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 00:41:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002044114.OVYT12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 00:41:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VGh81V00o1kojtg0000000
	Mon, 02 Oct 2006 00:41:09 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <45207D32.8040300@gmail.com> (A. Large Angry's message of "Sun,
	01 Oct 2006 19:45:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28214>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Git-merge-recur is no longer installed and make clean no longer
> removes it, so creating making it.

Thanks for noticing.

The bug is actually not installing nor cleaning it.  People who
wanted to stay on the bleeding edge could add "-s recur" on the
command line, or have "merge.twohead = recur" in the config;
this is what we actually encouraged people for wider testing.
We do not suddenly break them.  I planned the removal for the
release after 1.4.3.

This should fix it -- could you eyeball it please?

-- >8 --
Makefile: install and clean merge-recur, still.

We advertised git-merge-recur for some time, and we planned to
support it for one release after we made it the 'recursive'.
However we forgot to install it nor have "make clean" clean it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/Makefile b/Makefile
index dd33158..401b893 100644
--- a/Makefile
+++ b/Makefile
@@ -215,7 +215,8 @@ BUILT_INS = \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
-ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
+ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) \
+	git-merge-recur$X
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
@@ -586,8 +587,7 @@ export prefix TAR INSTALL DESTDIR SHELL_
 
 ### Build rules
 
-all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi \
-	git-merge-recur$X
+all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
 
 all: perl/Makefile
 	$(MAKE) -C perl
