From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 3/4] Generate PDF documents using docbook2pdf
Date: Fri, 10 Mar 2006 15:44:54 +0100
Message-ID: <20060310144454.GD7920@diku.dk>
References: <20060310144106.GA7920@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 15:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHirV-0008VW-3m
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 15:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWCJOo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 09:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCJOo5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 09:44:57 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:30892 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751467AbWCJOo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 09:44:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D5DD952D533;
	Fri, 10 Mar 2006 15:44:55 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01774-09; Fri, 10 Mar 2006 15:44:54 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 60D0452D61E;
	Fri, 10 Mar 2006 15:44:54 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 234BF6DFAB3; Fri, 10 Mar 2006 15:43:30 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4DC4A61DC1; Fri, 10 Mar 2006 15:44:54 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060310144106.GA7920@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17477>

Unfortunately xmlto cannot be used for this,

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 00e9276..d316a14 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -11,6 +11,8 @@ DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_
 DOC_MAN1=$(patsubst %.txt,%,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%,$(MAN7_TXT))
 
+DOC_PDF=$(patsubst %.txt,%.pdf,$(MAN1_TXT) $(MAN7_TXT)) introduction.pdf
+
 prefix=$(HOME)
 bin=$(prefix)/bin
 mandir=$(prefix)/man
@@ -35,15 +37,17 @@ all: html man txt
 
 html: $(DOC_HTML)
 
-
 man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
+pdf: $(DOC_PDF)
+
 txt: txt1 txt7
 txt1: $(MAN1_TXT)
 txt7: $(MAN7_TXT)
 
+
 install: man txt
 	$(INSTALL) -m755 -d $(DESTDIR)/$(txtdir)
 	$(INSTALL) $(MAN1_TXT) $(MAN7_TXT) $(DESTDIR)/$(txtdir)
@@ -56,13 +60,16 @@ install-html: html
 	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
 
 clean:
-	rm -f *.xml *.html *.1 *.7 cg*.[17].txt $(PACKAGE).7.txt
+	rm -f *.xml *.html *.pdf *.1 *.7 cg*.[17].txt $(PACKAGE).7.txt
 
 .PRECIOUS: cg%.txt
 
 introduction.html: ../README
 	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
 
+introduction.xml: ../README
+	asciidoc -b docbook -d article -f asciidoc.conf -o $@ $<
+
 %.1.html : %.1.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
@@ -87,6 +94,9 @@ introduction.html: ../README
 %.7 : %.7.xml
 	xmlto man $<
 
+%.pdf : %.xml
+	docbook2pdf $<
+
 $(PACKAGE).7.txt : make-$(PACKAGE)-asciidoc
 	./make-$(PACKAGE)-asciidoc > $@
 
-- 
Jonas Fonseca
