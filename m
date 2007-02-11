From: Dotan Barak <dotanb@dev.mellanox.co.il>
Subject: [PATCH] Allow setting the path of asciidoc in only one place when
	creating the documentation
Date: Sun, 11 Feb 2007 17:54:40 +0200
Message-ID: <1171209280.20052.5.camel@mtldesk014.lab.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 17:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHM6-0000Eh-MF
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbXBKQO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbXBKQO6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:14:58 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33465 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbXBKQO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:14:58 -0500
X-Greylist: delayed 1195 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Feb 2007 11:14:57 EST
Received: from mtldesk014.lab.mtl.com ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with ESMTP id l1BFsvXH008049
	for <git@vger.kernel.org>; Sun, 11 Feb 2007 17:54:58 +0200
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39287>

Allow setting the path of asciidoc in only one place when creating the documentation.

Signed-off-by: Dotan Barak <dotanb@dev.mellanox.co.il>

---

Index: git-1.5.0.rc4/Documentation/Makefile
===================================================================
--- git-1.5.0.rc4.orig/Documentation/Makefile	2007-02-08 01:05:14.000000000 +0200
+++ git-1.5.0.rc4/Documentation/Makefile	2007-02-11 17:37:05.000000000 +0200
@@ -31,6 +31,7 @@ man1dir=$(mandir)/man1
 man7dir=$(mandir)/man7
 # DESTDIR=
 
+ASCIIDOC=asciidoc
 INSTALL?=install
 DOC_REF = origin/man
 
@@ -91,16 +92,16 @@ clean:
 	rm -f $(cmds_txt)
 
 %.html : %.txt
-	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
+	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage -f asciidoc.conf $<
+	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
 
 user-manual.xml: user-manual.txt user-manual.conf
-	asciidoc -b docbook -d book $<
+	$(ASCIIDOC) -b docbook -d book $<
 
 user-manual.html: user-manual.xml
 	xmlto html-nochunks $<
@@ -108,7 +109,7 @@ user-manual.html: user-manual.xml
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
 	perl sort_glossary.pl | \
-	asciidoc -b xhtml11 - > glossary.html
+	$(ASCIIDOC) -b xhtml11 - > glossary.html
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	rm -f $@+ $@
@@ -116,13 +117,13 @@ howto-index.txt: howto-index.sh $(wildca
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	asciidoc -b xhtml11 $*.txt
+	$(ASCIIDOC) -b xhtml11 $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	rm -f $@+ $@
-	sed -e '1,/^$$/d' $< | asciidoc -b xhtml11 - >$@+
+	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+
 	mv $@+ $@
 
 install-webdoc : html
