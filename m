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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EEC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70D764F9E
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhBEWHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhBEOwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431EC0611C3
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:29:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 190so6510567wmz.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZrt/9Ddj4gx/b89hC5HBX3Cwr8bZTYyGFdAEwA+J8c=;
        b=ZBPorRCzy/rHnwUcZP8M4VMnyOUQ8UjluKfz0C27J7Ho74MnwXvs0hQZRZaKBKU7SZ
         IzSeV3lcmTi/QrlOMij2pIyWz8hAuLh9mfoCtg861D7xu+hqUcOxhr07vd6mH7jMZM4F
         MNfYUOQCxQ0c/pCsfxV3KeN3XWR5eGkrBAEyvB0ACNtseBUT3h+pdzGuSw4yXzXAJ8Zn
         oJRCN7Ert/Q6e/0j2sZKQZ3XW2Ivncd3NnIJ9SB4CFnADulZaSZhGAPgNDiqMQd/Gmp+
         wab+a2c+L3a+IlE4KwZXd9gZmv4rk5oCuSsSGtMKVdVG/YdaLHxqujrhthlWBB2VfGqj
         RxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZrt/9Ddj4gx/b89hC5HBX3Cwr8bZTYyGFdAEwA+J8c=;
        b=B8Q6qhq58HVJTAqEeawb8HgnlALvil/mnED9ZKaHqhu2QqC+VgxF6KjqWDsuZis1BQ
         qPlihaWwg0Z4DALF9EKFO3sJrd3VpHPhCTtu55XLEIC6UpMG+VUSco48uqiBYegXaUDC
         Kncmm+1dm4/iOdWXyWFC4w6CvTea6K6vsXy28La8CEpQsDGTa3cjEML3G/OcHQI45jOw
         H7FKQ3WY0iMxyFTU2OWYvAdaNOJ8j6A/hfzUQgqWB3beCAjVodCwAPinZE/zRa5djl4H
         Y7w6SS+KXQrgliyd2ATB3ncyQaK4ohg4mHgMuNCjmG+1/aZzZE2yorB30nqstInn7lO+
         V5UA==
X-Gm-Message-State: AOAM5330szVYa0emal2xzbWsD/8EBQzV3+QBbRZdV4kI1QF6h13OZrYK
        cNteeuVyv7b6mOHYlSr9OuhHpvAtU1s=
X-Google-Smtp-Source: ABdhPJzma14EFStLzGzTGttDB/vdLFylxt1qlFU+IVtRi5CBkDKAbRrF8Pe/BJO2zhuuiqEduR09eA==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr3796200wmj.57.1612535468915;
        Fri, 05 Feb 2021 06:31:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm9045545wmd.11.2021.02.05.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:08 -0800 (PST)
Message-Id: <6bddd9e63b9b41d196db1bb74c60ad66566f66c7.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:49 +0000
Subject: [PATCH v3 14/17] midx: use chunk-format read API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 midx.c                      | 72 ++++++++++++++-----------------------
 t/t5319-multi-pack-index.sh |  6 ++--
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/midx.c b/midx.c
index d9c7411b083b..aee9ed832d52 100644
--- a/midx.c
+++ b/midx.c
@@ -54,6 +54,19 @@ static char *get_midx_filename(const char *object_dir)
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+static int midx_read_oid_fanout(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = data;
+	m->chunk_oid_fanout = (uint32_t *)chunk_start;
+
+	if (chunk_size != 4 * 256) {
+		error(_("multi-pack-index OID fanout is of the wrong size"));
+		return 1;
+	}
+	return 0;
+}
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -65,6 +78,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
 	const char *cur_pack_name;
+	struct chunkfile *cf = NULL;
 
 	fd = git_open(midx_name);
 
@@ -114,58 +128,23 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
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
+	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required pack-name chunk"));
-	if (!m->chunk_oid_fanout)
+	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID fanout chunk"));
-	if (!m->chunk_oid_lookup)
+	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID lookup chunk"));
-	if (!m->chunk_object_offsets)
+	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required object offsets chunk"));
 
+	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
+
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
@@ -191,6 +170,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 cleanup_fail:
 	free(m);
 	free(midx_name);
+	free(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
 	if (0 <= fd)
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a94f..ad4e878b65b8 100755
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

