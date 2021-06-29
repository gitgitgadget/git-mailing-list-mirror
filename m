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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97601C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757C161D8B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhF2OAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhF2OA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 10:00:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798AC061767
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v12so10949805plo.10
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPixydXiKg7WReuwtWiH0kWy1FkSQEEZaRfcszh8nnk=;
        b=Wo/2cE2586oRszcsSrrj9ZJ2LpShx+TgHW1znwHeg4NWLnJmlDkYPsMSXi9G2F3lym
         s+7kwT/xdcDCiVHo539AIVvEvWZQ/9fh276dNNVhrHAXZYqKldOndS3OPXq7BKyuRNEp
         mzyWbCIJvAQzClFamOtIc0dIjqpIa8ErxdJTfPGvMHh2Lkks3xaXp4+L08Y+4PCOuYpE
         bsm9ke4Ij4a8Lr/Y6XhmnQDPKyCQt+R15q2BoQeGEylJnM9Pt3N7ULsLqEIqx26E2u6d
         BVvQItrvVVsn7YaK2oo5LpUZZgCvDMkTb0PkIRTTzO4m/2o5g0dO8eU84Jljt/MoUYFl
         Oalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPixydXiKg7WReuwtWiH0kWy1FkSQEEZaRfcszh8nnk=;
        b=Tryw5lNop2xIItlQYXTZtHIa4ZrYZWZ0i7fZ09oRh0VaCe6i5jo2QI/l7GuLqcgkDD
         2tLAJXFcwsNUk4SVF+l043TzAxHMZpA11SruPa2GthCSuh1IhqGwSx3mLcY3UhM6y9Fh
         RSIxOPnd7ueyHXkDv8pCPmJlEI7XP+D7xenomY8EMl4BLJkaF/WZmxZ7Q1czt6advIDv
         6sIkq/bnMxe/PQocXZ3lsNTLpbsHkyn2QtttqmTr95WYLO7/opF6/tG4FNfEC/zGpUXk
         WULQ7kFCJkIB1GZFoOGgL3LSvIEQ3xbyYsfWes9ufSWQlKD/8t6HDR6QHQtcBAxLw4KO
         tUyw==
X-Gm-Message-State: AOAM532R/X0OpRPCPIJpof3V0SjSrYEi/LTqCQvltyX13OyhC/eJC9Tj
        rycuabToQlvOSYlBj3+Ly5GLBEzcEHc=
X-Google-Smtp-Source: ABdhPJxiD0+ZcnciGwBHBDp7pjb4jwlaoEcxkKBONYOHVmGyJPJzDjCcd/iBlUpbe0BSHIaE/VJIkw==
X-Received: by 2002:a17:90a:454b:: with SMTP id r11mr230790pjm.60.1624975078661;
        Tue, 29 Jun 2021 06:57:58 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:8e5c:5bd7:f8a:333f:cf5])
        by smtp.gmail.com with ESMTPSA id c62sm18376572pfa.12.2021.06.29.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:57:58 -0700 (PDT)
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
Subject: [PATCH v4 2/2] t6402: preserve git exit status code
Date:   Tue, 29 Jun 2021 20:57:44 +0700
Message-Id: <6d3ebcb255769f22011c69936dbfea7b1d98dae1.1624974969.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <cover.1624974969.git.congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1624974969.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6402, we're checking number of files in the index and the working
tree by piping the output of "git ls-files" to "wc -l", thus losing the
exit status code of git.

Let's write the output of "git ls-files" to a temporary file, in order
to check exit status code of "git ls-files" properly.

While we're at it, also check exit status code of an invocation of
git-rev-parse, too.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 146 +++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 68 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..fbfa8967b0 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -11,6 +11,20 @@ modify () {
 	mv "$2.x" "$2"
 }
 
+check_ls_files_count() {
+	local ops val
+	if test "$#" -le 2
+	then
+		BUG "Expect 2 or more arguments"
+	fi &&
+	ops="$1" &&
+	val="$2" &&
+	shift 2 &&
+	mkdir -p .git/trash &&
+	git ls-files "$@" >.git/trash/output &&
+	test_line_count "$ops" "$val" .git/trash/output
+}
+
 test_expect_success 'setup' '
 	cat >A <<-\EOF &&
 	a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
@@ -105,10 +119,8 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	git show-branch &&
 	test_expect_code 1 git pull . white &&
 	git ls-files -s &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	check_ls_files_count = 3 -u B &&
