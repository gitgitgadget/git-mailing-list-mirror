Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E9C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C524921D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agkw6HiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbgJWQBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464808AbgJWQBa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB2C0613D2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s9so2469219wro.8
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7yt+yRyOLDBn/1W1vYjwIwKEYGvE1UbR4AYeCBJ5bbE=;
        b=agkw6HiFYnBNddLmF/7VGqXb7SAvZsKUpxlDQTmCNaCHSVWeTKie1CrT1fGvF6xvx/
         5O0MhfbJdWxiGztax0EgDt8g6Z6N8H/GP1itegoDpzBguWUnmQnKW7Tpp+0zceiMpL54
         /HRpoI8NtGPR04v2xdriuc1Jg22BHzLD1bb7Y9Hr0Nbw7//e6HBM0j6hLu0H2MABL5Ut
         rsfX0egmkakRdbYgi92Nox6W6srwg4vYKScPMjH4JTA8EVQgbha+QlBoaOiyo7H1BMrK
         Lo1xbPlnzFVPam9CZpoK2QmjvV7hJ1mmjIkJnsz05EtPf8WG+ILq3gPNIj6ZQtR6wwiO
         hl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7yt+yRyOLDBn/1W1vYjwIwKEYGvE1UbR4AYeCBJ5bbE=;
        b=OMv0P+Kh1/hjR3YxHpI44p6L7jY/mo9pc3A5RnkONWPoL7y6HzNTDWVmfXFYd6cimu
         CPLMDgL4QOtLr2rCuATk51TAb7hcxR6l+tU1y23eE3ore1Ol44dMC8/WG196rLDs05AL
         BgjgwrOXNxA+zENDVf9jEWz3BLEUWtRR/GVjMmonLXFoaXZOY9XFmSPZANL49hmRk9L9
         Q92oIT3hacKLzLnQcqHevdsRpi1tATrB7APxiLVVbCYB3I2hqmC9Ee1TTjU2lXXx4G5U
         SWQSPOPcyqTd0y4kTg9h4Fgc94QGD0vEdNe7GyCet8hexk+rRbbKtpICwJCKYKMXMwDf
         bDgQ==
X-Gm-Message-State: AOAM533djfWQq9TgX3z3PB3iI0nu0mGO6edIOEUDP9kNw1E1JaLfVT9C
        A3ljWr6CrUfoKjNd5aJ72BGU784Ref0=
X-Google-Smtp-Source: ABdhPJzbF74+0Pd1gb5EcpIAI6tfXfSBe1lqOLQ9fxZhVKVi1rebq4chMDVD96u9zydkEZl2pyOH2Q==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr3239356wrv.140.1603468887931;
        Fri, 23 Oct 2020 09:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b136sm3684306wmb.21.2020.10.23.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:27 -0700 (PDT)
Message-Id: <9394d526f1425fcf6b8865b53b737ba81c11dd80.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:17 +0000
Subject: [PATCH 2/9] merge tests: expect improved directory/file conflict
 handling in ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive.c is built on the idea of running unpack_trees() and
then "doing minor touch-ups" to get the result.  Unfortunately,
unpack_trees() was run in an update-as-it-goes mode, leading
merge-recursive.c to follow suit and end up with an immediate evaluation
and fix-it-up-as-you-go design.  Some things like directory/file
conflicts are not well representable in the index data structure, and
required special extra code to handle.  But then when it was discovered
that rename/delete conflicts could also be involved in directory/file
conflicts, the special directory/file conflict handling code had to be
copied to the rename/delete codepath.  ...and then it had to be copied
for modify/delete, and for rename/rename(1to2) conflicts, ...and yet it
still missed some.  Further, when it was discovered that there were also
file/submodule conflicts and submodule/directory conflicts, we needed to
copy the special submodule handling code to all the special cases
throughout the codebase.

And then it was discovered that our handling of directory/file conflicts
was suboptimal because it would create untracked files to store the
contents of the conflicting file, which would not be cleaned up if
someone were to run a 'git merge --abort' or 'git rebase --abort'.  It
was also difficult or scary to try to add or remove the index entries
corresponding to these files given the directory/file conflict in the
index.  But changing merge-recursive.c to handle these correctly was a
royal pain because there were so many sites in the code with similar but
not identical code for handling directory/file/submodule conflicts that
would all need to be updated.

I have worked hard to push all directory/file/submodule conflict
handling in merge-ort through a single codepath, and avoid creating
untracked files for storing tracked content (it does record things at
alternate paths, but makes sure they have higher-order stages in the
index).

