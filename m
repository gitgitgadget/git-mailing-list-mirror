Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA7AC433E4
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CCD20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1V1521c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgG3WZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgG3WY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85EC0617A0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so26316981wrw.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TMxpn4iMmsXP6T5DjXbu9YsDv8P3a3JeXKyeYM1BNkw=;
        b=r1V1521crySSp46ak7ulfyKqeneTMj1vPT8k5W9y0EdDJY0+cvOyuiqXc0x67/UFXK
         FUPNUUV+aAkdCfmsmxOE0i8Ush7cgwarySlAU9glbGu4HHmxZUujGwl3W8/hCdD0m2FT
         gQYhl/cDpBe2cSX+CFkc0LUhxLWtBvjaw5jJ/J0jcKjkA+cGrq5TZS7M9WTfX8GBE1Vd
         uzqML4mHix1QNKFqJzu6JbmKDL5WXAVFhZM0relYxAm+DJHoxgHC8/SrZaTXNnzHjRyA
         ohfVrcvRORSe2cbWo+BM58B6weI6QVP0NemjU4cZ7ZZsNRJxjWmnvg3ATKgFwaHnAs3b
         3k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TMxpn4iMmsXP6T5DjXbu9YsDv8P3a3JeXKyeYM1BNkw=;
        b=atZEVH+vat6hp5EhiKQKycPtkbjUIwdvzr1pYNCN8zWFlRa8eeeynXuQf9MDWlCIka
         uHttFCH3tzw8e/IuU3pYKucsV2146C7f1HSlQbuqJa4NfhV25AswX0NmtYk5JnuiFIgq
         EeNW50JifjiMW1XSvoyZ7wemnuJRghBS19px3+UPcXiuRCx5Q3jJg9OUTErnCvzHUU0q
         XB00l8ngYNY5rYTuCWYYzpeFZVSXAFEqztuhfRYAQUAqsFUyhhWLtuLrzLN0DY+cceoo
         /vnH/bihR7ViIkgrquFCVKLMEM/q5mgmUsMY4kWJf1jgSaujZsm5Amg1MICwwQiI5W4S
         T5BQ==
X-Gm-Message-State: AOAM532xMcOdt5fYCAO9HkqGhCOFAPPdJqioLZf+aJUb4ZX4PNcLdTbU
        ea6d04Nw+Gapa/yBusje8G45a7TN
X-Google-Smtp-Source: ABdhPJz+sfGGPT2Jm3I0L2/D/ECqrsZwgzIAe0hua05DPR+f/wwyHayDCy6FNhgloYJX00fRKou1sQ==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr672366wrx.270.1596147895579;
        Thu, 30 Jul 2020 15:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm10839150wrx.30.2020.07.30.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:54 -0700 (PDT)
Message-Id: <9b4cef7635ede3e9e597d5f8e8da24e352f34c12.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:25 +0000
Subject: [PATCH v3 19/20] midx: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that the multi-pack-index may be written as part of auto maintenance
at the end of a command, reduce the progress output when the operations
are quick. Use start_delayed_progress() instead of start_progress().

Update t5319-multi-pack-index.sh to use GIT_PROGRESS_DELAY=0 now that
the progress indicators are conditional.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 10 +++++-----
 t/t5319-multi-pack-index.sh | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index f0ebee34c8..66d7053d83 100644
--- a/midx.c
+++ b/midx.c
@@ -832,7 +832,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	packs.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
-		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
+		packs.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
 	else
 		packs.progress = NULL;
 
@@ -969,7 +969,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Writing chunks to multi-pack-index"),
+		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
 					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
@@ -1104,7 +1104,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		return 0;
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Looking for referenced packfiles"),
+		progress = start_delayed_progress(_("Looking for referenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
@@ -1225,7 +1225,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Counting referenced objects"),
+		progress = start_delayed_progress(_("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
@@ -1235,7 +1235,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2abd29a007..26f224b0e3 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -173,12 +173,12 @@ test_expect_success 'write progress off for redirected stderr' '
 '
 
 test_expect_success 'write force progress on for stderr' '
-	git multi-pack-index --object-dir=$objdir --progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress write 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'write with the --no-progress option' '
-	git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
 	test_line_count = 0 err
 '
 
@@ -335,17 +335,17 @@ test_expect_success 'git-fsck incorrect offset' '
 '
 
 test_expect_success 'repack progress off for redirected stderr' '
-	git multi-pack-index --object-dir=$objdir repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
 	test_line_count = 0 err
 '
 
 test_expect_success 'repack force progress on for stderr' '
-	git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'repack with the --no-progress option' '
-	git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
 	test_line_count = 0 err
 '
 
@@ -489,7 +489,7 @@ test_expect_success 'expire progress off for redirected stderr' '
 test_expect_success 'expire force progress on for stderr' '
 	(
 		cd dup &&
-		git multi-pack-index --progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index --progress expire 2>err &&
 		test_file_not_empty err
 	)
 '
@@ -497,7 +497,7 @@ test_expect_success 'expire force progress on for stderr' '
 test_expect_success 'expire with the --no-progress option' '
 	(
 		cd dup &&
-		git multi-pack-index --no-progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index --no-progress expire 2>err &&
 		test_line_count = 0 err
 	)
 '
-- 
gitgitgadget

