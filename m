Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669FC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82BE61425
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhDUKlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhDUKls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:41:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9896CC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:41:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so28376989pfc.12
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IN9/Ks5CqvPfiNaLbyYzujcrg/Ex+kz051cQzT8uIc=;
        b=D8P2zaQ+vib93gGREK3lqxKHSmnCNATM1gpGBbSEoOxy43a7dBDLe9hOn442rAhaa1
         YzOTT3n/D719BjvyZ7vlB9P21pZ8nN0+UbQmLrDzGbAyXF3F/5WQKwOwn8a1DA/MKqwe
         2eDsffg41aX0damm4xSiQAtNpDa88bALCrF6hl8ikzsyrlrS9OxBoCC6J6Xp/w2vaadF
         jk4rSEjUKYCVHBYu41OzMg6G7k5VM2dbOw+AkLHqubJ+nPfKf/sTYe7mpFCV0TulDsgp
         aX4daqiQGKRT/po6XVHgK6EumWu+NXeUu1aYK8oLx8ob6DrQlsn34RDKO6cRkEt1BzXJ
         pcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IN9/Ks5CqvPfiNaLbyYzujcrg/Ex+kz051cQzT8uIc=;
        b=eGTOs9mLUAIA6VEdu8mLuAfvw2TJ47fO/xuUboB2ZNIjFozVCEfGqfrEIh8+F+HBkT
         8XB4cKE29y69ml6NUPYJnQY8mhCH3UsE6iZz3rzCz7tT62PewgIRB6aY+EezHH2zj0fQ
         bI9G8XYM8nG1XOm9uAh/9BAm3s/9Ox8LNkA7eX9IE6UvwCI8Fx0CAL7dSTbExFhxzWs8
         IGU2KmK9GWZtPotJESKcthfUQIABTFzCfIZ3aIR+ZKLnQHGfdn6y1NBzB4u+nznjyngp
         awz/6pr/bq8eymy7vHXHudUnXPjERZADGv+FBIK2CtzRSAWoTF7D6ri9ZLHsc0PEVqrq
         H4Pw==
X-Gm-Message-State: AOAM531kdhYmaf89a2O7n1ANqqJrRk9JoD1YAC6+XtT7yg4OLZoZ1lAn
        iZqRTuvchdm971WF4Rx0pCeXcLpFIr4=
X-Google-Smtp-Source: ABdhPJyiwRq4+NkX4anL3pyc/8Wu4y3JM7Te0rPpj5rDsVAWSdn7n/pLWwsw7WeiphLfV/ZY8rzFwg==
X-Received: by 2002:a63:4d50:: with SMTP id n16mr15077184pgl.237.1619001674959;
        Wed, 21 Apr 2021 03:41:14 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id n20sm1458010pgv.15.2021.04.21.03.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:41:14 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/2] t6402: check exit status of ls-files
Date:   Wed, 21 Apr 2021 17:41:02 +0700
Message-Id: <20210421104102.3409-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.192.g0881477623
In-Reply-To: <20210421104102.3409-1-congdanhqx@gmail.com>
References: <YIAAzJTG1UitiWyu@danh.dev>
 <20210421104102.3409-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will lose the exit status of "git ls-files" if it's being run in
anywhere-but-not-final part of a pipe.

Let's send the output of "git ls-files" to a file first,
and adjust the expected result for "git ls-files -o" since a new
untracked file will be created as a side effect.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 148 +++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 47 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..d705847f26 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -330,8 +330,10 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 		test_i18ngrep "Adding as dir~HEAD instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 3 output &&
+	git ls-files -u dir/file-in-the-way >output &&
+	test_line_count = 2 output &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -357,8 +359,10 @@ test_expect_success 'Same as previous, but merged other way' '
 		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 3 output &&