Since updating merge-recursive is too much work and we don't want to
destabilize it, instead update the testsuite to have different
expectations for relevant directory/file/submodule conflict tests.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6400-merge-df.sh                  |  14 +-
 t/t6402-merge-rename.sh              | 108 ++++++++++++----
 t/t6416-recursive-corner-cases.sh    | 185 +++++++++++++++++++--------
 t/t6422-merge-rename-corner-cases.sh |  30 +++--
 t/t6423-merge-rename-directories.sh  |  53 +++++---
 t/t7610-mergetool.sh                 |  32 ++++-
 6 files changed, 314 insertions(+), 108 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index f1b84617af..9da0838216 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -81,7 +81,12 @@ test_expect_success 'modify/delete + directory/file conflict' '
 
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 4 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 0 -eq $(git ls-files -o | wc -l)
+	else
+		test 1 -eq $(git ls-files -o | wc -l)
+	fi &&
 
 	test_path_is_file letters/file &&
 	test_path_is_file letters.txt &&
@@ -97,7 +102,12 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 4 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 0 -eq $(git ls-files -o | wc -l)
+	else
+		test 1 -eq $(git ls-files -o | wc -l)
+	fi &&
 
 	test_path_is_file letters/file &&
 	test_path_is_file letters.txt &&
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index bbbba3dcbf..47d4434d64 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -397,7 +397,12 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
 	test 5 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+	else
+		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+	fi &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
@@ -415,7 +420,12 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
 	test 5 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+	else
+		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+	fi &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
@@ -471,7 +481,12 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 	git checkout -q rename-dest^0 &&
 	test_must_fail git merge --strategy=recursive source-conflict &&
 
-	test 1 -eq "$(git ls-files -u | wc -l)" &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 2 -eq "$(git ls-files -u | wc -l)"
+	else
+		test 1 -eq "$(git ls-files -u | wc -l)"
+	fi &&
 
 	test_must_fail git diff --quiet &&
 
@@ -505,34 +520,63 @@ test_expect_success 'setup pair rename to parent of other (D/F conflicts)' '
 	git commit -m "Rename one/file -> two"
 '
 
-test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
-	git checkout -q rename-one^0 &&
-	mkdir one &&
-	test_must_fail git merge --strategy=recursive rename-two &&
+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+then
+	test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
+		git checkout -q rename-one^0 &&
+		mkdir one &&
+		test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		test 4 -eq "$(git ls-files -u | wc -l)" &&
+		test 2 -eq "$(git ls-files -u one | wc -l)" &&
+		test 2 -eq "$(git ls-files -u two | wc -l)" &&
 
-	test_must_fail git diff --quiet &&
+		test_must_fail git diff --quiet &&
 
-	test 4 -eq $(find . | grep -v .git | wc -l) &&
+		test 3 -eq $(find . | grep -v .git | wc -l) &&
 
-	test_path_is_dir one &&
-	test_path_is_file one~rename-two &&
-	test_path_is_file two &&
-	test "other" = $(cat one~rename-two) &&
-	test "stuff" = $(cat two)
-'
+		test_path_is_file one &&
+		test_path_is_file two &&
+		test "other" = $(cat one) &&
+		test "stuff" = $(cat two)
+	'
+else
+	test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
+		git checkout -q rename-one^0 &&
+		mkdir one &&
+		test_must_fail git merge --strategy=recursive rename-two &&
+
+		test 2 -eq "$(git ls-files -u | wc -l)" &&
+		test 1 -eq "$(git ls-files -u one | wc -l)" &&
+		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+
+		test_must_fail git diff --quiet &&
+
+		test 4 -eq $(find . | grep -v .git | wc -l) &&
+
+		test_path_is_dir one &&
+		test_path_is_file one~rename-two &&
+		test_path_is_file two &&
+		test "other" = $(cat one~rename-two) &&
+		test "stuff" = $(cat two)
+	'
+fi
 
 test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean start' '
 	git reset --hard &&
 	git clean -fdqx &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 4 -eq "$(git ls-files -u | wc -l)" &&
+		test 2 -eq "$(git ls-files -u one | wc -l)" &&
+		test 2 -eq "$(git ls-files -u two | wc -l)"
+	else
+		test 2 -eq "$(git ls-files -u | wc -l)" &&
+		test 1 -eq "$(git ls-files -u one | wc -l)" &&
+		test 1 -eq "$(git ls-files -u two | wc -l)"
+	fi &&
 
 	test_must_fail git diff --quiet &&
 
@@ -572,12 +616,22 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename^0 &&
 	test_must_fail git merge --strategy=recursive second-rename &&
 
