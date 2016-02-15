From: larsxschneider@gmail.com
Subject: [PATCH v4 1/3] t: do not hide Git's exit code in tests
Date: Mon, 15 Feb 2016 11:17:44 +0100
Message-ID: <1455531466-16617-2-git-send-email-larsxschneider@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 11:18:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVGEC-0003TV-HM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbcBOKRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:17:52 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36961 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbcBOKRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:17:51 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so101775202wme.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+tcH92b9Mr48Zy0HJwDCp6plOG6wOAzCyaDGBjLetDo=;
        b=nB7KRtUFMhyO0eSjUXP21CsOZM7Yle6ybTB8Wrqw5WGUkEMa4FyWvNxPzT0GlinpIH
         pXZ3BXldDm4z6t9Xny2mrxyo5H5dA69Hq7L0YmwyKTKJGFMW79tKiJmea+rbtQ8h95jn
         J2k82Mem1ndb4TBsHgyrLnmdUF6J2jqkVNe2fiXFolXJRL/q62KDbw6hru3gxHAjgwNw
         v6MUOTNEEKsTo5VenKPctbH/Y/uIjv7JbwKRyMhot1mbObNwxlV+1sFD9C+UvMPRbgD8
         IABNqhHUSVPNroHr/WaLu90td9HwGyPAVtmVJZoPiR9t2Cv41QjQ5Ndgwo2V68fSnlhV
         9xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+tcH92b9Mr48Zy0HJwDCp6plOG6wOAzCyaDGBjLetDo=;
        b=ft+X1qKv0W7Do57xS/F9+k+nR8Iook461CAZZTa3hbS6TcOAgjP5M8v13zbkliS77A
         dTwd+QE6OR1ay2H3eDr6XpyqalddinPh1cfOKDDcpHfpRQLcfyoOhNRJezDhaeEsyrsL
         6XloG330MZ8NI6/Qkbke+KVX4JbpkqIW0JFaywMxRr1Y2f7Ns5k6m4F0kkq6nOpM9Wim
         H1g6kWZo6aKz+ramLRAoYlt7AHBi3WaCVBm/poxhBRBDS2EkKcE7wE1ojOFRI0GmTBlh
         B2IE5NvFb6qhx5/ja3neQU/8Tbx2njW9aNn9G8sMPp9V8xofMbWO0Jup1BapXNwik/Vw
         ZEAg==
X-Gm-Message-State: AG10YOTbVc//m/Sgi/hMig1q35lzWD92/g5BCOIKn8n4y0Mp418lijJmoscaIuAC60WmxA==
X-Received: by 10.28.182.136 with SMTP id g130mr12024578wmf.10.1455531470223;
        Mon, 15 Feb 2016 02:17:50 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB477C.dip0.t-ipconnect.de. [93.219.71.124])
        by smtp.gmail.com with ESMTPSA id i5sm24494120wja.23.2016.02.15.02.17.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 02:17:49 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286199>

From: Lars Schneider <larsxschneider@gmail.com>

Git should not be on the left-hand side of a pipe, because it hides the exit
code, and we want to make sure git does not fail.

There is one more occurrence of this pattern in t9010-svn-fe.sh which is to
evolved to change it easily.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t1300-repo-config.sh | 6 ++++--
 t/t7008-grep-binary.sh | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..1782add 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -957,13 +957,15 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list | nul_to_q >result &&
+	git config --null --list >result.raw &&
+	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
 
 test_expect_success '--null --get-regexp' '
-	git config --null --get-regexp "val[0-9]" | nul_to_q >result &&
+	git config --null --get-regexp "val[0-9]" >result.raw &&
+	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index b146406..9c9c378 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -141,7 +141,8 @@ test_expect_success 'grep respects not-binary diff attribute' '
 	test_cmp expect actual &&
 	echo "b diff" >.gitattributes &&
 	echo "b:binQary" >expect &&
-	git grep bin b | nul_to_q >actual &&
+	git grep bin b >actual.raw &&
+	nul_to_q <actual.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.5.1
