From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/6] git svn info: tests: use test_cmp instead of git-diff
Date: Tue, 26 Aug 2008 21:32:34 +0200
Message-ID: <1219779157-31602-4-git-send-email-trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-2-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-3-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:35:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4JU-0004pl-3J
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622AbYHZTcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759600AbYHZTco
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:44 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759595AbYHZTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:41 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:36 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
In-Reply-To: <1219779157-31602-3-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Aug 2008 19:32:37.0130 (UTC) FILETIME=[7EE54EA0:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93810>

git-diff does not appear to return the correct exit values, and gives
a false success for more than half (!) of the tests due to the space
in "trash directory" which git-svn fails to encode.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t9119-git-svn-info.sh |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index a70f2b9..7798dcc 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -60,7 +60,7 @@ test_expect_success 'setup repository and import' '
 test_expect_success 'info' "
 	(cd svnwc; svn info) > expected.info &&
 	(cd gitwc; git-svn info) > actual.info &&
-	git-diff expected.info actual.info
+	test_cmp expected.info actual.info
 	"
 
 test_expect_success 'info --url' '
@@ -70,7 +70,7 @@ test_expect_success 'info --url' '
 test_expect_success 'info .' "
 	(cd svnwc; svn info .) > expected.info-dot &&
 	(cd gitwc; git-svn info .) > actual.info-dot &&
-	git-diff expected.info-dot actual.info-dot
+	test_cmp expected.info-dot actual.info-dot
 	"
 
 test_expect_success 'info --url .' '
@@ -80,7 +80,7 @@ test_expect_success 'info --url .' '
 test_expect_success 'info file' "
 	(cd svnwc; svn info file) > expected.info-file &&
 	(cd gitwc; git-svn info file) > actual.info-file &&
-	git-diff expected.info-file actual.info-file
+	test_cmp expected.info-file actual.info-file
 	"
 
 test_expect_success 'info --url file' '
@@ -90,7 +90,7 @@ test_expect_success 'info --url file' '
 test_expect_success 'info directory' "
 	(cd svnwc; svn info directory) > expected.info-directory &&
 	(cd gitwc; git-svn info directory) > actual.info-directory &&
-	git-diff expected.info-directory actual.info-directory
+	test_cmp expected.info-directory actual.info-directory
 	"
 
 test_expect_success 'info --url directory' '
@@ -100,7 +100,7 @@ test_expect_success 'info --url directory' '
 test_expect_success 'info symlink-file' "
 	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
 	(cd gitwc; git-svn info symlink-file) > actual.info-symlink-file &&
-	git-diff expected.info-symlink-file actual.info-symlink-file
+	test_cmp expected.info-symlink-file actual.info-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file' '
@@ -113,7 +113,7 @@ test_expect_success 'info symlink-directory' "
 		> expected.info-symlink-directory &&
 	(cd gitwc; git-svn info symlink-directory) \
 		> actual.info-symlink-directory &&
-	git-diff expected.info-symlink-directory actual.info-symlink-directory
+	test_cmp expected.info-symlink-directory actual.info-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory' '
@@ -133,7 +133,7 @@ test_expect_success 'info added-file' "
 	cd .. &&
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
 	(cd gitwc; git-svn info added-file) > actual.info-added-file &&
-	git-diff expected.info-added-file actual.info-added-file
+	test_cmp expected.info-added-file actual.info-added-file
 	"
 
 test_expect_success 'info --url added-file' '
@@ -155,7 +155,7 @@ test_expect_success 'info added-directory' "
 		> expected.info-added-directory &&
 	(cd gitwc; git-svn info added-directory) \
 		> actual.info-added-directory &&
-	git-diff expected.info-added-directory actual.info-added-directory
+	test_cmp expected.info-added-directory actual.info-added-directory
 	"
 
 test_expect_success 'info --url added-directory' '
@@ -177,7 +177,7 @@ test_expect_success 'info added-symlink-file' "
 		> expected.info-added-symlink-file &&
 	(cd gitwc; git-svn info added-symlink-file) \
 		> actual.info-added-symlink-file &&
-	git-diff expected.info-added-symlink-file \
+	test_cmp expected.info-added-symlink-file \
 		 actual.info-added-symlink-file
 	"
 
@@ -200,7 +200,7 @@ test_expect_success 'info added-symlink-directory' "
 		> expected.info-added-symlink-directory &&
 	(cd gitwc; git-svn info added-symlink-directory) \
 		> actual.info-added-symlink-directory &&
-	git-diff expected.info-added-symlink-directory \
+	test_cmp expected.info-added-symlink-directory \
 		 actual.info-added-symlink-directory
 	"
 
@@ -227,7 +227,7 @@ test_expect_success 'info deleted-file' "
 	(cd gitwc; git-svn info file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> actual.info-deleted-file &&
-	git-diff expected.info-deleted-file actual.info-deleted-file
+	test_cmp expected.info-deleted-file actual.info-deleted-file
 	"
 
 test_expect_success 'info --url file (deleted)' '
@@ -248,7 +248,7 @@ test_expect_success 'info deleted-directory' "
 	(cd gitwc; git-svn info directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> actual.info-deleted-directory &&
-	git-diff expected.info-deleted-directory actual.info-deleted-directory
+	test_cmp expected.info-deleted-directory actual.info-deleted-directory
 	"
 
 test_expect_success 'info --url directory (deleted)' '
@@ -269,7 +269,7 @@ test_expect_success 'info deleted-symlink-file' "
 	(cd gitwc; git-svn info symlink-file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> actual.info-deleted-symlink-file &&
-	git-diff expected.info-deleted-symlink-file \
+	test_cmp expected.info-deleted-symlink-file \
 		 actual.info-deleted-symlink-file
 	"
 
@@ -291,7 +291,7 @@ test_expect_success 'info deleted-symlink-directory' "
 	(cd gitwc; git-svn info symlink-directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		 > actual.info-deleted-symlink-directory &&
-	git-diff expected.info-deleted-symlink-directory \
+	test_cmp expected.info-deleted-symlink-directory \
 		 actual.info-deleted-symlink-directory
 	"
 
@@ -309,13 +309,13 @@ test_expect_success 'info unknown-file' "
 	ptouch gitwc/unknown-file svnwc/unknown-file &&
 	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
 	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
-	git-diff expected.info-unknown-file actual.info-unknown-file
+	test_cmp expected.info-unknown-file actual.info-unknown-file
 	"
 
 test_expect_success 'info --url unknown-file' '
 	test -z "$(cd gitwc; git-svn info --url unknown-file \
 			2> ../actual.info--url-unknown-file)" &&
-	git-diff expected.info-unknown-file actual.info--url-unknown-file
+	test_cmp expected.info-unknown-file actual.info--url-unknown-file
 	'
 
 test_expect_success 'info unknown-directory' "
@@ -326,13 +326,13 @@ test_expect_success 'info unknown-directory' "
 		2> expected.info-unknown-directory &&
 	(cd gitwc; git-svn info unknown-directory) \
 		2> actual.info-unknown-directory &&
-	git-diff expected.info-unknown-directory actual.info-unknown-directory
+	test_cmp expected.info-unknown-directory actual.info-unknown-directory
 	"
 
 test_expect_success 'info --url unknown-directory' '
 	test -z "$(cd gitwc; git-svn info --url unknown-directory \
 			2> ../actual.info--url-unknown-directory)" &&
-	git-diff expected.info-unknown-directory \
+	test_cmp expected.info-unknown-directory \
 		 actual.info--url-unknown-directory
 	'
 
@@ -348,14 +348,14 @@ test_expect_success 'info unknown-symlink-file' "
 		2> expected.info-unknown-symlink-file &&
 	(cd gitwc; git-svn info unknown-symlink-file) \
 		2> actual.info-unknown-symlink-file &&
-	git-diff expected.info-unknown-symlink-file \
+	test_cmp expected.info-unknown-symlink-file \
 		 actual.info-unknown-symlink-file
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
 	test -z "$(cd gitwc; git-svn info --url unknown-symlink-file \
 			2> ../actual.info--url-unknown-symlink-file)" &&
-	git-diff expected.info-unknown-symlink-file \
+	test_cmp expected.info-unknown-symlink-file \
 		 actual.info--url-unknown-symlink-file
 	'
 
@@ -372,14 +372,14 @@ test_expect_success 'info unknown-symlink-directory' "
 		2> expected.info-unknown-symlink-directory &&
 	(cd gitwc; git-svn info unknown-symlink-directory) \
 		2> actual.info-unknown-symlink-directory &&
-	git-diff expected.info-unknown-symlink-directory \
+	test_cmp expected.info-unknown-symlink-directory \
 		 actual.info-unknown-symlink-directory
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
 	test -z "$(cd gitwc; git-svn info --url unknown-symlink-directory \
 			2> ../actual.info--url-unknown-symlink-directory)" &&
-	git-diff expected.info-unknown-symlink-directory \
+	test_cmp expected.info-unknown-symlink-directory \
 		 actual.info--url-unknown-symlink-directory
 	'
 
-- 
1.6.0.1.96.g9307e.dirty
