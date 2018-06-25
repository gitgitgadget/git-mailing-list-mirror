Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67B61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934499AbeFYOfd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34507 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934489AbeFYOfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id b20-v6so2883353qtp.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Ttcc0eCITq6GjLSD7GdLz81Iwe9ofNoD/RveixQSlU=;
        b=fZO8Jr4XKNFgluj9Dj69Rb68YOSFSd5zIvgb/STOWJ/zo/2eWzWnbrNegxiK1T+Z3R
         sxxDeEjbPuiak7Wj4Lcv3M3LLCiQfU1oDYIoYBm0X4KtNLYeD8fWeYRNSs+ybGhPYGL/
         4iqeGO/RN+aHMKbVegHP63oVY9Da5rsKI/QpsrpSmCCTqCijMaOfC0DZSPu8JnGfhPvz
         3olg2740WCdpZaUglOgavTK/1NcNl8rwGwTzhhFGVXXLmoZMskwsiqrIBdrxO/20u/e8
         iwDMXco2ziWJ13wvO1oBU3IFPqPTLy0gnfKUXme0Bbbc9vR9GjZJk71I083fpLGqRp+s
         q6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Ttcc0eCITq6GjLSD7GdLz81Iwe9ofNoD/RveixQSlU=;
        b=pna7zMPJ657gVvxCwsoF8fnRYLiHTVBx6zN0iQ3oz+1V4gYOBKu4NY88/QURWdJtga
         TPna2YMhsiYWWRZFXdSWs+ZANdMAzAyRBMzYCnb8ZSK7iOAh4deCHq20A5dgfONzUTEQ
         BYCQl08UMBVfT3ElH4y1iKNhApsKAIE9Kr1ubedxEAjsfxZXAJu1P0TIKXItnlNWfXYK
         60n0gLhH4azeUEZjeq3MBnGFkmzowgT2inFV2pNubXmHJBFAQr9oqaBdqJP0TtsyR5v3
         0XkmNv0hw1gzuIQrcnfuBDtE83dbEDC4FuhFhlHnY4UrrijdKIb0kA24/wfnP1hjC/eX
         WCzw==
X-Gm-Message-State: APt69E0x2Dck6tuOuEhzpIFcj5Ds99j+QKWk7vMIHo45C9pDqnARxGpd
        /rA7EK1D1KxGywssx/GqO/JPI5fY
X-Google-Smtp-Source: ADUXVKL+6IFKgqHfEzbVbHs1L2pZ5kP4xc3fyEzEcYNJmWjyN9g3IEJ1WwdNUiwukA0gjDV2s9mAuQ==
X-Received: by 2002:ac8:e46:: with SMTP id j6-v6mr10933929qti.419.1529937329514;
        Mon, 25 Jun 2018 07:35:29 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:28 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 18/24] midx: read objects from multi-pack-index
Date:   Mon, 25 Jun 2018 10:34:28 -0400
Message-Id: <20180625143434.89044-19-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++++++--
 midx.h         |  2 ++
 object-store.h |  1 +
 packfile.c     |  8 ++++-
 4 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 3dd5027dc6..14514d6828 100644
--- a/midx.c
+++ b/midx.c
@@ -4,7 +4,7 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-store.h"
-#include "packfile.h"
+#include "sha1-lookup.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
@@ -150,7 +150,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
-	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
+	m->packs = xcalloc(m->num_packs, sizeof(*m->packs));
+	ALLOC_ARRAY(m->pack_names, m->num_packs);
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
 	for (i = 0; i < m->num_packs; i++) {
@@ -176,6 +177,94 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
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
index 731ad6f094..6b74a0640f 100644
--- a/midx.h
+++ b/midx.h
@@ -6,6 +6,8 @@
 struct multi_pack_index;
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
diff --git a/object-store.h b/object-store.h
index 7d67ad7aa9..03cc278758 100644
--- a/object-store.h
+++ b/object-store.h
@@ -106,6 +106,7 @@ struct multi_pack_index {
 	const unsigned char *chunk_large_offsets;
 
 	const char **pack_names;
+	struct packed_git **packs;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/packfile.c b/packfile.c
index ff2df22a0b..946d0c241f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1904,11 +1904,17 @@ static int fill_pack_entry(const struct object_id *oid,
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
2.18.0.24.g1b579a2ee9

