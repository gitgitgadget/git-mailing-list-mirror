Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AAAC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8221421473
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj8X+wAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEIOYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgEIOYf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 10:24:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2AEC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 07:24:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so5262783wrx.10
        for <git@vger.kernel.org>; Sat, 09 May 2020 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vLwvwwzpb9qwVxE1q2cc0nMLfRc6MQAm7yWUIDNBSuw=;
        b=rj8X+wAxgsImHb5+lRliA4IVlW4I0YHA9Ou4uvR0k4R8dZSVwKGdz39cfGcTfwUoCK
         /FmzZ4O+ZT4n5c/QB9BB19Wro9/OHElL4W1L8ieVDlIc5m02NxljiH4Q4dGNJShpZJxk
         NiiKGNe9wWyaYdNTP7Nb3TXl6DYKC68Jtai8+cUd9bb884zy54cPXeoUz+wJ4+/pQI7F
         Y+tnu4117UXK4nG80V4qztI6oph6UdbYhCCWu45vzpERLc47PWQS8ZxbxUqrXaAEuFpU
         8ZmkkulzdViNbgsVyJJcN3pn+o0R8LmKC8tQvjqU/kmQsno634+WxdgbDh6ez2E/HhBE
         89SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vLwvwwzpb9qwVxE1q2cc0nMLfRc6MQAm7yWUIDNBSuw=;
        b=aqlAdUYCYkAsD9G4rGoIQj4PIJ7wji4h1TwgOLfbCJ5gF/LmAYIwLQ615iGWJcUpod
         bBr5KugKJm10Uy+H/Wo6j3+fUDCJo4cflg1aN8k8FS291E0R7RNRLh7Y/Rp+PUH7eNDv
         qGwuUTjkA6IaicCBXJ+rSfXKDZa6CH4BaeOgVr2ECPkWUUrhfJMWEiADDdk23BUgcAk1
         6Ad4EzfOMM6j07/maAMHSv/xNnAkyG7Ty/mciP+bk+OGgEvqzzU3zc+zVwbLe/PqJ5Sz
         rwpEw95MdkUaZpqZ9+QhwNeIem8g+TWu9nYm6Xsl8yUvY29U3HoDch8K/NrnNaoPBNLs
         ki5g==
X-Gm-Message-State: AGi0PuZu7tmdNrAs/e02e3to4bQOAUZvAn3gD3GPzo7vE6lS5GsRBky0
        f/CjCsfnJxhqaA09jADS4J8AGmsX
X-Google-Smtp-Source: APiQypIKA0kJbpaNlZz5HZy3jblBZbR6Ve6tOCioazSBUOJhOfOAjj0WcG1dXuhjKpHIE1qNdJr0wg==
X-Received: by 2002:adf:9d91:: with SMTP id p17mr2441137wre.119.1589034273043;
        Sat, 09 May 2020 07:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm17509137wmc.7.2020.05.09.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 07:24:32 -0700 (PDT)
Message-Id: <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 14:24:29 +0000
Subject: [PATCH v3 2/3] multi-pack-index: respect repack.packKeptObjects=false
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
index 1e76be56826..9b14d915db1 100644
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

