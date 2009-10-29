From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 16/19] Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
Date: Thu, 29 Oct 2009 11:01:24 -0700
Message-ID: <1256839287-19016-17-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZLb-00051l-C9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZJ2SC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZJ2SC4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:56 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbZJ2SCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:45 -0400
Received: by mail-pz0-f188.google.com with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hzRRuhc+idBtXSzIxImFEREN1rb8EkLy9g+rnZ5+czk=;
        b=IY72CFwxoso6FWY/8181kbd2e1f15O6C84txG4iv/C265Ojx+fDbew+aZJFjMVwpuv
         WQSV8uKYUrdLITu3+lOAM0/vjCSN1RF0IS42zpuElX8FZgOuwLDBrypPSAHd3U6pR7aZ
         f4oX8JTgQXsyHjYxzMnCrAWG+PfU14IQmEXSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NJgbzWQ7hD3yQGaWMXAinURiugFp7DIwmb0q8SLG7smuLA/B3v4YVsvQhJ7hunQ6Ek
         WaMG9EIXbE3FeVEiuL6UzvoJw6+isqkINs1mmuU4AsHhvaLmwV3wxbGE/X2KFR3W1D7W
         M5DuhMXjyKcSz6BDeQaBgREXmC7dUJf+QlNyc=
Received: by 10.114.253.38 with SMTP id a38mr264394wai.113.1256839370184;
        Thu, 29 Oct 2009 11:02:50 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131633>

From: Johan Herland <johan@herland.net>

Junio discovered that the installed git-remote-cvs executable is unable
to find the installed git_remote_cvs Python package. This is due to the
'instlibdir' target of git_remote_cvs/Makefile being invoked with
insufficient arguments (prefix and DESTDIR). This patch fixes that.

Signed-off-by: Johan Herland <johan@herland.net>
---

	Unchanged.

 Makefile                |    2 +-
 git_remote_cvs/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a63f44d..9fb2747 100644
--- a/Makefile
+++ b/Makefile
@@ -1525,7 +1525,7 @@ endif # NO_PERL
 ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s --no-print-directory instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s --no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e '}' \
diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index 061c247..0d9eb31 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -28,7 +28,7 @@ install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
 
 instlibdir: $(pysetupfile)
-	@echo "$(prefix)/$(PYLIBDIR)"
+	@echo "$(DESTDIR_SQ)$(prefix)/$(PYLIBDIR)"
 
 clean:
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
-- 
1.6.5.2.291.gf76a3
