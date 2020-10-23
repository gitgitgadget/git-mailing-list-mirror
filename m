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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0444BC55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB1022210
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjZoLSVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbgJWQBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbgJWQBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72086C0613D2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y12so2481131wrp.6
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/RJodLrhrZB0Tw1j/DElxsuBn696TMLb/sWHDwufkIU=;
        b=FjZoLSVVRJHzZx5HQqMPKicdcG/RbUcK4hktgoLzy1arCAE1VvxtKXVbZ7HbsMmQWi
         xOpX3wzcBHsatQLeAIBIk/aU0nf4s2vZDsq3BgmgvVM3+1k6JvpWHj6h7gW3UfbFS62c
         aKmiHrgwU6czi1uihUOPezjOROKNfUhGUXrmTeU+6Jp0XuOZGWu6yEt1LcCB/MDpn1SH
         yqsODMya3J1tA6ABQdgyxXcNoaLRyLp7n8xEho9VGh4v4gIlihZ79R5KWCIAcaxZUNwr
         tvpX1lSYa+wr1gMWAMytLraXJ/XthgU6Aw4PFcwTvCboUQOg+z/gUgCECQ7VRWtA2J+B
         DF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/RJodLrhrZB0Tw1j/DElxsuBn696TMLb/sWHDwufkIU=;
        b=L1+p36/2Afruhr2ExylZTVeU/EJMtvQuZTgRiSt9FyCnH42m3s3MBHCbEl7US7b6i6
         fxMD3otknuJPqp9Ozcerpwb7d2F3IJ2mnoKchyEiQ17LSC8/YQne60Ikw2T6QP/Q7VnK
         y08DY6NUBoW7NPw2n5I9A75iWyF1cYIDEYpdAE210RgXDwY9a7lW097ytF0ZNtr4YZmy
         CptwGHLjuu1cZybNsz2MPA/diypd88eyDfZ3XoiaFb9EOsBnbPSkbkAcpyj8/8YV7f44
         Hi/DuXEgmuD/JIdp0JlHux4vvRpQ43nUKppWOQOd0Hrn/IhLlWvhjVJTfe60rSRisUdi
         cmTw==
X-Gm-Message-State: AOAM532Qn7kJ+CL3V0hdRwNEQaFg22LBvSKw518zVXIWKAVjeu/OydkG
        +dzF119kWyRdMEYAlIi2F0nrEkILTkA=
X-Google-Smtp-Source: ABdhPJxPjB08dIRpQnJmdAxPbNk71jyJaOe4wtCnLvqbYSYshs9W9Q9kHm/wKMLUj22cGV5zZ4F21A==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr3350995wrp.413.1603468897489;
        Fri, 23 Oct 2020 09:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h128sm4118691wme.38.2020.10.23.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:37 -0700 (PDT)
Message-Id: <9d46cc1ef3dbc863c48a446f40419470b1bad5a3.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:22 +0000
Subject: [PATCH 7/9] t6423, t6436: note improved ort handling with dirty files
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

The "recursive" backend relies on unpack_trees() to check if unstaged
changes would be overwritten by a merge, but unpack_trees() does not
understand renames -- and once it returns, it has already written many
updates to the working tree and index.  As such, "recursive" had to do a
special 4-way merge where it would need to also treat the working copy
as an extra source of differences that we had to carefully avoid
overwriting and resulting in moving files to new locations to avoid
conflicts.

The "ort" backend, by contrast, does the complete merge inmemory, and
only updates the index and working copy as a post-processing step.  If
there are dirty files in the way, it can simply abort the merge.

Update t6423 and t6436 to reflect the better merge abilities and
expectations we have for ort, while still leaving the
best-case-as-good-as-recursive-can-do expectations there for the
recursive backend so we retain its stability until we are ready to
deprecate and remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 266 ++++++++++++++++------------
 t/t6436-merge-overwrite.sh          |  18 +-
 2 files changed, 165 insertions(+), 119 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 7e32626913..32e6925ca4 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -3634,28 +3634,35 @@ test_expect_success '11a: Avoid losing dirty contents with simple rename' '
 		echo stuff >>z/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
-		test_seq 1 10 >expected &&
-		echo stuff >>expected &&
-		test_cmp expected z/c &&
+			git ls-files -s >out &&
+			test_line_count = 2 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 4 out &&
+			git rev-parse >actual \
+				:0:z/a :2:z/c &&
+			git rev-parse >expect \
+				 O:z/a  B:z/b &&
+			test_cmp expect actual &&
 
-		git rev-parse >actual \
-			:0:z/a :2:z/c &&
-		git rev-parse >expect \
-			 O:z/a  B:z/b &&
-		test_cmp expect actual &&
+			git hash-object z/c~HEAD >actual &&
+			git rev-parse B:z/b >expect &&
+			test_cmp expect actual
+		fi &&
+
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c
 
-		git hash-object z/c~HEAD >actual &&
-		git rev-parse B:z/b >expect &&
-		test_cmp expect actual
 	)
 '
 
@@ -3706,32 +3713,39 @@ test_expect_success '11b: Avoid losing dirty file involved in directory rename'
 		git checkout A^0 &&
 		echo stuff >>z/c &&
 
