From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] t3030 (merge-recursive): use test_expect_code
Date: Thu,  8 Dec 2011 18:40:13 +0530
Message-ID: <1323349817-15737-5-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdlJ-0004PD-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1LHNLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:35 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50863 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1LHNLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:34 -0500
Received: by qcqz2 with SMTP id z2so1236541qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A1wZSn64yTm1E3Gd7kA4qTL8BH3dzbfPtwZ6YdRHrCE=;
        b=VWeTwDSwOH2WtDwMN91ugX7GaQpASA3WyuKEYX4pngIT4YSAPZLx1TIQzg23BvzcsM
         R4wV6t0HUs3VYs+HN6D5Yq7y47PsRkYLCkyN6FkWmkF3MTP1KHz4/oAehklijHn/u9d2
         bdVDMT6ut6AKm4P0FtBj62lBuhFcPHdUrRrPc=
Received: by 10.50.208.100 with SMTP id md4mr3746402igc.9.1323349893519;
        Thu, 08 Dec 2011 05:11:33 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:33 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186556>

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
