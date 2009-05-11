From: Don Slutz <slutz@krl.com>
Subject: (unknown)
Date: Mon, 11 May 2009 14:57:12 -0400
Message-ID: <200905111857.n4BIvC7S002321@krl.krl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3b81-0005Ox-2A
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbZEKTZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755687AbZEKTZW
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:25:22 -0400
Received: from krl.krl.com ([192.147.32.3]:42939 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755188AbZEKTZU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:25:20 -0400
X-Greylist: delayed 1681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 15:25:15 EDT
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BIvDrA002332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 May 2009 14:57:13 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BIvC7S002321
	for git@vger.kernel.org; Mon, 11 May 2009 14:57:12 -0400
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118822>

>From d60f6f2fdfcdc5cbbd468992ccbc56438fe0e149 Mon Sep 17 00:00:00 2001
From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Date: Mon, 11 May 2009 12:16:55 -0400
Subject: [PATCH 4/6] Fix tests to work with core.autocrlf=true

Force core.autocrlf=false for these tests.  Most of these tests are checking
for whitespace differences and so are not simple to fix.  The rest are not
clear how to fix.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/t1002-read-tree-m-u-2way.sh |    3 ++-
 t/t4015-diff-whitespace.sh    |    2 ++
 t/t4019-diff-wserror.sh       |    1 +
 t/t4116-apply-reverse.sh      |    1 +
 t/t4200-rerere.sh             |    2 ++
 5 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 5e40cec..acc9474 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -37,7 +37,8 @@ check_cache_at () {
 
 test_expect_success \
     setup \
-    'echo frotz >frotz &&
+    'git config core.autocrlf false &&
+     echo frotz >frotz &&
      echo nitfol >nitfol &&
      echo bozbar >bozbar &&
      echo rezrov >rezrov &&
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6d13da3..122557e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -9,6 +9,8 @@ test_description='Test special whitespace in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
+test_expect_success "setup" 'git config core.autocrlf false'
+
 # Ray Lehtiniemi's example
 
 cat << EOF > x
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 84a1fe3..a580403 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -6,6 +6,7 @@ test_description='diff whitespace error detection'
 
 test_expect_success setup '
 
+	git config core.autocrlf false &&
 	git config diff.color.whitespace "blue reverse" &&
 	>F &&
 	git add F &&
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 2298ece..a846be6 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -11,6 +11,7 @@ test_description='git apply in reverse
 
 test_expect_success setup '
 
+	git config core.autocrlf false &&
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
 	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a6bc028..5e6cc82 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -8,6 +8,8 @@ test_description='git rerere
 
 . ./test-lib.sh
 
+git config core.autocrlf false
+
 cat > a1 << EOF
 Some title
 ==========
-- 
1.6.3.15.g49878
