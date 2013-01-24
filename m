From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 2/4] t7102 (reset): refactoring: don't hardcode SHA-1 in expected outputs
Date: Thu, 24 Jan 2013 13:10:26 +0400
Message-ID: <63637506fa940f6dd5fc050c7fccfa5ef41993dd.1359018188.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 10:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIqT-0002y0-9q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 10:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab3AXJLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 04:11:17 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60339 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab3AXJLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 04:11:15 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so2382213lbo.19
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=EBU5nUnqKM39bIKlr35SVdWF4KtqXpCXemd1r45aH5k=;
        b=mw2vpR0PPLTMeojAIE/Lj53tUOWDz+SCfuFE7PQRyxTvVLDkHDJlMlWKPCbAdkob0E
         XHM016fG6Q1pAwhfd+K61pNXn/XhEUBtthjxFpUvWEHoZ0vbK0gfIyEGqrxgImJRTx5t
         jOUMonTctMTZfbt/hObTl61qdPSDc03WS+Rzxh8002y5VHFRJ4+TfpmvAEikz9Xleq4l
         drJj36a8J3PbI+8z6lWbKMt6CyQGLgVRzT7TerSZaFVYItmLH7eXn/ebKMjq6k8V9rxO
         9/iMK3IL0POlMst+Q2B7+P2mPbtIt6aL6hbZ51uBPGOZkmg443WIhzmlDMYEdRf4+7uS
         Hm2g==
X-Received: by 10.152.111.102 with SMTP id ih6mr1142457lab.20.1359018673952;
        Thu, 24 Jan 2013 01:11:13 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id u5sm9304115lbm.8.2013.01.24.01.11.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 01:11:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 8A4E760017;
	Thu, 24 Jan 2013 13:11:44 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
References: <20110921004602.3d59bed4@zappedws> <cover.1359018188.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214421>

The expected SHA-1 digests are always available in variables.  Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t7102-reset.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b096dc8..cf492f4 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -28,7 +28,8 @@ test_expect_success 'creating initial files and commits' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file"
+	git commit -a -m "modify 2nd file" &&
+	head5=$(git rev-parse --verify HEAD)
 '
 # git log --pretty=oneline # to see those SHA1 involved
 
@@ -56,7 +57,7 @@ test_expect_success 'giving a non existing revision should fail' '
 	test_must_fail git reset --mixed aaaaaa &&
 	test_must_fail git reset --soft aaaaaa &&
 	test_must_fail git reset --hard aaaaaa &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 test_expect_success 'reset --soft with unmerged index should fail' '
@@ -74,7 +75,7 @@ test_expect_success \
 	test_must_fail git reset --hard -- first &&
 	test_must_fail git reset --soft HEAD^ -- first &&
 	test_must_fail git reset --hard HEAD^ -- first &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 test_expect_success 'giving unrecognized options should fail' '
@@ -86,7 +87,7 @@ test_expect_success 'giving unrecognized options should fail' '
 	test_must_fail git reset --soft -o &&
 	test_must_fail git reset --hard --other &&
 	test_must_fail git reset --hard -o &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 test_expect_success \
@@ -110,7 +111,7 @@ test_expect_success \
 
 	git checkout master &&
 	git branch -D branch1 branch2 &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 test_expect_success \
@@ -133,27 +134,27 @@ test_expect_success \
 
 	git checkout master &&
 	git branch -D branch3 branch4 &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 test_expect_success \
 	'resetting to HEAD with no changes should succeed and do nothing' '
 	git reset --hard &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset --hard HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset --soft &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset --soft HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset --mixed &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset --mixed HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+		check_changes $head5 &&
 	git reset HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes $head5
 '
 
 >.diff_expect
@@ -176,7 +177,7 @@ test_expect_success '--soft reset only should show changes in diff --cached' '
 	git reset --soft HEAD^ &&
 	check_changes d1a4bc3abce4829628ae2dcb0d60ef3d1a78b1c4 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
-			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+			$head5
 '
 
 >.diff_expect
@@ -193,7 +194,7 @@ test_expect_success \
 	git commit -a -C ORIG_HEAD &&
 	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
 	test "$(git rev-parse ORIG_HEAD)" = \
-			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+			$head5
 '
 
 >.diff_expect
@@ -303,7 +304,7 @@ test_expect_success 'redoing the last two commits should succeed' '
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
 	git commit -a -m "modify 2nd file" &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 >.diff_expect
@@ -341,15 +342,15 @@ EOF
 test_expect_success \
 	'--hard reset to ORIG_HEAD should clear a fast-forward merge' '
 	git reset --hard HEAD^ &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+	check_changes $head5 &&
 
 	git pull . branch1 &&
 	git reset --hard ORIG_HEAD &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
+	check_changes $head5 &&
 
 	git checkout master &&
 	git branch -D branch1 branch2 &&
-	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+	check_changes $head5
 '
 
 cat > expect << EOF
-- 
1.8.1.1.10.g9255f3f
