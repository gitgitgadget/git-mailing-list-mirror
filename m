From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Remove pdf target from Makefiles
Date: Mon, 17 Jun 2013 20:16:12 +0200 (CEST)
Message-ID: <1370125851.738272.1371492972525.JavaMail.ngmail@webmail23.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 20:16:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uodya-00069T-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 20:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab3FQSQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 14:16:17 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:52525 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538Ab3FQSQO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 14:16:14 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 8F97BAA483
	for <git@vger.kernel.org>; Mon, 17 Jun 2013 20:16:12 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 87C1F112039
	for <git@vger.kernel.org>; Mon, 17 Jun 2013 20:16:12 +0200 (CEST)
Received: from webmail23.arcor-online.net (webmail23.arcor-online.net [151.189.8.121])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 7E7D48257
	for <git@vger.kernel.org>; Mon, 17 Jun 2013 20:16:12 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 7E7D48257
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1371492972; bh=0rcUj7C11C1Mh2hq4q5GqP4BYPWFzC2EIX7f7UXjta4=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=AR+fAk2ug0tiOJCZZTDDZICaYYOgb1g59Vp7055UZy1kJk+RxxXXQGkf5A2XjpiIW
	 aQ8t3wO4yOBJCBngXA7W80424fbX+x1/Lsuh99L7Jud/MVfjeqPkcB3tD9LSUHrndk
	 0fImPcFSUCISCJu4A5HHiflivVLZJ40HUaBaLZH0=
Received: from [94.217.130.17] by webmail23.arcor-online.net (151.189.8.121) with HTTP (Arcor Webmail); Mon, 17 Jun 2013 20:16:11 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.130.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228095>


This target was only used to create user-manual.pdf with dblatex
using a separate style definition than was used for user-manual.html.
These two style definitions had to be maintained separately and
so made improvements to user-manual.html unnecessarily hard.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---

Improving anything on the formatting of user-manual.pdf would necessitate
to create customized versions of public dblatex style files from
/etc/asciidoc/dblatex/. Instead of trying to expand on creating more and better
pdfs from the git documentation I suggest to drop the pdf target altogether
and thus also get rid of the dependency on dblatex.

 Documentation/Makefile | 15 ---------------
 Makefile               |  6 ------
 2 files changed, 21 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 62dbd9a..c42aa07 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -81,7 +81,6 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 htmldir?=$(prefix)/share/doc/git-doc
-pdfdir?=$(prefix)/share/doc/git-doc
 mandir?=$(prefix)/share/man
 man1dir=$(mandir)/man1
 man5dir=$(mandir)/man5
@@ -102,7 +101,6 @@ infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
 INSTALL_INFO=install-info
 DOCBOOK2X_TEXI=docbook2x-texi
-DBLATEX=dblatex
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -185,7 +183,6 @@ ifndef V
 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
 	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
-	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
 	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
 	QUIET_STDERR	= 2> /dev/null
@@ -207,8 +204,6 @@ man7: $(DOC_MAN7)
 
 info: git.info gitman.info
 
-pdf: user-manual.pdf
-
 install: install-man
 
 install-man: man
@@ -229,10 +224,6 @@ install-info: info
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi
 
-install-pdf: pdf
-	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
-	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
-
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -289,7 +280,6 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
-	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
@@ -352,11 +342,6 @@ user-manual.texi: user-manual.xml
 	rm $@++ && \
 	mv $@+ $@
 
-user-manual.pdf: user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $< && \
-	mv $@+ $@
-
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
diff --git a/Makefile b/Makefile
index 03524d0..ab8fb15 100644
--- a/Makefile
+++ b/Makefile
@@ -2089,9 +2089,6 @@ html:
 info:
 	$(MAKE) -C Documentation info
 
-pdf:
-	$(MAKE) -C Documentation pdf
-
 XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments \
@@ -2404,9 +2401,6 @@ install-html:
 install-info:
 	$(MAKE) -C Documentation install-info
 
-install-pdf:
-	$(MAKE) -C Documentation install-pdf
-
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.8.3.msysgit.0



---
Thomas
