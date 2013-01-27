From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 13/21] git p4 test: avoid wildcard * in windows
Date: Sat, 26 Jan 2013 22:11:16 -0500
Message-ID: <1359256284-5660-14-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:16:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIj3-0006BI-Ut
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab3A0DPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:15:49 -0500
Received: from honk.padd.com ([74.3.171.149]:58733 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:15:48 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id A59EF2F3F;
	Sat, 26 Jan 2013 19:15:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B85BF22838; Sat, 26 Jan 2013 22:15:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214664>

This character is not valid in windows filenames, even though
it can appear in p4 depot paths.  Avoid using it in tests on
windows, both mingw and cygwin.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9809-git-p4-client-view.sh | 10 ++++++++--
 t/t9812-git-p4-wildcards.sh   | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 0b58fb9..a911988 100755
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
1.8.1.1.460.g6fa8886
