From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Fri, 20 Mar 2009 22:40:20 -0400
Message-ID: <1237603220-22897-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 03:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkrD2-0001ja-9P
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 03:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZCUCkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 22:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbZCUCkX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 22:40:23 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:55886 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZCUCkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 22:40:22 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lkr8G-000336-Kf; Fri, 20 Mar 2009 22:40:20 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lkr8G-0005y4-I6; Fri, 20 Mar 2009 22:40:20 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2L2eKNm022940;
	Fri, 20 Mar 2009 22:40:20 -0400
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114023>

Take SHELL_PATH into account, if set, in Documentation/Makefile.  This
allows the caller to provide a shell capable of running the install
scripts on systems where sh is not bash.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Documentation/Makefile |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..2eb5a72 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,11 @@ ASCIIDOC_EXTRA += -a docbook-xsl-172
 MANPAGE_XSL = manpage-1.72.xsl
 endif
 
+#retain original (but broken) behaviour if SHELL_PATH isn't overridden
+ifndef SHELL_PATH
+	SHELL_PATH = sh
+endif
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
@@ -116,7 +121,7 @@ install-pdf: pdf
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
 install-html: html
-	sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
+	$(SHELL_PATH) ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
@@ -178,7 +183,7 @@ user-manual.xml: user-manual.txt user-manual.conf
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	cd technical && sh ./api-index.sh
+	cd technical && $(SHELL_PATH) ./api-index.sh
 
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
 	$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
@@ -220,7 +225,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(RM) $@+ $@
-	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
+	$(SHELL_PATH) ./howto-index.sh $(wildcard howto/*.txt) >$@+
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -234,14 +239,14 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	mv $@+ $@
 
 install-webdoc : html
-	sh ./install-webdoc.sh $(WEBDOC_DEST)
+	$(SHELL_PATH) ./install-webdoc.sh $(WEBDOC_DEST)
 
 quick-install: quick-install-man
 
 quick-install-man:
-	sh ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
+	$(SHELL_PATH) ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
 
 quick-install-html:
-	sh ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
+	$(SHELL_PATH) ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
 
 .PHONY: .FORCE-GIT-VERSION-FILE
-- 
1.6.0.5
