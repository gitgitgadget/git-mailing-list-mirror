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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE6DC43331
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9215864F84
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhCLUUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhCLUUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB8C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so12938103wmj.2
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mEYY5RFnABjUdPQXwEeopErjgHJtth0stDmGGwAAgSY=;
        b=BrPDShSj5Oo6K7lxM9geoDmhd4VWS4Oue96yIrCGQqvmpM4vVdG6gdnRQ19NW6gldR
         63iJqZ2Xzdg4VBjX3mGWwUNu/vBcvG5tDkWEmkrDNfsTFgR70W2Y5C8Cx/oQvs1DQ4Qa
         Z6tB0sGP2O835NCfQsYbnxldPbocF5LS7eW1fwr+/dJ6Hu0nLbqXnliOTIczcyl7B6cE
         3Llz7zikhy8tKVt8fYRRTHvw3yIk79yPcFjyoAqY1ebRuZ0cvodv4GWauJZ9hQ3XcOOF
         Uqcku0W0MFPPFMrgwnBMFV3+M9OjWzSUNPHxcLl0tQk/3PIZz3mQna5CCGCkx/jgR0na
         RCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mEYY5RFnABjUdPQXwEeopErjgHJtth0stDmGGwAAgSY=;
        b=Vi7Tj9y20esWzRRebo32C0kJiMlRK1EtL13mLw9GNcI1N7lKiZ46v62JsD8dN1kSB/
         fKUZdS/Zr3Yt+baVUygIW7nXsAN/AvdSPbapdRiVR1Ejq2H2WJGMnLBuaA+YCc0dmrII
         EaWnbCxwa/IFHl4nEcZuuT9o+sNjz+D5SAMb7cBMgoDrAjugVnM/Sddfkq8FsYuSsX4l
         VgPwg0iS0uQ7hESpTbzZoiTayYpdDp9dntsVea5MGJ/lXI1oBxqh8C7dquoHy5eCI1eD
         vYsiABWC+o4/cmzyc+LlcOVgu7tE6uAWrsRyzZfC/YUIsSfjAzdCjRsYgIXoC/sbUjS8
         c6LA==
X-Gm-Message-State: AOAM532taFBkZnOMEglDVUHx/a11x7Tb3692Sl3JSQBaHcYFI+j9USFJ
        ZtOY17C4/5U4UaxBzfZaTw9p9zBj9pU=
X-Google-Smtp-Source: ABdhPJyb9ZPdSmHjN1/1c03LXtQfF8LxgDtplbeFqYGE4xF385DVKGydnxmSnDFipWrWbEv0VAzyOA==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr14760541wma.80.1615580405587;
        Fri, 12 Mar 2021 12:20:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a131sm3503084wmc.48.2021.03.12.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:20:05 -0800 (PST)
Message-Id: <f2f005afca192b0d9b0fc878ca40f3bbed53a28d.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:50 +0000
Subject: [PATCH v5 09/15] reftable: write reftable files
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                   |   1 +
 reftable/reftable-writer.h | 147 ++++++++
 reftable/writer.c          | 691 +++++++++++++++++++++++++++++++++++++
 reftable/writer.h          |  50 +++
 4 files changed, 889 insertions(+)
 create mode 100644 reftable/reftable-writer.h
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h

