Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADFC43333
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F304464F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhCLUUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhCLUUI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65DC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k8so2453657wrc.3
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6qiZPnWQjZSu2CtM+Oqw9Z4FxbOgSgiVRdpm4esM8vY=;
        b=r9ADrq7yHB1t+zLmUYxZ8+yfLCxVzckV6ecPYof32nw/ilPCJtpmNzNMDF0Y3ygk1q
         7Ro6bkjWIRzj/Bi5vgs13HgTBsUp0GGZv45zN8xCo7csTQe1Hhs6Ra+lN8HURO3EPZ+V
         QuI6z76VgjRjeupygOPyGc4nLcbrbwlWaszvrixfcbHtfyixe5Xn2yFmi5oekIwZ4FyO
         L3X30lZqwu29mX+4Pc0wMybHFEGrDzsmNqZ3m0+SpUZCs5bp2jritvgaRejNf37A+BIB
         gniK47Tbt05ZgROlS0Qd5sYIQ2lBG4uZEOzOEHcGSud51QMz402bUKRBy1LOgj5dxKUJ
         FC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6qiZPnWQjZSu2CtM+Oqw9Z4FxbOgSgiVRdpm4esM8vY=;
        b=CdjSV/nRAdeukGRRT+48dmn2IYBzgRbZP9ZCPQDSf9kWCxQo7tw4rfJ4Zh5H86aBvT
         MxYWzOtuJeqA4je/n1CuMZO5gNM5j6Oy9GUYHhB6jy00mONm+tb4jFVjWJk8wOexZfWV
         OjbvNBPaNNcVyuW1q59ml06imFEe1MD88JtzCbQKSg34YMooSEhryUWZB3KHn+tXCkKR
         +VNFlOuMKYvCJMGaAlz53DM4+VqM0UKyMjPsvcOJTfH4EuPI+9wowKTPLG5/2et1o1zv
         hb00/V3EhGmc59Rk9Es0KVIS+/yCeFEiiUEIonzsvxorNdbHEw7pogqEuA9sq+jwlUZg
         qlHw==
X-Gm-Message-State: AOAM533YyT719BBlC7u9KyhpRRuIvNyg3BTB8DHSzfsMZuVeJuGy2GLx
        WwEq6MaMWJOiv+Bvp3KSWS72YAx6pCs=
X-Google-Smtp-Source: ABdhPJx1X7JuQxpKcMIU9s0E2gc7cA+a1V+AWNJipq3FcAPWGP//mDkCHT3poNEwO2HSCIDmoCN1Zg==
X-Received: by 2002:adf:f292:: with SMTP id k18mr16056450wro.335.1615580406263;
        Fri, 12 Mar 2021 12:20:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21sm3463378wmg.41.2021.03.12.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:20:05 -0800 (PST)
Message-Id: <1f17d5edab5274e0ed742c4ec7b9e463d4c00538.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:51 +0000
Subject: [PATCH v5 10/15] reftable: read reftable files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This supports reading a single reftable file.

The commit introduces an abstract iterator type, which captures the usecases
both of reading individual refs, and iterating over a segment of the ref
namespace.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                     |   3 +
 reftable/iter.c              | 248 ++++++++++++
 reftable/iter.h              |  75 ++++
 reftable/reader.c            | 733 +++++++++++++++++++++++++++++++++++
 reftable/reader.h            |  75 ++++
 reftable/reftable-iterator.h |  37 ++
 reftable/reftable-reader.h   |  89 +++++
 7 files changed, 1260 insertions(+)
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable-reader.h

diff --git a/Makefile b/Makefile
index d37dd79bfab7..aba1adc10b75 100644
--- a/Makefile
+++ b/Makefile
@@ -2386,8 +2386,11 @@ REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/reftable.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
diff --git a/reftable/iter.c b/reftable/iter.c
new file mode 100644
index 000000000000..b8c091ffd570
--- /dev/null
+++ b/reftable/iter.c
@@ -0,0 +1,248 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "iter.h"
+
+#include "system.h"
+
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "reftable-error.h"
+
+int iterator_is_null(struct reftable_iterator *it)
+{
+	return it->ops == NULL;
+}
+
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
+{
+	return 1;
+}
+
+static void empty_iterator_close(void *arg)
+{
+}
+
+static struct reftable_iterator_vtable empty_vtable = {
+	.next = &empty_iterator_next,
+	.close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct reftable_iterator *it)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
+
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
+{
+	return it->ops->next(it->iter_arg, rec);
+}
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (it->ops == NULL) {
+		return;
+	}
+	it->ops->close(it->iter_arg);
+	it->ops = NULL;
+	FREE_AND_NULL(it->iter_arg);
+}
+
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, ref);
+	return iterator_next(it, &rec);
+}
+
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, log);
+	return iterator_next(it, &rec);
+}
+
+static void filtering_ref_iterator_close(void *iter_arg)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	strbuf_release(&fri->oid);
+	reftable_iterator_destroy(&fri->it);
+}
+
+static int filtering_ref_iterator_next(void *iter_arg,
+				       struct reftable_record *rec)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec->data;
+	int err = 0;
+	while (1) {
+		err = reftable_iterator_next_ref(&fri->it, ref);
+		if (err != 0) {
+			break;
+		}
+
+		if (fri->double_check) {
+			struct reftable_iterator it = { NULL };
+
+			err = reftable_table_seek_ref(&fri->tab, &it,
+						      ref->refname);
+			if (err == 0) {
+				err = reftable_iterator_next_ref(&it, ref);
+			}
+
+			reftable_iterator_destroy(&it);
+
+			if (err < 0) {
+				break;
+			}
+
+			if (err > 0) {
+				continue;
+			}
+		}
+
+		if (ref->value_type == REFTABLE_REF_VAL2 &&
+		    (!memcmp(fri->oid.buf, ref->value.val2.target_value,
+			     fri->oid.len) ||
+		     !memcmp(fri->oid.buf, ref->value.val2.value,
+			     fri->oid.len)))
+			return 0;
+
+		if (ref->value_type == REFTABLE_REF_VAL1 &&
+		    !memcmp(fri->oid.buf, ref->value.val1, fri->oid.len)) {
+			return 0;
+		}
+	}
+
+	reftable_ref_record_release(ref);
+	return err;
+}
+
+static struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
+	.next = &filtering_ref_iterator_next,
+	.close = &filtering_ref_iterator_close,
+};
+
+void iterator_from_filtering_ref_iterator(struct reftable_iterator *it,
+					  struct filtering_ref_iterator *fri)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = fri;
+	it->ops = &filtering_ref_iterator_vtable;
+}
+
+static void indexed_table_ref_iter_close(void *p)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	block_iter_close(&it->cur);
+	reftable_block_done(&it->block_reader.block);
+	strbuf_release(&it->oid);
+}
+
+static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
+{
+	uint64_t off;
+	int err = 0;
+	if (it->offset_idx == it->offset_len) {
+		it->is_finished = 1;
+		return 1;
+	}
+
+	reftable_block_done(&it->block_reader.block);
+
+	off = it->offsets[it->offset_idx++];
+	err = reader_init_block_reader(it->r, &it->block_reader, off,
+				       BLOCK_TYPE_REF);
+	if (err < 0) {
+		return err;
+	}
+	if (err > 0) {
+		/* indexed block does not exist. */
+		return REFTABLE_FORMAT_ERROR;
+	}
+	block_reader_start(&it->block_reader, &it->cur);
+	return 0;
+}
+
+static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec->data;
+
+	while (1) {
+		int err = block_iter_next(&it->cur, rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			err = indexed_table_ref_iter_next_block(it);
+			if (err < 0) {
+				return err;
+			}
+
+			if (it->is_finished) {
+				return 1;
+			}
+			continue;
+		}
+		/* BUG */
+		if (!memcmp(it->oid.buf, ref->value.val2.target_value,
+			    it->oid.len) ||
+		    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
+			return 0;
+		}
+	}
+}
+
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+			       struct reftable_reader *r, uint8_t *oid,
+			       int oid_len, uint64_t *offsets, int offset_len)
+{
+	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
+	struct indexed_table_ref_iter *itr =
+		reftable_calloc(sizeof(struct indexed_table_ref_iter));
+	int err = 0;
+
+	*itr = empty;
+	itr->r = r;
+	strbuf_add(&itr->oid, oid, oid_len);
+
+	itr->offsets = offsets;
+	itr->offset_len = offset_len;
+
+	err = indexed_table_ref_iter_next_block(itr);
+	if (err < 0) {
+		reftable_free(itr);
+	} else {
+		*dest = itr;
+	}
+	return err;
+}
+
+static struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
+	.next = &indexed_table_ref_iter_next,
+	.close = &indexed_table_ref_iter_close,
+};
+
+void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
+					  struct indexed_table_ref_iter *itr)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = itr;
+	it->ops = &indexed_table_ref_iter_vtable;
+}
diff --git a/reftable/iter.h b/reftable/iter.h
new file mode 100644
index 000000000000..2ba964c29a3f
--- /dev/null
+++ b/reftable/iter.h
@@ -0,0 +1,75 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef ITER_H
+#define ITER_H
+
+#include "system.h"
+#include "block.h"
+#include "record.h"
+
+#include "reftable-iterator.h"
+#include "reftable-generic.h"
+
+struct reftable_iterator_vtable {
+	int (*next)(void *iter_arg, struct reftable_record *rec);
+	void (*close)(void *iter_arg);
+};
+
+void iterator_set_empty(struct reftable_iterator *it);
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
+
+/* Returns true for a zeroed out iterator, such as the one returned from
+ * iterator_destroy. */
+int iterator_is_null(struct reftable_iterator *it);
+
+/* iterator that produces only ref records that point to `oid` */
+struct filtering_ref_iterator {
+	int double_check;
+	struct reftable_table tab;
+	struct strbuf oid;
+	struct reftable_iterator it;
+};
+#define FILTERING_REF_ITERATOR_INIT \
+	{                           \
+		.oid = STRBUF_INIT  \
+	}
+
+void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
+					  struct filtering_ref_iterator *);
+
+/* iterator that produces only ref records that point to `oid`,
+ * but using the object index.
+ */
+struct indexed_table_ref_iter {
+	struct reftable_reader *r;
+	struct strbuf oid;
+
+	/* mutable */
+	uint64_t *offsets;
+
+	/* Points to the next offset to read. */
+	int offset_idx;
+	int offset_len;
+	struct block_reader block_reader;
+	struct block_iter cur;
+	int is_finished;
+};
+
+#define INDEXED_TABLE_REF_ITER_INIT                                     \
+	{                                                               \
+		.cur = { .last_key = STRBUF_INIT }, .oid = STRBUF_INIT, \
+	}
+
+void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
+					  struct indexed_table_ref_iter *itr);
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+			       struct reftable_reader *r, uint8_t *oid,
+			       int oid_len, uint64_t *offsets, int offset_len);
+
+#endif
diff --git a/reftable/reader.c b/reftable/reader.c
new file mode 100644
index 000000000000..a5b7b1d4fefa
--- /dev/null
+++ b/reftable/reader.c
@@ -0,0 +1,733 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reader.h"
+
+#include "system.h"
+#include "block.h"
+#include "constants.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable-error.h"
+#include "tree.h"
+
+uint64_t block_source_size(struct reftable_block_source *source)
+{
+	return source->ops->size(source->arg);
+}
+
+int block_source_read_block(struct reftable_block_source *source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size)
+{
+	int result = source->ops->read_block(source->arg, dest, off, size);
+	dest->source = *source;
+	return result;
+}
+
+void block_source_close(struct reftable_block_source *source)
+{
+	if (source->ops == NULL) {
+		return;
+	}
+
+	source->ops->close(source->arg);
+	source->ops = NULL;
+}
+
+static struct reftable_reader_offsets *
+reader_offsets_for(struct reftable_reader *r, uint8_t typ)
+{
+	switch (typ) {
+	case BLOCK_TYPE_REF:
+		return &r->ref_offsets;
+	case BLOCK_TYPE_LOG:
+		return &r->log_offsets;
+	case BLOCK_TYPE_OBJ:
+		return &r->obj_offsets;
+	}
+	abort();
+}
+
+static int reader_get_block(struct reftable_reader *r,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t sz)
+{
+	if (off >= r->size)
+		return 0;
+
+	if (off + sz > r->size) {
+		sz = r->size - off;
+	}
+
+	return block_source_read_block(&r->source, dest, off, sz);
+}
+
+uint32_t reftable_reader_hash_id(struct reftable_reader *r)
+{
+	return r->hash_id;
+}
+
+const char *reader_name(struct reftable_reader *r)
+{
+	return r->name;
+}
+
+static int parse_footer(struct reftable_reader *r, uint8_t *footer,
+			uint8_t *header)
+{
+	uint8_t *f = footer;
+	uint8_t first_block_typ;
+	int err = 0;
+	uint32_t computed_crc;
+	uint32_t file_crc;
+
+	if (memcmp(f, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+	f += 4;
+
+	if (memcmp(footer, header, header_size(r->version))) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	f++;
+	r->block_size = get_be24(f);
+
+	f += 3;
+	r->min_update_index = get_be64(f);
+	f += 8;
+	r->max_update_index = get_be64(f);
+	f += 8;
+
+	if (r->version == 1) {
+		r->hash_id = SHA1_ID;
+	} else {
+		r->hash_id = get_be32(f);
+		switch (r->hash_id) {
+		case SHA1_ID:
+			break;
+		case SHA256_ID:
+			break;
+		default:
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
+		f += 4;
+	}
+
+	r->ref_offsets.index_offset = get_be64(f);
+	f += 8;
+
+	r->obj_offsets.offset = get_be64(f);
+	f += 8;
+
+	r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
+	r->obj_offsets.offset >>= 5;
+
+	r->obj_offsets.index_offset = get_be64(f);
+	f += 8;
+	r->log_offsets.offset = get_be64(f);
+	f += 8;
+	r->log_offsets.index_offset = get_be64(f);
+	f += 8;
+
+	computed_crc = crc32(0, footer, f - footer);
+	file_crc = get_be32(f);
+	f += 4;
+	if (computed_crc != file_crc) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	first_block_typ = header[header_size(r->version)];
+	r->ref_offsets.is_present = (first_block_typ == BLOCK_TYPE_REF);
+	r->ref_offsets.offset = 0;
+	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
+				     r->log_offsets.offset > 0);
+	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
+	err = 0;
+done:
+	return err;
+}
+
+int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
+		const char *name)
+{
+	struct reftable_block footer = { NULL };
+	struct reftable_block header = { NULL };
+	int err = 0;
+
+	memset(r, 0, sizeof(struct reftable_reader));
+
+	/* Need +1 to read type of first block. */
+	err = block_source_read_block(source, &header, 0, header_size(2) + 1);
+	if (err != header_size(2) + 1) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	if (memcmp(header.data, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+	r->version = header.data[4];
+	if (r->version != 1 && r->version != 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	r->size = block_source_size(source) - footer_size(r->version);
+	r->source = *source;
+	r->name = xstrdup(name);
+	r->hash_id = 0;
+
+	err = block_source_read_block(source, &footer, r->size,
+				      footer_size(r->version));
+	if (err != footer_size(r->version)) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = parse_footer(r, footer.data, header.data);
+done:
+	reftable_block_done(&footer);
+	reftable_block_done(&header);
+	return err;
+}
+
+struct table_iter {
+	struct reftable_reader *r;
+	uint8_t typ;
+	uint64_t block_off;
+	struct block_iter bi;
+	int is_finished;
+};
+#define TABLE_ITER_INIT                          \
+	{                                        \
+		.bi = {.last_key = STRBUF_INIT } \
+	}
+
+static void table_iter_copy_from(struct table_iter *dest,
+				 struct table_iter *src)
+{
+	dest->r = src->r;
+	dest->typ = src->typ;
+	dest->block_off = src->block_off;
+	dest->is_finished = src->is_finished;
+	block_iter_copy_from(&dest->bi, &src->bi);
+}
+
+static int table_iter_next_in_block(struct table_iter *ti,
+				    struct reftable_record *rec)
+{
+	int res = block_iter_next(&ti->bi, rec);
+	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
+		((struct reftable_ref_record *)rec->data)->update_index +=
+			ti->r->min_update_index;
+	}
+
+	return res;
+}
+
+static void table_iter_block_done(struct table_iter *ti)
+{
+	if (ti->bi.br == NULL) {
+		return;
+	}
+	reftable_block_done(&ti->bi.br->block);
+	FREE_AND_NULL(ti->bi.br);
+
+	ti->bi.last_key.len = 0;
+	ti->bi.next_off = 0;
+}
+
+static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
+				  int version)
+{
+	int32_t result = 0;
+
+	if (off == 0) {
+		data += header_size(version);
+	}
+
+	*typ = data[0];
+	if (reftable_is_block_type(*typ)) {
+		result = get_be24(data + 1);
+	}
+	return result;
+}
+
+int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
+			     uint64_t next_off, uint8_t want_typ)
+{
+	int32_t guess_block_size = r->block_size ? r->block_size :
+							 DEFAULT_BLOCK_SIZE;
+	struct reftable_block block = { NULL };
+	uint8_t block_typ = 0;
+	int err = 0;
+	uint32_t header_off = next_off ? 0 : header_size(r->version);
+	int32_t block_size = 0;
+
+	if (next_off >= r->size)
+		return 1;
+
+	err = reader_get_block(r, &block, next_off, guess_block_size);
+	if (err < 0)
+		return err;
+
+	block_size = extract_block_size(block.data, &block_typ, next_off,
+					r->version);
+	if (block_size < 0)
+		return block_size;
+
+	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+		reftable_block_done(&block);
+		return 1;
+	}
+
+	if (block_size > guess_block_size) {
+		reftable_block_done(&block);
+		err = reader_get_block(r, &block, next_off, block_size);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	return block_reader_init(br, &block, header_off, r->block_size,
+				 hash_size(r->hash_id));
+}
+
+static int table_iter_next_block(struct table_iter *dest,
+				 struct table_iter *src)
+{
+	uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
+	struct block_reader br = { 0 };
+	int err = 0;
+
+	dest->r = src->r;
+	dest->typ = src->typ;
+	dest->block_off = next_block_off;
+
+	err = reader_init_block_reader(src->r, &br, next_block_off, src->typ);
+	if (err > 0) {
+		dest->is_finished = 1;
+		return 1;
+	}
+	if (err != 0)
+		return err;
+	else {
+		struct block_reader *brp =
+			reftable_malloc(sizeof(struct block_reader));
+		*brp = br;
+
+		dest->is_finished = 0;
+		block_reader_start(brp, &dest->bi);
+	}
+	return 0;
+}
+
+static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
+{
+	if (reftable_record_type(rec) != ti->typ)
+		return REFTABLE_API_ERROR;
+
+	while (1) {
+		struct table_iter next = TABLE_ITER_INIT;
+		int err = 0;
+		if (ti->is_finished) {
+			return 1;
+		}
+
+		err = table_iter_next_in_block(ti, rec);
+		if (err <= 0) {
+			return err;
+		}
+
+		err = table_iter_next_block(&next, ti);
+		if (err != 0) {
+			ti->is_finished = 1;
+		}
+		table_iter_block_done(ti);
+		if (err != 0) {
+			return err;
+		}
+		table_iter_copy_from(ti, &next);
+		block_iter_close(&next.bi);
+	}
+}
+
+static int table_iter_next_void(void *ti, struct reftable_record *rec)
+{
+	return table_iter_next((struct table_iter *)ti, rec);
+}
+
+static void table_iter_close(void *p)
+{
+	struct table_iter *ti = (struct table_iter *)p;
+	table_iter_block_done(ti);
+	block_iter_close(&ti->bi);
+}
+
+static struct reftable_iterator_vtable table_iter_vtable = {
+	.next = &table_iter_next_void,
+	.close = &table_iter_close,
+};
+
+static void iterator_from_table_iter(struct reftable_iterator *it,
+				     struct table_iter *ti)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = ti;
+	it->ops = &table_iter_vtable;
+}
+
+static int reader_table_iter_at(struct reftable_reader *r,
+				struct table_iter *ti, uint64_t off,
+				uint8_t typ)
+{
+	struct block_reader br = { 0 };
+	struct block_reader *brp = NULL;
+
+	int err = reader_init_block_reader(r, &br, off, typ);
+	if (err != 0)
+		return err;
+
+	brp = reftable_malloc(sizeof(struct block_reader));
+	*brp = br;
+	ti->r = r;
+	ti->typ = block_reader_type(brp);
+	ti->block_off = off;
+	block_reader_start(brp, &ti->bi);
+	return 0;
+}
+
+static int reader_start(struct reftable_reader *r, struct table_iter *ti,
+			uint8_t typ, int index)
+{
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	uint64_t off = offs->offset;
+	if (index) {
+		off = offs->index_offset;
+		if (off == 0) {
+			return 1;
+		}
+		typ = BLOCK_TYPE_INDEX;
+	}
+
+	return reader_table_iter_at(r, ti, off, typ);
+}
+
+static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
+			      struct reftable_record *want)
+{
+	struct reftable_record rec =
+		reftable_new_record(reftable_record_type(want));
+	struct strbuf want_key = STRBUF_INIT;
+	struct strbuf got_key = STRBUF_INIT;
+	struct table_iter next = TABLE_ITER_INIT;
+	int err = -1;
+
+	reftable_record_key(want, &want_key);
+
+	while (1) {
+		err = table_iter_next_block(&next, ti);
+		if (err < 0)
+			goto done;
+
+		if (err > 0) {
+			break;
+		}
+
+		err = block_reader_first_key(next.bi.br, &got_key);
+		if (err < 0)
+			goto done;
+
+		if (strbuf_cmp(&got_key, &want_key) > 0) {
+			table_iter_block_done(&next);
+			break;
+		}
+
+		table_iter_block_done(ti);
+		table_iter_copy_from(ti, &next);
+	}
+
+	err = block_iter_seek(&ti->bi, &want_key);
+	if (err < 0)
+		goto done;
+	err = 0;
+
+done:
+	block_iter_close(&next.bi);
+	reftable_record_destroy(&rec);
+	strbuf_release(&want_key);
+	strbuf_release(&got_key);
+	return err;
+}
+
+static int reader_seek_indexed(struct reftable_reader *r,
+			       struct reftable_iterator *it,
+			       struct reftable_record *rec)
+{
+	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
+	struct reftable_record want_index_rec = { NULL };
+	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
+	struct reftable_record index_result_rec = { NULL };
+	struct table_iter index_iter = TABLE_ITER_INIT;
+	struct table_iter next = TABLE_ITER_INIT;
+	int err = 0;
+
+	reftable_record_key(rec, &want_index.last_key);
+	reftable_record_from_index(&want_index_rec, &want_index);
+	reftable_record_from_index(&index_result_rec, &index_result);
+
+	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
+	if (err < 0)
+		goto done;
+
+	err = reader_seek_linear(r, &index_iter, &want_index_rec);
+	while (1) {
+		err = table_iter_next(&index_iter, &index_result_rec);
+		table_iter_block_done(&index_iter);
+		if (err != 0)
+			goto done;
+
+		err = reader_table_iter_at(r, &next, index_result.offset, 0);
+		if (err != 0)
+			goto done;
+
+		err = block_iter_seek(&next.bi, &want_index.last_key);
+		if (err < 0)
+			goto done;
+
+		if (next.typ == reftable_record_type(rec)) {
+			err = 0;
+			break;
+		}
+
+		if (next.typ != BLOCK_TYPE_INDEX) {
+			err = REFTABLE_FORMAT_ERROR;
+			break;
+		}
+
+		table_iter_copy_from(&index_iter, &next);
+	}
+
+	if (err == 0) {
+		struct table_iter empty = TABLE_ITER_INIT;
+		struct table_iter *malloced =
+			reftable_calloc(sizeof(struct table_iter));
+		*malloced = empty;
+		table_iter_copy_from(malloced, &next);
+		iterator_from_table_iter(it, malloced);
+	}
+done:
+	block_iter_close(&next.bi);
+	table_iter_close(&index_iter);
+	reftable_record_release(&want_index_rec);
+	reftable_record_release(&index_result_rec);
+	return err;
+}
+
+static int reader_seek_internal(struct reftable_reader *r,
+				struct reftable_iterator *it,
+				struct reftable_record *rec)
+{
+	struct reftable_reader_offsets *offs =
+		reader_offsets_for(r, reftable_record_type(rec));
+	uint64_t idx = offs->index_offset;
+	struct table_iter ti = TABLE_ITER_INIT;
+	int err = 0;
+	if (idx > 0)
+		return reader_seek_indexed(r, it, rec);
+
+	err = reader_start(r, &ti, reftable_record_type(rec), 0);
+	if (err < 0)
+		return err;
+	err = reader_seek_linear(r, &ti, rec);
+	if (err < 0)
+		return err;
+	else {
+		struct table_iter *p =
+			reftable_malloc(sizeof(struct table_iter));
+		*p = ti;
+		iterator_from_table_iter(it, p);
+	}
+
+	return 0;
+}
+
+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
+		struct reftable_record *rec)
+{
+	uint8_t typ = reftable_record_type(rec);
+
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	if (!offs->is_present) {
+		iterator_set_empty(it);
+		return 0;
+	}
+
+	return reader_seek_internal(r, it, rec);
+}
+
+int reftable_reader_seek_ref(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *)name,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, &ref);
+	return reader_seek(r, it, &rec);
+}
+
+int reftable_reader_seek_log_at(struct reftable_reader *r,
+				struct reftable_iterator *it, const char *name,
+				uint64_t update_index)
+{
+	struct reftable_log_record log = {
+		.refname = (char *)name,
+		.update_index = update_index,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, &log);
+	return reader_seek(r, it, &rec);
+}
+
+int reftable_reader_seek_log(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name)
+{
+	uint64_t max = ~((uint64_t)0);
+	return reftable_reader_seek_log_at(r, it, name, max);
+}
+
+void reader_close(struct reftable_reader *r)
+{
+	block_source_close(&r->source);
+	FREE_AND_NULL(r->name);
+}
+
+int reftable_new_reader(struct reftable_reader **p,
+			struct reftable_block_source *src, char const *name)
+{
+	struct reftable_reader *rd =
+		reftable_calloc(sizeof(struct reftable_reader));
+	int err = init_reader(rd, src, name);
+	if (err == 0) {
+		*p = rd;
+	} else {
+		block_source_close(src);
+		reftable_free(rd);
+	}
+	return err;
+}
+
+void reftable_reader_free(struct reftable_reader *r)
+{
+	reader_close(r);
+	reftable_free(r);
+}
+
+static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
+					    struct reftable_iterator *it,
+					    uint8_t *oid)
+{
+	struct reftable_obj_record want = {
+		.hash_prefix = oid,
+		.hash_prefix_len = r->object_id_len,
+	};
+	struct reftable_record want_rec = { NULL };
+	struct reftable_iterator oit = { NULL };
+	struct reftable_obj_record got = { NULL };
+	struct reftable_record got_rec = { NULL };
+	int err = 0;
+	struct indexed_table_ref_iter *itr = NULL;
+
+	/* Look through the reverse index. */
+	reftable_record_from_obj(&want_rec, &want);
+	err = reader_seek(r, &oit, &want_rec);
+	if (err != 0)
+		goto done;
+
+	/* read out the reftable_obj_record */
+	reftable_record_from_obj(&got_rec, &got);
+	err = iterator_next(&oit, &got_rec);
+	if (err < 0)
+		goto done;
+
+	if (err > 0 ||
+	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
+		/* didn't find it; return empty iterator */
+		iterator_set_empty(it);
+		err = 0;
+		goto done;
+	}
+
+	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+					 got.offsets, got.offset_len);
+	if (err < 0)
+		goto done;
+	got.offsets = NULL;
+	iterator_from_indexed_table_ref_iter(it, itr);
+
+done:
+	reftable_iterator_destroy(&oit);
+	reftable_record_release(&got_rec);
+	return err;
+}
+
+static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
+					      struct reftable_iterator *it,
+					      uint8_t *oid)
+{
+	struct table_iter ti_empty = TABLE_ITER_INIT;
+	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
+	struct filtering_ref_iterator *filter = NULL;
+	struct filtering_ref_iterator empty = FILTERING_REF_ITERATOR_INIT;
+	int oid_len = hash_size(r->hash_id);
+	int err;
+
+	*ti = ti_empty;
+	err = reader_start(r, ti, BLOCK_TYPE_REF, 0);
+	if (err < 0) {
+		reftable_free(ti);
+		return err;
+	}
+
+	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
+	*filter = empty;
+
+	strbuf_add(&filter->oid, oid, oid_len);
+	reftable_table_from_reader(&filter->tab, r);
+	filter->double_check = 0;
+	iterator_from_table_iter(&filter->it, ti);
+
+	iterator_from_filtering_ref_iterator(it, filter);
+	return 0;
+}
+
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, uint8_t *oid)
+{
+	if (r->obj_offsets.is_present)
+		return reftable_reader_refs_for_indexed(r, it, oid);
+	return reftable_reader_refs_for_unindexed(r, it, oid);
+}
+
+uint64_t reftable_reader_max_update_index(struct reftable_reader *r)
+{
+	return r->max_update_index;
+}
+
+uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
+{
+	return r->min_update_index;
+}
diff --git a/reftable/reader.h b/reftable/reader.h
new file mode 100644
index 000000000000..6d4927e1c5d6
--- /dev/null
+++ b/reftable/reader.h
@@ -0,0 +1,75 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef READER_H
+#define READER_H
+
+#include "block.h"
+#include "record.h"
+#include "reftable-iterator.h"
+#include "reftable-reader.h"
+
+uint64_t block_source_size(struct reftable_block_source *source);
+
+int block_source_read_block(struct reftable_block_source *source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size);
+void block_source_close(struct reftable_block_source *source);
+
+/* metadata for a block type */
+struct reftable_reader_offsets {
+	int is_present;
+	uint64_t offset;
+	uint64_t index_offset;
+};
+
+/* The state for reading a reftable file. */
+struct reftable_reader {
+	/* for convience, associate a name with the instance. */
+	char *name;
+	struct reftable_block_source source;
+
+	/* Size of the file, excluding the footer. */
+	uint64_t size;
+
+	/* 'sha1' for SHA1, 's256' for SHA-256 */
+	uint32_t hash_id;
+
+	uint32_t block_size;
+	uint64_t min_update_index;
+	uint64_t max_update_index;
+	/* Length of the OID keys in the 'o' section */
+	int object_id_len;
+	int version;
+
+	struct reftable_reader_offsets ref_offsets;
+	struct reftable_reader_offsets obj_offsets;
+	struct reftable_reader_offsets log_offsets;
+};
+
+int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
+		const char *name);
+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
+		struct reftable_record *rec);
+void reader_close(struct reftable_reader *r);
+const char *reader_name(struct reftable_reader *r);
+
+/* initialize a block reader to read from `r` */
+int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
+			     uint64_t next_off, uint8_t want_typ);
+
+/* generic interface to reftables */
+struct reftable_table_vtable {
+	int (*seek_record)(void *tab, struct reftable_iterator *it,
+			   struct reftable_record *);
+	uint32_t (*hash_id)(void *tab);
+	uint64_t (*min_update_index)(void *tab);
+	uint64_t (*max_update_index)(void *tab);
+};
+
+#endif
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
new file mode 100644
index 000000000000..d8251a45ba19
--- /dev/null
+++ b/reftable/reftable-iterator.h
@@ -0,0 +1,37 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_ITERATOR_H
+#define REFTABLE_ITERATOR_H
+
+#include "reftable-record.h"
+
+/* iterator is the generic interface for walking over data stored in a
+ * reftable.
+ */
+struct reftable_iterator {
+	struct reftable_iterator_vtable *ops;
+	void *iter_arg;
+};
+
+/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
+ * end of iteration.
+ */
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref);
+
+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
+ * end of iteration.
+ */
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log);
+
+/* releases resources associated with an iterator. */
+void reftable_iterator_destroy(struct reftable_iterator *it);
+
+#endif
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
new file mode 100644
index 000000000000..804e28543b35
--- /dev/null
+++ b/reftable/reftable-reader.h
@@ -0,0 +1,89 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_READER_H
+#define REFTABLE_READER_H
+
+#include "reftable-iterator.h"
+#include "reftable-blocksource.h"
+
+/*
+ * Reading single tables
+ *
+ * The follow routines are for reading single files. For an application-level
+ * interface, skip ahead to struct reftable_merged_table and struct
+ * reftable_stack.
+ */
+
+/* The reader struct is a handle to an open reftable file. */
+struct reftable_reader;
+
+/* reftable_new_reader opens a reftable for reading. If successful, returns 0
+ * code and sets pp. The name is used for creating a stack. Typically, it is the
+ * basename of the file. The block source `src` is owned by the reader, and is
+ * closed on calling reftable_reader_destroy().
+ */
+int reftable_new_reader(struct reftable_reader **pp,
+			struct reftable_block_source *src, const char *name);
+
+/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
+   in the table.  To seek to the start of the table, use name = "".
+
+   example:
+
+   struct reftable_reader *r = NULL;
+   int err = reftable_new_reader(&r, &src, "filename");
+   if (err < 0) { ... }
+   struct reftable_iterator it  = {0};
+   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
+   if (err < 0) { ... }
+   struct reftable_ref_record ref  = {0};
+   while (1) {
+     err = reftable_iterator_next_ref(&it, &ref);
+     if (err > 0) {
+       break;
+     }
+     if (err < 0) {
+       ..error handling..
+     }
+     ..found..
+   }
+   reftable_iterator_destroy(&it);
+   reftable_ref_record_release(&ref);
+ */
+int reftable_reader_seek_ref(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name);
+
+/* returns the hash ID used in this table. */
+uint32_t reftable_reader_hash_id(struct reftable_reader *r);
+
+/* seek to logs for the given name, older than update_index. To seek to the
+   start of the table, use name = "".
+ */
+int reftable_reader_seek_log_at(struct reftable_reader *r,
+				struct reftable_iterator *it, const char *name,
+				uint64_t update_index);
+
+/* seek to newest log entry for given name. */
+int reftable_reader_seek_log(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name);
+
+/* closes and deallocates a reader. */
+void reftable_reader_free(struct reftable_reader *);
+
+/* return an iterator for the refs pointing to `oid`. */
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, uint8_t *oid);
+
+/* return the max_update_index for a table */
+uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
+
+/* return the min_update_index for a table */
+uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
+
+#endif
-- 
gitgitgadget

