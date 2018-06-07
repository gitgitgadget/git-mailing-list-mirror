Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11D31F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbeFGOEj (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:39 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43382 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeFGOEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id y89-v6so9923383qtd.10
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2o3RrPX9psSmScwYx0A+DhEU1dfG5U7JK8NcUjQWHo=;
        b=NS4vEdMJa4r2jxZesmxd69CIkad3STWYFwRRaoL8DRWMvMAcIbl8vSSn7vHPTPXgDi
         QAJKkGFhS6y2Or/IXiFeZ1au3vX0+kDwvOCNKsuejIGE557F44OXB0ceWU1uukZzWY9E
         VPLvBYvYXFZIOgjivNbqccp2JAY8m/fvvyh14SBadQV0U+vfSWFbi0kaRp0RM8L6L58L
         DGeCQP8A0vNq3wXYzsPcxoBUshMcOE1DVlqyDZ5Y61zCAE/SGQPEd9asMDW8fS7VyCMO
         zn53SJBvxQX8+I8R259ugdJdSepGOcpi9ENb3qcmXTkYrRPwDbln3tLXCyOTIKm180MY
         EsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2o3RrPX9psSmScwYx0A+DhEU1dfG5U7JK8NcUjQWHo=;
        b=U30fFS5a0e66kFyg+XcMg41Aw+oSHzbNUHnLDgHj8wkCLXyMdQfswutTrdPWRTe2sp
         aZvOVVCdRzqCmVecZdOK4a+bazW+Mn4cC3rOa4nQ542P3iVvvoICkPn3+FE7cMqXKMEe
         hAVYVwJ62rks4WykZvvLe/foNoafKkhAzHkho8hfmyhzbFhQlwhgbH2Rbb9xfDvrGwOH
         W8ZzeHwoa7Okq2Wiq+ehM/mFmHu5fMhMjKVNbJDEtR/s5KAhHfgPv4Wgd97xL0fTnGcV
         qMRjabVk82l3Az9hIhe3vzRw1NitCd6kQraODEGCx5YGRQAv5aDdktXHyGrUz72Ru11p
         2NBQ==
X-Gm-Message-State: APt69E1GyP4o3mIvA454A7TTtU6BPSu3PxIa6izshtbhhBJYAhG0cpqv
        dI3aeipbzPwKhdaxxKGKZKfhB9uO
X-Google-Smtp-Source: ADUXVKKAYttk2OjWFZ9fLVEaxzcvaTrgvUhZMvmf5hG8WKGPm29ymgEx29uFEIztvLXLTqvgtTg2IA==
X-Received: by 2002:a0c:e946:: with SMTP id n6-v6mr1755611qvo.196.1528380243505;
        Thu, 07 Jun 2018 07:04:03 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:02 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 17/23] midx: read objects from multi-pack-index
Date:   Thu,  7 Jun 2018 10:03:32 -0400
Message-Id: <20180607140338.32440-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
 midx.h         |  2 ++
 object-store.h |  1 +
 packfile.c     |  8 ++++-
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 5e9290ca8f..6eca8f1b12 100644
--- a/midx.c
+++ b/midx.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "csum-file.h"
 #include "lockfile.h"
+#include "sha1-lookup.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "midx.h"
@@ -64,7 +65,7 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 
 	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
 	strcpy(m->object_dir, object_dir);
-	m->data = midx_map;
+	m->data = (const unsigned char*)midx_map;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE) {
@@ -145,7 +146,9 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
-	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
+	m->packs = xcalloc(m->num_packs, sizeof(*m->packs));
+
+	ALLOC_ARRAY(m->pack_names, m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (i) {
 			if (ntohl(m->chunk_pack_lookup[i]) <= ntohl(m->chunk_pack_lookup[i - 1])) {
@@ -175,6 +178,95 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 	exit(1);
 }
 
+static int prepare_midx_pack(struct midxed_git *m, uint32_t pack_int_id)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+
+	if (pack_int_id >= m->num_packs)
+		BUG("bad pack-int-id");
+
+	if (m->packs[pack_int_id])
+		return 0;
+
+	strbuf_addstr(&pack_name, m->object_dir);
+	strbuf_addstr(&pack_name, "/pack/");
+	strbuf_addstr(&pack_name, m->pack_names[pack_int_id]);
+
+	m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, 1);
+	strbuf_release(&pack_name);
+	return !m->packs[pack_int_id];
+}
+
+int bsearch_midx(const struct object_id *oid, struct midxed_git *m, uint32_t *result)
+{
+	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
+			    MIDX_HASH_LEN, result);
+}
+
+static off_t nth_midxed_offset(struct midxed_git *m, uint32_t pos)
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
+static uint32_t nth_midxed_pack_int_id(struct midxed_git *m, uint32_t pos)
+{
+	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
+}
+
+static int nth_midxed_pack_entry(struct midxed_git *m, struct pack_entry *e, uint32_t pos)
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
+int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct midxed_git *m)
+{
+	uint32_t pos;
+
+	if (!bsearch_midx(oid, m, &pos))
+		return 0;
+
+	return nth_midxed_pack_entry(m, e, pos);
+}
+
 int prepare_midxed_git_one(struct repository *r, const char *object_dir)
 {
 	struct midxed_git *m = r->objects->midxed_git;
diff --git a/midx.h b/midx.h
index 793203fc4a..0c66812229 100644
--- a/midx.h
+++ b/midx.h
@@ -8,6 +8,8 @@
 #include "repository.h"
 
 struct midxed_git *load_midxed_git(const char *object_dir);
+int bsearch_midx(const struct object_id *oid, struct midxed_git *m, uint32_t *result);
+int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct midxed_git *m);
 int prepare_midxed_git_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
diff --git a/object-store.h b/object-store.h
index 7908d46e34..5af2a852bc 100644
--- a/object-store.h
+++ b/object-store.h
@@ -108,6 +108,7 @@ struct midxed_git {
 	const unsigned char *chunk_large_offsets;
 
 	const char **pack_names;
+	struct packed_git **packs;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/packfile.c b/packfile.c
index b91ca9b9f5..73f8cc28ee 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1857,11 +1857,17 @@ static int fill_pack_entry(const struct object_id *oid,
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
+	struct midxed_git *m;
 
 	prepare_packed_git(r);
-	if (!r->objects->packed_git)
+	if (!r->objects->packed_git && !r->objects->midxed_git)
 		return 0;
 
+	for (m = r->objects->midxed_git; m; m = m->next) {
+		if (fill_midx_entry(oid, e, m))
+			return 1;
+	}
+
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(oid, e, p)) {
-- 
2.18.0.rc1

