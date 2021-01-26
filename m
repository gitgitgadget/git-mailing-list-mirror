Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26899C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A5B2220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbhAZQDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404565AbhAZQCr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA818C0698C8
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 6so17019745wri.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/9WZzc0JHsPutkXhtZtPjDnbj9w/mbrhFV+hIT7xcoo=;
        b=ag7Tu7N9BbF12VoAVBwg4a70HIqr++6HdKATakL1dTwD4inrXcn0voC2iwBplRyx7d
         jEWCvdq2LxTF95ww7UZg3E/wkxjo9f9L3xB/P5X6tNKX3LfwfJXIo0DkrPOadgrQ0NNX
         08307OfLAgINRXcLLkl7rngz96ZatmDbIxzHzw1p0RZV+LFkl+7kjAdGr3AS9hQWljMl
         4Ab1sCwpU+wlRs1IjTr/zOCaoywgevoib1tDEpVwCUcIkh1Mn62FLfnXIYhHLniPOBH5
         seCJUWt9NGUBzKdO6/C0gkAGBEVbx+WQ84QV1JTqQZeEvu6hn4IPf8/6RRHAf44ucoIC
         ZSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/9WZzc0JHsPutkXhtZtPjDnbj9w/mbrhFV+hIT7xcoo=;
        b=VD4Kotn+pJUEHbByvXkH/hNdkAgjmMnGGS5MgzlYpTsjxTs4gsWtUWH7DXzg5HlhD8
         kAJerLR4GWo5oor46J++Ym8Q8lx6LSd8+PeCPOE3wg+ks0a3mdHrW80fvAm3WtBZeft1
         dVtG2jMEv17B1YFjA9kjNE4ZoN61w+9OxGNhxFNaJe6JYlvkfZpxt9V0LfEUEOVF25A7
         7bCUKCZwD6P3gl8uiz4DNwbdwrXJsVs7fLLZxkmqbU2gUhOCaJAcwLsN/5oFzV+bGIz2
         yFurnJXb0ovStmY+sEq1jb78vYFWH1QUj+Tj0nuOUiWXvYQ9VVHAE/iPiWkoKYOOduTY
         7bCg==
X-Gm-Message-State: AOAM532rDExvsTL/4pcPBhD7jBo4XThZWKqlizAuSpElZYzz6385HmZz
        +E0Hskwdb9MdBttXPBoyE9Cf+rFqQV8=
X-Google-Smtp-Source: ABdhPJxkm542g4izd0kPYWYLVMJDquNT4CphCXnN17T3hiYdC2z79E/yLghSlauppyTuAYBhXOtlhw==
X-Received: by 2002:adf:f512:: with SMTP id q18mr6831963wro.55.1611676901422;
        Tue, 26 Jan 2021 08:01:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm3735818wme.37.2021.01.26.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:40 -0800 (PST)
Message-Id: <cb145e0e32afed99b9bfa822c76f48bee18885ba.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:23 +0000
Subject: [PATCH 14/17] midx: use chunk-format read API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Instead of parsing the table of contents directly, use the chunk-format
API methods read_table_of_contents() and pair_chunk(). In particular, we
can use the return value of pair_chunk() to generate an error when a
required chunk is missing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 103 ++++++++++++++++++++----------------
 t/t5319-multi-pack-index.sh |   6 +--
 2 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/midx.c b/midx.c
index 0bfd2d802b6..dd019c00795 100644
--- a/midx.c
+++ b/midx.c
@@ -54,6 +54,51 @@ static char *get_midx_filename(const char *object_dir)
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+static int midx_read_pack_names(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_pack_names = chunk_start;
+	return 0;
+}
+
+static int midx_read_oid_fanout(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_oid_fanout = (uint32_t *)chunk_start;
+
+	if (chunk_size != 4 * 256) {
+		error(_("multi-pack-index OID fanout is of the wrong size"));
+		return 1;
+	}
+	return 0;
+}
+
+static int midx_read_oid_lookup(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_oid_lookup = chunk_start;
+	return 0;
+}
+
+static int midx_read_offsets(const unsigned char *chunk_start,
+			     size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_object_offsets = chunk_start;
+	return 0;
+}
+
+static int midx_read_large_offsets(const unsigned char *chunk_start,
+				   size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = (struct multi_pack_index *)data;
+	m->chunk_large_offsets = chunk_start;
+	return 0;
+}
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -65,6 +110,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
 	const char *cur_pack_name;
+	struct chunkfile *cf = NULL;
 
 	fd = git_open(midx_name);
 
@@ -114,58 +160,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
 
-	for (i = 0; i < m->num_chunks; i++) {
-		uint32_t chunk_id = get_be32(m->data + MIDX_HEADER_SIZE +
-					     MIDX_CHUNKLOOKUP_WIDTH * i);
-		uint64_t chunk_offset = get_be64(m->data + MIDX_HEADER_SIZE + 4 +
-						 MIDX_CHUNKLOOKUP_WIDTH * i);
-
-		if (chunk_offset >= m->data_len)
-			die(_("invalid chunk offset (too large)"));
-
-		switch (chunk_id) {
-			case MIDX_CHUNKID_PACKNAMES:
-				m->chunk_pack_names = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OIDFANOUT:
-				m->chunk_oid_fanout = (uint32_t *)(m->data + chunk_offset);
-				break;
-
-			case MIDX_CHUNKID_OIDLOOKUP:
-				m->chunk_oid_lookup = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_OBJECTOFFSETS:
-				m->chunk_object_offsets = m->data + chunk_offset;
-				break;
-
-			case MIDX_CHUNKID_LARGEOFFSETS:
-				m->chunk_large_offsets = m->data + chunk_offset;
-				break;
-
-			case 0:
-				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
-				break;
-
-			default:
-				/*
-				 * Do nothing on unrecognized chunks, allowing future
-				 * extensions to add optional chunks.
-				 */
-				break;
-		}
-	}
+	cf = init_chunkfile(NULL);
 
-	if (!m->chunk_pack_names)
+	if (read_table_of_contents(cf, m->data, midx_size,
+				   MIDX_HEADER_SIZE, m->num_chunks))
+		goto cleanup_fail;
+
+	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, midx_read_pack_names, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required pack-name chunk"));
-	if (!m->chunk_oid_fanout)
+	if (pair_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID fanout chunk"));
-	if (!m->chunk_oid_lookup)
+	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID lookup chunk"));
-	if (!m->chunk_object_offsets)
+	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_offsets, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required object offsets chunk"));
 
+	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, midx_read_large_offsets, m);
+
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a94..ad4e878b65b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -314,12 +314,12 @@ test_expect_success 'verify bad OID version' '
 
 test_expect_success 'verify truncated chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\01" $objdir \
-		"missing required"
+		"final chunk has non-zero id"
 '
 
 test_expect_success 'verify extended chunk count' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\07" $objdir \
-		"terminating multi-pack-index chunk id appears earlier than expected"
+		"terminating chunk id appears earlier than expected"
 '
 
 test_expect_success 'verify missing required chunk' '
@@ -329,7 +329,7 @@ test_expect_success 'verify missing required chunk' '
 
 test_expect_success 'verify invalid chunk offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_OFFSET "\01" $objdir \
-		"invalid chunk offset (too large)"
+		"improper chunk offset(s)"
 '
 
 test_expect_success 'verify packnames out of order' '
-- 
gitgitgadget

