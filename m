From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 4/7] t5520: factor out common code
Date: Sat,  2 Apr 2016 23:28:29 +0530
Message-ID: <1459619912-5445-5-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:01:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPr5-0000O2-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcDBSA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:00:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35158 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbcDBSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:00:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so7510581pfr.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zpwBvFrs/tmp9KwGLerH3fJ6HEm+hwg0aRloxrT4Ug=;
        b=yY2YInXdjyavMoRrxL1KEMX4yHza6k9en81HiYaH2hVvPHcA5xBAHn6PzbldAkcXK5
         jLDoc5eWEIuYXuq8BLVV4s+MsKqhNApcvRX3wgzTRVVW9TpeXhDjjIMg+thO7je89pAZ
         FCctFjYcvwA52YBE38al0Mx4Vqn0hYXB5J9ven5P9z0oEjMXOacaRV131HpklDbqBrkY
         enz7zgQpX2VD6NcxTZ5ohUxI9vgOmO4SrLotTSYdXLhr//jlrZEwT/FRAqCuLmoPE/3s
         m0ZShL4EJYSKNufzXSRo8LQG4+gvIsRXvx+DP+qzJuE+axbGSwshbu+a1Lb+jBB9T3ZO
         DmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zpwBvFrs/tmp9KwGLerH3fJ6HEm+hwg0aRloxrT4Ug=;
        b=RGHMuWX1fiHnCIHU25FYs5a8i8xaMX6nRL/Bm3bZfK+mYC+1/2XZ3qHai/viS+z/Lj
         oLTRFdln5fZOBKvy6/IHaRgiDkoQ7LS8atRFG3EBg5AYoTdTv75eXp4GTEDVD5wSMeGM
         rMzaDyenpXwJFozYZHmvKZ4KrOW2pGlkaDXAiq2sc+ue50vTRgKC+byKWvqLYwKgco2a
         GX/CFi5wHiifUEghQOn3SdsZVPor54hkqdUSkRv2IlA9PGIwI7B68F1GdZJJiUyJ+1O3
         fG48KJHUPafhgXK9n/NzPCH61mIKqD+Ex8BzWzBMQeJ4iccbITWp1ZD4InYAkeMiqLx7
         0BEg==
X-Gm-Message-State: AD7BkJLVB9vZmsAC1eepIhcakjcxqjUGUlAnb8K62Hx7vrk3v/Rq+8ezAR/VBF6mODaZDg==
X-Received: by 10.98.18.1 with SMTP id a1mr7834826pfj.39.1459620058396;
        Sat, 02 Apr 2016 11:00:58 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:00:57 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290600>

Four tests contains repetitive lines of code.

Factor out common code into test_pull_autostash() and then call it in
these tests.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index d03cb84..ac063c2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,6 +9,16 @@ modify () {
 	mv "$2.x" "$2"
 }
 
+test_pull_autostash () {
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull $@ . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+}
+
 test_expect_success setup '
 	echo file >file &&
 	git add file &&
@@ -247,46 +257,22 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --rebase
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --rebase --autostash
 '
 
-test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
+test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
-- 
2.7.1.340.g69eb491.dirty
