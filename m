From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] build: add NO_INSTALL variable
Date: Fri, 24 May 2013 21:41:05 -0500
Message-ID: <1369449666-18879-6-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Rq-0000Of-Hg
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab3EYCnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:43:01 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:37625 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3EYCm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:59 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so6969890oag.37
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M1vFKw7z93u/9zHrPLvjUntzCPHYsA5OFdmD9v/Y830=;
        b=Nj0FeF3abXpPJSn7tKLUbfLPlk2U1rRUlTRbgcQdKmAvyOW55uQXZ/Liy01DEb5Emv
         8FlxIJvAJSSwec6S4KidPJlR8xw/Np2Imsn8R+fJe1I92ebPakY/NgE1ja/cyFG9HOTs
         uktkJDF2vPqUPn2VX6BZWDEI2fMZ/QoyC1LcIXHE5F7S+wttZEzUKeXafHY6dIlO+/JH
         ulwHDIydM7iqE0uhJd2p3Dwex8+xUpN2lWiYbV6DIgevvQYZlL4hHKIlTClglCXd2gj0
         i+ZoqkII6pa3yMqMWk1Cg/WmX+thjhhctwr+QbWsD0IuEb91PpzhPBh+Jo249zONOTz7
         jJpQ==
X-Received: by 10.60.17.231 with SMTP id r7mr13745770oed.13.1369449779601;
        Fri, 24 May 2013 19:42:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20606240oez.4.2013.05.24.19.42.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225474>

So that we can specify which scripts we do not want to install (they are
for testing).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 97ff848..333b5d3 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,10 @@ SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 
+SCRIPT_SH_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_SH_GEN))
+SCRIPT_PERL_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PERL_GEN))
+SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
+
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
 # from subdirectories like contrib/*/
@@ -509,11 +513,11 @@ build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
 .PHONY: install-perl-script install-sh-script install-python-script
-install-sh-script: $(SCRIPT_SH_GEN)
+install-sh-script: $(SCRIPT_SH_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-perl-script: $(SCRIPT_PERL_GEN)
+install-perl-script: $(SCRIPT_PERL_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-python-script: $(SCRIPT_PYTHON_GEN)
+install-python-script: $(SCRIPT_PYTHON_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
@@ -524,9 +528,9 @@ clean-perl-script:
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
 
-SCRIPTS = $(SCRIPT_SH_GEN) \
-	  $(SCRIPT_PERL_GEN) \
-	  $(SCRIPT_PYTHON_GEN) \
+SCRIPTS = $(SCRIPT_SH_INS) \
+	  $(SCRIPT_PERL_INS) \
+	  $(SCRIPT_PYTHON_INS) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
-- 
1.8.3.rc3.312.g47657de
