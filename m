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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE815C48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51C961434
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhFORXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFORXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:23:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5B6C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q15so12006675pgg.12
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgUOiuqvJB+xgCFZAbSDxhNV+dU2sGOWXwyrt+ySb0w=;
        b=RS6Pq+r0hMm/DbGPPy3ya19qt1EdcC0r/G0x/DtVcX1BbnwTx7d8smCp7ylS7D3dLU
         p3ruUsQPdGJG9Ry0yngGSy7L+4JlQkYf+b7ULgi2wusYosAmGJybVNFxnfnEZMfD1bL5
         Hd19NvXR0ILme8b9I1+dIRIsRpc5GGEeE0exoSJhpk7qafAGZQVeYtM2zoi9f65A792y
         /dYqrbEYRvJRFvVC7wPCNeAe5dDfn3tzX689OKx9fkx8L7aHenAggNIMKjF+ZJlScOfB
         zlDsDxN0hN6HN+71W3lg79qS7tQ5TCj6qTxh0dQXOuqaKKCjREd+fxPw8ojHGbZOASIY
         vBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgUOiuqvJB+xgCFZAbSDxhNV+dU2sGOWXwyrt+ySb0w=;
        b=SzUMGI+d/EqoSBRB4spfGWmsliW8HyXqRxKvm+tbo4fhAbuczhCZ+0Ft02qxFXywND
         R9Tocdm7FRozPi2ng+1DQAsicf/hIiHtUv69JTcSP0vTNzFfC0iMF+CbEcm2V1HLIFHQ
         9VDNbtvaNzpfL1nD6PcHNrdRLWM6oYGkKGWUyqBWC0u0NBVp50cIvmBDmBGQXOMt5/sz
         YN8bMHGXexWDfsJOq1SNIfDPMeZkCRSpBhsmS8X1br9G93V1N8xqkZbUD7UdIrRVf5pl
         OdVHr+kLpoEPqvTHLH9O8UoBU4UIkBnm+IK75oRZpeqa4tgEV2LaCOLaD+PiNla1XGrD
         Z8QA==
X-Gm-Message-State: AOAM532QtUHYO/8+jcp4uyGe0jSH4VoDbb4G2wid8NGt3mxN0zNBowR8
        y3ubTWPaGI3Dgm+uUnO9RzR7WR6CQ7M=
X-Google-Smtp-Source: ABdhPJxf6v8higDZxP5UjEK8rjTZiaZ0RPeFF8qP5M4CRjcNuToDQKw7Fn5ptKYG7HXohlcawsz4Og==
X-Received: by 2002:a05:6a00:bc1:b029:2f4:3461:c2ae with SMTP id x1-20020a056a000bc1b02902f43461c2aemr5382197pfu.9.1623777668109;
        Tue, 15 Jun 2021 10:21:08 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:21:07 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/5] t6402: use test_line_count_cmd to count # of lines in stdout
Date:   Wed, 16 Jun 2021 00:20:38 +0700
Message-Id: <20210615172038.28917-6-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 126 +++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 67 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 5d76cd6414..ca84588eb5 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -105,10 +105,8 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	git show-branch &&
 	test_expect_code 1 git pull . white &&
 	git ls-files -s &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_line_count_cmd --out = 3 git ls-files -u B &&
+	test_line_count_cmd --out = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -122,10 +120,8 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	git reset --hard &&
 	git checkout red &&
 	test_expect_code 1 git pull . white &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_line_count_cmd --out = 3 git ls-files -u B &&
+	test_line_count_cmd --out = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -138,10 +134,8 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . main &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_line_count_cmd --out = 3 git ls-files -u B &&
+	test_line_count_cmd --out = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -154,14 +148,10 @@ test_expect_success 'pull conflicting renames' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . blue &&
-	git ls-files -u A >a.stages &&
-	test_line_count = 1 a.stages &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 1 b.stages &&
-	git ls-files -u C >c.stages &&
-	test_line_count = 1 c.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_line_count_cmd --out = 1 git ls-files -u A &&
+	test_line_count_cmd --out = 1 git ls-files -u B &&
+	test_line_count_cmd --out = 1 git ls-files -u C &&
+	test_line_count_cmd --out = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -330,8 +320,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 		test_i18ngrep "Adding as dir~HEAD instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd --out = 3 git ls-files -u &&
+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -357,8 +347,8 @@ test_expect_success 'Same as previous, but merged other way' '
 		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd --out = 3 git ls-files -u &&
