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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73914C48BE8
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB41611CC
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhFSBd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhFSBd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 21:33:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF6C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o21so5575139pll.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tY5GDYo8JvJx1OH+v02buekfncdqWoLcooxycWXMx1A=;
        b=mG+bcj5F+kiZivs3qAIr4lOWctdumk/16j3ls2ryNuf3KW8PoIBh5hmjEeUQjG8DFL
         Rv13/rzeN5Pd+jmJJIjp4Dq8KG948VTfnqzrJR/SAOv2xMP0fDZautvncRPFwxJIkauh
         oxKL/26swXa8xWPy/BCtLSb+LD5OMrTl3PkpCh+jIz324nHQZ2cyQ6GtNxAdEWZceJM4
         MPiK5m7JBrs9lp3pCTxjRi9+/jQjxbiDgUdcIjDJUUjYg602KLPWMZjIfE7ljCALDmbS
         bII/ZxveKC2I7+5QK30Op5hgYQCJk2MSFy5ls3qZOSV4/8B5jDBOyAGgZAp+M0UOtSst
         dRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tY5GDYo8JvJx1OH+v02buekfncdqWoLcooxycWXMx1A=;
        b=LQO6XL8EHdBJSQPxsmyPu02JR4SGBTarr6T+kxihSHkJ8DD4N38SG8rtqk9r/iIDW/
         7wOK9R/eATAjdKLxmvrejVl/Wj7O0NR2k8h1ZiEHuV5fhwLortkik0uUC/vI7AxommeI
         WBfxR20xKp8axk7PXIODErldNI7NxUoQ9NSAMxJu0JcY/3NFObfLMDsoYKUaVbDeA3Pu
         il66MmjHwSYINogiuxz1jZrpiKtpgZjVeFkLdAjV68PPz2ERDSgiJ6XUykyBnHwGj49U
         N/gtQN7MtjjJGoZ8+kGTgfYKyjxfvRx6NcKY8WIUHAg8VoJtrvdY20kHAWMUdVmW2kNc
         t43A==
X-Gm-Message-State: AOAM531V6efUHYto7+OJqu+4RhZXDS4y9/WO4ZEtzQbDWiE8BQ9aovYH
        Sx22a9E5Kh+ZFYO+5F5gmW/SlKc0kTA=
X-Google-Smtp-Source: ABdhPJzNgRhYiaKrgRU3JhDjgwxi/MLBo0FpwTrQIt1hhlarYhRe1+Y0/ofa0QutFqTehhdJk9RN0g==
X-Received: by 2002:a17:902:904a:b029:101:af84:4f55 with SMTP id w10-20020a170902904ab0290101af844f55mr7339494plz.80.1624066276292;
        Fri, 18 Jun 2021 18:31:16 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id s123sm8733427pfb.78.2021.06.18.18.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 18:31:15 -0700 (PDT)
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
Subject: [PATCH v3 4/4] t6402: use test_line_count_cmd to count # of lines in stdout
Date:   Sat, 19 Jun 2021 08:30:35 +0700
Message-Id: <20210619013035.26313-5-congdanhqx@gmail.com>
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
index 5d76cd6414..52bd35899e 100755
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
+	test_line_count_cmd = 3 git ls-files -u B &&
+	test_line_count_cmd = 1 git ls-files -s N &&
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
+	test_line_count_cmd = 3 git ls-files -u B &&
+	test_line_count_cmd = 1 git ls-files -s N &&
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
+	test_line_count_cmd = 3 git ls-files -u B &&
+	test_line_count_cmd = 1 git ls-files -s N &&
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
+	test_line_count_cmd = 1 git ls-files -u A &&
+	test_line_count_cmd = 1 git ls-files -u B &&
+	test_line_count_cmd = 1 git ls-files -u C &&
+	test_line_count_cmd = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -330,8 +320,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 		test_i18ngrep "Adding as dir~HEAD instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd = 3 git ls-files -u &&
+	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -357,8 +347,8 @@ test_expect_success 'Same as previous, but merged other way' '
 		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd = 3 git ls-files -u &&
+	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -374,8 +364,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
+	test_line_count_cmd = 3 git ls-files -u &&
+	test_line_count_cmd = 3 git ls-files -u dir &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -409,14 +399,15 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_line_count_cmd = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+		test_line_count_cmd = 3 git ls-files -u dir~HEAD
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test_line_count_cmd = 3 grep -v file-in-the-way out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -432,14 +423,15 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_line_count_cmd = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+		test_line_count_cmd = 3 git ls-files -u dir~renamed-file-has-conflicts
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test_line_count_cmd = 3 grep -v file-in-the-way out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -496,9 +488,9 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 2 -eq "$(git ls-files -u | wc -l)"
+		test_line_count_cmd = 2 git ls-files -u
 	else
-		test 1 -eq "$(git ls-files -u | wc -l)"
+		test_line_count_cmd = 1 git ls-files -u
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -540,9 +532,9 @@ then
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)" &&
+		test_line_count_cmd = 4 git ls-files -u &&
+		test_line_count_cmd = 2 git ls-files -u one &&
+		test_line_count_cmd = 2 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -559,9 +551,9 @@ else
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		test_line_count_cmd = 2 git ls-files -u &&
+		test_line_count_cmd = 1 git ls-files -u one &&
+		test_line_count_cmd = 1 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -582,13 +574,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)"
+		test_line_count_cmd = 4 git ls-files -u &&
+		test_line_count_cmd = 2 git ls-files -u one &&
+		test_line_count_cmd = 2 git ls-files -u two
 	else
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)"
+		test_line_count_cmd = 2 git ls-files -u &&
+		test_line_count_cmd = 1 git ls-files -u one &&
+		test_line_count_cmd = 1 git ls-files -u two
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
+		test_line_count_cmd = 5 git ls-files -s &&
+		test_line_count_cmd = 3 git ls-files -u &&
+		test_line_count_cmd = 1 git ls-files -u one~HEAD &&
+		test_line_count_cmd = 1 git ls-files -u two~second-rename &&
+		test_line_count_cmd = 1 git ls-files -u original &&
+		test_line_count_cmd = 0 git ls-files -o
 	else
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 2 -eq "$(git ls-files -o | wc -l)"
+		test_line_count_cmd = 5 git ls-files -s &&
+		test_line_count_cmd = 3 git ls-files -u &&
+		test_line_count_cmd = 1 git ls-files -u one &&
+		test_line_count_cmd = 1 git ls-files -u two &&
+		test_line_count_cmd = 1 git ls-files -u original &&
+		test_line_count_cmd = 2 git ls-files -o
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
+	test_line_count_cmd = 3 git ls-files -u &&
+	test_line_count_cmd = 1 git ls-files -u one &&
+	test_line_count_cmd = 1 git ls-files -u two &&
+	test_line_count_cmd = 1 git ls-files -u original &&
+	test_line_count_cmd = 0 git ls-files -o &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
@@ -861,8 +853,8 @@ test_expect_success 'setup merge of rename + small change' '
 test_expect_success 'merge rename + small change' '
 	git merge rename_branch &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+	test_line_count_cmd = 1 git ls-files -s &&
+	test_line_count_cmd = 0 git ls-files -o &&
 	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
 '
 
-- 
2.32.0.278.gd42b80f139

