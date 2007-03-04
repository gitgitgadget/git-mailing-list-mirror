From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: ensure generated manual references stylesheet
Date: Sun,  4 Mar 2007 16:59:12 -0500
Message-ID: <11730455591178-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysl-00081f-9v
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbXCDWIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXCDWIX
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:23 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752661AbXCDWIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:21 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxJt9006627;
	Sun, 4 Mar 2007 16:59:19 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxJqG006626;
	Sun, 4 Mar 2007 16:59:19 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <1173045558959-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41383>

From: J. Bruce Fields <bfields@citi.umich.edu>

The generated user manual is rather hard to read thanks to the lack of
the css that's supposed to be included from docbook-xsl.css.

I'm totally ignorant of the toolchain; grubbing through xmlto and
related scripts, the easiest way I could find to ensure that the
generated html links to the stylesheet is by calling xsltproc directly.
Maybe there's some better way.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b6d1d88..7c1c9e1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -105,8 +105,11 @@ clean:
 user-manual.xml: user-manual.txt user-manual.conf
 	$(ASCIIDOC) -b docbook -d book $<
 
+XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
+XSLTOPTS = --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css
+
 user-manual.html: user-manual.xml
-	xmlto html-nochunks $<
+	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
-- 
1.5.0.gb75812-dirty
