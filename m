From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Remove duplication in t9119-git-svn-info.sh
Date: Mon, 31 Dec 2007 15:33:19 -0800
Message-ID: <1199143999-6859-1-git-send-email-ddkilzer@kilzer.net>
References: <7vodc65whw.fsf@gitster.siamese.dyndns.org>
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9U8m-0004Cz-IE
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 00:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXLaXdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXLaXdW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 18:33:22 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:54467 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXLaXdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 18:33:22 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id 9E5421CB3CB0;
	Mon, 31 Dec 2007 15:33:21 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 80DA228082;
	Mon, 31 Dec 2007 15:33:21 -0800 (PST)
X-AuditID: 11807130-a9e4ebb000004fb9-17-47797c41217a
Received: from localhost.localdomain (unknown [17.151.86.187])
	by relay11.apple.com (Apple SCV relay) with ESMTP id 1ED5E2804D;
	Mon, 31 Dec 2007 15:33:21 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <7vodc65whw.fsf@gitster.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69425>

Simplify arguments to ptouch bash function.
---
 t/t9119-git-svn-info.sh |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 6d9bec9..907058e 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -20,7 +20,7 @@ ptouch() {
 			my $atime = $mtime;
 			utime $atime, $mtime, $git_file;
 		}
-	' "`svn info $1 | grep '^Text Last Updated:'`" "$2"
+	' "`svn info svnwc/$1 | grep '^Text Last Updated:'`" "gitwc/$1"
 }
 
 test_expect_success 'setup repository and import' "
@@ -40,10 +40,10 @@ test_expect_success 'setup repository and import' "
 		git-svn fetch &&
 	cd .. &&
 	svn co $svnrepo svnwc &&
-	ptouch svnwc/file gitwc/file &&
-	ptouch svnwc/directory gitwc/directory &&
-	ptouch svnwc/symlink-file gitwc/symlink-file &&
-	ptouch svnwc/symlink-directory gitwc/symlink-directory
+	ptouch file &&
+	ptouch directory &&
+	ptouch symlink-file &&
+	ptouch symlink-directory
 	"
 
 test_expect_success 'info' "
@@ -116,7 +116,7 @@ test_expect_success 'info added-file' "
 		git add added-file &&
 	cd .. &&
 	cp gitwc/added-file svnwc/added-file &&
-	ptouch svnwc/added-file gitwc/added-file &&
+	ptouch added-file &&
 	cd svnwc &&
 		svn add added-file > /dev/null &&
 	cd .. &&
@@ -132,7 +132,7 @@ test_expect_success 'info --url added-file' '
 
 test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
-	ptouch svnwc/added-directory gitwc/added-directory &&
+	ptouch added-directory &&
 	touch gitwc/added-directory/.placeholder &&
 	cd svnwc &&
 		svn add added-directory > /dev/null &&
@@ -161,7 +161,7 @@ test_expect_success 'info added-symlink-file' "
 		ln -s added-file added-symlink-file &&
 		svn add added-symlink-file > /dev/null &&
 	cd .. &&
-	ptouch svnwc/added-symlink-file gitwc/added-symlink-file &&
+	ptouch added-symlink-file &&
 	(cd svnwc; svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
 	(cd gitwc; git-svn info added-symlink-file) \
@@ -184,7 +184,7 @@ test_expect_success 'info added-symlink-directory' "
 		ln -s added-directory added-symlink-directory &&
 		svn add added-symlink-directory > /dev/null &&
 	cd .. &&
-	ptouch svnwc/added-symlink-directory gitwc/added-symlink-directory &&
+	ptouch added-symlink-directory &&
 	(cd svnwc; svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
 	(cd gitwc; git-svn info added-symlink-directory) \
@@ -295,7 +295,7 @@ test_expect_success 'info --url symlink-directory (deleted)' '
 test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
 	cp gitwc/unknown-file svnwc/unknown-file &&
-	ptouch svnwc/unknown-file gitwc/unknown-file &&
+	ptouch unknown-file &&
 	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
 	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
 	git-diff expected.info-unknown-file actual.info-unknown-file
@@ -309,7 +309,7 @@ test_expect_success 'info --url unknown-file' '
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	ptouch svnwc/unknown-directory gitwc/unknown-directory &&
+	ptouch unknown-directory &&
 	touch gitwc/unknown-directory/.placeholder &&
 	(cd svnwc; svn info unknown-directory) \
 		2> expected.info-unknown-directory &&
@@ -332,7 +332,7 @@ test_expect_success 'info unknown-symlink-file' "
 	cd svnwc &&
 		ln -s unknown-file unknown-symlink-file &&
 	cd .. &&
-	ptouch svnwc/unknown-symlink-file gitwc/unknown-symlink-file &&
+	ptouch unknown-symlink-file &&
 	(cd svnwc; svn info unknown-symlink-file) \
 		2> expected.info-unknown-symlink-file &&
 	(cd gitwc; git-svn info unknown-symlink-file) \
@@ -355,8 +355,7 @@ test_expect_success 'info unknown-symlink-directory' "
 	cd svnwc &&
 		ln -s unknown-directory unknown-symlink-directory &&
 	cd .. &&
-	ptouch svnwc/unknown-symlink-directory \
-	       gitwc/unknown-symlink-directory &&
+	ptouch unknown-symlink-directory &&
 	(cd svnwc; svn info unknown-symlink-directory) \
 		2> expected.info-unknown-symlink-directory &&
 	(cd gitwc; git-svn info unknown-symlink-directory) \
-- 
1.5.3.7
