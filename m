From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/8] t3900: use ancient iconv names for backward compatibility
Date: Mon, 18 May 2009 18:44:38 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CW2-0003Pz-Sn
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZERXo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbZERXo6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:44:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50112 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZERXo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:56 -0400
Received: by mail.nrlssc.navy.mil id n4INitKK024906; Mon, 18 May 2009 18:44:56 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0074 (UTC) FILETIME=[A5480020:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119473>

Some old iconv implementations do not have many alternate names and/or
do not match character encoding names case insensitively.  These
implementations can not tell that utf-8 and UTF-8 are the same encoding
and fail when trying to do the conversion.  So use the old names, which
modern implementations still support.

The following conversions were performed:

         utf-8 --> UTF-8
    ISO-8859-1 --> ISO8859-1
         EUCJP --> eucJP

Also update t9129 and t9500 which make use of the test files in t/t3900.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3900-i18n-commit.sh                    |   28 ++++++++++++++--------------
 t/t3900/{ISO-8859-1.txt => ISO8859-1.txt} |    0
 t/t3900/{EUCJP.txt => eucJP.txt}          |    0
 t/t9129-git-svn-i18n-commitencoding.sh    |   10 +++++-----
 t/t9500-gitweb-standalone-no-errors.sh    |    2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)
 rename t/t3900/{ISO-8859-1.txt => ISO8859-1.txt} (100%)
 rename t/t3900/{EUCJP.txt => eucJP.txt} (100%)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index b4ec2b5..256c4c9 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,7 +34,7 @@ test_expect_success 'no encoding header for base case' '
 	test z = "z$E"
 '
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
 		git config i18n.commitencoding $H &&
@@ -44,7 +44,7 @@ do
 	'
 done
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "check encoding header for $H" '
 		E=$(git cat-file commit '$H' | sed -ne "s/^encoding //p") &&
@@ -61,14 +61,14 @@ test_expect_success 'config to remove customization' '
 	else
 		test z = "z$Z"
 	fi &&
-	git config i18n.commitencoding utf-8
+	git config i18n.commitencoding UTF-8
 '
 
-test_expect_success 'ISO-8859-1 should be shown in UTF-8 now' '
-	compare_with ISO-8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
+test_expect_success 'ISO8859-1 should be shown in UTF-8 now' '
+	compare_with ISO8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
 '
 
-for H in EUCJP ISO-2022-JP
+for H in eucJP ISO-2022-JP
 do
 	test_expect_success "$H should be shown in UTF-8 now" '
 		compare_with '$H' "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
@@ -86,7 +86,7 @@ test_expect_success 'config to add customization' '
 	fi
 '
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H should be shown in itself now" '
 		git config i18n.commitencoding '$H' &&
@@ -95,21 +95,21 @@ do
 done
 
 test_expect_success 'config to tweak customization' '
-	git config i18n.logoutputencoding utf-8
+	git config i18n.logoutputencoding UTF-8
 '
 
-test_expect_success 'ISO-8859-1 should be shown in UTF-8 now' '
-	compare_with ISO-8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
+test_expect_success 'ISO8859-1 should be shown in UTF-8 now' '
+	compare_with ISO8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
 '
 
-for H in EUCJP ISO-2022-JP
+for H in eucJP ISO-2022-JP
 do
 	test_expect_success "$H should be shown in UTF-8 now" '
 		compare_with '$H' "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
 	'
 done
 
-for J in EUCJP ISO-2022-JP
+for J in eucJP ISO-2022-JP
 do
 	if test "$J" = ISO-2022-JP
 	then
@@ -118,7 +118,7 @@ do
 		ICONV=
 	fi
 	git config i18n.logoutputencoding $J
-	for H in EUCJP ISO-2022-JP
+	for H in eucJP ISO-2022-JP
 	do
 		test_expect_success "$H should be shown in $J now" '
 			compare_with '$H' "$TEST_DIRECTORY"/t3900/'$J'.txt $ICONV
@@ -126,7 +126,7 @@ do
 	done
 done
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "No conversion with $H" '
 		compare_with "--encoding=none '$H'" "$TEST_DIRECTORY"/t3900/'$H'.txt
diff --git a/t/t3900/ISO-8859-1.txt b/t/t3900/ISO8859-1.txt
similarity index 100%
rename from t/t3900/ISO-8859-1.txt
rename to t/t3900/ISO8859-1.txt
diff --git a/t/t3900/EUCJP.txt b/t/t3900/eucJP.txt
similarity index 100%
rename from t/t3900/EUCJP.txt
rename to t/t3900/eucJP.txt
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 3200ab3..6c6d033 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -29,7 +29,7 @@ compare_svn_head_with () {
 	test_cmp current "$1"
 }
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
 		mkdir $H &&
@@ -38,7 +38,7 @@ do
 	'
 done
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H commit on git side" '
 	(
@@ -55,7 +55,7 @@ do
 	'
 done
 
-for H in ISO-8859-1 EUCJP ISO-2022-JP
+for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H dcommit to svn" '
 	(
@@ -77,12 +77,12 @@ fi
 
 test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
 	(
-		cd ISO-8859-1 &&
+		cd ISO8859-1 &&
 		compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
 	)
 '
 
-for H in EUCJP ISO-2022-JP
+for H in eucJP ISO-2022-JP
 do
 	test_expect_success UTF8 "$H should match UTF-8 in svn" '
 		(
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index f4210fb..d539619 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -590,7 +590,7 @@ test_expect_success \
 	 echo "ISO-8859-1" >> file &&
 	 git add file &&
 	 git config i18n.commitencoding ISO-8859-1 &&
-	 git commit -F "$TEST_DIRECTORY"/t3900/ISO-8859-1.txt &&
+	 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
 	 git config --unset i18n.commitencoding &&
 	 gitweb_run "p=.git;a=commit"'
 test_debug 'cat gitweb.log'
-- 
1.6.3.1.24.g152f4
