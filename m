From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH 1/2] Fix the building of user-manual.texi and gitman.texi documents
Date: Mon, 29 Dec 2008 10:03:08 +0200
Message-ID: <1230537789-5376-2-git-send-email-tlikonen@iki.fi>
References: <1230537789-5376-1-git-send-email-tlikonen@iki.fi>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHD79-0007A7-LI
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYL2IDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYL2IDO
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:03:14 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:38029 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbYL2IDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:03:13 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C703167EA8; Mon, 29 Dec 2008 10:03:12 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LHD5h-0001PD-TV; Mon, 29 Dec 2008 10:03:09 +0200
X-Mailer: git-send-email 1.6.1.16.gd45c5
In-Reply-To: <1230537789-5376-1-git-send-email-tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104078>

Previously "docbook2x-texi" failed to generate user-manual.texi and
gitman.texi files from .xml input files because "iconv" stopped at
"illegal input sequence" error. This was due to some UTF-8 octets in the
input .xml files. This patch adds option --encoding=UTF-8 for
"docbook2x-texi" to allow the building of .texi files complete.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c34c1ca..c41a7b4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -187,13 +187,14 @@ git.info: user-manual.texi
 
 user-manual.texi: user-manual.xml
 	$(RM) $@+ $@
-	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | $(PERL_PATH) fix-texi.perl >$@+
+	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout | \
+		$(PERL_PATH) fix-texi.perl >$@+
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(RM) $@+ $@
-	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --to-stdout $(xml);)) | \
-	$(PERL_PATH) cat-texi.perl $@ >$@+
+	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
+		--to-stdout $(xml);)) | $(PERL_PATH) cat-texi.perl $@ >$@+
 	mv $@+ $@
 
 gitman.info: gitman.texi
-- 
1.6.1.16.gd45c5