-	test 5 -eq "$(git ls-files -s | wc -l)" &&
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
-	test 1 -eq "$(git ls-files -u original | wc -l)" &&
-	test 2 -eq "$(git ls-files -o | wc -l)" &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 5 -eq "$(git ls-files -s | wc -l)" &&
+		test 3 -eq "$(git ls-files -u | wc -l)" &&
+		test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
+		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
+		test 1 -eq "$(git ls-files -u original | wc -l)" &&
+		test 0 -eq "$(git ls-files -o | wc -l)"
+	else
+		test 5 -eq "$(git ls-files -s | wc -l)" &&
+		test 3 -eq "$(git ls-files -u | wc -l)" &&
+		test 1 -eq "$(git ls-files -u one | wc -l)" &&
+		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		test 1 -eq "$(git ls-files -u original | wc -l)" &&
+		test 2 -eq "$(git ls-files -o | wc -l)"
+	fi &&
 
 	test_path_is_file one/file &&
 	test_path_is_file two/file &&
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 8b3a4fc843..0317e83970 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -538,9 +538,15 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout B^0 &&
 		test_must_fail git merge C^0 &&
-		git clean -fd &&
-		git rm -rf a/ &&
-		git rm a &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git rm -rf a/ &&
+			git rm a~HEAD
+		else
+			git clean -fd &&
+			git rm -rf a/ &&
+			git rm a
+		fi &&
 		git cat-file -p B:a >a2 &&
 		git add a2 &&
 		git commit -m D2 &&
@@ -559,7 +565,12 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout C^0 &&
 		test_must_fail git merge B^0 &&
-		git clean -fd &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git rm a~B^0
+		else
+			git clean -fd
+		fi &&
 		git rm -rf a/ &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a &&
 		git add a &&
@@ -568,9 +579,15 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout C^0 &&
 		test_must_fail git merge B^0 &&
-		git clean -fd &&
-		git rm -rf a/ &&
-		git rm a &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git rm -rf a/ &&
+			git rm a~B^0
+		else
+			git clean -fd &&
+			git rm -rf a/ &&
+			git rm a
+		fi &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a2 &&
 		git add a2 &&
 		git commit -m E4 &&
@@ -588,18 +605,34 @@ test_expect_success 'merge of D1 & E1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E1^0 &&
 
-		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
-
-		git rev-parse >expect    \
-			A:ignore-me  B:a &&
-		git rev-parse   >actual   \
-			:0:ignore-me :2:a &&
-		test_cmp expect actual
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				A:ignore-me  B:a  D1:a &&
+			git rev-parse   >actual   \
+				:0:ignore-me :1:a :2:a &&
+			test_cmp expect actual
+		else
+			git ls-files -s >out &&
+			test_line_count = 2 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				A:ignore-me  B:a &&
+			git rev-parse   >actual   \
+				:0:ignore-me :2:a &&
+			test_cmp expect actual
+		fi
 	)
 '
 
@@ -613,18 +646,34 @@ test_expect_success 'merge of E1 & D1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D1^0 &&
 
-		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
-
-		git rev-parse >expect    \
-			A:ignore-me  B:a &&
-		git rev-parse   >actual   \
-			:0:ignore-me :3:a &&
-		test_cmp expect actual
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				A:ignore-me  B:a  D1:a &&
+			git rev-parse   >actual   \
+				:0:ignore-me :1:a :3:a &&
+			test_cmp expect actual
+		else
+			git ls-files -s >out &&
+			test_line_count = 2 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				A:ignore-me  B:a &&
+			git rev-parse   >actual   \
+				:0:ignore-me :3:a &&
+			test_cmp expect actual
+		fi
 	)
 '
 
@@ -638,17 +687,32 @@ test_expect_success 'merge of D1 & E2 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E2^0 &&
 
-		git ls-files -s >out &&
-		test_line_count = 4 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
-
-		git rev-parse >expect    \
-			B:a   E2:a/file  C:a/file   A:ignore-me &&
-		git rev-parse   >actual   \
-			:2:a  :3:a/file  :1:a/file  :0:ignore-me &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 5 out &&
+			git ls-files -u >out &&
+			test_line_count = 4 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
+			git rev-parse   >actual   \
+				:1:a~HEAD :2:a~HEAD :3:a/file  :1:a/file  :0:ignore-me
+		else
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 2 out &&
+
+			git rev-parse >expect    \
+				B:a    E2:a/file  C:a/file   A:ignore-me &&
+			git rev-parse   >actual   \
+				:2:a   :3:a/file  :1:a/file  :0:ignore-me
+		fi &&
 		test_cmp expect actual &&
 
 		test_path_is_file a~HEAD
@@ -665,17 +729,32 @@ test_expect_success 'merge of E2 & D1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D1^0 &&
 
