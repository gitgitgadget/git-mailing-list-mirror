From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/4] Documentation: move some AsciiDoc parameters into variables
Date: Sat, 11 Oct 2014 23:37:35 +0000
Message-ID: <1413070656-241955-4-git-send-email-sandals@crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 01:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd6Ea-0004Lp-LW
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 01:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbaJKXhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 19:37:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49221 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223AbaJKXhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 19:37:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EC82528093
	for <git@vger.kernel.org>; Sat, 11 Oct 2014 23:37:42 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor takes slightly different arguments from AsciiDoc in some
cases.  It has a different name for the HTML backend and the "docbook"
backend produces DocBook 5, not DocBook 4.5.  Also, Asciidoctor does not
accept the -f option.  Move these values into variables so that they can
be overridden by users wishing to use Asciidoctor instead of Asciidoc.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cea0e7a..00c50bf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -97,6 +97,9 @@ man7dir = $(mandir)/man7
 
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
+ASCIIDOC_HTML = xhtml11
+ASCIIDOC_DOCBOOK = docbook
+ASCIIDOC_CONF = -f asciidoc.conf
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
@@ -304,13 +307,13 @@ clean:
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
+	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
 $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
+	$(ASCIIDOC) -b $(ASCIIDOC_HTML) $(ASCIIDOC_CONF) \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
@@ -323,13 +326,13 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 %.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
+	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d article -o $@+ $< && \
+	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_DOCBOOK) -d article -o $@+ $< && \
 	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
@@ -338,7 +341,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) $(ASCIIDOC_CONF) \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
 XSLT = docbook.xsl
@@ -386,14 +389,15 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
+	sed -e '1,/^$$/d' $< | \
+	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_HTML) - >$@+ && \
 	mv $@+ $@
 
 install-webdoc : html
-- 
2.1.1
