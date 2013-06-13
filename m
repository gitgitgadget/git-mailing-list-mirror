From: benoit.person@ensimag.fr
Subject: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Thu, 13 Jun 2013 12:07:18 +0200
Message-ID: <1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 12:08:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4Rg-0007zb-RI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544Ab3FMKHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:07:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36242 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758491Ab3FMKHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:07:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DA7hhK025800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 12:07:43 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DA7iDd011016;
	Thu, 13 Jun 2013 12:07:44 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DA7Wad026514;
	Thu, 13 Jun 2013 12:07:44 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 12:07:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227714>

From: Benoit Person <benoit.person@ensimag.fr>

This script will be used for all tools and command related to a mediawiki
remote. In this commit we introduce the tool, the way it parses argument
and subcommands and an example of subcommand: "help". It also updates
the Makefile so that the new tool is installed properly.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/Makefile    |  7 ++++---
 contrib/mw-to-git/git-mw.perl | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 contrib/mw-to-git/git-mw.perl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index fe30e7f..c0633b1 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -6,6 +6,7 @@
 
 GIT_MEDIAWIKI_PM=GitMediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
+SCRIPT_PERL+=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
@@ -19,14 +20,14 @@ install_pm:
 	cp $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)
 
 build:
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 build-perl-script
 
 install: install_pm
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 install-perl-script
 
 clean:
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 clean-perl-script
 	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
\ No newline at end of file
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
new file mode 100644
index 0000000..a2f0aa1
--- /dev/null
+++ b/contrib/mw-to-git/git-mw.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl
+
+# Copyright (C) 2013
+#     Benoit Person <benoit.person@ensimag.imag.fr>
+#     Celestin Matte <celestin.matte@ensimag.imag.fr>
+# License: GPL v2 or later
+
+# Set of tools for git repo with a mediawiki remote.
+# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
+
+use strict;
+use warnings;
+
+use Getopt::Long;
+
+my %commands = (
+	'help' =>
+		[\&help, {}, \&help]
+);
+
+# Search for sub-command
+my $cmd = $commands{'help'};
+for (my $i = 0; $i < @ARGV; $i++) {
+	if (defined $commands{$ARGV[$i]}) {
+		$cmd = $commands{$ARGV[$i]};
+		splice @ARGV, $i, 1;
+		last;
+	}
+};
+GetOptions( %{$cmd->[1]},
+	'help|h' => \&{$cmd->[2]});
+
+# Launch command
+&{$cmd->[0]};
+
+############################## Help Functions ##################################
+
+sub help {
+	print <<'END';
+usage: git mw <command> <args>
+
+git mw commands are:
+    Help        Display help information about git mw
+END
+	exit;
+}
\ No newline at end of file
-- 
1.8.3.GIT
