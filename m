From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/15] t3030 (merge-recursive): use test_expect_code
Date: Thu,  8 Dec 2011 01:06:49 +0530
Message-ID: <1323286611-4806-14-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKK-0001Jr-Ex
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab1LGTip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:44 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A1wZSn64yTm1E3Gd7kA4qTL8BH3dzbfPtwZ6YdRHrCE=;
        b=FIrWl+zUZ2XkRQg+o95BWjh0QwtDCTVCzLzi/VQG/6zNniS9Upx5FakG4i+kkuPhjQ
         IEDL3G5yjku+W79jhCi+4Jm+rC12FPmoRTJkBV3wN54tRzSZ2bZddFZOvSVPAMRY7U5D
         uECEcSsg7DpDJeui0rUKsr+Gh8XdwXsQT/OZo=
Received: by 10.42.150.135 with SMTP id a7mr136265icw.53.1323286724187;
        Wed, 07 Dec 2011 11:38:44 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:43 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186494>

Use test_expect_code in preference to repeatedly checking exit codes
by hand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3030-merge-recursive.sh |   72 ++++----------------------------------------
 1 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 55ef189..a5e3da7 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -285,17 +285,7 @@ test_expect_success 'merge-recursive simple' '
 	rm -fr [abcd] &&
 	git checkout -f "$c2" &&
 
-	git merge-recursive "$c0" -- "$c2" "$c1"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c2" "$c1"
 '
 
 test_expect_success 'merge-recursive result' '
@@ -334,17 +324,7 @@ test_expect_success 'merge-recursive remove conflict' '
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
 
-	git merge-recursive "$c0" -- "$c1" "$c5"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c1" "$c5"
 '
 
 test_expect_success 'merge-recursive remove conflict' '
@@ -388,17 +368,7 @@ test_expect_success 'merge-recursive d/f conflict' '
 	git reset --hard &&
 	git checkout -f "$c1" &&
 
-	git merge-recursive "$c0" -- "$c1" "$c4"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c1" "$c4"
 '
 
 test_expect_success 'merge-recursive d/f conflict result' '
@@ -422,17 +392,7 @@ test_expect_success 'merge-recursive d/f conflict the other way' '
 	git reset --hard &&
 	git checkout -f "$c4" &&
 
-	git merge-recursive "$c0" -- "$c4" "$c1"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c4" "$c1"
 '
 
 test_expect_success 'merge-recursive d/f conflict result the other way' '
@@ -456,17 +416,7 @@ test_expect_success 'merge-recursive d/f conflict' '
 	git reset --hard &&
 	git checkout -f "$c1" &&
 
-	git merge-recursive "$c0" -- "$c1" "$c6"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c1" "$c6"
 '
 
 test_expect_success 'merge-recursive d/f conflict result' '
@@ -490,17 +440,7 @@ test_expect_success 'merge-recursive d/f conflict' '
 	git reset --hard &&
 	git checkout -f "$c6" &&
 
-	git merge-recursive "$c0" -- "$c6" "$c1"
-	status=$?
-	case "$status" in
-	1)
-		: happy
-		;;
-	*)
-		echo >&2 "why status $status!!!"
-		false
-		;;
-	esac
+	test_expect_code 1 git merge-recursive "$c0" -- "$c6" "$c1"
 '
 
 test_expect_success 'merge-recursive d/f conflict result' '
-- 
1.7.7.3
