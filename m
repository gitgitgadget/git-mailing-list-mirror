From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH 2/2] Fix the building of gitman.info document
Date: Mon, 29 Dec 2008 10:03:09 +0200
Message-ID: <1230537789-5376-3-git-send-email-tlikonen@iki.fi>
References: <1230537789-5376-1-git-send-email-tlikonen@iki.fi>
 <1230537789-5376-2-git-send-email-tlikonen@iki.fi>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHD7A-0007A7-Ct
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbYL2IDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbYL2IDR
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:03:17 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43860 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbYL2IDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:03:16 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88031703F0; Mon, 29 Dec 2008 10:03:15 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LHD5h-0001PF-UH; Mon, 29 Dec 2008 10:03:09 +0200
X-Mailer: git-send-email 1.6.1.16.gd45c5
In-Reply-To: <1230537789-5376-2-git-send-email-tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104077>

"makeinfo" failed to generate gitman.info from gitman.texi input file
because the combined manual page file contains several nodes with the
same name (DESCRIPTION, OPTIONS, SEE ALSO etc.). An Info document should
contain unique node names.

This patch creates a simple (read: ugly) work-around by suppressing the
validation of the final Info file. Jumping to nodes in the Info document
still works but they are not very useful. Common man-page headings like
DESCRIPTION and OPTIONS appear in the Info node list and they point to
the man page where they appear first (that is git-add currently).

Also, this patch adds directory-entry information for Info document to
make the document appear in the top-level Info directory.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/Makefile      |    2 +-
 Documentation/cat-texi.perl |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c41a7b4..5cd8b63 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -198,7 +198,7 @@ gitman.texi: $(MAN_XML) cat-texi.perl
 	mv $@+ $@
 
 gitman.info: gitman.texi
-	$(MAKEINFO) --no-split $*.texi
+	$(MAKEINFO) --no-split --no-validate $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(RM) $@+ $@
diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index dbc133c..828ec62 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -18,8 +18,12 @@ close TMP;
 
 printf '\input texinfo
 @setfilename gitman.info
-@documentencoding us-ascii
-@node Top,,%s
+@documentencoding UTF-8
+@dircategory Development
+@direntry
+* Git Man Pages: (gitman).  Manual pages for Git revision control system
+@end direntry
+@node Top,,, (dir)
 @top Git Manual Pages
 @documentlanguage en
 @menu
-- 
1.6.1.16.gd45c5
