From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] git_remote_cvs: Use $(shell) in the Makefile
Date: Sun, 16 Aug 2009 14:25:08 -0700
Message-ID: <1250457908-27376-2-git-send-email-davvid@gmail.com>
References: <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
 <1250457908-27376-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, mhagger@alum.mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sun Aug 16 23:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McnEP-0007l4-Il
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbZHPVZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbZHPVZW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:25:22 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:44432 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958AbZHPVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:25:21 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so933681pxi.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=inC5fmWGnFFg9ALr2Z4ugvuNh5zNyZwytzsjWWoXHrQ=;
        b=EeLARCYT8CkgSlWr6qxixx6cAVjMkJqOYxzz9I3pGu3vJjSkAm8HMb01r2gIe+toLj
         fnt3MLSA41s/SI2QBF+PHM1Rb8+zaN9A5SpwjO39159AX9K8aDQenbRt6IDAGNPBYbNz
         IUTek/NbINhgja+OQD4owm/wOU1/XvypyKTi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uP4Zhmuy8mRaraWT9Kex2ncykV090we23OHL08DTvoIODP2L9uqnTL6RWb642nfQKT
         UvRt+a5kTrrkx/vvgqWbwpqPmgOXYj+bOSioy/yG3UaQjKT/8WGUXqzWI9QPxyRQYylc
         vlxGEyeJKgRL6Ddsw1mH3Tn9ZghFJAu7aHkrM=
Received: by 10.114.47.14 with SMTP id u14mr3927667wau.22.1250457923094;
        Sun, 16 Aug 2009 14:25:23 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l30sm8712626waf.0.2009.08.16.14.25.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 14:25:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.314.g034e1
In-Reply-To: <1250457908-27376-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126080>

This updates the git_remote_cvs Makefile to use the same
$(shell <cmd>) style used by the top-level git Makefile.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git_remote_cvs/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index 2e26dbe..061c247 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -17,15 +17,19 @@ ifndef V
 	QUIETSETUP = --quiet
 endif
 
-PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' % sys.version_info[:2]"`
+PYLIBDIR=$(shell $(PYTHON_PATH) -c \
+	 "import sys; \
+	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
 
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+
 install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
 
 instlibdir: $(pysetupfile)
 	@echo "$(prefix)/$(PYLIBDIR)"
+
 clean:
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
 	$(RM) *.pyo *.pyc
-- 
1.6.4.314.g034e1
