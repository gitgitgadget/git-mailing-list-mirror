From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4] Makefile: factor common configuration in git-default-config.mak
Date: Wed,  6 Feb 2013 19:11:31 +0100
Message-ID: <1360174292-14793-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 06 19:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39Tl-0007m9-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab3BFSLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:11:49 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45251 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755684Ab3BFSLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:11:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16IBahi007449
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:11:36 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T8-0005kV-KC; Wed, 06 Feb 2013 19:11:38 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T8-0003rj-GN; Wed, 06 Feb 2013 19:11:38 +0100
X-Mailer: git-send-email 1.8.1.2.526.gf51a757
In-Reply-To: <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 19:11:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IBahi007449
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360779100.28045@M5iurIzGNJbCeVs1qmx0Uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215608>

Similarly to the extraction of perl-related code in perl.mak, we extract
general default configuration from the Makefile to make it available from
directories other than the toplevel.

This is required to make perl.mak usable because it requires $(pathsep)
to be set.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Makefile           | 62 +-----------------------------------------------------
 default-config.mak | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 61 deletions(-)
 create mode 100644 default-config.mak

diff --git a/Makefile b/Makefile
index f39d4a9..9649a41 100644
--- a/Makefile
+++ b/Makefile
@@ -346,67 +346,7 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
-# CFLAGS and LDFLAGS are for the users to override from the command line.
-
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
-ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
-ALL_LDFLAGS = $(LDFLAGS)
-STRIP ?= strip
-
-# Among the variables below, these:
-#   gitexecdir
-#   template_dir
-#   mandir
-#   infodir
-#   htmldir
-#   sysconfdir
-# can be specified as a relative path some/where/else;
-# this is interpreted as relative to $(prefix) and "git" at
-# runtime figures out where they are based on the path to the executable.
-# This can help installing the suite in a relocatable way.
-
-prefix = $(HOME)
-bindir_relative = bin
-bindir = $(prefix)/$(bindir_relative)
-mandir = share/man
-infodir = share/info
-gitexecdir = libexec/git-core
-mergetoolsdir = $(gitexecdir)/mergetools
-sharedir = $(prefix)/share
-gitwebdir = $(sharedir)/gitweb
-localedir = $(sharedir)/locale
-template_dir = share/git-core/templates
-htmldir = share/doc/git-doc
-ETC_GITCONFIG = $(sysconfdir)/gitconfig
-ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
-lib = lib
-# DESTDIR =
-pathsep = :
-
-export prefix bindir sharedir sysconfdir gitwebdir localedir
-
-CC = cc
-AR = ar
-RM = rm -f
-DIFF = diff
-TAR = tar
-FIND = find
-INSTALL = install
-RPMBUILD = rpmbuild
-TCL_PATH = tclsh
-TCLTK_PATH = wish
-XGETTEXT = xgettext
-MSGFMT = msgfmt
-PTHREAD_LIBS = -lpthread
-PTHREAD_CFLAGS =
-GCOV = gcov
-
-export TCL_PATH TCLTK_PATH
-
-SPARSE_FLAGS =
-
-
+include default-config.mak
 
 ### --- END CONFIGURATION SECTION ---
 
diff --git a/default-config.mak b/default-config.mak
new file mode 100644
index 0000000..b2aab3d
--- /dev/null
+++ b/default-config.mak
@@ -0,0 +1,61 @@
+# CFLAGS and LDFLAGS are for the users to override from the command line.
+
+CFLAGS = -g -O2 -Wall
+LDFLAGS =
+ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
+ALL_LDFLAGS = $(LDFLAGS)
+STRIP ?= strip
+
+# Among the variables below, these:
+#   gitexecdir
+#   template_dir
+#   mandir
+#   infodir
+#   htmldir
+#   sysconfdir
+# can be specified as a relative path some/where/else;
+# this is interpreted as relative to $(prefix) and "git" at
+# runtime figures out where they are based on the path to the executable.
+# This can help installing the suite in a relocatable way.
+
+prefix = $(HOME)
+bindir_relative = bin
+bindir = $(prefix)/$(bindir_relative)
+mandir = share/man
+infodir = share/info
+gitexecdir = libexec/git-core
+mergetoolsdir = $(gitexecdir)/mergetools
+sharedir = $(prefix)/share
+gitwebdir = $(sharedir)/gitweb
+localedir = $(sharedir)/locale
+template_dir = share/git-core/templates
+htmldir = share/doc/git-doc
+ETC_GITCONFIG = $(sysconfdir)/gitconfig
+ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+lib = lib
+# DESTDIR =
+pathsep = :
+
+export prefix bindir sharedir sysconfdir gitwebdir localedir
+
+CC = cc
+AR = ar
+RM = rm -f
+DIFF = diff
+TAR = tar
+FIND = find
+INSTALL = install
+RPMBUILD = rpmbuild
+TCL_PATH = tclsh
+TCLTK_PATH = wish
+XGETTEXT = xgettext
+MSGFMT = msgfmt
+PTHREAD_LIBS = -lpthread
+PTHREAD_CFLAGS =
+GCOV = gcov
+
+export TCL_PATH TCLTK_PATH
+
+SPARSE_FLAGS =
+
+
-- 
1.8.1.2.526.gf51a757
