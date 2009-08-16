From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/2] git_remote_cvs: Honor DESTDIR in the Makefile
Date: Sun, 16 Aug 2009 14:25:07 -0700
Message-ID: <1250457908-27376-1-git-send-email-davvid@gmail.com>
References: <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, mhagger@alum.mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sun Aug 16 23:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McnED-0007dq-FT
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbZHPVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbZHPVZP
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:25:15 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:44432 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZHPVZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:25:14 -0400
Received: by pxi34 with SMTP id 34so933681pxi.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h6KuDLUUZARFxtybA9fy7VGenZuFMQqgodT4HD9XIPw=;
        b=aJr3IKazUhCQUDqnl9yqsGCrV/ZvjwWV+bSyhQg9msGGfD8DMpN1PrbD23mw94yyv1
         d+2zdVBwQ7H/wZtnAE02jpRV4HLmKEOx8nHpytCOozSWmPyOY1mnegbQXq0iHADzYBEt
         SAIRL20+81VFNBK88YDy8IutiBusdKaZUqH1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I9XVmopVa1jyRc9lTyWURQ8WIpMr7iHZWg9RH/o0Qzn1QrVUWzTrrF+Auf+uF0EtPm
         wgtxcpzTRVuSL4ie2aiqgj8Hmex+/uUCsf0RINHK01I7ozXeVypapB5mkaRxArgPnsFA
         24xaYdUE/uotRD56idird06RhG8S1J3n0CQHo=
Received: by 10.115.116.14 with SMTP id t14mr3755514wam.208.1250457915806;
        Sun, 16 Aug 2009 14:25:15 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m6sm2404885wag.68.2009.08.16.14.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.314.g034e1
In-Reply-To: <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126079>

This modifies the setup.py invocation so that user-defined
DESTDIRs are taken into account.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

setup.py gets confused if we use --root like in v1 of this patch.
I think this is simpler.  Thoughts?

 git_remote_cvs/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index 8dbf3fa..2e26dbe 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -3,6 +3,9 @@
 #
 pysetupfile:=setup.py
 
+# Shell quote (do not use $(call) to accommodate ancient setups);
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
@@ -19,7 +22,8 @@ PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' %
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
 install: $(pysetupfile)
-	$(PYTHON_PATH) $(pysetupfile) install --prefix $(prefix)
+	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
+
 instlibdir: $(pysetupfile)
 	@echo "$(prefix)/$(PYLIBDIR)"
 clean:
-- 
1.6.4.314.g034e1