+	git ls-files -u dir/file-in-the-way >output &&
+	test_line_count = 2 output &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -374,8 +378,10 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 3 output &&
+	git ls-files -u dir >output &&
+	test_line_count = 3 output &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -409,14 +415,19 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 5 output &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+		git ls-files -u dir~HEAD >output &&
+		test_line_count = 3 output
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >output &&
+		grep -v file-in-the-way output >filtered
+		test_line_count = 3 filtered
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	git ls-files -u dir/file-in-the-way >output &&
+	test_line_count = 2 output &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -432,14 +443,19 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 5 output &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+		git ls-files -u dir~renamed-file-has-conflicts >output &&
+		test_line_count = 3 output
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >output &&
+		grep -v file-in-the-way output >filtered
+		test_line_count = 3 filtered
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	git ls-files -u dir/file-in-the-way >output &&
+	test_line_count = 2 output &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -494,11 +510,12 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 	git checkout -q rename-dest^0 &&
 	test_must_fail git merge --strategy=recursive source-conflict &&
 
+	git ls-files -u >output &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 2 -eq "$(git ls-files -u | wc -l)"
+		test_line_count = 2 output
 	else
-		test 1 -eq "$(git ls-files -u | wc -l)"
+		test_line_count = 1 output
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -540,9 +557,13 @@ then
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)" &&
+		git ls-files -u >output &&
+		test_line_count = 4 output &&
+		git ls-files -u one >output &&
+		test_line_count = 2 output &&
+		git ls-files -u two >output &&
+		test_line_count = 2 output &&
+		rm -f output &&
 
 		test_must_fail git diff --quiet &&
 
@@ -559,9 +580,13 @@ else
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		git ls-files -u >output &&
+		test_line_count = 2 output &&
+		git ls-files -u one >output &&
+		test_line_count = 1 output &&
+		git ls-files -u two >output &&
+		test_line_count = 1 output &&
+		rm -f output &&
 
 		test_must_fail git diff --quiet &&
 
@@ -582,14 +607,21 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)"
+		git ls-files -u >output &&
+		test_line_count = 4 output &&
+		git ls-files -u one >output &&
+		test_line_count = 2 output &&
+		git ls-files -u two >output &&
+		test_line_count = 2 output
 	else
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)"
+		git ls-files -u >output &&
+		test_line_count = 2 output &&
+		git ls-files -u one >output &&
+		test_line_count = 1 output &&
+		git ls-files -u two >output &&
+		test_line_count = 1 output
 	fi &&
+	rm -f output &&
 
 	test_must_fail git diff --quiet &&
 
@@ -631,20 +663,33 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 0 -eq "$(git ls-files -o | wc -l)"
+		git ls-files -s >output &&
+		test_line_count = 5 output &&
+		git ls-files -u >output &&
+		test_line_count = 3 output &&
+		git ls-files -u one~HEAD >output &&
+		test_line_count = 1 output &&
+		git ls-files -u two~second-rename >output &&
+		test_line_count = 1 output &&
+		git ls-files -u original >output &&
+		test_line_count = 1 output &&
+		git ls-files -o >output &&
+		test_line_count = 1 output
 	else
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 2 -eq "$(git ls-files -o | wc -l)"
+		git ls-files -s >output &&
+		test_line_count = 5 output &&
+		git ls-files -u >output &&
+		test_line_count = 3 output &&
+		git ls-files -u one >output &&
+		test_line_count = 1 output &&
+		git ls-files -u two >output &&
+		test_line_count = 1 output &&
+		git ls-files -u original >output &&
+		test_line_count = 1 output &&
+		git ls-files -o >output &&
+		test_line_count = 3 output
 	fi &&
+	rm -f output &&
 
 	test_path_is_file one/file &&
 	test_path_is_file two/file &&
@@ -679,11 +724,17 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
-	test 1 -eq "$(git ls-files -u original | wc -l)" &&
-	test 0 -eq "$(git ls-files -o | wc -l)" &&
+	git ls-files -u >output &&
+	test_line_count = 3 output &&
+	git ls-files -u one >output &&
+	test_line_count = 1 output &&
+	git ls-files -u two >output &&
+	test_line_count = 1 output &&
+	git ls-files -u original >output &&
+	test_line_count = 1 output &&
+	git ls-files -o >output &&
+	test_line_count = 1 output &&
+	rm -f output &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
@@ -861,8 +912,11 @@ test_expect_success 'setup merge of rename + small change' '
 test_expect_success 'merge rename + small change' '
 	git merge rename_branch &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+	git ls-files -s >output &&
+	test_line_count = 1 output &&
+	git ls-files -o >output &&
+	test_line_count = 1 output &&
+	rm -f output &&
 	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
 '
 
-- 
2.31.1.192.g0881477623