-		git ls-files -s >out &&
-		test_line_count = 4 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
-
-		git rev-parse >expect    \
-			B:a   E2:a/file  C:a/file   A:ignore-me &&
-		git rev-parse   >actual   \
-			:3:a  :2:a/file  :1:a/file  :0:ignore-me &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 5 out &&
+			git ls-files -u >out &&
+			test_line_count = 4 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >expect    \
+				B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
+			git rev-parse   >actual   \
+				:1:a~D1^0 :3:a~D1^0 :2:a/file  :1:a/file  :0:ignore-me
+		else
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 2 out &&
+
+			git rev-parse >expect    \
+				B:a   E2:a/file  C:a/file   A:ignore-me &&
+			git rev-parse   >actual   \
+				:3:a  :2:a/file  :1:a/file  :0:ignore-me
+		fi &&
 		test_cmp expect actual &&
 
 		test_path_is_file a~D1^0
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 58729593ba..78bfaf17f0 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -313,15 +313,18 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
 		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_line_count = 1 out
+		else
+			test_line_count = 2 out
+		fi &&
 
 		echo 0 >expect &&
 		git cat-file -p base:file >>expect &&
 		echo 7 >>expect &&
 		test_cmp expect newfile~HEAD &&
 
-		test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
-
 		test_path_is_file newfile/realfile &&
 		test_path_is_file newfile~HEAD
 	)
@@ -344,7 +347,12 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
 		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_line_count = 1 out
+		else
+			test_line_count = 2 out
+		fi &&
 
 		git cat-file -p left-conflict:newfile >left &&
 		git cat-file -p base:file    >base &&
@@ -356,10 +364,16 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 			left base right &&
 		test_cmp left newfile~HEAD &&
 
-		git rev-parse >expect                                 \
-			base:file   left-conflict:newfile  right:file &&
-		git rev-parse >actual                                 \
-			:1:newfile  :2:newfile             :3:newfile &&
+		git rev-parse >expect   \
+			base:file       left-conflict:newfile right:file &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git rev-parse >actual \
+				:1:newfile~HEAD :2:newfile~HEAD :3:newfile~HEAD
+		else
+			git rev-parse >actual \
+				:1:newfile      :2:newfile      :3:newfile
+		fi &&
 		test_cmp expect actual &&
 
 		test_path_is_file newfile/realfile &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 807a424a52..5ea77564d7 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -1177,10 +1177,18 @@ test_expect_success '5d: Directory/file/file conflict due to directory rename' '
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
 		git ls-files -o >out &&
-		test_line_count = 2 out &&
-
-		git rev-parse >actual \
-			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+			    :0:y/b :0:y/c :0:z/d :0:y/f :2:y/d~HEAD :0:y/d/e
+		else
+			test_line_count = 2 out &&
+
+			git rev-parse >actual \
+			    :0:y/b :0:y/c :0:z/d :0:y/f :2:y/d      :0:y/d/e
+		fi &&
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:z/d  B:z/f  A:y/d  B:y/d/e &&
 		test_cmp expect actual &&
@@ -2017,17 +2025,32 @@ test_expect_success '7e: transitive rename in rename/delete AND dirs in the way'
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 5 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
-
-		git rev-parse >actual \
-			:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
-		git rev-parse >expect \
-			 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+				:0:x/d/f :0:y/d/g :0:y/b :0:y/c :1:y/d~B^0 :3:y/d~B^0 &&
+			git rev-parse >expect \
+				 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d      O:x/d
+		else
+			git ls-files -s >out &&
+			test_line_count = 5 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 2 out &&
+
+			git rev-parse >actual \
+				:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
+			git rev-parse >expect \
+				 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d
+		fi &&
 		test_cmp expect actual &&
 
 		git hash-object y/d~B^0 >actual &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index ad288ddc69..70afdd06fa 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -532,7 +532,14 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
-	yes "l" | git mergetool submod &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		yes "c" | git mergetool submod~HEAD &&
+		git rm submod &&
+		git mv submod~HEAD submod
+	else
+		yes "l" | git mergetool submod
+	fi &&
 	git submodule update -N &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod &&
@@ -549,7 +556,15 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
-	yes "r" | git mergetool submod &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		mv submod submod.orig &&
+		git rm --cached submod &&
+		yes "c" | git mergetool submod~test19 &&
+		git mv submod~test19 submod
+	else
+		yes "r" | git mergetool submod
+	fi &&
 	test -d submod.orig &&
 	git submodule update -N &&
 	echo "not a submodule" >expect &&
@@ -567,6 +582,10 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		yes "d" | git mergetool submod~test19
+	fi &&
 	echo "master submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
@@ -664,7 +683,14 @@ test_expect_success 'directory vs modified submodule' '
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
-	yes "r" | git mergetool submod &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		yes "r" | git mergetool submod~master &&
+		git mv submod submod.orig &&
+		git mv submod~master submod
+	else
+		yes "r" | git mergetool submod
+	fi &&
 	test -d submod.orig &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod.orig/file16 &&
-- 
gitgitgadget

