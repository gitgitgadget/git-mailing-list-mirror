Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C23B1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGLTvh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:37 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46977 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:37 -0400
Received: by mail-qt0-f176.google.com with SMTP id d4-v6so9667907qtn.13
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OetCFEXdbt3h+IZQMumQTB6C7nRHnAoblikShb+Toik=;
        b=WugLpMe17HuWToBzyrFM0Z1sGowwdEuLty5klkwN3bYilo91Htg6pZGpvdfyqeuyfT
         wGw3wuLypv4liaW3YjRgktP9Cd+Ij/hBK0bi9G1BHqs/xS5dqApx/7+JG2axW/GGcQrV
         Q72B8sdxFF5OZvDCjHPMNwHi24vOInXy7h06cH4EAonFkVOu0+MjTTY+wrJtavMP1xeG
         UA4m7VQ8R0yZ5ZUschHzVSJWN/VW4uW8zh0Tq7saaDmnx5yPdFRIsBaJrbPUrrzaZJ8z
         LCyCbQdaHdxuTbIYj4pZxXhRZLa+h+GtwItihDDx/LdE5tBouGW8wYh9GkAD812dec4Q
         RO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OetCFEXdbt3h+IZQMumQTB6C7nRHnAoblikShb+Toik=;
        b=gBW5AdFyLIpHpFl9N62TFDGkNtxZE8/84SDwQ5VTnji3ViBorHDEIUyCwgnejXLTMo
         BP4Dh7y013/qbKdqakPaZ6jSzgF9XAZPvQr33R4CttNO2kzAWaI4fhwIWQ3Q36k1QeNn
         DGMQBb872uAkILdiX4sGkkmC6uoi4UVHa6Uwo3iR6mjDC8/nSqs5BpImSd3ynx9MvDCF
         Xh7CqFZ8dOdbVW6ZYId7HdJ8EGCRhT4dkNhD1Pdp2gzx4KjdE4UvMjRd83YshqeGgqEQ
         mhZ80UjmjdoLMLMzN4uFOYJ7ee7rQnKnFCATNAGzWRlIBfCp3NVramLmFdtH3KpHjuAH
         zJGA==
X-Gm-Message-State: AOUpUlFf36yiCh1+99oGU69TetmJIGI3CBusOS+rldtq7mAZnH7hwIAU
        5GE9iny8GI7iGLkrl3TWFTfCabZStyQ=
X-Google-Smtp-Source: AAOMgpfPhhZ4L5bDGsMrkaebV19TPABfjfMBo7ecbVZeeUEOoe6k6lKAMfbB0G+TpWl5zyqlpo5bcA==
X-Received: by 2002:aed:2457:: with SMTP id s23-v6mr3181211qtc.366.1531424436548;
        Thu, 12 Jul 2018 12:40:36 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:36 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 17/23] midx: read objects from multi-pack-index
Date:   Thu, 12 Jul 2018 15:39:34 -0400
Message-Id: <20180712193940.21065-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 midx.h     |  3 ++
 packfile.c |  8 ++++-
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 4090cf4ca4..182535933c 100644
--- a/midx.c
+++ b/midx.c
@@ -5,7 +5,7 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-store.h"
-#include "packfile.h"
+#include "sha1-lookup.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
@@ -151,6 +151,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
+	m->packs = xcalloc(m->num_packs, sizeof(*m->packs));
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
 	for (i = 0; i < m->num_packs; i++) {
@@ -178,6 +179,94 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return NULL;
 }
 
+static int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+
+	if (pack_int_id >= m->num_packs)
+		BUG("bad pack-int-id");
+
+	if (m->packs[pack_int_id])
+		return 0;
+
+	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
+		    m->pack_names[pack_int_id]);
+
+	m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, 1);
+	strbuf_release(&pack_name);
+	return !m->packs[pack_int_id];
+}
+
+int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
+{
+	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
+			    MIDX_HASH_LEN, result);
+}
+
+static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
+{
+	const unsigned char *offset_data;
+	uint32_t offset32;
+
+	offset_data = m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH;
+	offset32 = get_be32(offset_data + sizeof(uint32_t));
+
+	if (m->chunk_large_offsets && offset32 & MIDX_LARGE_OFFSET_NEEDED) {
+		if (sizeof(offset32) < sizeof(uint64_t))
+			die(_("multi-pack-index stores a 64-bit offset, but off_t is too small"));
+
+		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
+		return get_be64(m->chunk_large_offsets + sizeof(uint64_t) * offset32);
+	}
+
+	return offset32;
+}
+
+static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
+{
+	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
+}
+
+static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *e, uint32_t pos)
+{
+	uint32_t pack_int_id;
+	struct packed_git *p;
+
+	if (pos >= m->num_objects)
+		return 0;
+
+	pack_int_id = nth_midxed_pack_int_id(m, pos);
+
+	if (prepare_midx_pack(m, pack_int_id))
+		die(_("error preparing packfile from multi-pack-index"));
+	p = m->packs[pack_int_id];
+
+	/*
+	* We are about to tell the caller where they can locate the
+	* requested object.  We better make sure the packfile is
+	* still here and can be accessed before supplying that
+	* answer, as it may have been deleted since the MIDX was
+	* loaded!
+	*/
+	if (!is_pack_valid(p))
+		return 0;
+
+	e->offset = nth_midxed_offset(m, pos);
+	e->p = p;
+
+	return 1;
+}
+
+int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m)
+{
+	uint32_t pos;
+
+	if (!bsearch_midx(oid, m, &pos))
+		return 0;
+
+	return nth_midxed_pack_entry(m, e, pos);
+}
+
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
 {
 	struct multi_pack_index *m = r->objects->multi_pack_index;
diff --git a/midx.h b/midx.h
index 9bcfc82d2e..377838c9ca 100644
--- a/midx.h
+++ b/midx.h
@@ -25,10 +25,13 @@ struct multi_pack_index {
 	const unsigned char *chunk_large_offsets;
 
 	const char **pack_names;
+	struct packed_git **packs;
 	char object_dir[FLEX_ARRAY];
 };
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
diff --git a/packfile.c b/packfile.c
index 5d4493dbf4..bc763d91b9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1902,11 +1902,17 @@ static int fill_pack_entry(const struct object_id *oid,
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
+	struct multi_pack_index *m;
 
 	prepare_packed_git(r);
-	if (!r->objects->packed_git)
+	if (!r->objects->packed_git && !r->objects->multi_pack_index)
 		return 0;
 
+	for (m = r->objects->multi_pack_index; m; m = m->next) {
+		if (fill_midx_entry(oid, e, m))
+			return 1;
+	}
+
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(oid, e, p)) {
-- 
2.18.0.118.gd4f65b8d14

