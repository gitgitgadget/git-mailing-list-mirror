Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC0C38A2A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AC82075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdSCd68d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgEFJnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728729AbgEFJnS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 05:43:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621FC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 02:43:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so553169wre.13
        for <git@vger.kernel.org>; Wed, 06 May 2020 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nIAqygyDcoL0/Z80+fqR+rZ0oV3urL291l9ZRhupjKI=;
        b=rdSCd68dEULIIEqsgZalSDvu8svT+dyplOMSVpBgLVNoBKZx5s2WspfGKHc84rj40G
         8nCC0xOJM2GXc1yj6602S5LnXrG6lXWAu0jLhLzkoh6IvWZvw97Nuj1e4YadbCpXLY2U
         sNZKDtpGAayvbyf4ut6zl6uaE8j/kT8AyGwMiBNQ3rDknahQTXBBuM8aIskQI5SDo4Vu
         8w/CODrGRMI/YuJdrXlR8VY+qehwvUNRTd9b1gzCTZ1BgU6U1aNHiB2rRZjknJFsrMxT
         2g40qaz0vM6ftog8pzRi4xOOMFDS3j8+iRtd99EUbonVjEUSDdjnBZgzy8fGec7lqx0j
         pZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nIAqygyDcoL0/Z80+fqR+rZ0oV3urL291l9ZRhupjKI=;
        b=NV0tujhoEErQPZrdzhkLm584UlugUlMarhH7VBVTcSpiA3IiprRv3TMZIR27sdcD4f
         o3diZyzOtxdBMFjp+MgOhKaaYkq5Zq3tuSLPLUmnAFRXslv7Hbyw/ZCznPvt5itET/3a
         8OqzT4VFdVVyvb19jM1BG67ryhtjYS2uRxIXfD+xuBkmjS4IxLPA3/2kYOF1ytKktM1z
         CfVggLuUrNvAdeyFT4IndHiavCV6s56H740l5J5dDr1cqi8IUXs8RxRv5DnFXpudHmKg
         uGRcWKgtQPXTOaRq4H3DlhhSbWqcyulu5xzoy5JmkghrJF1JcK/ju3lqdvR0nXeafaol
         B/fQ==
X-Gm-Message-State: AGi0PuZur5fE9zblG7wOlIT/3/uE/eSfBMZ5FR6lD1KFGmn5yBmYdMgl
        8MAa+rvvjk3TnTULQRL4Xpt/aQzV
X-Google-Smtp-Source: APiQypK3nEFwDFlZ8wzLxUQDzr71JvQblato0qPsLZHyMwZ4+8Gefw3VJ4SBbc7F+62wJfxlV0uDtA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr4858330wrm.406.1588758196797;
        Wed, 06 May 2020 02:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm1964648wrr.7.2020.05.06.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:43:16 -0700 (PDT)
Message-Id: <3d7b334f5c6a89f438bba34cf91259cb67aebcd0.1588758194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
        <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 May 2020 09:43:14 +0000
Subject: [PATCH v2 2/2] multi-pack-index: respect repack.packKeptObjects=false
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When selecting a batch of pack-files to repack in the "git
multi-pack-index repack" command, Git should respect the
repack.packKeptObjects config option. When false, this option says that
the pack-files with an associated ".keep" file should not be repacked.
This config value is "false" by default.

There are two cases for selecting a batch of objects. The first is the
case where the input batch-size is zero, which specifies "repack
everything". The second is with a non-zero batch size, which selects
pack-files using a greedy selection criteria. Both of these cases are
updated and tested.

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  3 +++
 midx.c                                 | 26 +++++++++++++++++++++-----
 t/t5319-multi-pack-index.sh            | 26 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 642d9ac5b72..0c6619493c1 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -56,6 +56,9 @@ repack::
 	file is created, rewrite the multi-pack-index to reference the
 	new pack-file. A later run of 'git multi-pack-index expire' will
 	delete the pack-files that were part of this batch.
++
+If `repack.packKeptObjects` is `false`, then any pack-files with an
+associated `.keep` file will not be selected for the batch to repack.
 
 
 EXAMPLES
diff --git a/midx.c b/midx.c
index 3348f8e569b..b8a52740832 100644
--- a/midx.c
+++ b/midx.c
@@ -1293,15 +1293,26 @@ static int compare_by_mtime(const void *a_, const void *b_)
 	return 0;
 }
 
-static int fill_included_packs_all(struct multi_pack_index *m,
+static int fill_included_packs_all(struct repository *r,
+				   struct multi_pack_index *m,
 				   unsigned char *include_pack)
 {
-	uint32_t i;
+	uint32_t i, count = 0;
+	int pack_kept_objects = 0;
+
+	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (prepare_midx_pack(r, m, i))
+			continue;
+		if (!pack_kept_objects && m->packs[i]->pack_keep)
+			continue;
 
-	for (i = 0; i < m->num_packs; i++)
 		include_pack[i] = 1;
+		count++;
+	}
 
-	return m->num_packs < 2;
+	return count < 2;
 }
 
 static int fill_included_packs_batch(struct repository *r,
@@ -1312,6 +1323,9 @@ static int fill_included_packs_batch(struct repository *r,
 	uint32_t i, packs_to_repack;
 	size_t total_size;
 	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
+	int pack_kept_objects = 0;
+
+	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
 		pack_info[i].pack_int_id = i;
@@ -1338,6 +1352,8 @@ static int fill_included_packs_batch(struct repository *r,
 
 		if (!p)
 			continue;
+		if (!pack_kept_objects && p->pack_keep)
+			continue;
 		if (open_pack_index(p) || !p->num_objects)
 			continue;
 
@@ -1380,7 +1396,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	if (batch_size) {
 		if (fill_included_packs_batch(r, m, include_pack, batch_size))
 			goto cleanup;
-	} else if (fill_included_packs_all(m, include_pack))
+	} else if (fill_included_packs_all(r, m, include_pack))
 		goto cleanup;
 
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 030a7222b2a..67afe1bb8d9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -538,6 +538,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 	)
 '
 
+test_expect_success 'repack respects repack.packKeptObjects=false' '
+	test_when_finished rm -f dup/.git/objects/pack/*keep &&
+	(
+		cd dup &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		ls .git/objects/pack/*.pack | sed "s/\.pack/.keep/" >keep-list &&
+		for keep in $(cat keep-list)
+		do
+			touch $keep || return 1
+		done &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 5 midx-list &&
+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
+		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
+		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 5 midx-list
+	)
+'
+
 test_expect_success 'repack creates a new pack' '
 	(
 		cd dup &&
-- 
gitgitgadget