+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -374,8 +364,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
+	test_line_count_cmd --out = 3 git ls-files -u &&
+	test_line_count_cmd --out = 3 git ls-files -u dir &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -409,14 +399,15 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_line_count_cmd --out = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+		test_line_count_cmd --out = 3 git ls-files -u dir~HEAD
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test_line_count_cmd --out = 3 grep -v file-in-the-way out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -432,14 +423,15 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_line_count_cmd --out = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+		test_line_count_cmd --out = 3 git ls-files -u dir~renamed-file-has-conflicts
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test_line_count_cmd --out = 3 grep -v file-in-the-way out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -496,9 +488,9 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 2 -eq "$(git ls-files -u | wc -l)"
+		test_line_count_cmd --out = 2 git ls-files -u
 	else
-		test 1 -eq "$(git ls-files -u | wc -l)"
+		test_line_count_cmd --out = 1 git ls-files -u
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -540,9 +532,9 @@ then
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)" &&
+		test_line_count_cmd --out = 4 git ls-files -u &&
+		test_line_count_cmd --out = 2 git ls-files -u one &&
+		test_line_count_cmd --out = 2 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -559,9 +551,9 @@ else
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		test_line_count_cmd --out = 2 git ls-files -u &&
+		test_line_count_cmd --out = 1 git ls-files -u one &&
+		test_line_count_cmd --out = 1 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -582,13 +574,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)"
+		test_line_count_cmd --out = 4 git ls-files -u &&
+		test_line_count_cmd --out = 2 git ls-files -u one &&
+		test_line_count_cmd --out = 2 git ls-files -u two
 	else
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)"
+		test_line_count_cmd --out = 2 git ls-files -u &&
+		test_line_count_cmd --out = 1 git ls-files -u one &&
+		test_line_count_cmd --out = 1 git ls-files -u two
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -631,19 +623,19 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 0 -eq "$(git ls-files -o | wc -l)"
+		test_line_count_cmd --out = 5 git ls-files -s &&
+		test_line_count_cmd --out = 3 git ls-files -u &&
+		test_line_count_cmd --out = 1 git ls-files -u one~HEAD &&
+		test_line_count_cmd --out = 1 git ls-files -u two~second-rename &&
+		test_line_count_cmd --out = 1 git ls-files -u original &&
+		test_line_count_cmd --out = 0 git ls-files -o
 	else
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 2 -eq "$(git ls-files -o | wc -l)"
+		test_line_count_cmd --out = 5 git ls-files -s &&
+		test_line_count_cmd --out = 3 git ls-files -u &&
+		test_line_count_cmd --out = 1 git ls-files -u one &&
+		test_line_count_cmd --out = 1 git ls-files -u two &&
+		test_line_count_cmd --out = 1 git ls-files -u original &&
+		test_line_count_cmd --out = 2 git ls-files -o
 	fi &&
 
 	test_path_is_file one/file &&
@@ -679,11 +671,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
-	test 1 -eq "$(git ls-files -u original | wc -l)" &&
-	test 0 -eq "$(git ls-files -o | wc -l)" &&
+	test_line_count_cmd --out = 3 git ls-files -u &&
+	test_line_count_cmd --out = 1 git ls-files -u one &&
+	test_line_count_cmd --out = 1 git ls-files -u two &&
+	test_line_count_cmd --out = 1 git ls-files -u original &&
+	test_line_count_cmd --out = 0 git ls-files -o &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
@@ -861,8 +853,8 @@ test_expect_success 'setup merge of rename + small change' '
 test_expect_success 'merge rename + small change' '
 	git merge rename_branch &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+	test_line_count_cmd --out = 1 git ls-files -s &&
+	test_line_count_cmd --out = 0 git ls-files -o &&
 	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
 '
 
-- 
2.32.0.278.gd42b80f139

