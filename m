From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 13/21] git p4 test: avoid wildcard * in windows
Date: Fri, 28 Sep 2012 08:04:17 -0400
Message-ID: <1348833865-6093-14-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZNL-0003Ea-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab2I1MIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:08:50 -0400
Received: from honk.padd.com ([74.3.171.149]:34980 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I1MIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:08:50 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 975AB5AF2;
	Fri, 28 Sep 2012 05:08:49 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 22CB131413; Fri, 28 Sep 2012 08:08:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206570>

This character is not valid in windows filenames, even though
it can appear in p4 depot paths.  Avoid using it in tests on
windows, both mingw and cygwin.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9809-git-p4-client-view.sh | 10 ++++++++--
 t/t9812-git-p4-wildcards.sh   | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 281be29..fd8fa89 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -365,7 +365,10 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >dir1/git-wild#hash &&
-		echo git-wild-star >dir1/git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			echo git-wild-star >dir1/git-wild\*star
+		fi &&
 		echo git-wild-at >dir1/git-wild@at &&
 		echo git-wild-percent >dir1/git-wild%percent &&
 		git add dir1/git-wild* &&
@@ -376,7 +379,10 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$cli" &&
 		test_path_is_file dir1/git-wild#hash &&
-		test_path_is_file dir1/git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			test_path_is_file dir1/git-wild\*star
+		fi &&
 		test_path_is_file dir1/git-wild@at &&
 		test_path_is_file dir1/git-wild%percent
 	) &&
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 143d413..6763325 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -14,7 +14,10 @@ test_expect_success 'add p4 files with wildcards in the names' '
 		printf "file2\nhas\nsome\nrandom\ntext\n" >file2 &&
 		p4 add file2 &&
 		echo file-wild-hash >file-wild#hash &&
-		echo file-wild-star >file-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			echo file-wild-star >file-wild\*star
+		fi &&
 		echo file-wild-at >file-wild@at &&
 		echo file-wild-percent >file-wild%percent &&
 		p4 add -f file-wild* &&
@@ -28,7 +31,10 @@ test_expect_success 'wildcard files git p4 clone' '
 	(
 		cd "$git" &&
 		test -f file-wild#hash &&
-		test -f file-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			test -f file-wild\*star
+		fi &&
 		test -f file-wild@at &&
 		test -f file-wild%percent
 	)
@@ -40,7 +46,10 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >git-wild#hash &&
-		echo git-wild-star >git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			echo git-wild-star >git-wild\*star
+		fi &&
 		echo git-wild-at >git-wild@at &&
 		echo git-wild-percent >git-wild%percent &&
 		git add git-wild* &&
@@ -51,7 +60,10 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$cli" &&
 		test_path_is_file git-wild#hash &&
-		test_path_is_file git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			test_path_is_file git-wild\*star
+		fi &&
 		test_path_is_file git-wild@at &&
 		test_path_is_file git-wild%percent
 	)
@@ -63,7 +75,10 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$git" &&
 		echo new-line >>git-wild#hash &&
-		echo new-line >>git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			echo new-line >>git-wild\*star
+		fi &&
 		echo new-line >>git-wild@at &&
 		echo new-line >>git-wild%percent &&
 		git add git-wild* &&
@@ -74,7 +89,10 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$cli" &&
 		test_line_count = 2 git-wild#hash &&
-		test_line_count = 2 git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			test_line_count = 2 git-wild\*star
+		fi &&
 		test_line_count = 2 git-wild@at &&
 		test_line_count = 2 git-wild%percent
 	)
@@ -87,7 +105,7 @@ test_expect_success 'wildcard files submit back to p4, copy' '
 		cd "$git" &&
 		cp file2 git-wild-cp#hash &&
 		git add git-wild-cp#hash &&
-		cp git-wild\*star file-wild-3 &&
+		cp git-wild#hash file-wild-3 &&
 		git add file-wild-3 &&
 		git commit -m "wildcard copies" &&
 		git config git-p4.detectCopies true &&
@@ -134,7 +152,10 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 	(
 		cd "$cli" &&
 		test_path_is_missing git-wild#hash &&
-		test_path_is_missing git-wild\*star &&
+		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		then
+			test_path_is_missing git-wild\*star
+		fi &&
 		test_path_is_missing git-wild@at &&
 		test_path_is_missing git-wild%percent
 	)
-- 
1.7.12.1.403.g28165e1