-		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
-		grep -q stuff z/c &&
-		test_seq 1 10 >expected &&
-		echo stuff >>expected &&
-		test_cmp expected z/c &&
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -m >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git ls-files -s >out &&
-		test_line_count = 3 out &&
-		git ls-files -u >out &&
-		test_line_count = 0 out &&
-		git ls-files -m >out &&
-		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 4 out &&
+			git rev-parse >actual \
+				:0:x/b :0:y/a :0:y/c &&
+			git rev-parse >expect \
+				 O:x/b  O:z/a  B:x/c &&
+			test_cmp expect actual &&
 
-		git rev-parse >actual \
-			:0:x/b :0:y/a :0:y/c &&
-		git rev-parse >expect \
-			 O:x/b  O:z/a  B:x/c &&
-		test_cmp expect actual &&
+			git hash-object y/c >actual &&
+			git rev-parse B:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
-		git hash-object y/c >actual &&
-		git rev-parse B:x/c >expect &&
-		test_cmp expect actual
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c
 	)
 '
 
@@ -3783,7 +3797,13 @@ test_expect_success '11c: Avoid losing not-uptodate with rename + D/F conflict'
 		echo stuff >>y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "following files would be overwritten by merge" err &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			test_i18ngrep "following files would be overwritten by merge" err
+		fi &&
 
 		grep -q stuff y/c &&
 		test_seq 1 10 >expected &&
@@ -3851,29 +3871,35 @@ test_expect_success '11d: Avoid losing not-uptodate with rename + D/F conflict'
 		echo stuff >>z/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
-		grep -q stuff z/c &&
-		test_seq 1 10 >expected &&
-		echo stuff >>expected &&
-		test_cmp expected z/c &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 4 out &&
 
-		git ls-files -s >out &&
-		test_line_count = 4 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 5 out &&
+			git rev-parse >actual \
+				:0:x/b :0:y/a :0:y/c/d :3:y/c &&
+			git rev-parse >expect \
+				 O:x/b  O:z/a  B:y/c/d  B:x/c &&
+			test_cmp expect actual &&
 
-		git rev-parse >actual \
-			:0:x/b :0:y/a :0:y/c/d :3:y/c &&
-		git rev-parse >expect \
-			 O:x/b  O:z/a  B:y/c/d  B:x/c &&
-		test_cmp expect actual &&
+			git hash-object y/c~HEAD >actual &&
+			git rev-parse B:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
-		git hash-object y/c~HEAD >actual &&
-		git rev-parse B:x/c >expect &&
-		test_cmp expect actual
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c
 	)
 '
 
@@ -3931,37 +3957,43 @@ test_expect_success '11e: Avoid deleting not-uptodate with dir rename/rename(1to
 		echo mods >>y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose dirty file at y/c" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose dirty file at y/c" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 7 out &&
-		git ls-files -u >out &&
-		test_line_count = 4 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 7 out &&
+			git ls-files -u >out &&
+			test_line_count = 4 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
+
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
+			test_cmp expect actual &&
+
+			# See if y/c~merged has expected contents; requires manually
+			# doing the expected file merge
+			git cat-file -p A:y/c >c1 &&
+			git cat-file -p B:z/c >c2 &&
+			>empty &&
+			test_must_fail git merge-file \
+				-L "HEAD" \
+				-L "" \
+				-L "B^0" \
+				c1 empty c2 &&
+			test_cmp c1 y/c~merged
+		fi &&
 
 		echo different >expected &&
 		echo mods >>expected &&
-		test_cmp expected y/c &&
-
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
-		test_cmp expect actual &&
-
-		# See if y/c~merged has expected contents; requires manually
-		# doing the expected file merge
-		git cat-file -p A:y/c >c1 &&
-		git cat-file -p B:z/c >c2 &&
-		>empty &&
-		test_must_fail git merge-file \
-			-L "HEAD" \
-			-L "" \
-			-L "B^0" \
-			c1 empty c2 &&
-		test_cmp c1 y/c~merged
+		test_cmp expected y/c
 	)
 '
 
@@ -4014,38 +4046,44 @@ test_expect_success '11f: Avoid deleting not-uptodate with dir rename/rename(2to
 		echo important >>y/wham &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: Your local changes to the following files would be overwritten by merge" err
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 4 out &&
-		git ls-files -u >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		test_seq 1 10 >expected &&
-		echo important >>expected &&
-		test_cmp expected y/wham &&
+			test_must_fail git rev-parse :1:y/wham &&
 
-		test_must_fail git rev-parse :1:y/wham &&
+			git rev-parse >actual \
+				:0:y/a :0:y/b :2:y/wham :3:y/wham &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/c     O:x/d &&
+			test_cmp expect actual &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/c     O:x/d &&
-		test_cmp expect actual &&
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
+		test_seq 1 10 >expected &&
+		echo important >>expected &&
+		test_cmp expected y/wham
 	)
 '
 
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index dd8ab7ede1..dd9376842f 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -97,11 +97,19 @@ test_expect_success 'will not overwrite unstaged changes in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	test_must_fail git merge c1a >out &&
-	test_i18ngrep "Refusing to lose dirty file at other.c" out &&
-	test_path_is_file other.c~HEAD &&
-	test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
-	test_cmp important other.c
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_must_fail git merge c1a >out 2>err &&
+		test_i18ngrep "would be overwritten by merge" err &&
+		test_cmp important other.c &&
+		test_path_is_missing .git/MERGE_HEAD
+	else
+		test_must_fail git merge c1a >out &&
+		test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+		test_path_is_file other.c~HEAD &&
+		test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
+		test_cmp important other.c
+	fi
 '
 
 test_expect_success 'will not overwrite untracked subtree' '
-- 
gitgitgadget

