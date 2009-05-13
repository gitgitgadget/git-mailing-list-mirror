From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 4/7] Fix tests to work with core.autocrlf=true -- force false
Date: Wed, 13 May 2009 15:35:45 -0400
Message-ID: <1242243348-6690-5-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KGr-0006Xb-IG
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532AbZEMTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZEMTgZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:25 -0400
Received: from krl.krl.com ([192.147.32.3]:59307 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994AbZEMTgK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:10 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJa6HS006802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:06 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJa6IG006801;
	Wed, 13 May 2009 15:36:06 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119099>

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
