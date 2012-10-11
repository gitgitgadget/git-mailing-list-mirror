From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 8/8] Wire everything into Makefile and
 Documentation/Makefile
Date: Thu, 11 Oct 2012 19:26:17 +0200 (CEST)
Message-ID: <1374330060.47046.1349976377823.JavaMail.ngmail@webmail22.arcor-online.net>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMWk-0003sJ-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab2JKR0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:26:20 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:59046 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932758Ab2JKR0T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:26:19 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id DC2EF35B351;
	Thu, 11 Oct 2012 19:26:17 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id D5442208008;
	Thu, 11 Oct 2012 19:26:17 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id C988B21305D;
	Thu, 11 Oct 2012 19:26:17 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net C988B21305D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349976377; bh=gbFjYgc6CpOmQzMR5A0K1IG2D0lWUF9Bl4T5hNjzb6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=TCLgrQhFqNFWhrgOM4HK1RkE0/6HBfSiyB0oDVe6Bix+aMU8wBmTRD7ZZVlXwpLyR
	 IzBgUFm5CouXUeZTdaJQxwfr8os5hEC1u7Q3xav4MIcmpzx+VjguvhTyGpb2bqb3qx
	 suLuoilbHy7nYE65sa5kE32cELf00HM93HCvJZno=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:26:17 +0200 (CEST)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207498>

>From ac7de86bd58c5849c12e2b05e7b7f68704d9093e Mon Sep 17 00:00:00 2001
From: Thomas Ackermann <th.acker@arcor.de>
Date: Wed, 10 Oct 2012 19:30:55 +0200
Subject: [PATCH] Wire everything into Makefile and Documentation/Makefile

- target "html" creates html for all files in Documentation/howto and Documentation/technical
- new target "relnoteshtml" creates html for all release notes
- new target "fullpdf" creates "git-doc.pdf" and uses targets "html", "relnoteshtml" and "pdf"
- "html" does not use "relnoteshtml"

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile | 43 +++++++++++++++++++++++++++++++++++++++++--
 Makefile               |  9 +++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 267dfe1..6710325 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -15,6 +15,9 @@ MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
+RELNOTES_TXT = $(wildcard RelNotes/*.txt)
+RELNOTES_HTML= $(patsubst %.txt,%.html,$(RELNOTES_TXT))
+ 
 ARTICLES = howto-index
 ARTICLES += everyday
 ARTICLES += git-tools
@@ -24,8 +27,30 @@ SP_ARTICLES = user-manual
 SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
+SP_ARTICLES += howto/use-git-daemon
+SP_ARTICLES += howto/update-hook-example
+SP_ARTICLES += howto/setup-git-server-over-http
+SP_ARTICLES += howto/separating-topic-branches
+SP_ARTICLES += howto/revert-a-faulty-merge
+SP_ARTICLES += howto/recover-corrupted-blob-object
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebase-from-internal-branch
+SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
+
+TECH_DOCS += technical/index-format
+TECH_DOCS += technical/pack-format
+TECH_DOCS += technical/pack-heuristics
+TECH_DOCS += technical/pack-protocol
+TECH_DOCS += technical/protocol-capabilities
+TECH_DOCS += technical/protocol-common
+TECH_DOCS += technical/racy-git
+TECH_DOCS += technical/send-pack-pipeline
+TECH_DOCS += technical/shallow
+TECH_DOCS += technical/trivial-merge
+SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
 DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
@@ -156,6 +181,8 @@ all: html man
 
 html: $(DOC_HTML)
 
+relnoteshtml: $(RELNOTES_HTML)
+
 $(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
 
 man: man1 man5 man7
@@ -167,6 +194,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+fullpdf: pdf relnoteshtml html
+	./makedocpdf.sh
+
 install: install-man
 
 install-man: man
@@ -191,6 +221,10 @@ install-pdf: pdf
 	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
+install-fullpdf: fullpdf install-pdf
+	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
+	$(INSTALL) -m 644 git-doc.pdf $(DESTDIR)$(pdfdir)
+
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -230,8 +264,10 @@ clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
+	$(RM) docfiles.txt
+	$(RM) RelNotes/*.html
 	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/api-*.html technical/api-index.txt
+	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
 
@@ -241,6 +277,9 @@ $(MAN_HTML): %.html : %.txt
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
+$(RELNOTES_HTML): %.html : %.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
+
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
@@ -264,7 +303,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
diff --git a/Makefile b/Makefile
index 8413606..0392782 100644
--- a/Makefile
+++ b/Makefile
@@ -2479,12 +2479,18 @@ man:
 html:
 	$(MAKE) -C Documentation html
 
+relnoteshtml:
+	$(MAKE) -C Documentation relnoteshtml
+
 info:
 	$(MAKE) -C Documentation info
 
 pdf:
 	$(MAKE) -C Documentation pdf
 
+fullpdf:
+	$(MAKE) -C Documentation fullpdf
+
 XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments \
@@ -2796,6 +2802,9 @@ install-info:
 install-pdf:
 	$(MAKE) -C Documentation install-pdf
 
+install-fullpdf:
+	$(MAKE) -C Documentation install-fullpdf
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.7.11.msysgit.1


---
Thomas