+	check_ls_files_count = 1 -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -122,10 +134,8 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	git reset --hard &&
 	git checkout red &&
 	test_expect_code 1 git pull . white &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	check_ls_files_count = 3 -u B &&
+	check_ls_files_count = 1 -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -138,10 +148,8 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . main &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	check_ls_files_count = 3 -u B &&
+	check_ls_files_count = 1 -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -154,14 +162,10 @@ test_expect_success 'pull conflicting renames' \
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
+	check_ls_files_count = 1 -u A &&
+	check_ls_files_count = 1 -u B &&
+	check_ls_files_count = 1 -u C &&
+	check_ls_files_count = 1 -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -330,8 +334,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 		test_i18ngrep "Adding as dir~HEAD instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	check_ls_files_count = 3 -u &&
+	check_ls_files_count = 2 -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -357,8 +361,8 @@ test_expect_success 'Same as previous, but merged other way' '
 		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	check_ls_files_count = 3 -u &&
+	check_ls_files_count = 2 -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -374,8 +378,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
+	check_ls_files_count = 3 -u &&
+	check_ls_files_count = 3 -u dir &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -409,14 +413,16 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	check_ls_files_count = 5 -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+		check_ls_files_count = 3 -u dir~HEAD
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
+		rm -f out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	check_ls_files_count = 2 -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -432,14 +438,16 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	check_ls_files_count = 5 -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+		check_ls_files_count = 3 -u dir~renamed-file-has-conflicts
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
+		rm -f out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	check_ls_files_count = 2 -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -496,9 +504,9 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 2 -eq "$(git ls-files -u | wc -l)"
+		check_ls_files_count = 2 -u
 	else
-		test 1 -eq "$(git ls-files -u | wc -l)"
+		check_ls_files_count = 1 -u
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -540,9 +548,9 @@ then
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)" &&
+		check_ls_files_count = 4 -u &&
+		check_ls_files_count = 2 -u one &&
+		check_ls_files_count = 2 -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -559,9 +567,9 @@ else
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		check_ls_files_count = 2 -u &&
+		check_ls_files_count = 1 -u one &&
+		check_ls_files_count = 1 -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -582,13 +590,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)"
+		check_ls_files_count = 4 -u &&
+		check_ls_files_count = 2 -u one &&
+		check_ls_files_count = 2 -u two
 	else
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)"
+		check_ls_files_count = 2 -u &&
+		check_ls_files_count = 1 -u one &&
+		check_ls_files_count = 1 -u two
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -631,19 +639,19 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 0 -eq "$(git ls-files -o | wc -l)"
+		check_ls_files_count = 5 -s &&
+		check_ls_files_count = 3 -u &&
+		check_ls_files_count = 1 -u one~HEAD &&
+		check_ls_files_count = 1 -u two~second-rename &&
+		check_ls_files_count = 1 -u original &&
+		check_ls_files_count = 0 -o
 	else
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 2 -eq "$(git ls-files -o | wc -l)"
+		check_ls_files_count = 5 -s &&
+		check_ls_files_count = 3 -u &&
+		check_ls_files_count = 1 -u one &&
+		check_ls_files_count = 1 -u two &&
+		check_ls_files_count = 1 -u original &&
+		check_ls_files_count = 2 -o
 	fi &&
 
 	test_path_is_file one/file &&
@@ -679,11 +687,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
-	test 1 -eq "$(git ls-files -u original | wc -l)" &&
-	test 0 -eq "$(git ls-files -o | wc -l)" &&
+	check_ls_files_count = 3 -u &&
+	check_ls_files_count = 1 -u one &&
+	check_ls_files_count = 1 -u two &&
+	check_ls_files_count = 1 -u original &&
+	check_ls_files_count = 0 -o &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
@@ -861,9 +869,11 @@ test_expect_success 'setup merge of rename + small change' '
 test_expect_success 'merge rename + small change' '
 	git merge rename_branch &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
-	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
+	check_ls_files_count = 1 -s &&
+	check_ls_files_count = 0 -o &&
+	newhash=$(git rev-parse HEAD:renamed_file) &&
+	oldhash=$(git rev-parse HEAD~1:file) &&
+	test $newhash = $oldhash
 '
 
 test_expect_success 'setup for use of extended merge markers' '
-- 
2.32.0.278.gd42b80f139

