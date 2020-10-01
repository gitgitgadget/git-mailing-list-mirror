Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5CC4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427CF207FB
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVjqHia0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgJAQLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbgJAQLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAFC0613E3
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so6465271wrx.7
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ehSZbwVbSTQProKRC22cu7jGSZxT6jHMYN6oX3g5DWA=;
        b=UVjqHia0SSXsIFDhiHIdUZUI11E/5zKtINjhmeNzePwC/h/GzTdQbiIPPs6H+w2lg2
         XbueWm4cn2HLrIhBtmdSFS5qxJVpBW7qMoxKCzfj9PSPkDIIMmHfaeA7kGunWnzrgWmu
         Ro2SQEzoqn5iG8dvlV5vjEMGmQFg8EqIAQsp/DBzVCJc4QN2wQ2HSir1Hmu2XkdX50JO
         GdsWcRUu0L76E7mz5XDtlu/csIkazaE2N4VOijNmnSkAsCzZ10iVQ+JFloEYCT0dMvud
         EDM161zOTH+cTVMy6NR+O5t4Pgl5uUpNzYy7oPrWz44o5Iig1kWfQ8puMuID3SQGWlWx
         gipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ehSZbwVbSTQProKRC22cu7jGSZxT6jHMYN6oX3g5DWA=;
        b=Sx8ZWxWvzDuLIDJVXPllW8fxBijajqhWH2IZH009K9a2yBQa4nGX20JaWCBtw9hMlo
         RzBF9KgrOU79BaLwrI57b+YTldAmgYGVMl+7I9wDXi7YgeICogP8sczMoQ3rdhyP0zT1
         RQS1SJGpH0TzXBclt0rU765HncETPdcws8E6s2unYTc9d7zn2d/gNLMyrNLW7YDCMjJs
         FWEGuVlnUkMNhPsTAAZMqMYeq4SrN9532ksG1phwXpjF5MUjy5/jcz3sigjvHa6ikOmr
         tI4aLrNC2+JC5AyjJxOJZHkva/k8qHhS2RC1bwSkyPZJgO+qRqsnLZdqALpaFG2d7WP0
         CV8w==
X-Gm-Message-State: AOAM532Od9f5z8L3iReFxPULzI8+Z8OyT9CTGJLPOkfdikjj+LbBmlqp
        SlJoQIkVHF8Xh00RCrIVyzLq4bDeLtk=
X-Google-Smtp-Source: ABdhPJwkOlv6iqPzRfCmqJcqnIwyeDhMhltyXzYf9LIs3KMcu6KoLeczp5qQzEyCvGnfI3ZGbERAYw==
X-Received: by 2002:adf:f084:: with SMTP id n4mr9818633wro.26.1601568672199;
        Thu, 01 Oct 2020 09:11:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm10401251wrb.91.2020.10.01.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:11 -0700 (PDT)
Message-Id: <757dd30fe2cdd19affc0208d8e8091d12810af80.1601568664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:10:57 +0000
Subject: [PATCH v2 07/13] reftable: reading/writing blocks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Includes a code snippet copied from zlib

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |   3 +
 reftable/.gitattributes  |   1 +
 reftable/block.c         | 441 +++++++++++++++++++++++++++++++++++++++
 reftable/block.h         | 129 ++++++++++++
 reftable/block_test.c    | 158 ++++++++++++++
 reftable/zlib-compat.c   |  92 ++++++++
 t/helper/test-reftable.c |   1 +
 7 files changed, 825 insertions(+)
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/zlib-compat.c

diff --git a/Makefile b/Makefile
index b5e43d79ed..eda92b00ef 100644
--- a/Makefile
+++ b/Makefile
@@ -2373,12 +2373,15 @@ XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
 
 REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/compat.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/strbuf.o
+REFTABLE_OBJS += reftable/zlib-compat.o
 
+REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/strbuf_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 0000000000..f44451a379
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
diff --git a/reftable/block.c b/reftable/block.c
new file mode 100644
index 0000000000..d49e80df7c
--- /dev/null
+++ b/reftable/block.c
@@ -0,0 +1,441 @@
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
+#include "reftable.h"
+#include "system.h"
+#include "zlib.h"
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
+		if (Z_OK != uncompress_return_consumed(
+				    uncompressed + block_header_skip, &dst_len,
+				    block->data + block_header_skip,
+				    &src_len)) {
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
+	struct restart_find_args *a = (struct restart_find_args *)args;
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
+void block_writer_clear(struct block_writer *bw)
+{
+	FREE_AND_NULL(bw->restarts);
+	strbuf_release(&bw->last_key);
+	/* the block is not owned. */
+}
+
+void reftable_block_done(struct reftable_block *blockp)
+{
+	struct reftable_block_source source = blockp->source;
+	if (blockp != NULL && source.ops != NULL)
+		source.ops->return_block(source.arg, blockp);
+	blockp->data = NULL;
+	blockp->len = 0;
+	blockp->source.ops = NULL;
+	blockp->source.arg = NULL;
+}
diff --git a/reftable/block.h b/reftable/block.h
new file mode 100644
index 0000000000..14a6f835f4
--- /dev/null
+++ b/reftable/block.h
@@ -0,0 +1,129 @@
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
+#include "reftable.h"
+
+/*
+  Writes reftable blocks. The block_writer is reused across blocks to minimize
+  allocation overhead.
+*/
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
+  initializes the blockwriter to write `typ` entries, using `buf` as temporary
+  storage. `buf` is not owned by the block_writer. */
+void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+		       uint32_t block_size, uint32_t header_off, int hash_size);
+
+/*
+  returns the block type (eg. 'r' for ref records.
+*/
+uint8_t block_writer_type(struct block_writer *bw);
+
+/* appends the record, or -1 if it doesn't fit. */
+int block_writer_add(struct block_writer *w, struct reftable_record *rec);
+
+/* appends the key restarts, and compress the block if necessary. */
+int block_writer_finish(struct block_writer *w);
+
+/* clears out internally allocated block_writer members. */
+void block_writer_clear(struct block_writer *bw);
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
index 0000000000..2fa8ca9831
--- /dev/null
+++ b/reftable/block_test.c
@@ -0,0 +1,158 @@
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
+
+#include "blocksource.h"
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct binsearch_args {
+	int key;
+	int *arr;
+};
+
+static int binsearch_func(size_t i, void *void_args)
+{
+	struct binsearch_args *args = (struct binsearch_args *)void_args;
+
+	return args->key < args->arr[i];
+}
+
+static void test_binsearch(void)
+{
+	int arr[] = { 2, 4, 6, 8, 10 };
+	size_t sz = ARRAY_SIZE(arr);
+	struct binsearch_args args = {
+		.arr = arr,
+	};
+
+	int i = 0;
+	for (i = 1; i < 11; i++) {
+		int res;
+		args.key = i;
+		res = binsearch(sz, &binsearch_func, &args);
+
+		if (res < sz) {
+			assert(args.key < arr[res]);
+			if (res > 0) {
+				assert(args.key >= arr[res - 1]);
+			}
+		} else {
+			assert(args.key == 10 || args.key == 11);
+		}
+	}
+}
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
+			  header_off, hash_size(SHA1_ID));
+	reftable_record_from_ref(&rec, &ref);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		uint8_t hash[SHA1_SIZE];
+		snprintf(name, sizeof(name), "branch%02d", i);
+		memset(hash, i, sizeof(hash));
+
+		ref.refname = name;
+		ref.value = hash;
+		names[i] = xstrdup(name);
+		n = block_writer_add(&bw, &rec);
+		ref.refname = NULL;
+		ref.value = NULL;
+		assert(n == 0);
+	}
+
+	n = block_writer_finish(&bw);
+	assert(n > 0);
+
+	block_writer_clear(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
+
+	block_reader_start(&br, &it);
+
+	while (1) {
+		int r = block_iter_next(&it, &rec);
+		assert(r >= 0);
+		if (r > 0) {
+			break;
+		}
+		assert_streq(names[j], ref.refname);
+		j++;
+	}
+
+	reftable_record_clear(&rec);
+	block_iter_close(&it);
+
+	for (i = 0; i < N; i++) {
+		struct block_iter it = { .last_key = STRBUF_INIT };
+		strbuf_reset(&want);
+		strbuf_addstr(&want, names[i]);
+
+		n = block_reader_seek(&br, &it, &want);
+		assert(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		assert(n == 0);
+
+		assert_streq(names[i], ref.refname);
+
+		want.len--;
+		n = block_reader_seek(&br, &it, &want);
+		assert(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		assert(n == 0);
+		assert_streq(names[10 * (i / 10)], ref.refname);
+
+		block_iter_close(&it);
+	}
+
+	reftable_record_clear(&rec);
+	reftable_block_done(&br.block);
+	strbuf_release(&want);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+}
+
+int block_test_main(int argc, const char *argv[])
+{
+	add_test_case("binsearch", &test_binsearch);
+	add_test_case("block_read_write", &test_block_read_write);
+	return test_main(argc, argv);
+}
diff --git a/reftable/zlib-compat.c b/reftable/zlib-compat.c
new file mode 100644
index 0000000000..3e0b0f24f1
--- /dev/null
+++ b/reftable/zlib-compat.c
@@ -0,0 +1,92 @@
+/* taken from zlib's uncompr.c
+
+   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
+   Author: Mark Adler <madler@alumni.caltech.edu>
+   Date:   Sun Jan 15 09:18:46 2017 -0800
+
+       zlib 1.2.11
+
+*/
+
+/*
+ * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
+ * For conditions of distribution and use, see copyright notice in zlib.h
+ */
+
+#include "system.h"
+
+/* clang-format off */
+
+/* ===========================================================================
+     Decompresses the source buffer into the destination buffer.  *sourceLen is
+   the byte length of the source buffer. Upon entry, *destLen is the total size
+   of the destination buffer, which must be large enough to hold the entire
+   uncompressed data. (The size of the uncompressed data must have been saved
+   previously by the compressor and transmitted to the decompressor by some
+   mechanism outside the scope of this compression library.) Upon exit,
+   *destLen is the size of the decompressed data and *sourceLen is the number
+   of source bytes consumed. Upon return, source + *sourceLen points to the
+   first unused input byte.
+
+     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
+   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
+   Z_DATA_ERROR if the input data was corrupted, including if the input data is
+   an incomplete zlib stream.
+*/
+int ZEXPORT uncompress_return_consumed (
+    Bytef *dest,
+    uLongf *destLen,
+    const Bytef *source,
+    uLong *sourceLen) {
+    z_stream stream;
+    int err;
+    const uInt max = (uInt)-1;
+    uLong len, left;
+    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
+
+    len = *sourceLen;
+    if (*destLen) {
+        left = *destLen;
+        *destLen = 0;
+    }
+    else {
+        left = 1;
+        dest = buf;
+    }
+
+    stream.next_in = (z_const Bytef *)source;
+    stream.avail_in = 0;
+    stream.zalloc = (alloc_func)0;
+    stream.zfree = (free_func)0;
+    stream.opaque = (voidpf)0;
+
+    err = inflateInit(&stream);
+    if (err != Z_OK) return err;
+
+    stream.next_out = dest;
+    stream.avail_out = 0;
+
+    do {
+        if (stream.avail_out == 0) {
+            stream.avail_out = left > (uLong)max ? max : (uInt)left;
+            left -= stream.avail_out;
+        }
+        if (stream.avail_in == 0) {
+            stream.avail_in = len > (uLong)max ? max : (uInt)len;
+            len -= stream.avail_in;
+        }
+        err = inflate(&stream, Z_NO_FLUSH);
+    } while (err == Z_OK);
+
+    *sourceLen -= len + stream.avail_in;
+    if (dest != buf)
+        *destLen = stream.total_out;
+    else if (stream.total_out && err == Z_BUF_ERROR)
+        left = 1;
+
+    inflateEnd(&stream);
+    return err == Z_STREAM_END ? Z_OK :
+           err == Z_NEED_DICT ? Z_DATA_ERROR  :
+           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
+           err;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9341272089..81a9bd5667 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,6 +3,7 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	block_test_main(argc, argv);
 	record_test_main(argc, argv);
 	strbuf_test_main(argc, argv);
 	return 0;
-- 
gitgitgadget

