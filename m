Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE8FC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6192074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2NRYrrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHYSg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHYSgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4831C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q14so2716195wrn.9
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddgOxQAf9A7kFmL2ILUM2HpYvMuwscp0rEU6vEGE8Rg=;
        b=S2NRYrrjZ9jh5mdU5l/hdu3ABk7nhMrJ/d7cai/YKr4Kkt90YHpuQTuS2gmbgLy2vI
         8T6yYdRydSYLd7wsTY6HBKkMIRwUGfcawBTNBwuZL2NFdlwU9VANC97E6PkC5apaYL3l
         usI71//EqvYyYAJ0kTX1dqbSbxbsuZFzD0JkcL9z9xxefsfw+6Bbk+H7nVcon0r4sBqK
         uo6Ajujsav66fXGUQ9BUVGL1PmuHtjVnfHQrex9IGvJsTyaMvLKu/bMGkEr/uOdHKUll
         1t5I5BcDsTt8Ve5x4qXysxAPMXX+nIpwTA0cBhmcrYcA8RwNKzDGhMxxXIfL/nw8tB4F
         vd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddgOxQAf9A7kFmL2ILUM2HpYvMuwscp0rEU6vEGE8Rg=;
        b=pM9MM6WjS7jca/0SH7H6fAoPAf3Wsh+7TVXAAlY17lCLUOceoG9gN0b0iNBuTEU3AZ
         algHLZrvuP+Vb7y5wyHSXaDVvT+kzvHi5AG5jQQbfiDCxAMNjdCja78sK3OQXRtmoKrP
         3d98VoQOC5xvv/g38sklO7az4bMt7OvexrC9+P+kxm8QOlYj4oomqwe/z6oQkZRSyNkb
         C3TqmXWxgEH/9gALcREUrOWHRKCpXS8XA/YmTGUUWYIa7QLttCqK9T3qOzXb/W6z32BU
         2OQzxKoG0oiyrPbv5NkJeQdGmQ0hQOvMNhgpg0gd4fykStW4IV0QoH5yiRIpGwTgQ6VY
         Evaw==
X-Gm-Message-State: AOAM532QydJhsCCBNMpd+KBw/pOto7Wovv4+8kUL5DcvewEUKXQC6ORP
        b4hSRjZ8uPLC7VykG+uUi0FSigLt/ro=
X-Google-Smtp-Source: ABdhPJyvMpolzzm2xCJ4vHxNai2s9Bgcp6f0zSBxfPd1Ry3xx1SdBANumUhpxFAnvnzncS09jDiElA==
X-Received: by 2002:a5d:6505:: with SMTP id x5mr11598549wru.336.1598380605316;
        Tue, 25 Aug 2020 11:36:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm35263398wrc.97.2020.08.25.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:44 -0700 (PDT)
Message-Id: <2cd3c803d9b7227e645b26758605475e40bf98eb.1598380599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:36 +0000
Subject: [PATCH v3 5/8] midx: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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
index ef499cf504..aa37d5da86 100644
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
index 7dfff0f8f4..ec87f616c6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -171,12 +171,12 @@ test_expect_success 'write progress off for redirected stderr' '
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
 
@@ -333,17 +333,17 @@ test_expect_success 'git-fsck incorrect offset' '
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
 
@@ -487,7 +487,7 @@ test_expect_success 'expire progress off for redirected stderr' '
 test_expect_success 'expire force progress on for stderr' '
 	(
 		cd dup &&
-		git multi-pack-index --progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index --progress expire 2>err &&
 		test_file_not_empty err
 	)
 '
@@ -495,7 +495,7 @@ test_expect_success 'expire force progress on for stderr' '
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

