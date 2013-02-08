From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-remote-mediawiki: use toplevel's Makefile
Date: Fri,  8 Feb 2013 18:31:17 +0100
Message-ID: <1360344677-5962-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq4nhmbusp.fsf@grenoble-inp.fr>
 <1360344677-5962-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 18:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3roh-00048N-J9
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946810Ab3BHRc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:32:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51155 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946774Ab3BHRc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:32:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r18HVNXB028804
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2013 18:31:23 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U3rnJ-0002v8-CE; Fri, 08 Feb 2013 18:31:25 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U3rnJ-0001Yt-8O; Fri, 08 Feb 2013 18:31:25 +0100
X-Mailer: git-send-email 1.8.1.2.530.g3cc16e4.dirty
In-Reply-To: <1360344677-5962-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Feb 2013 18:31:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r18HVNXB028804
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360949485.52197@T7Byyl9asqAh1P8ZvUJeKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215787>

This makes the Makefile simpler, while providing more features, and more
consistency (the exact same rules with the exact same configuration as
Git official commands are applied with the new version).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/.gitignore                       |  1 +
 contrib/mw-to-git/Makefile                         | 64 ++++++----------------
 ...-remote-mediawiki => git-remote-mediawiki.perl} |  0
 3 files changed, 18 insertions(+), 47 deletions(-)
 create mode 100644 contrib/mw-to-git/.gitignore
 rewrite contrib/mw-to-git/Makefile (96%)
 rename contrib/mw-to-git/{git-remote-mediawiki => git-remote-mediawiki.perl} (100%)

diff --git a/contrib/mw-to-git/.gitignore b/contrib/mw-to-git/.gitignore
new file mode 100644
index 0000000..b919655
--- /dev/null
+++ b/contrib/mw-to-git/.gitignore
@@ -0,0 +1 @@
+git-remote-mediawiki
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
dissimilarity index 96%
index 3ed728b..f149719 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -1,47 +1,17 @@
-#
-# Copyright (C) 2012
-#     Charles Roussel <charles.roussel@ensimag.imag.fr>
-#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
-#     Julien Khayat <julien.khayat@ensimag.imag.fr>
-#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
-#     Simon Perrat <simon.perrat@ensimag.imag.fr>
-#
-## Build git-remote-mediawiki
-
--include ../../config.mak.autogen
--include ../../config.mak
-
-ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
-endif
-ifndef gitexecdir
-	gitexecdir = $(shell git --exec-path)
-endif
-
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
-SCRIPT = git-remote-mediawiki
-
-.PHONY: install help doc test clean
-
-help:
-	@echo 'This is the help target of the Makefile. Current configuration:'
-	@echo '  gitexecdir = $(gitexecdir_SQ)'
-	@echo '  PERL_PATH = $(PERL_PATH_SQ)'
-	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir'
-	@echo 'Run "$(MAKE) test" to run the testsuite'
-
-install:
-	sed -e '1s|#!.*/perl|#!$(PERL_PATH_SQ)|' $(SCRIPT) \
-		> '$(gitexecdir_SQ)/$(SCRIPT)'
-	chmod +x '$(gitexecdir)/$(SCRIPT)'
-
-doc:
-	@echo 'Sorry, "make doc" is not implemented yet for $(SCRIPT)'
-
-test:
-	$(MAKE) -C t/ test
-
-clean:
-	$(RM) '$(gitexecdir)/$(SCRIPT)'
-	$(MAKE) -C t/ clean
+#
+# Copyright (C) 2013
+#     Matthieu Moy <Matthieu.Moy@imag.fr>
+#
+## Build git-remote-mediawiki
+
+SCRIPT_PERL=git-remote-mediawiki.perl
+GIT_ROOT_DIR=../..
+HERE=contrib/mw-to-git/
+
+SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
+
+all: build
+
+build install clean:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+                $@-perl-script
diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki.perl
similarity index 100%
rename from contrib/mw-to-git/git-remote-mediawiki
rename to contrib/mw-to-git/git-remote-mediawiki.perl
-- 
1.8.1.2.530.g3cc16e4.dirty