diff --git a/Makefile b/Makefile
index 57a61b359ea7..d37dd79bfab7 100644
--- a/Makefile
+++ b/Makefile
@@ -2389,6 +2389,7 @@ REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/tree.o
+REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
new file mode 100644
index 000000000000..9d2f8d605558
--- /dev/null
+++ b/reftable/reftable-writer.h
@@ -0,0 +1,147 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_WRITER_H
+#define REFTABLE_WRITER_H
+
+#include <stdint.h>
+
+#include "reftable-record.h"
+
+/* Writing single reftables */
+
+/* reftable_write_options sets options for writing a single reftable. */
+struct reftable_write_options {
+	/* boolean: do not pad out blocks to block size. */
+	unsigned unpadded : 1;
+
+	/* the blocksize. Should be less than 2^24. */
+	uint32_t block_size;
+
+	/* boolean: do not generate a SHA1 => ref index. */
+	unsigned skip_index_objects : 1;
+
+	/* how often to write complete keys in each block. */
+	int restart_interval;
+
+	/* 4-byte identifier ("sha1", "s256") of the hash.
+	 * Defaults to SHA1 if unset
+	 */
+	uint32_t hash_id;
+
+	/* boolean: do not check ref names for validity or dir/file conflicts.
+	 */
+	unsigned skip_name_check : 1;
+
+	/* boolean: copy log messages exactly. If unset, check that the message
+	 *   is a single line, and add '\n' if missing.
+	 */
+	unsigned exact_log_message : 1;
+};
+
+/* reftable_block_stats holds statistics for a single block type */
+struct reftable_block_stats {
+	/* total number of entries written */
+	int entries;
+	/* total number of key restarts */
+	int restarts;
+	/* total number of blocks */
+	int blocks;
+	/* total number of index blocks */
+	int index_blocks;
+	/* depth of the index */
+	int max_index_level;
+
+	/* offset of the first block for this type */
+	uint64_t offset;
+	/* offset of the top level index block for this type, or 0 if not
+	 * present */
+	uint64_t index_offset;
+};
+
+/* stats holds overall statistics for a single reftable */
+struct reftable_stats {
+	/* total number of blocks written. */
+	int blocks;
+	/* stats for ref data */
+	struct reftable_block_stats ref_stats;
+	/* stats for the SHA1 to ref map. */
+	struct reftable_block_stats obj_stats;
+	/* stats for index blocks */
+	struct reftable_block_stats idx_stats;
+	/* stats for log blocks */
+	struct reftable_block_stats log_stats;
+
+	/* disambiguation length of shortened object IDs. */
+	int object_id_len;
+};
+
+/* reftable_new_writer creates a new writer */
+struct reftable_writer *
+reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
+		    void *writer_arg, struct reftable_write_options *opts);
+
+/* Set the range of update indices for the records we will add. When writing a
+   table into a stack, the min should be at least
+   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
+
+   For transactional updates to a stack, typically min==max, and the
+   update_index can be obtained by inspeciting the stack. When converting an
+   existing ref database into a single reftable, this would be a range of
+   update-index timestamps.
+ */
+void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+				uint64_t max);
+
+/*
+  Add a reftable_ref_record. The record should have names that come after
+  already added records.
+
+  The update_index must be within the limits set by
+  reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned. It is an
+  REFTABLE_API_ERROR error to write a ref record after a log record.
+*/
+int reftable_writer_add_ref(struct reftable_writer *w,
+			    struct reftable_ref_record *ref);
+
+/*
+  Convenience function to add multiple reftable_ref_records; the function sorts
+  the records before adding them, reordering the records array passed in.
+*/
+int reftable_writer_add_refs(struct reftable_writer *w,
+			     struct reftable_ref_record *refs, int n);
+
+/*
+  adds reftable_log_records. Log records are keyed by (refname, decreasing
+  update_index). The key for the record added must come after the already added
+  log records.
+*/
+int reftable_writer_add_log(struct reftable_writer *w,
+			    struct reftable_log_record *log);
+
+/*
+  Convenience function to add multiple reftable_log_records; the function sorts
+  the records before adding them, reordering records array passed in.
+*/
+int reftable_writer_add_logs(struct reftable_writer *w,
+			     struct reftable_log_record *logs, int n);
+
+/* reftable_writer_close finalizes the reftable. The writer is retained so
+ * statistics can be inspected. */
+int reftable_writer_close(struct reftable_writer *w);
+
+/* writer_stats returns the statistics on the reftable being written.
+
+   This struct becomes invalid when the writer is freed.
+ */
+const struct reftable_stats *writer_stats(struct reftable_writer *w);
+
+/* reftable_writer_free deallocates memory for the writer */
+void reftable_writer_free(struct reftable_writer *w);
+
+#endif
diff --git a/reftable/writer.c b/reftable/writer.c
new file mode 100644
index 000000000000..d42ca8afac11
--- /dev/null
+++ b/reftable/writer.c
@@ -0,0 +1,691 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "writer.h"
+
+#include "system.h"
+
+#include "block.h"
+#include "constants.h"
+#include "record.h"
+#include "tree.h"
+#include "reftable-error.h"
+
+/* finishes a block, and writes it to storage */
+static int writer_flush_block(struct reftable_writer *w);
+
+/* deallocates memory related to the index */
+static void writer_clear_index(struct reftable_writer *w);
+
+/* finishes writing a 'r' (refs) or 'g' (reflogs) section */
+static int writer_finish_public_section(struct reftable_writer *w);
+
+static struct reftable_block_stats *
+writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
+{
+	switch (typ) {
+	case 'r':
+		return &w->stats.ref_stats;
+	case 'o':
+		return &w->stats.obj_stats;
+	case 'i':
+		return &w->stats.idx_stats;
+	case 'g':
+		return &w->stats.log_stats;
+	}
+	abort();
+	return NULL;
+}
+
+/* write data, queuing the padding for the next write. Returns negative for
+ * error. */
+static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
+			int padding)
+{
+	int n = 0;
+	if (w->pending_padding > 0) {
+		uint8_t *zeroed = reftable_calloc(w->pending_padding);
+		int n = w->write(w->write_arg, zeroed, w->pending_padding);
+		if (n < 0)
+			return n;
+
+		w->pending_padding = 0;
+		reftable_free(zeroed);
+	}
+
+	w->pending_padding = padding;
+	n = w->write(w->write_arg, data, len);
+	if (n < 0)
+		return n;
+	n += padding;
+	return 0;
+}
+
+static void options_set_defaults(struct reftable_write_options *opts)
+{
+	if (opts->restart_interval == 0) {
+		opts->restart_interval = 16;
+	}
+
+	if (opts->hash_id == 0) {
+		opts->hash_id = SHA1_ID;
+	}
+	if (opts->block_size == 0) {
+		opts->block_size = DEFAULT_BLOCK_SIZE;
+	}
+}
+
+static int writer_version(struct reftable_writer *w)
+{
+	return (w->opts.hash_id == 0 || w->opts.hash_id == SHA1_ID) ? 1 : 2;
+}
+
+static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
+{
+	memcpy((char *)dest, "REFT", 4);
+
+	dest[4] = writer_version(w);
+
+	put_be24(dest + 5, w->opts.block_size);
+	put_be64(dest + 8, w->min_update_index);
+	put_be64(dest + 16, w->max_update_index);
+	if (writer_version(w) == 2) {
+		put_be32(dest + 24, w->opts.hash_id);
+	}
+	return header_size(writer_version(w));
+}
+
+static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
+{
+	int block_start = 0;
+	if (w->next == 0) {
+		block_start = header_size(writer_version(w));
+	}
+
+	strbuf_release(&w->last_key);
+	block_writer_init(&w->block_writer_data, typ, w->block,
+			  w->opts.block_size, block_start,
+			  hash_size(w->opts.hash_id));
+	w->block_writer = &w->block_writer_data;
+	w->block_writer->restart_interval = w->opts.restart_interval;
+}
+
+static struct strbuf reftable_empty_strbuf = STRBUF_INIT;
+
+struct reftable_writer *
+reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
+		    void *writer_arg, struct reftable_write_options *opts)
+{
+	struct reftable_writer *wp =
+		reftable_calloc(sizeof(struct reftable_writer));
+	strbuf_init(&wp->block_writer_data.last_key, 0);
+	options_set_defaults(opts);
+	if (opts->block_size >= (1 << 24)) {
+		/* TODO - error return? */
+		abort();
+	}
+	wp->last_key = reftable_empty_strbuf;
+	wp->block = reftable_calloc(opts->block_size);
+	wp->write = writer_func;
+	wp->write_arg = writer_arg;
+	wp->opts = *opts;
+	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
+
+	return wp;
+}
+
+void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+				uint64_t max)
+{
+	w->min_update_index = min;
+	w->max_update_index = max;
+}
+
+void reftable_writer_free(struct reftable_writer *w)
+{
+	reftable_free(w->block);
+	reftable_free(w);
+}
+
+struct obj_index_tree_node {
+	struct strbuf hash;
+	uint64_t *offsets;
+	size_t offset_len;
+	size_t offset_cap;
+};
+
+#define OBJ_INDEX_TREE_NODE_INIT    \
+	{                           \
+		.hash = STRBUF_INIT \
+	}
+
+static int obj_index_tree_node_compare(const void *a, const void *b)
+{
+	return strbuf_cmp(&((const struct obj_index_tree_node *)a)->hash,
+			  &((const struct obj_index_tree_node *)b)->hash);
+}
+
+static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
+{
+	uint64_t off = w->next;
+
+	struct obj_index_tree_node want = { .hash = *hash };
+
+	struct tree_node *node = tree_search(&want, &w->obj_index_tree,
+					     &obj_index_tree_node_compare, 0);
+	struct obj_index_tree_node *key = NULL;
+	if (node == NULL) {
+		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
+		key = reftable_malloc(sizeof(struct obj_index_tree_node));
+		*key = empty;
+
+		strbuf_reset(&key->hash);
+		strbuf_addbuf(&key->hash, hash);
+		tree_search((void *)key, &w->obj_index_tree,
+			    &obj_index_tree_node_compare, 1);
+	} else {
+		key = node->key;
+	}
+
+	if (key->offset_len > 0 && key->offsets[key->offset_len - 1] == off) {
+		return;
+	}
+
+	if (key->offset_len == key->offset_cap) {
+		key->offset_cap = 2 * key->offset_cap + 1;
+		key->offsets = reftable_realloc(
+			key->offsets, sizeof(uint64_t) * key->offset_cap);
+	}
+
+	key->offsets[key->offset_len++] = off;
+}
+
+static int writer_add_record(struct reftable_writer *w,
+			     struct reftable_record *rec)
+{
+	int result = -1;
+	struct strbuf key = STRBUF_INIT;
+	int err = 0;
+	reftable_record_key(rec, &key);
+	if (strbuf_cmp(&w->last_key, &key) >= 0)
+		goto done;
+
+	strbuf_reset(&w->last_key);
+	strbuf_addbuf(&w->last_key, &key);
+	if (w->block_writer == NULL) {
+		writer_reinit_block_writer(w, reftable_record_type(rec));
+	}
+
+	assert(block_writer_type(w->block_writer) == reftable_record_type(rec));
+
+	if (block_writer_add(w->block_writer, rec) == 0) {
+		result = 0;
+		goto done;
+	}
+
+	err = writer_flush_block(w);
+	if (err < 0) {
+		result = err;
+		goto done;
+	}
+
+	writer_reinit_block_writer(w, reftable_record_type(rec));
+	err = block_writer_add(w->block_writer, rec);
+	if (err < 0) {
+		result = err;
+		goto done;
+	}
+
+	result = 0;
+done:
+	strbuf_release(&key);
+	return result;
+}
+
+int reftable_writer_add_ref(struct reftable_writer *w,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { NULL };
+	struct reftable_ref_record copy = *ref;
+	int err = 0;
+
+	if (ref->refname == NULL)
+		return REFTABLE_API_ERROR;
+	if (ref->update_index < w->min_update_index ||
+	    ref->update_index > w->max_update_index)
+		return REFTABLE_API_ERROR;
+
+	reftable_record_from_ref(&rec, &copy);
+	copy.update_index -= w->min_update_index;
+
+	err = writer_add_record(w, &rec);
+	if (err < 0)
+		return err;
+
+	if (!w->opts.skip_index_objects &&
+	    reftable_ref_record_val1(ref) != NULL) {
+		struct strbuf h = STRBUF_INIT;
+		strbuf_add(&h, (char *)reftable_ref_record_val1(ref),
+			   hash_size(w->opts.hash_id));
+		writer_index_hash(w, &h);
+		strbuf_release(&h);
+	}
+
+	if (!w->opts.skip_index_objects &&
+	    reftable_ref_record_val2(ref) != NULL) {
+		struct strbuf h = STRBUF_INIT;
+		strbuf_add(&h, reftable_ref_record_val2(ref),
+			   hash_size(w->opts.hash_id));
+		writer_index_hash(w, &h);
+		strbuf_release(&h);
+	}
+	return 0;
+}
+
+int reftable_writer_add_refs(struct reftable_writer *w,
+			     struct reftable_ref_record *refs, int n)
+{
+	int err = 0;
+	int i = 0;
+	QSORT(refs, n, reftable_ref_record_compare_name);
+	for (i = 0; err == 0 && i < n; i++) {
+		err = reftable_writer_add_ref(w, &refs[i]);
+	}
+	return err;
+}
+
+static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
+					    struct reftable_log_record *log)
+{
+	struct reftable_record rec = { NULL };
+	if (w->block_writer != NULL &&
+	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
+		int err = writer_finish_public_section(w);
+		if (err < 0)
+			return err;
+	}
+
+	w->next -= w->pending_padding;
+	w->pending_padding = 0;
+
+	reftable_record_from_log(&rec, log);
+	return writer_add_record(w, &rec);
+}
+
+int reftable_writer_add_log(struct reftable_writer *w,
+			    struct reftable_log_record *log)
+{
+	char *input_log_message = NULL;
+	struct strbuf cleaned_message = STRBUF_INIT;
+	int err = 0;
+
+	if (log->value_type == REFTABLE_LOG_DELETION)
+		return reftable_writer_add_log_verbatim(w, log);
+
+	if (log->refname == NULL)
+		return REFTABLE_API_ERROR;
+
+	input_log_message = log->update.message;
+	if (!w->opts.exact_log_message && log->update.message != NULL) {
+		strbuf_addstr(&cleaned_message, log->update.message);
+		while (cleaned_message.len &&
+		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
+			strbuf_setlen(&cleaned_message,
+				      cleaned_message.len - 1);
+		if (strchr(cleaned_message.buf, '\n')) {
+			// multiple lines not allowed.
+			err = REFTABLE_API_ERROR;
+			goto done;
+		}
+		strbuf_addstr(&cleaned_message, "\n");
+		log->update.message = cleaned_message.buf;
+	}
+
+	err = reftable_writer_add_log_verbatim(w, log);
+	log->update.message = input_log_message;
+done:
+	strbuf_release(&cleaned_message);
+	return err;
+}
+
+int reftable_writer_add_logs(struct reftable_writer *w,
+			     struct reftable_log_record *logs, int n)
+{
+	int err = 0;
+	int i = 0;
+	QSORT(logs, n, reftable_log_record_compare_key);
+
+	for (i = 0; err == 0 && i < n; i++) {
+		err = reftable_writer_add_log(w, &logs[i]);
+	}
+	return err;
+}
+
+static int writer_finish_section(struct reftable_writer *w)
+{
+	uint8_t typ = block_writer_type(w->block_writer);
+	uint64_t index_start = 0;
+	int max_level = 0;
+	int threshold = w->opts.unpadded ? 1 : 3;
+	int before_blocks = w->stats.idx_stats.blocks;
+	int err = writer_flush_block(w);
+	int i = 0;
+	struct reftable_block_stats *bstats = NULL;
+	if (err < 0)
+		return err;
+
+	while (w->index_len > threshold) {
+		struct reftable_index_record *idx = NULL;
+		int idx_len = 0;
+
+		max_level++;
+		index_start = w->next;
+		writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+		idx = w->index;
+		idx_len = w->index_len;
+
+		w->index = NULL;
+		w->index_len = 0;
+		w->index_cap = 0;
+		for (i = 0; i < idx_len; i++) {
+			struct reftable_record rec = { NULL };
+			reftable_record_from_index(&rec, idx + i);
+			if (block_writer_add(w->block_writer, &rec) == 0) {
+				continue;
+			}
+
+			err = writer_flush_block(w);
+			if (err < 0)
+				return err;
+
+			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+			err = block_writer_add(w->block_writer, &rec);
+			if (err != 0) {
+				/* write into fresh block should always succeed
+				 */
+				abort();
+			}
+		}
+		for (i = 0; i < idx_len; i++) {
+			strbuf_release(&idx[i].last_key);
+		}
+		reftable_free(idx);
+	}
+
+	writer_clear_index(w);
+
+	err = writer_flush_block(w);
+	if (err < 0)
+		return err;
+
+	bstats = writer_reftable_block_stats(w, typ);
+	bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
+	bstats->index_offset = index_start;
+	bstats->max_index_level = max_level;
+
+	/* Reinit lastKey, as the next section can start with any key. */
+	w->last_key.len = 0;
+
+	return 0;
+}
+
+struct common_prefix_arg {
+	struct strbuf *last;
+	int max;
+};
+
+static void update_common(void *void_arg, void *key)
+{
+	struct common_prefix_arg *arg = (struct common_prefix_arg *)void_arg;
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+	if (arg->last != NULL) {
+		int n = common_prefix_size(&entry->hash, arg->last);
+		if (n > arg->max) {
+			arg->max = n;
+		}
+	}
+	arg->last = &entry->hash;
+}
+
+struct write_record_arg {
+	struct reftable_writer *w;
+	int err;
+};
+
+static void write_object_record(void *void_arg, void *key)
+{
+	struct write_record_arg *arg = (struct write_record_arg *)void_arg;
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+	struct reftable_obj_record obj_rec = {
+		.hash_prefix = (uint8_t *)entry->hash.buf,
+		.hash_prefix_len = arg->w->stats.object_id_len,
+		.offsets = entry->offsets,
+		.offset_len = entry->offset_len,
+	};
+	struct reftable_record rec = { NULL };
+	if (arg->err < 0)
+		goto done;
+
+	reftable_record_from_obj(&rec, &obj_rec);
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+	if (arg->err == 0)
+		goto done;
+
+	arg->err = writer_flush_block(arg->w);
+	if (arg->err < 0)
+		goto done;
+
+	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+	if (arg->err == 0)
+		goto done;
+	obj_rec.offset_len = 0;
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+
+	/* Should be able to write into a fresh block. */
+	assert(arg->err == 0);
+
+done:;
+}
+
+static void object_record_free(void *void_arg, void *key)
+{
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+
+	FREE_AND_NULL(entry->offsets);
+	strbuf_release(&entry->hash);
+	reftable_free(entry);
+}
+
+static int writer_dump_object_index(struct reftable_writer *w)
+{
+	struct write_record_arg closure = { .w = w };
+	struct common_prefix_arg common = { NULL };
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &update_common, &common);
+	}
+	w->stats.object_id_len = common.max + 1;
+
+	writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &write_object_record, &closure);
+	}
+
+	if (closure.err < 0)
+		return closure.err;
+	return writer_finish_section(w);
+}
+
+static int writer_finish_public_section(struct reftable_writer *w)
+{
+	uint8_t typ = 0;
+	int err = 0;
+
+	if (w->block_writer == NULL)
+		return 0;
+
+	typ = block_writer_type(w->block_writer);
+	err = writer_finish_section(w);
+	if (err < 0)
+		return err;
+	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+	    w->stats.ref_stats.index_blocks > 0) {
+		err = writer_dump_object_index(w);
+		if (err < 0)
+			return err;
+	}
+
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &object_record_free, NULL);
+		tree_free(w->obj_index_tree);
+		w->obj_index_tree = NULL;
+	}
+
+	w->block_writer = NULL;
+	return 0;
+}
+
+int reftable_writer_close(struct reftable_writer *w)
+{
+	uint8_t footer[72];
+	uint8_t *p = footer;
+	int err = writer_finish_public_section(w);
+	int empty_table = w->next == 0;
+	if (err != 0)
+		goto done;
+	w->pending_padding = 0;
+	if (empty_table) {
+		/* Empty tables need a header anyway. */
+		uint8_t header[28];
+		int n = writer_write_header(w, header);
+		err = padded_write(w, header, n, 0);
+		if (err < 0)
+			goto done;
+	}
+
+	p += writer_write_header(w, footer);
+	put_be64(p, w->stats.ref_stats.index_offset);
+	p += 8;
+	put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
+	p += 8;
+	put_be64(p, w->stats.obj_stats.index_offset);
+	p += 8;
+
+	put_be64(p, w->stats.log_stats.offset);
+	p += 8;
+	put_be64(p, w->stats.log_stats.index_offset);
+	p += 8;
+
+	put_be32(p, crc32(0, footer, p - footer));
+	p += 4;
+
+	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
+	if (err < 0)
+		goto done;
+
+	if (empty_table) {
+		err = REFTABLE_EMPTY_TABLE_ERROR;
+		goto done;
+	}
+
+done:
+	/* free up memory. */
+	block_writer_release(&w->block_writer_data);
+	writer_clear_index(w);
+	strbuf_release(&w->last_key);
+	return err;
+}
+
+static void writer_clear_index(struct reftable_writer *w)
+{
+	int i = 0;
+	for (i = 0; i < w->index_len; i++) {
+		strbuf_release(&w->index[i].last_key);
+	}
+
+	FREE_AND_NULL(w->index);
+	w->index_len = 0;
+	w->index_cap = 0;
+}
+
+static const int debug = 0;
+
+static int writer_flush_nonempty_block(struct reftable_writer *w)
+{
+	uint8_t typ = block_writer_type(w->block_writer);
+	struct reftable_block_stats *bstats =
+		writer_reftable_block_stats(w, typ);
+	uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
+	int raw_bytes = block_writer_finish(w->block_writer);
+	int padding = 0;
+	int err = 0;
+	struct reftable_index_record ir = { .last_key = STRBUF_INIT };
+	if (raw_bytes < 0)
+		return raw_bytes;
+
+	if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG) {
+		padding = w->opts.block_size - raw_bytes;
+	}
+
+	if (block_typ_off > 0) {
+		bstats->offset = block_typ_off;
+	}
+
+	bstats->entries += w->block_writer->entries;
+	bstats->restarts += w->block_writer->restart_len;
+	bstats->blocks++;
+	w->stats.blocks++;
+
+	if (debug) {
+		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
+			w->next, raw_bytes,
+			get_be24(w->block + w->block_writer->header_off + 1));
+	}
+
+	if (w->next == 0) {
+		writer_write_header(w, w->block);
+	}
+
+	err = padded_write(w, w->block, raw_bytes, padding);
+	if (err < 0)
+		return err;
+
+	if (w->index_cap == w->index_len) {
+		w->index_cap = 2 * w->index_cap + 1;
+		w->index = reftable_realloc(
+			w->index,
+			sizeof(struct reftable_index_record) * w->index_cap);
+	}
+
+	ir.offset = w->next;
+	strbuf_reset(&ir.last_key);
+	strbuf_addbuf(&ir.last_key, &w->block_writer->last_key);
+	w->index[w->index_len] = ir;
+
+	w->index_len++;
+	w->next += padding + raw_bytes;
+	w->block_writer = NULL;
+	return 0;
+}
+
+static int writer_flush_block(struct reftable_writer *w)
+{
+	if (w->block_writer == NULL)
+		return 0;
+	if (w->block_writer->entries == 0)
+		return 0;
+	return writer_flush_nonempty_block(w);
+}
+
+const struct reftable_stats *writer_stats(struct reftable_writer *w)
+{
+	return &w->stats;
+}
diff --git a/reftable/writer.h b/reftable/writer.h
new file mode 100644
index 000000000000..4921c249d06b
--- /dev/null
+++ b/reftable/writer.h
@@ -0,0 +1,50 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef WRITER_H
+#define WRITER_H
+
+#include "basics.h"
+#include "block.h"
+#include "tree.h"
+#include "reftable-writer.h"
+
+struct reftable_writer {
+	int (*write)(void *, const void *, size_t);
+	void *write_arg;
+	int pending_padding;
+	struct strbuf last_key;
+
+	/* offset of next block to write. */
+	uint64_t next;
+	uint64_t min_update_index, max_update_index;
+	struct reftable_write_options opts;
+
+	/* memory buffer for writing */
+	uint8_t *block;
+
+	/* writer for the current section. NULL or points to
+	 * block_writer_data */
+	struct block_writer *block_writer;
+
+	struct block_writer block_writer_data;
+
+	/* pending index records for the current section */
+	struct reftable_index_record *index;
+	size_t index_len;
+	size_t index_cap;
+
+	/*
+	 * tree for use with tsearch; used to populate the 'o' inverse OID
+	 * map */
+	struct tree_node *obj_index_tree;
+
+	struct reftable_stats stats;
+};
+
+#endif
-- 
gitgitgadget

