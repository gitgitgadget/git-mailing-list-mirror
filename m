From: Tommi Virtanen <tv@eagain.net>
Subject: [PATCH] "git shell" won't work, need "git-shell"
Date: Sun, 24 Aug 2008 23:23:25 +0300
Message-ID: <20080824202325.GA14930@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 22:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMIm-0002aP-Sx
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYHXUeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYHXUeB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:34:01 -0400
Received: from eagain.net ([208.78.102.120]:57556 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYHXUeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:34:00 -0400
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Aug 2008 16:34:00 EDT
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id F31391EC039;
	Sun, 24 Aug 2008 20:23:26 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 3FB3B508695; Sun, 24 Aug 2008 23:23:25 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93562>

>From 8e7935231e8a91d470b3a4a2310803031ef49fc4 Mon Sep 17 00:00:00 2001
From: Tommi Virtanen <tv@eagain.net>
Date: Sun, 24 Aug 2008 23:20:33 +0300
Subject: [PATCH] Install git-shell in bindir, again.

/etc/passwd shell field must be something execable, you can't enter
"/usr/bin/git shell" there. git-shell must be present as a separate
executable, or it is useless.

Signed-off-by: Tommi Virtanen <tv@eagain.net>
---

Hi. Recent changes moved away from "git-foo" to "git foo", except for
some commands that needed backwards compatibility. However, git-shell
as a separate binary was removed. I hope you will reinstante git-shell
as a publicly visible binary in bin. Here's why:

The shell field in /etc/passwd is *exec*ed, not interpreted via sh -c
or some such. For example, source of Debian's shadow, containing
/bin/login:

libmisc/shell.c:80:	execle (file, arg, (char *) 0, envp);

I also tested this for real, and having a

test:x:1001:1001:,,,:/home/test:/usr/bin/git-shell

line works, and

test:x:1001:1001:,,,:/home/test:/usr/bin/git shell

just makes ssh loop asking for a password, logging

"User test not allowed because shell /usr/bin/git shell does not exist"

So, as far as I understand, as it currently is, "git shell" is utterly
useless for what it was meant to do. Restoring "git-shell" will fix
it.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..24d5809 100644
--- a/Makefile
+++ b/Makefile
@@ -1351,7 +1351,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
-- 
1.6.0.2.g2ebc0.dirty

-- 
:(){ :|:&};:
