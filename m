From: benoit.person@ensimag.fr
Subject: [PATCH/RFC 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Thu, 13 Jun 2013 12:07:16 +0200
Message-ID: <1371118039-18925-2-git-send-email-benoit.person@ensimag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 12:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4Rb-0007u5-IS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489Ab3FMKHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:07:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36240 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758477Ab3FMKHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:07:46 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DA7dkd025765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 12:07:41 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DA7e3l011005;
	Thu, 13 Jun 2013 12:07:40 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DA7Wab026514;
	Thu, 13 Jun 2013 12:07:39 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 12:07:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227712>

From: Benoit Person <benoit.person@ensimag.fr>

The GitMediawiki.pm goal is to share code betwwen several scripts in
Git-Mediawiki (for now, git-mw.perl introduced in this patch serie and
git-remote-mediawiki.perl)

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/GitMediawiki.pm | 24 ++++++++++++++++++++++++
 contrib/mw-to-git/Makefile        | 19 +++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 contrib/mw-to-git/GitMediawiki.pm

diff --git a/contrib/mw-to-git/GitMediawiki.pm b/contrib/mw-to-git/GitMediawiki.pm
new file mode 100644
index 0000000..8a0ffc7
--- /dev/null
+++ b/contrib/mw-to-git/GitMediawiki.pm
@@ -0,0 +1,24 @@
+package GitMediawiki;
+
+use 5.008;
+use strict;
+use Git;
+
+BEGIN {
+
+our ($VERSION, @ISA, @EXPORT, @EXPORT_OK);
+
+# Totally unstable API.
+$VERSION = '0.01';
+
+require Exporter;
+
+@ISA = qw(Exporter);
+
+@EXPORT = ();
+
+# Methods which can be called as standalone functions as well:
+@EXPORT_OK = ();
+}
+
+1; # Famous last words
\ No newline at end of file
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index f149719..fe30e7f 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -4,14 +4,29 @@
 #
 ## Build git-remote-mediawiki
 
+GIT_MEDIAWIKI_PM=GitMediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
+INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
+                -s --no-print-directory instlibdir)
 
 all: build
 
-build install clean:
+install_pm:
+	cp $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)
+
+build:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+                build-perl-script
+
+install: install_pm
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+                install-perl-script
+
+clean:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
-                $@-perl-script
+                clean-perl-script
+	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
\ No newline at end of file
-- 
1.8.3.GIT
