From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 4/5] t/t5520: modify tests to reduce common code
Date: Tue, 29 Mar 2016 18:59:59 +0530
Message-ID: <1459258200-32444-5-git-send-email-mehul.jain2029@gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:31:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktkP-0005J5-Es
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbcC2Nbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:31:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34651 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbcC2Nbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:31:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id n5so2337966pfn.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ukRlYhO2+vVmpO1I/R21VzVu/9T0jIT/D3vdlUZqPMI=;
        b=BQbJxji79WZ+XXhXWpa/xqLWgFogzYzMFzeyRkryR/ftcfnQ95tNd5W3VfqcviMYPM
         qxlrfxxjiDHCjXhlvlYmT/c5iPQ6QZbl9rBgrR78S14MJMECDKAiXfWtTSIGCED9xk47
         orxK2raBjBckTlZSg3r2XwwqPOunB2AAazW5xcStLh9+Wg97ARXLSKebP7Be7Y0tEF8L
         7NN7N/PGa/7YRN59xWN0BFT05CxlJHqYfiBPyEih73VT07rHJ8qk0kWcEO/dg73CfteZ
         jJZUaWQEPA8wx7tmNIpbq95v94yw9shY4EQZ511klm96+IJrrXusLptR7XWSdXxnlybB
         wbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ukRlYhO2+vVmpO1I/R21VzVu/9T0jIT/D3vdlUZqPMI=;
        b=OoV9Dlwi9fOoZulv5a8wxIDcDmT5zH8siHxqm8me1iX1HsbqehkSRjocUS0iykiZ9b
         ZWeYvBbRraG3jeGbV9CUmFfEFq3Arnd6PUq0bjkfSs3VdbDB29/fcAirGL/khrgGwFYJ
         /RWBVR9ke/n93vRZGjMibsBZ6M/nCWZw5l47Et6LwUcIrVk7Nr1P49S6tzt6a44Op+sB
         DChIamb8ExRaFiE7ySN7pZumt3f5I+tBmnQ81ELFaSBOkQaUKG8BNk8eTqcejHAXoEKI
         3zrrKgnqYImsrvHjb7iomcxDHD4ZyWrd1YYpbPavnYKmvJ6/9Tlgq6XfbsDA/kg2AXxn
         kdBw==
X-Gm-Message-State: AD7BkJJ0qCIrHxYJmUn0OwJbHfiziKd16taaSV/1cxUY17NzOIkxyqyURmYp8rXwYBnX0g==
X-Received: by 10.98.68.209 with SMTP id m78mr3452829pfi.153.1459258308447;
        Tue, 29 Mar 2016 06:31:48 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:31:47 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290139>

There exist three groups of tests which have repetitive lines of code.

Introduce two functions test_rebase_autostash() and
test_rebase_no_autostash() to reduce the number of lines. Also introduce
loops to futher reduce the current implementation.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 100 +++++++++++++++++++++++---------------------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index d03cb84..2611170 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,6 +9,24 @@ modify () {
 	mv "$2.x" "$2"
 }
 
+test_rebase_autostash () {
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+}
+
+test_rebase_no_autostash () {
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+}
+
 test_expect_success setup '
 	echo file >file &&
 	git add file &&
@@ -256,75 +274,39 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat file)" = "modified again"
 '
 
-test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
-	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
-'
-
-test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
-	test_config rebase.autostash false &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
-'
+for i in true false
+	do
+		test_expect_success "pull --rebase --autostash & rebase.autostash=$i" '
+			test_config rebase.autostash $i &&
+			test_rebase_autostash
+		'
+	done
 
 test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_rebase_autostash
 '
 
-test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
-	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
-'
-
-test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
-	test_config rebase.autostash false &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
-'
+for i in true false
+	do
+		test_expect_success "pull --rebase --no-autostash & rebase.autostash=$i" '
+			test_config rebase.autostash $i &&
+			test_rebase_no_autostash
+		'
+	done
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_rebase_no_autostash
 '
 
-test_expect_success 'pull --autostash (without --rebase) should error out' '
-	test_must_fail git pull --autostash . copy 2>err &&
-	test_i18ngrep "only valid with --rebase" err
-'
-
-test_expect_success 'pull --no-autostash (without --rebase) should error out' '
-	test_must_fail git pull --no-autostash . copy 2>err &&
-	test_i18ngrep "only valid with --rebase" err
-'
+for i in --autostash --no-autostash
+	do
+		test_expect_success "pull $i (without --rebase) is illegal" '
+			test_must_fail git pull $i . copy 2>actual &&
+			test_i18ngrep "only valid with --rebase" actual
+		'
+	done
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
