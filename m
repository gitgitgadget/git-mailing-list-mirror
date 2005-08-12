From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix documentation installation
Date: Fri, 12 Aug 2005 23:11:45 +0200
Message-ID: <20050812211145.GA20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 23:13:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3gog-00081S-KL
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 23:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVHLVLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVHLVLs
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 17:11:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20750 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1750885AbVHLVLr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 17:11:47 -0400
Received: (qmail 1484 invoked by uid 2001); 12 Aug 2005 21:11:46 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Documentation's install target now depends on man since
it installs manpages. It now also installs the .txt files, to
$prefix/share/doc/cogito/txt/ by default. A separate install-html target
was added for installing .html files to $prefix/share/doc/cogito/html/. It
isn't part of the install target since building HTML might cause problems
on some asciidoc installations (like, well, mine) as xhtml11 appears
not to be an official asciidoc plugin, or so asciidoc claims.

The missing dependency was pointed out by Jonas Fonseca.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit e7b483b293fb7d359dcebf974e6784f8b14f2ab1
tree 5e998614a0dbce85758de5be847306837953bb42
parent 2b0289c3805d0c99eb031a7116948a3cb4ddf332
author Petr Baudis <pasky@suse.cz> Fri, 12 Aug 2005 22:58:13 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 12 Aug 2005 22:58:13 +0200

 Documentation/Makefile |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -11,6 +11,9 @@ bin=$(prefix)/bin
 mandir=$(prefix)/man
 man1=$(mandir)/man1
 man7=$(mandir)/man7
+docdir=$(prefix)/share/doc/git-core
+txtdir=$(docdir)/txt
+htmldir=$(docdir)/html
 # DESTDIR=
 
 INSTALL=install
@@ -33,11 +36,18 @@ man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
-install:
+install: man
+	$(INSTALL) -m755 -d $(DESTDIR)/$(txtdir)
+	$(INSTALL) $(MAN1_TXT) $(MAN7_TXT) $(DESTDIR)/$(txtdir)
 	$(INSTALL) -m755 -d $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
 	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
 	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
 
+install-html: html
+	$(INSTALL) -m755 -d $(DESTDIR)/$(htmldir)
+	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
+
+
 # 'include' dependencies
 git-diff-%.txt: diff-format.txt diff-options.txt
 	touch $@
diff --git a/tools/Makefile b/tools/Makefile
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -18,7 +18,7 @@ git-%: %.c
 all: $(PROGRAMS)
 
 install: $(PROGRAMS) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
 
 clean:
