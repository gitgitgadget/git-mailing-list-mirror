Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3332C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984AB6138F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhHWMOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhHWMNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946AC06175F
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so5019240wmh.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4DOV6kf0TX48TQiNjEJfN6YZveDvfPbzB0D5Pczzg0=;
        b=fk/huozvCQnnbYjGOE/ZSSJbJMwAiO4qGDGWVA1i2mkPGUpp/XOtTUB4GCovEJVcWk
         QFqAeYA//jx70tSGe4AYmm0hIy8ZiMbEF/A7XaJJwrPFjDPFAjQvwUyed2rnjqj89aw0
         mpiDpcbrUr64B8CpJwxA1LZmLihPaS7c8LYYo3mQPGF0dYa0tU/GZs1uFCgqrnTGAKyz
         vOF+KHWT4Um5hpTENrIbNTNxnp3nmm/QfrdE3v48hHV0uNSuf9KAE1bDIYrXMch7MVC6
         8jjzhHCCAZb8DY4mpqrEaa5nSS7Eug2d8NTb2KokrVPgJydYb+TCj+7Q+LQFaaURhFro
         icuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4DOV6kf0TX48TQiNjEJfN6YZveDvfPbzB0D5Pczzg0=;
        b=Ai7gkPoLbquUsOIilmi8tu1gihq+DSSbxqTVeW+r8ZrbnGFIBI6gPGmy3jyx/qiL0Y
         GGxt1Vq6lTFSwIevtXNZGhfs3Y9JmpO+F5AxQiiDSwgT6rw5yf3QcARZXEVZDDnV8dRz
         3CZ9jqmq/iyIjecVjMoW0X3Ejvd2RD3o4Mwc8+sjNG0Y6Q32TudDozzUpjAj4OiSJSVo
         rQJ6j1cyriPCqiUqcw461C1y9Cqs2f//S8qKxoCfb5YTNsZ1SCTrox5Hhiuq9ypMOXNM
         OUnD9KnnbSaq4LrreLnyt69YFc2sR5cc2s61B82WneG3EU+tN7B7lJ3yWvCfNxzXMvjm
         zVyA==
X-Gm-Message-State: AOAM533FrlxsF9VuXrQKrs8OhIl7g6hnkR0iSHDkAKYiySCat86jGSLp
        UqZSYXQD30w2WvW86ZW18NIQxXCzbGv1pATY
X-Google-Smtp-Source: ABdhPJyfmlWHq96X21RyousO0jmBMBodw4DQI7Oe7C7JpdSSgKqEA+LIT+6jFyhn/rSQGX8SkOcTXw==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr16266571wmz.98.1629720782866;
        Mon, 23 Aug 2021 05:13:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 09/28] reftable: reading/writing blocks
Date:   Mon, 23 Aug 2021 14:12:20 +0200
Message-Id: <patch-v4-09.28-9d468fbdd07-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format is structured as a sequence of block. Within a block,
records are prefix compressed, with an index of offsets for fully expand keys to
enable binary search within blocks.

This commit provides the logic to read and write these blocks.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |   2 +
 reftable/block.c         | 448 +++++++++++++++++++++++++++++++++++++++
 reftable/block.h         | 127 +++++++++++
 reftable/block_test.c    | 120 +++++++++++
 t/helper/test-reftable.c |   1 +
 5 files changed, 698 insertions(+)
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c

diff --git a/Makefile b/Makefile
index 16c883978d4..1d396c87be9 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,10 +2454,12 @@ xdiff-objs: $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/record.o
 
+REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/basics_test.o
diff --git a/reftable/block.c b/reftable/block.c
new file mode 100644
index 00000000000..eb5268dd3a6
--- /dev/null
+++ b/reftable/block.c
@@ -0,0 +1,448 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include "blocksource.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable-error.h"
+#include "system.h"
+#include <zlib.h>
+
+#ifdef NO_UNCOMPRESS2
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017)
+ */
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
+int header_size(int version)
+{
+	switch (version) {
+	case 1:
+		return 24;
+	case 2:
+		return 28;
+	}
+	abort();
+}
+
+int footer_size(int version)
+{
+	switch (version) {
+	case 1:
+		return 68;
+	case 2:
+		return 72;
+	}
+	abort();
+}
+
+static int block_writer_register_restart(struct block_writer *w, int n,
+					 int is_restart, struct strbuf *key)
+{
+	int rlen = w->restart_len;
+	if (rlen >= MAX_RESTARTS) {
+		is_restart = 0;
+	}
+
+	if (is_restart) {
+		rlen++;
+	}
+	if (2 + 3 * rlen + n > w->block_size - w->next)
+		return -1;
+	if (is_restart) {
+		if (w->restart_len == w->restart_cap) {
+			w->restart_cap = w->restart_cap * 2 + 1;
+			w->restarts = reftable_realloc(
+				w->restarts, sizeof(uint32_t) * w->restart_cap);
+		}
+
+		w->restarts[w->restart_len++] = w->next;
+	}
+
+	w->next += n;
+
+	strbuf_reset(&w->last_key);
+	strbuf_addbuf(&w->last_key, key);
+	w->entries++;
+	return 0;
+}
+
+void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+		       uint32_t block_size, uint32_t header_off, int hash_size)
+{
+	bw->buf = buf;
+	bw->hash_size = hash_size;
+	bw->block_size = block_size;
+	bw->header_off = header_off;
+	bw->buf[header_off] = typ;
+	bw->next = header_off + 4;
+	bw->restart_interval = 16;
+	bw->entries = 0;
+	bw->restart_len = 0;
+	bw->last_key.len = 0;
+}
+
+uint8_t block_writer_type(struct block_writer *bw)
+{
+	return bw->buf[bw->header_off];
+}
+
+/* adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
+   success */
+int block_writer_add(struct block_writer *w, struct reftable_record *rec)
+{
+	struct strbuf empty = STRBUF_INIT;
+	struct strbuf last =
+		w->entries % w->restart_interval == 0 ? empty : w->last_key;
+	struct string_view out = {
+		.buf = w->buf + w->next,
+		.len = w->block_size - w->next,
+	};
+
+	struct string_view start = out;
+
+	int is_restart = 0;
+	struct strbuf key = STRBUF_INIT;
+	int n = 0;
+
+	reftable_record_key(rec, &key);
+	n = reftable_encode_key(&is_restart, out, last, key,
+				reftable_record_val_type(rec));
+	if (n < 0)
+		goto done;
+	string_view_consume(&out, n);
+
+	n = reftable_record_encode(rec, out, w->hash_size);
+	if (n < 0)
+		goto done;
+	string_view_consume(&out, n);
+
+	if (block_writer_register_restart(w, start.len - out.len, is_restart,
+					  &key) < 0)
+		goto done;
+
+	strbuf_release(&key);
+	return 0;
+
+done:
+	strbuf_release(&key);
+	return -1;
+}
+
+int block_writer_finish(struct block_writer *w)
+{
+	int i = 0;
+	for (i = 0; i < w->restart_len; i++) {
+		put_be24(w->buf + w->next, w->restarts[i]);
+		w->next += 3;
+	}
+
+	put_be16(w->buf + w->next, w->restart_len);
+	w->next += 2;
+	put_be24(w->buf + 1 + w->header_off, w->next);
+
+	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
+		int block_header_skip = 4 + w->header_off;
+		uint8_t *compressed = NULL;
+		int zresult = 0;
+		uLongf src_len = w->next - block_header_skip;
+		size_t dest_cap = src_len;
+
+		compressed = reftable_malloc(dest_cap);
+		while (1) {
+			uLongf out_dest_len = dest_cap;
+
+			zresult = compress2(compressed, &out_dest_len,
+					    w->buf + block_header_skip, src_len,
+					    9);
+			if (zresult == Z_BUF_ERROR) {
+				dest_cap *= 2;
+				compressed =
+					reftable_realloc(compressed, dest_cap);
+				continue;
+			}
+
+			if (Z_OK != zresult) {
+				reftable_free(compressed);
+				return REFTABLE_ZLIB_ERROR;
+			}
+
+			memcpy(w->buf + block_header_skip, compressed,
+			       out_dest_len);
+			w->next = out_dest_len + block_header_skip;
+			reftable_free(compressed);
+			break;
+		}
+	}
+	return w->next;
+}
+
+uint8_t block_reader_type(struct block_reader *r)
+{
+	return r->block.data[r->header_off];
+}
+
+int block_reader_init(struct block_reader *br, struct reftable_block *block,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size)
+{
+	uint32_t full_block_size = table_block_size;
+	uint8_t typ = block->data[header_off];
+	uint32_t sz = get_be24(block->data + header_off + 1);
+
+	uint16_t restart_count = 0;
+	uint32_t restart_start = 0;
+	uint8_t *restart_bytes = NULL;
+
+	if (!reftable_is_block_type(typ))
+		return REFTABLE_FORMAT_ERROR;
+
+	if (typ == BLOCK_TYPE_LOG) {
+		int block_header_skip = 4 + header_off;
+		uLongf dst_len = sz - block_header_skip; /* total size of dest
+							    buffer. */
+		uLongf src_len = block->len - block_header_skip;
+		/* Log blocks specify the *uncompressed* size in their header.
+		 */
+		uint8_t *uncompressed = reftable_malloc(sz);
+
+		/* Copy over the block header verbatim. It's not compressed. */
+		memcpy(uncompressed, block->data, block_header_skip);
+
+		/* Uncompress */
+		if (Z_OK !=
+		    uncompress2(uncompressed + block_header_skip, &dst_len,
+				block->data + block_header_skip, &src_len)) {
+			reftable_free(uncompressed);
+			return REFTABLE_ZLIB_ERROR;
+		}
+
+		if (dst_len + block_header_skip != sz)
+			return REFTABLE_FORMAT_ERROR;
+
+		/* We're done with the input data. */
+		reftable_block_done(block);
+		block->data = uncompressed;
+		block->len = sz;
+		block->source = malloc_block_source();
+		full_block_size = src_len + block_header_skip;
+	} else if (full_block_size == 0) {
+		full_block_size = sz;
+	} else if (sz < full_block_size && sz < block->len &&
+		   block->data[sz] != 0) {
+		/* If the block is smaller than the full block size, it is
+		   padded (data followed by '\0') or the next block is
+		   unaligned. */
+		full_block_size = sz;
+	}
+
+	restart_count = get_be16(block->data + sz - 2);
+	restart_start = sz - 2 - 3 * restart_count;
+	restart_bytes = block->data + restart_start;
+
+	/* transfer ownership. */
+	br->block = *block;
+	block->data = NULL;
+	block->len = 0;
+
+	br->hash_size = hash_size;
+	br->block_len = restart_start;
+	br->full_block_size = full_block_size;
+	br->header_off = header_off;
+	br->restart_count = restart_count;
+	br->restart_bytes = restart_bytes;
+
+	return 0;
+}
+
+static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
+{
+	return get_be24(br->restart_bytes + 3 * i);
+}
+
+void block_reader_start(struct block_reader *br, struct block_iter *it)
+{
+	it->br = br;
+	strbuf_reset(&it->last_key);
+	it->next_off = br->header_off + 4;
+}
+
+struct restart_find_args {
+	int error;
+	struct strbuf key;
+	struct block_reader *r;
+};
+
+static int restart_key_less(size_t idx, void *args)
+{
+	struct restart_find_args *a = args;
+	uint32_t off = block_reader_restart_offset(a->r, idx);
+	struct string_view in = {
+		.buf = a->r->block.data + off,
+		.len = a->r->block_len - off,
+	};
+
+	/* the restart key is verbatim in the block, so this could avoid the
+	   alloc for decoding the key */
+	struct strbuf rkey = STRBUF_INIT;
+	struct strbuf last_key = STRBUF_INIT;
+	uint8_t unused_extra;
+	int n = reftable_decode_key(&rkey, &unused_extra, last_key, in);
+	int result;
+	if (n < 0) {
+		a->error = 1;
+		return -1;
+	}
+
+	result = strbuf_cmp(&a->key, &rkey);
+	strbuf_release(&rkey);
+	return result;
+}
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
+{
+	dest->br = src->br;
+	dest->next_off = src->next_off;
+	strbuf_reset(&dest->last_key);
+	strbuf_addbuf(&dest->last_key, &src->last_key);
+}
+
+int block_iter_next(struct block_iter *it, struct reftable_record *rec)
+{
+	struct string_view in = {
+		.buf = it->br->block.data + it->next_off,
+		.len = it->br->block_len - it->next_off,
+	};
+	struct string_view start = in;
+	struct strbuf key = STRBUF_INIT;
+	uint8_t extra = 0;
+	int n = 0;
+
+	if (it->next_off >= it->br->block_len)
+		return 1;
+
+	n = reftable_decode_key(&key, &extra, it->last_key, in);
+	if (n < 0)
+		return -1;
+
+	string_view_consume(&in, n);
+	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
+	if (n < 0)
+		return -1;
+	string_view_consume(&in, n);
+
+	strbuf_reset(&it->last_key);
+	strbuf_addbuf(&it->last_key, &key);
+	it->next_off += start.len - in.len;
+	strbuf_release(&key);
+	return 0;
+}
+
+int block_reader_first_key(struct block_reader *br, struct strbuf *key)
+{
+	struct strbuf empty = STRBUF_INIT;
+	int off = br->header_off + 4;
+	struct string_view in = {
+		.buf = br->block.data + off,
+		.len = br->block_len - off,
+	};
+
+	uint8_t extra = 0;
+	int n = reftable_decode_key(key, &extra, empty, in);
+	if (n < 0)
+		return n;
+
+	return 0;
+}
+
+int block_iter_seek(struct block_iter *it, struct strbuf *want)
+{
+	return block_reader_seek(it->br, it, want);
+}
+
+void block_iter_close(struct block_iter *it)
+{
+	strbuf_release(&it->last_key);
+}
+
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct strbuf *want)
+{
+	struct restart_find_args args = {
+		.key = *want,
+		.r = br,
+	};
+	struct reftable_record rec = reftable_new_record(block_reader_type(br));
+	struct strbuf key = STRBUF_INIT;
+	int err = 0;
+	struct block_iter next = {
+		.last_key = STRBUF_INIT,
+	};
+
+	int i = binsearch(br->restart_count, &restart_key_less, &args);
+	if (args.error) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	it->br = br;
+	if (i > 0) {
+		i--;
+		it->next_off = block_reader_restart_offset(br, i);
+	} else {
+		it->next_off = br->header_off + 4;
+	}
+
+	/* We're looking for the last entry less/equal than the wanted key, so
+	   we have to go one entry too far and then back up.
+	*/
+	while (1) {
+		block_iter_copy_from(&next, it);
+		err = block_iter_next(&next, &rec);
+		if (err < 0)
+			goto done;
+
+		reftable_record_key(&rec, &key);
+		if (err > 0 || strbuf_cmp(&key, want) >= 0) {
+			err = 0;
+			goto done;
+		}
+
+		block_iter_copy_from(it, &next);
+	}
+
+done:
+	strbuf_release(&key);
+	strbuf_release(&next.last_key);
+	reftable_record_destroy(&rec);
+
+	return err;
+}
+
+void block_writer_release(struct block_writer *bw)
+{
+	FREE_AND_NULL(bw->restarts);
+	strbuf_release(&bw->last_key);
+	/* the block is not owned. */
+}
+
+void reftable_block_done(struct reftable_block *blockp)
+{
+	struct reftable_block_source source = blockp->source;
+	if (blockp && source.ops)
+		source.ops->return_block(source.arg, blockp);
+	blockp->data = NULL;
+	blockp->len = 0;
+	blockp->source.ops = NULL;
+	blockp->source.arg = NULL;
+}
diff --git a/reftable/block.h b/reftable/block.h
new file mode 100644
index 00000000000..e207706a644
--- /dev/null
+++ b/reftable/block.h
@@ -0,0 +1,127 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCK_H
+#define BLOCK_H
+
+#include "basics.h"
+#include "record.h"
+#include "reftable-blocksource.h"
+
+/*
+ * Writes reftable blocks. The block_writer is reused across blocks to minimize
+ * allocation overhead.
+ */
+struct block_writer {
+	uint8_t *buf;
+	uint32_t block_size;
+
+	/* Offset ofof the global header. Nonzero in the first block only. */
+	uint32_t header_off;
+
+	/* How often to restart keys. */
+	int restart_interval;
+	int hash_size;
+
+	/* Offset of next uint8_t to write. */
+	uint32_t next;
+	uint32_t *restarts;
+	uint32_t restart_len;
+	uint32_t restart_cap;
+
+	struct strbuf last_key;
+	int entries;
+};
+
+/*
+ * initializes the blockwriter to write `typ` entries, using `buf` as temporary
+ * storage. `buf` is not owned by the block_writer. */
+void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+		       uint32_t block_size, uint32_t header_off, int hash_size);
+
+/* returns the block type (eg. 'r' for ref records. */
+uint8_t block_writer_type(struct block_writer *bw);
+
+/* appends the record, or -1 if it doesn't fit. */
+int block_writer_add(struct block_writer *w, struct reftable_record *rec);
+
+/* appends the key restarts, and compress the block if necessary. */
+int block_writer_finish(struct block_writer *w);
+
+/* clears out internally allocated block_writer members. */
+void block_writer_release(struct block_writer *bw);
+
+/* Read a block. */
+struct block_reader {
+	/* offset of the block header; nonzero for the first block in a
+	 * reftable. */
+	uint32_t header_off;
+
+	/* the memory block */
+	struct reftable_block block;
+	int hash_size;
+
+	/* size of the data, excluding restart data. */
+	uint32_t block_len;
+	uint8_t *restart_bytes;
+	uint16_t restart_count;
+
+	/* size of the data in the file. For log blocks, this is the compressed
+	 * size. */
+	uint32_t full_block_size;
+};
+
+/* Iterate over entries in a block */
+struct block_iter {
+	/* offset within the block of the next entry to read. */
+	uint32_t next_off;
+	struct block_reader *br;
+
+	/* key for last entry we read. */
+	struct strbuf last_key;
+};
+
+/* initializes a block reader. */
+int block_reader_init(struct block_reader *br, struct reftable_block *bl,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size);
+
+/* Position `it` at start of the block */
+void block_reader_start(struct block_reader *br, struct block_iter *it);
+
+/* Position `it` to the `want` key in the block */
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct strbuf *want);
+
+/* Returns the block type (eg. 'r' for refs) */
+uint8_t block_reader_type(struct block_reader *r);
+
+/* Decodes the first key in the block */
+int block_reader_first_key(struct block_reader *br, struct strbuf *key);
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
+
+/* return < 0 for error, 0 for OK, > 0 for EOF. */
+int block_iter_next(struct block_iter *it, struct reftable_record *rec);
+
+/* Seek to `want` with in the block pointed to by `it` */
+int block_iter_seek(struct block_iter *it, struct strbuf *want);
+
+/* deallocate memory for `it`. The block reader and its block is left intact. */
+void block_iter_close(struct block_iter *it);
+
+/* size of file header, depending on format version */
+int header_size(int version);
+
+/* size of file footer, depending on format version */
+int footer_size(int version);
+
+/* returns a block to its source. */
+void reftable_block_done(struct reftable_block *ret);
+
+#endif
diff --git a/reftable/block_test.c b/reftable/block_test.c
new file mode 100644
index 00000000000..4b3ea262dcb
--- /dev/null
+++ b/reftable/block_test.c
@@ -0,0 +1,120 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include "system.h"
+#include "blocksource.h"
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_block_read_write(void)
+{
+	const int header_off = 21; /* random */
+	char *names[30];
+	const int N = ARRAY_SIZE(names);
+	const int block_size = 1024;
+	struct reftable_block block = { NULL };
+	struct block_writer bw = {
+		.last_key = STRBUF_INIT,
+	};
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_record rec = { NULL };
+	int i = 0;
+	int n;
+	struct block_reader br = { 0 };
+	struct block_iter it = { .last_key = STRBUF_INIT };
+	int j = 0;
+	struct strbuf want = STRBUF_INIT;
+
+	block.data = reftable_calloc(block_size);
+	block.len = block_size;
+	block.source = malloc_block_source();
+	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	reftable_record_from_ref(&rec, &ref);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		uint8_t hash[GIT_SHA1_RAWSZ];
+		snprintf(name, sizeof(name), "branch%02d", i);
+		memset(hash, i, sizeof(hash));
+
+		ref.refname = name;
+		ref.value_type = REFTABLE_REF_VAL1;
+		ref.value.val1 = hash;
+
+		names[i] = xstrdup(name);
+		n = block_writer_add(&bw, &rec);
+		ref.refname = NULL;
+		ref.value_type = REFTABLE_REF_DELETION;
+		EXPECT(n == 0);
+	}
+
+	n = block_writer_finish(&bw);
+	EXPECT(n > 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+
+	block_reader_start(&br, &it);
+
+	while (1) {
+		int r = block_iter_next(&it, &rec);
+		EXPECT(r >= 0);
+		if (r > 0) {
+			break;
+		}
+		EXPECT_STREQ(names[j], ref.refname);
+		j++;
+	}
+
+	reftable_record_release(&rec);
+	block_iter_close(&it);
+
+	for (i = 0; i < N; i++) {
+		struct block_iter it = { .last_key = STRBUF_INIT };
+		strbuf_reset(&want);
+		strbuf_addstr(&want, names[i]);
+
+		n = block_reader_seek(&br, &it, &want);
+		EXPECT(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		EXPECT(n == 0);
+
+		EXPECT_STREQ(names[i], ref.refname);
+
+		want.len--;
+		n = block_reader_seek(&br, &it, &want);
+		EXPECT(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		EXPECT(n == 0);
+		EXPECT_STREQ(names[10 * (i / 10)], ref.refname);
+
+		block_iter_close(&it);
+	}
+
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	strbuf_release(&want);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+}
+
+int block_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_block_read_write);
+	return 0;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 09d4b83ef9b..c9deeaf08c7 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -4,6 +4,7 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	basics_test_main(argc, argv);
+	block_test_main(argc, argv);
 	record_test_main(argc, argv);
 	return 0;
 }
-- 
2.33.0.662.gbaddc25a55e

