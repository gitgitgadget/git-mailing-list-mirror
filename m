Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AACC54E4B
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3F2080C
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTAixRLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgEJQHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:07:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296FC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so7823998wrt.9
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BkNVlqrcMQOdDBxOOa2+sJ7tkIqvaDD9KCbiNFKfzNE=;
        b=BTAixRLMXN4wxL3BO7x72yIpmiiPdlRmtRfs6l+JzAqV9YrQSUqidjbh26WzFkzJjh
         I+YO3zAReOSxF+T48xjiaeWKLurQqmzU1hn+gj0P0dOZACy/y/muhRBuhVnMJp8pFmoV
         iX4RC1msWRsqFokS/mnWhVgqZ4Zhvfc0mvssx44XSCauBmsF+04Hx4hp0nebRAPUBS2v
         GUxLybirxbi1ryUHhYSBT6G1KV9FaLe5P15b1iBNSBbKU5GWsai4NVwTLUFWIPDCPX7d
         XHs9hFLaohxKvGyxuhnoFmQcwYg9dgslJJyJBrmJI6ALGDWu3AsEAxnpdNZYRcWVdckc
         PmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BkNVlqrcMQOdDBxOOa2+sJ7tkIqvaDD9KCbiNFKfzNE=;
        b=lD3dQaspjMyeyZZkIR8qE8JFn4SS/D4JHNbYtEyHwt6AlKCgIHy/kKRzOReTB8RWyK
         9phot9xdUVkZeHSrqwEOvTFaU5e5pZ5MmbrpQ1RkpxfdRjVsRBoq7yqQ3rQXcbxWowC6
         F0UOzQSEZRj7arSzpSgWo3DM3zTU49NBJ/k9x8UM/APf1l7g8tnsWQ8k4M66d9UZtjOB
         OZWAK7OnAMUUaxSFTFLCyR/K56uyDKEV7aar/juTKs4ewdz3+FSyYfH+rYEufIbZrTzg
         T2UvweK9TZVEAyFecjLEnu7GVGBRGe33SXDqqtnGSDUBxbvezF6dPrsmz8LhXAzY5m4L
         NQDg==
X-Gm-Message-State: AGi0PubF0nNxQ8DX+cesaajs+SgNak1nbyX8VS5+OiifpS3DJBWMnZca
        ArMxoHdOZfqmQttNuEnd239qgLbg
X-Google-Smtp-Source: APiQypKndunGczO4a9Lwb4inPvn9/jZwQ2yFqXT/qEF/Z9RIvWmH8kcoXq0bbSp8LrUFFhjycAkCDg==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr14319618wrm.106.1589126857744;
        Sun, 10 May 2020 09:07:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 77sm13925708wrc.6.2020.05.10.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:07:37 -0700 (PDT)
Message-Id: <192fc7853825013250552eda75957a290a9928eb.1589126855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v4.git.1589126855.gitgitgadget@gmail.com>
References: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
        <pull.626.v4.git.1589126855.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 May 2020 16:07:34 +0000
Subject: [PATCH v4 2/2] multi-pack-index: respect repack.packKeptObjects=false
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
 midx.c                                 | 26 ++++++++++++++++++++-----
 t/t5319-multi-pack-index.sh            | 27 ++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 5 deletions(-)

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
index d2a43bd1a38..6d1584ca51d 100644
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
 
@@ -1386,7 +1402,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	if (batch_size) {
 		if (fill_included_packs_batch(r, m, include_pack, batch_size))
 			goto cleanup;
-	} else if (fill_included_packs_all(m, include_pack))
+	} else if (fill_included_packs_all(r, m, include_pack))
 		goto cleanup;
 
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 030a7222b2a..7214cab36c0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -538,6 +538,33 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 	)
 '
 
+test_expect_success 'repack respects repack.packKeptObjects=false' '
+	test_when_finished rm -f dup/.git/objects/pack/*keep &&
+	(
+		cd dup &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		ls .git/objects/pack/*.pack | sed "s/\.pack/.keep/" >keep-list &&
+		test_line_count = 5 keep-list &&
+		for keep in $(cat keep-list)
+		do
+			touch $keep || return 1
+		done &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 5 midx-list &&
+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | sed -n 3p) &&
+		BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&
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
