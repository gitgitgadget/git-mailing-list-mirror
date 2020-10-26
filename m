Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B0C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC3F239D2
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c28YwJVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442910AbgJZRCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42978 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775616AbgJZRBx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id j7so13458122wrt.9
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xTh0/ZwZW6Ma8rEW81J5QgP6ZpGakFVaDbdYOH/CrOM=;
        b=c28YwJVL0f+87T199saFGqXrzmwjbN+T0BI6t9NyeaTUEkLdMtgKvq/L5GG7w1Caah
         VKaRY/E3KlZvVZwq+s491JVhAwE/Ie1bjsGcV/XBCpNswzY5t3u2uk1cJdj2txJd17yL
         ImpFfcCfMCVlE2yGdpjqcA4zvZf14pgFxf0QJ+Z+RPXH0uUQwpgALaJGaxomvqfMn9qX
         7kBi1ZyekiEY2aM2vcUVfGf7aSvqhsBPLcsHIQtwNwXhP5tt5vEWDCtG6tJGXAiOAMnn
         rM5JUgKS9PbxtSAqffy9HlFvrg+1fALXfzS69i++hB9FAgW8c6ESQmS4Ecs3PkQ3xEDw
         7uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xTh0/ZwZW6Ma8rEW81J5QgP6ZpGakFVaDbdYOH/CrOM=;
        b=RQ8yGxw2Vhe8AkDNVP7EGM9/4TtbqbvCuVyb47XP2cBjxA9NA3F+NHel7XZPptRU20
         PafIjKxOtxPlWsD35rzUwU0qlmkSIcUB8mtDrRdMDnWhDe/+waj5fRnIaqDyIftYtQLN
         +YyuG1NpfGOEZfNamo5fl2i+959LLY6O6F8U+uVjaf8LkY+O0IafMnFv6E8eYwLzFBQk
         x7wpwJQS2b/Bdy92AP/m9gZKM4rkUMjKXF4HiQk/Vl4m853m0dK5qzrHiWUgiafxY+AU
         TXrle2COU2SbuJdBLgvJymIlvQcH5v3F0b/Iuc5fISE37O31pS2YRYH7yhumB6zg3gmf
         QqPg==
X-Gm-Message-State: AOAM530sfumuYIYaa4IdU1bX07G3yFIvReqJFvyWtXyV+7VNqu+UvyKY
        wZ776N4x2ORoxIzf+9R20TTs2p6JW1o=
X-Google-Smtp-Source: ABdhPJzwkpbSjzfr2BtCQ9ISHcZPA3EcHvu9VHb73TjvHwcqnidIDlbSuyLGVg+XApgja/nJzWWaeQ==
X-Received: by 2002:a5d:4d0c:: with SMTP id z12mr20473721wrt.60.1603731709704;
        Mon, 26 Oct 2020 10:01:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm24083310wmf.45.2020.10.26.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:49 -0700 (PDT)
Message-Id: <6e47fa19f84a2017cad728aaa8170fb23aca45c7.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:39 +0000
Subject: [PATCH v2 4/9] t6404, t6423: expect improved rename/delete handling
 in ort backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When a file is renamed and has content conflicts, merge-recursive does
not have some stages for the old filename and some stages for the new
filename in the index; instead it copies all the stages corresponding to
the old filename over to the corresponding locations for the new
filename, so that there are three higher order stages all corresponding
to the new filename.  Doing things this way makes it easier for the user
to access the different versions and to resolve the conflict (no need to
manually 'git rm' the old version as well as 'git add' the new one).

rename/deletes should be handled similarly -- there should be two stages
for the renamed file rather than just one.  We do not want to
destabilize merge-recursive right now, so instead update relevant tests
to have different expectations depending on whether the "recursive" or
"ort" merge strategies are in use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6404-recursive-merge.sh          | 14 +++++-
 t/t6423-merge-rename-directories.sh | 70 ++++++++++++++++++++---------
 2 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 332cfc53fd..b1c3d4dda4 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -118,12 +118,22 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test_tick &&
 	git commit -m rename &&
 	test_must_fail git merge delete &&
-	test 1 = $(git ls-files --unmerged | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 2 = $(git ls-files --unmerged | wc -l)
+	else
+		test 1 = $(git ls-files --unmerged | wc -l)
+	fi &&
 	git rev-parse --verify :2:a2 &&
 	test_must_fail git rev-parse --verify :3:a2 &&
 	git checkout -f delete &&
 	test_must_fail git merge rename &&
-	test 1 = $(git ls-files --unmerged | wc -l) &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test 2 = $(git ls-files --unmerged | wc -l)
+	else
+		test 1 = $(git ls-files --unmerged | wc -l)
+	fi &&
 	test_must_fail git rev-parse --verify :2:a2 &&
 	git rev-parse --verify :3:a2
 '
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 5ea77564d7..f9a3f24039 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -1271,17 +1271,32 @@ test_expect_success '6a: Tricky rename/delete' '
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
 
-		git rev-parse >actual \
-			:0:y/b :3:y/c &&
-		git rev-parse >expect \
-			 O:z/b  O:z/c &&
+			git rev-parse >actual \
+				:0:y/b :1:y/c :3:y/c &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:z/c
+		else
+			git ls-files -s >out &&
+			test_line_count = 2 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+				:0:y/b :3:y/c &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c
+		fi &&
 		test_cmp expect actual
 	)
 '
@@ -1934,17 +1949,32 @@ test_expect_success '7d: transitive rename involved in rename/delete; how is it
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
-		git ls-files -s >out &&
-		test_line_count = 3 out &&
-		git ls-files -u >out &&
-		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
 
-		git rev-parse >actual \
-			:0:y/b :0:y/c :3:y/d &&
-		git rev-parse >expect \
-			 O:z/b  O:z/c  O:x/d &&
+			git rev-parse >actual \
+				:0:y/b :0:y/c :1:y/d :3:y/d &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:x/d  O:x/d
+		else
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 1 out &&
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			git rev-parse >actual \
+				:0:y/b :0:y/c :3:y/d &&
+			git rev-parse >expect \
+				 O:z/b  O:z/c  O:x/d
+		fi &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget

