Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC7C5517A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ADC21D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfKGZ5r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbgJWQBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbgJWQBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFECC0613D4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so2473900wrp.10
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6GQbWuh37mT7te6bMTumGT3vAbVRprkgFjHvwvPU8nI=;
        b=hfKGZ5r44hXL2EhFuSjlJ6gfi+gm7Dpag1Je9muAhHRexivs40Z2OHwx+6qg1FRyFb
         1xlfTL9TIqhDD4Tz9y5yRRviHZlyRpJMlFKe/+pDAS/ZboDpwDObVGALB5VI7/tRvsZ+
         NGo0a7VYM6x0XD5oq6geJ3GCLvId+7XkfcX1SyUYf5xldHAd6kD2/X2oIangizv2YCTb
         XCJu6OpslT0rtA68Xe1DytWYR451SZuRi4Nb/xCwYOKUIQhss9oUnRCtQMiSvZbSuXQf
         wUDMusyoCwTkm8pmllWFuzWe9sxARhuGZccLbxAsDITIX2vZHx3eO5qKGl0d1BeHOt5X
         DcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6GQbWuh37mT7te6bMTumGT3vAbVRprkgFjHvwvPU8nI=;
        b=CmFlLVg6vKuhBjWpVJbrDZxN8v0WHDe9IC2j+utBZGV6Ods0lZvNMnRdzV1YO0WS5r
         w+UgWB2K4l4PNzmSa5InYrmRe60z5UgthRs70OykbZl+tnVJtYXnIcLuQ43U8aTa+bCp
         GI1Q1UFTh8ZAYvq+b1qPr4+PYCp92Un9kBDJv8yWZ1DKG5NjY3MbASufMX4mn8nqbCMw
         XE/6k9Pc8PkX0rAIDzI3ouZeA8MGL5qrr0on+/xBTlN8mfbqz5f9Td61juIB+F6oxCLP
         BCtZdxmL1EWNCBVmgdvWRKzAuryiJmE3/jVINmR0u9uQjStaHSMD9Sbosz6ye2v1WeXC
         biuQ==
X-Gm-Message-State: AOAM532zeWkIeJXQlaZtsMZDtb3aT95CScUtJordjtRM6Jsi8w61uQ9R
        Ebj/61unbJwbt6uInQPg6J8llR0fIwo=
X-Google-Smtp-Source: ABdhPJxj1FiVz2jV0ZPtycYIl+BiAPemPTjNSxrUn9xKIMpf5JYw+wPfVAQO2Vs9bk/nAUpKnH7h7w==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr3160538wrw.243.1603468898314;
        Fri, 23 Oct 2020 09:01:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm4687140wrq.27.2020.10.23.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:37 -0700 (PDT)
Message-Id: <436577106e6ad079ece200fc318acab9262f6ce7.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:23 +0000
Subject: [PATCH 8/9] t6423: note improved ort handling with untracked files
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

Similar to the previous commit, since the "recursive" backend relies on
unpack_trees() to check if unstaged or untracked files would be
overwritten by a merge, and unpack_trees() does not understand renames
-- it has false positives and false negatives.  Once it has run, since
it updates as it goes, merge-recursive then has to handle completing the
merge as best it can despite extra changes in the working copy.
However, this is not just an issue for dirty files, but also for
untracked files because directory renames can cause file contents to
need to be written to a location that was not tracked on either side of
history.

Since the "ort" backend does the complete merge inmemory, and only
updates the index and working copy as a post-processing step, if there
are untracked files in the way it can simply abort the merge much like
checkout does.

Update t6423 to reflect the better merge abilities and expectations for
ort, while still leaving the best-case-as-good-as-recursive-can-do
expectations there for the recursive backend so we retain its stability
until we are ready to deprecate and remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 195 ++++++++++++++++++----------
 1 file changed, 124 insertions(+), 71 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 32e6925ca4..db694a6316 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -3214,6 +3214,7 @@ test_expect_success '10a: Overwrite untracked with normal rename/delete' '
 		echo important >z/d &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+		test_path_is_missing .git/MERGE_HEAD &&
 		test_i18ngrep "The following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
@@ -3283,21 +3284,34 @@ test_expect_success '10b: Overwrite untracked with dir rename + delete' '
 		echo contents >y/e &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
-		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 3 out &&
-		git ls-files -u >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 5 out &&
+			git ls-files -s >out &&
+			test_line_count = 1 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 5 out
+		else
+			test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
+			test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
 
-		git rev-parse >actual \
-			:0:y/b :3:y/d :3:y/e &&
-		git rev-parse >expect \
-			O:z/b  O:z/c  B:z/e &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 5 out &&
+
+			git rev-parse >actual \
+				:0:y/b :3:y/d :3:y/e &&
+			git rev-parse >expect \
+				O:z/b  O:z/c  B:z/e &&
+			test_cmp expect actual
+		fi &&
 
 		echo very >expect &&
 		test_cmp expect y/c &&
@@ -3360,25 +3374,38 @@ test_expect_success '10c1: Overwrite untracked with dir rename/rename(1to2)' '
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git hash-object y/c~B^0 >actual &&
-		git rev-parse O:x/c >expect &&
-		test_cmp expect actual &&
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+			test_cmp expect actual &&
+
+			git hash-object y/c~B^0 >actual &&
+			git rev-parse O:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3398,25 +3425,38 @@ test_expect_success '10c2: Overwrite untracked with dir rename/rename(1to2), oth
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git hash-object y/c~HEAD >actual &&
-		git rev-parse O:x/c >expect &&
-		test_cmp expect actual &&
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+			test_cmp expect actual &&
+
+			git hash-object y/c~HEAD >actual &&
+			git rev-parse O:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3474,37 +3514,50 @@ test_expect_success '10d: Delete untracked with dir rename/rename(2to1)' '
 		echo important >y/wham &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
+
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
+			test_cmp expect actual &&
 
-		test_must_fail git rev-parse :1:y/wham &&
+			test_must_fail git rev-parse :1:y/wham &&
 
-		echo important >expect &&
-		test_cmp expect y/wham &&
+			# Test that two-way merge in y/wham~merged is as expected
+			git cat-file -p :2:y/wham >expect &&
+			git cat-file -p :3:y/wham >other &&
+			>empty &&
+			test_must_fail git merge-file \
+				-L "HEAD" \
+				-L "" \
+				-L "B^0" \
+				expect empty other &&
+			test_cmp expect y/wham~merged
+		fi &&
 
-		# Test that the two-way merge in y/wham~merged is as expected
-		git cat-file -p :2:y/wham >expect &&
-		git cat-file -p :3:y/wham >other &&
-		>empty &&
-		test_must_fail git merge-file \
-			-L "HEAD" \
-			-L "" \
-			-L "B^0" \
-			expect empty other &&
-		test_cmp expect y/wham~merged
+		echo important >expect &&
+		test_cmp expect y/wham
 	)
 '
 
-- 
gitgitgadget

