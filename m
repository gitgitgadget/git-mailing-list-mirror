Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3620610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbhIISud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbhIIStO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D8C061793
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v10so3964114wrd.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0/Vjg5v3P17c/IL6O7TPWcCD3rMJthZoqILA+ZQv7OQ=;
        b=NIwWNeFoVHNKrK2B4L1rYnOaqXCld93IsceA2wDEA4VW+wB0dkq+qQsnKWy6TTxRSb
         uHxApY3CETKdZLf6Im7VckVtHeEmwTWoZMPyTSl6hWrVB9D10QBlhFYlPWCkuIIrxMLc
         2pwSvQ8d/FHoq+RZXLaMaJi6fZYlPmEYEv/uQ9nTOlvpgIbrjCxFWICUkbJHEe7Z98/w
         +6Op6Ch0nzCzCyKAHeOuNj/CBpxOKomwZDY/WUnmWXcDVhSWqAGpHEL0M6jwZhR0f+t+
         Ph9PavDn9RRSVLfN4DNtIEJPOHsr7//oXUmMjNdqW4smnMEdSdCo1Qek4ktJdYrvxvWI
         Mh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0/Vjg5v3P17c/IL6O7TPWcCD3rMJthZoqILA+ZQv7OQ=;
        b=oQUGqLBDOvCLfVF6p83UZsc9vUY9BJ3w6UOASuZfJSoFT98toX4R6Zv8l/clhEcMYi
         kYAFChAhrOFQLRyq6PE5w5YqtenLZH+rtYd8AHdkdZ8SX3FsyVfutfjxmj06qosGwAzk
         F2QazzY9EXrJDJIJaaIjwtGNl8KWWtAPCH5aE7kU64k4QLvlPEVtlum/YvlpFXSm3rqC
         ZuWM5A941pp1UE4QVw6ck4vcTGt64HiTfNapNyYCfITdLwxiJ1oJAowDKHlt5ar9iAth
         /QMMr4llJcxUCEBXYLlEcrGe8EoQ7RnQjee3oDAvm25SG2nSrrQYyCxgBdntuWDSGKtt
         jCUw==
X-Gm-Message-State: AOAM532J2YiZaqLCICjETAuQBbVTLghHG8Cajzotc85iURBWwV0Ikxj7
        Yk4v4Iy0B/gYWw2X3/Wmvhdeqbat9Us=
X-Google-Smtp-Source: ABdhPJycTS6PgAwmjOnwX3JxOMHYAiWLCc5k4xdPo+wIIPsdyh+mMT8HIhokM1w7MlsYdnXZDpaosw==
X-Received: by 2002:adf:fd92:: with SMTP id d18mr5457102wrr.28.1631213275552;
        Thu, 09 Sep 2021 11:47:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm2553414wmi.18.2021.09.09.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:55 -0700 (PDT)
Message-Id: <905ffa58f362c440ccbaf88583420c69f64d0c18.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:40 +0000
Subject: [PATCH v2 15/19] reftable: add merged table view
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This adds an abstract, read-only interface to the ref database.

This primitive is used to construct the read view of the ref database
(the read view is constructed by merging several *.ref files). It also
provides the mechanism to provide a unified view of the refs in the main
repository and the per-worktree refs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                   |   2 +
 reftable/merged.c          | 362 +++++++++++++++++++++++++++++++++++++
 reftable/merged.h          |  35 ++++
 reftable/merged_test.c     | 292 ++++++++++++++++++++++++++++++
 reftable/reftable-merged.h |  72 ++++++++
 t/helper/test-reftable.c   |   1 +
 6 files changed, 764 insertions(+)
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/reftable-merged.h

diff --git a/Makefile b/Makefile
index d2c9b0097a7..27f29779c9a 100644
--- a/Makefile
+++ b/Makefile
@@ -2462,6 +2462,7 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
@@ -2473,6 +2474,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
diff --git a/reftable/merged.c b/reftable/merged.c
new file mode 100644
index 00000000000..e5b53da6db3
--- /dev/null
+++ b/reftable/merged.c
@@ -0,0 +1,362 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include "constants.h"
+#include "iter.h"
+#include "pq.h"
+#include "reader.h"
+#include "record.h"
+#include "generic.h"
+#include "reftable-merged.h"
+#include "reftable-error.h"
+#include "system.h"
+
+static int merged_iter_init(struct merged_iter *mi)
+{
+	int i = 0;
+	for (i = 0; i < mi->stack_len; i++) {
+		struct reftable_record rec = reftable_new_record(mi->typ);
+		int err = iterator_next(&mi->stack[i], &rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			reftable_iterator_destroy(&mi->stack[i]);
+			reftable_record_destroy(&rec);
+		} else {
+			struct pq_entry e = {
+				.rec = rec,
+				.index = i,
+			};
+			merged_iter_pqueue_add(&mi->pq, e);
+		}
+	}
+
+	return 0;
+}
+
+static void merged_iter_close(void *p)
+{
+	struct merged_iter *mi = p;
+	int i = 0;
+	merged_iter_pqueue_release(&mi->pq);
+	for (i = 0; i < mi->stack_len; i++) {
+		reftable_iterator_destroy(&mi->stack[i]);
+	}
+	reftable_free(mi->stack);
+}
+
+static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
+					       size_t idx)
+{
+	struct reftable_record rec = reftable_new_record(mi->typ);
+	struct pq_entry e = {
+		.rec = rec,
+		.index = idx,
+	};
+	int err = iterator_next(&mi->stack[idx], &rec);
+	if (err < 0)
+		return err;
+
+	if (err > 0) {
+		reftable_iterator_destroy(&mi->stack[idx]);
+		reftable_record_destroy(&rec);
+		return 0;
+	}
+
+	merged_iter_pqueue_add(&mi->pq, e);
+	return 0;
+}
+
+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
+{
+	if (iterator_is_null(&mi->stack[idx]))
+		return 0;
+	return merged_iter_advance_nonnull_subiter(mi, idx);
+}
+
+static int merged_iter_next_entry(struct merged_iter *mi,
+				  struct reftable_record *rec)
+{
+	struct strbuf entry_key = STRBUF_INIT;
+	struct pq_entry entry = { 0 };
+	int err = 0;
+
+	if (merged_iter_pqueue_is_empty(mi->pq))
+		return 1;
+
+	entry = merged_iter_pqueue_remove(&mi->pq);
+	err = merged_iter_advance_subiter(mi, entry.index);
+	if (err < 0)
+		return err;
+
+	/*
+	  One can also use reftable as datacenter-local storage, where the ref
+	  database is maintained in globally consistent database (eg.
+	  CockroachDB or Spanner). In this scenario, replication delays together
+	  with compaction may cause newer tables to contain older entries. In
+	  such a deployment, the loop below must be changed to collect all
+	  entries for the same key, and return new the newest one.
+	*/
+	reftable_record_key(&entry.rec, &entry_key);
+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
+		struct strbuf k = STRBUF_INIT;
+		int err = 0, cmp = 0;
+
+		reftable_record_key(&top.rec, &k);
+
+		cmp = strbuf_cmp(&k, &entry_key);
+		strbuf_release(&k);
+
+		if (cmp > 0) {
+			break;
+		}
+
+		merged_iter_pqueue_remove(&mi->pq);
+		err = merged_iter_advance_subiter(mi, top.index);
+		if (err < 0) {
+			return err;
+		}
+		reftable_record_destroy(&top.rec);
+	}
+
+	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+	reftable_record_destroy(&entry.rec);
+	strbuf_release(&entry_key);
+	return 0;
+}
+
+static int merged_iter_next(struct merged_iter *mi, struct reftable_record *rec)
+{
+	while (1) {
+		int err = merged_iter_next_entry(mi, rec);
+		if (err == 0 && mi->suppress_deletions &&
+		    reftable_record_is_deletion(rec)) {
+			continue;
+		}
+
+		return err;
+	}
+}
+
+static int merged_iter_next_void(void *p, struct reftable_record *rec)
+{
+	struct merged_iter *mi = p;
+	if (merged_iter_pqueue_is_empty(mi->pq))
+		return 1;
+
+	return merged_iter_next(mi, rec);
+}
+
+static struct reftable_iterator_vtable merged_iter_vtable = {
+	.next = &merged_iter_next_void,
+	.close = &merged_iter_close,
+};
+
+static void iterator_from_merged_iter(struct reftable_iterator *it,
+				      struct merged_iter *mi)
+{
+	assert(!it->ops);
+	it->iter_arg = mi;
+	it->ops = &merged_iter_vtable;
+}
+
+int reftable_new_merged_table(struct reftable_merged_table **dest,
+			      struct reftable_table *stack, int n,
+			      uint32_t hash_id)
+{
+	struct reftable_merged_table *m = NULL;
+	uint64_t last_max = 0;
+	uint64_t first_min = 0;
+	int i = 0;
+	for (i = 0; i < n; i++) {
+		uint64_t min = reftable_table_min_update_index(&stack[i]);
+		uint64_t max = reftable_table_max_update_index(&stack[i]);
+
+		if (reftable_table_hash_id(&stack[i]) != hash_id) {
+			return REFTABLE_FORMAT_ERROR;
+		}
+		if (i == 0 || min < first_min) {
+			first_min = min;
+		}
+		if (i == 0 || max > last_max) {
+			last_max = max;
+		}
+	}
+
+	m = reftable_calloc(sizeof(struct reftable_merged_table));
+	m->stack = stack;
+	m->stack_len = n;
+	m->min = first_min;
+	m->max = last_max;
+	m->hash_id = hash_id;
+	*dest = m;
+	return 0;
+}
+
+/* clears the list of subtable, without affecting the readers themselves. */
+void merged_table_release(struct reftable_merged_table *mt)
+{
+	FREE_AND_NULL(mt->stack);
+	mt->stack_len = 0;
+}
+
+void reftable_merged_table_free(struct reftable_merged_table *mt)
+{
+	if (!mt) {
+		return;
+	}
+	merged_table_release(mt);
+	reftable_free(mt);
+}
+
+uint64_t
+reftable_merged_table_max_update_index(struct reftable_merged_table *mt)
+{
+	return mt->max;
+}
+
+uint64_t
+reftable_merged_table_min_update_index(struct reftable_merged_table *mt)
+{
+	return mt->min;
+}
+
+static int reftable_table_seek_record(struct reftable_table *tab,
+				      struct reftable_iterator *it,
+				      struct reftable_record *rec)
+{
+	return tab->ops->seek_record(tab->table_arg, it, rec);
+}
+
+static int merged_table_seek_record(struct reftable_merged_table *mt,
+				    struct reftable_iterator *it,
+				    struct reftable_record *rec)
+{
+	struct reftable_iterator *iters = reftable_calloc(
+		sizeof(struct reftable_iterator) * mt->stack_len);
+	struct merged_iter merged = {
+		.stack = iters,
+		.typ = reftable_record_type(rec),
+		.hash_id = mt->hash_id,
+		.suppress_deletions = mt->suppress_deletions,
+	};
+	int n = 0;
+	int err = 0;
+	int i = 0;
+	for (i = 0; i < mt->stack_len && err == 0; i++) {
+		int e = reftable_table_seek_record(&mt->stack[i], &iters[n],
+						   rec);
+		if (e < 0) {
+			err = e;
+		}
+		if (e == 0) {
+			n++;
+		}
+	}
+	if (err < 0) {
+		int i = 0;
+		for (i = 0; i < n; i++) {
+			reftable_iterator_destroy(&iters[i]);
+		}
+		reftable_free(iters);
+		return err;
+	}
+
+	merged.stack_len = n;
+	err = merged_iter_init(&merged);
+	if (err < 0) {
+		merged_iter_close(&merged);
+		return err;
+	} else {
+		struct merged_iter *p =
+			reftable_malloc(sizeof(struct merged_iter));
+		*p = merged;
+		iterator_from_merged_iter(it, p);
+	}
+	return 0;
+}
+
+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *)name,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, &ref);
+	return merged_table_seek_record(mt, it, &rec);
+}
+
+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
+				      struct reftable_iterator *it,
+				      const char *name, uint64_t update_index)
+{
+	struct reftable_log_record log = {
+		.refname = (char *)name,
+		.update_index = update_index,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, &log);
+	return merged_table_seek_record(mt, it, &rec);
+}
+
+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name)
+{
+	uint64_t max = ~((uint64_t)0);
+	return reftable_merged_table_seek_log_at(mt, it, name, max);
+}
+
+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
+{
+	return mt->hash_id;
+}
+
+static int reftable_merged_table_seek_void(void *tab,
+					   struct reftable_iterator *it,
+					   struct reftable_record *rec)
+{
+	return merged_table_seek_record(tab, it, rec);
+}
+
+static uint32_t reftable_merged_table_hash_id_void(void *tab)
+{
+	return reftable_merged_table_hash_id(tab);
+}
+
+static uint64_t reftable_merged_table_min_update_index_void(void *tab)
+{
+	return reftable_merged_table_min_update_index(tab);
+}
+
+static uint64_t reftable_merged_table_max_update_index_void(void *tab)
+{
+	return reftable_merged_table_max_update_index(tab);
+}
+
+static struct reftable_table_vtable merged_table_vtable = {
+	.seek_record = reftable_merged_table_seek_void,
+	.hash_id = reftable_merged_table_hash_id_void,
+	.min_update_index = reftable_merged_table_min_update_index_void,
+	.max_update_index = reftable_merged_table_max_update_index_void,
+};
+
+void reftable_table_from_merged_table(struct reftable_table *tab,
+				      struct reftable_merged_table *merged)
+{
+	assert(!tab->ops);
+	tab->ops = &merged_table_vtable;
+	tab->table_arg = merged;
+}
diff --git a/reftable/merged.h b/reftable/merged.h
new file mode 100644
index 00000000000..8c4d4d58d77
--- /dev/null
+++ b/reftable/merged.h
@@ -0,0 +1,35 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef MERGED_H
+#define MERGED_H
+
+#include "pq.h"
+
+struct reftable_merged_table {
+	struct reftable_table *stack;
+	size_t stack_len;
+	uint32_t hash_id;
+	int suppress_deletions;
+
+	uint64_t min;
+	uint64_t max;
+};
+
+struct merged_iter {
+	struct reftable_iterator *stack;
+	uint32_t hash_id;
+	size_t stack_len;
+	uint8_t typ;
+	int suppress_deletions;
+	struct merged_iter_pqueue pq;
+};
+
+void merged_table_release(struct reftable_merged_table *mt);
+
+#endif
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
new file mode 100644
index 00000000000..da607401141
--- /dev/null
+++ b/reftable/merged_test.c
@@ -0,0 +1,292 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include "system.h"
+
+#include "basics.h"
+#include "blocksource.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-merged.h"
+#include "reftable-tests.h"
+#include "reftable-generic.h"
+#include "reftable-writer.h"
+
+static void write_test_table(struct strbuf *buf,
+			     struct reftable_ref_record refs[], int n)
+{
+	int min = 0xffffffff;
+	int max = 0;
+	int i = 0;
+	int err;
+
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_writer *w = NULL;
+	for (i = 0; i < n; i++) {
+		uint64_t ui = refs[i].update_index;
+		if (ui > max) {
+			max = ui;
+		}
+		if (ui < min) {
+			min = ui;
+		}
+	}
+
+	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
+	reftable_writer_set_limits(w, min, max);
+
+	for (i = 0; i < n; i++) {
+		uint64_t before = refs[i].update_index;
+		int n = reftable_writer_add_ref(w, &refs[i]);
+		EXPECT(n == 0);
+		EXPECT(before == refs[i].update_index);
+	}
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+
+	reftable_writer_free(w);
+}
+
+static struct reftable_merged_table *
+merged_table_from_records(struct reftable_ref_record **refs,
+			  struct reftable_block_source **source,
+			  struct reftable_reader ***readers, int *sizes,
+			  struct strbuf *buf, int n)
+{
+	int i = 0;
+	struct reftable_merged_table *mt = NULL;
+	int err;
+	struct reftable_table *tabs =
+		reftable_calloc(n * sizeof(struct reftable_table));
+	*readers = reftable_calloc(n * sizeof(struct reftable_reader *));
+	*source = reftable_calloc(n * sizeof(**source));
+	for (i = 0; i < n; i++) {
+		write_test_table(&buf[i], refs[i], sizes[i]);
+		block_source_from_strbuf(&(*source)[i], &buf[i]);
+
+		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
+					  "name");
+		EXPECT_ERR(err);
+		reftable_table_from_reader(&tabs[i], (*readers)[i]);
+	}
+
+	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	EXPECT_ERR(err);
+	return mt;
+}
+
+static void readers_destroy(struct reftable_reader **readers, size_t n)
+{
+	int i = 0;
+	for (; i < n; i++)
+		reftable_reader_free(readers[i]);
+	reftable_free(readers);
+}
+
+static void test_merged_between(void)
+{
+	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 0 };
+
+	struct reftable_ref_record r1[] = { {
+		.refname = "b",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = hash1,
+	} };
+	struct reftable_ref_record r2[] = { {
+		.refname = "a",
+		.update_index = 2,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
+
+	struct reftable_ref_record *refs[] = { r1, r2 };
+	int sizes[] = { 1, 1 };
+	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
+	int i;
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	EXPECT_ERR(err);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	EXPECT_ERR(err);
+	EXPECT(ref.update_index == 2);
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	readers_destroy(readers, 2);
+	reftable_merged_table_free(mt);
+	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+		strbuf_release(&bufs[i]);
+	}
+	reftable_free(bs);
+}
+
+static void test_merged(void)
+{
+	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
+	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
+	struct reftable_ref_record r1[] = {
+		{
+			.refname = "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		},
+		{
+			.refname = "b",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		},
+		{
+			.refname = "c",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		}
+	};
+	struct reftable_ref_record r2[] = { {
+		.refname = "a",
+		.update_index = 2,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
+	struct reftable_ref_record r3[] = {
+		{
+			.refname = "c",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash2,
+		},
+		{
+			.refname = "d",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		},
+	};
+
+	struct reftable_ref_record want[] = {
+		r2[0],
+		r1[1],
+		r3[0],
+		r3[1],
+	};
+
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	int sizes[3] = { 3, 1, 2 };
+	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
+
+	struct reftable_iterator it = { NULL };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	struct reftable_ref_record *out = NULL;
+	size_t len = 0;
+	size_t cap = 0;
+	int i = 0;
+
+	EXPECT_ERR(err);
+	while (len < 100) { /* cap loops/recursion. */
+		struct reftable_ref_record ref = { NULL };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (len == cap) {
+			cap = 2 * cap + 1;
+			out = reftable_realloc(
+				out, sizeof(struct reftable_ref_record) * cap);
+		}
+		out[len++] = ref;
+	}
+	reftable_iterator_destroy(&it);
+
+	EXPECT(ARRAY_SIZE(want) == len);
+	for (i = 0; i < len; i++) {
+		EXPECT(reftable_ref_record_equal(&want[i], &out[i],
+						 GIT_SHA1_RAWSZ));
+	}
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_release(&out[i]);
+	}
+	reftable_free(out);
+
+	for (i = 0; i < 3; i++) {
+		strbuf_release(&bufs[i]);
+	}
+	readers_destroy(readers, 3);
+	reftable_merged_table_free(mt);
+	reftable_free(bs);
+}
+
+static void test_default_write_opts(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	struct reftable_ref_record rec = {
+		.refname = "master",
+		.update_index = 1,
+	};
+	int err;
+	struct reftable_block_source source = { NULL };
+	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
+	uint32_t hash_id;
+	struct reftable_reader *rd = NULL;
+	struct reftable_merged_table *merged = NULL;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	EXPECT_ERR(err);
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	reftable_writer_free(w);
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = reftable_new_reader(&rd, &source, "filename");
+	EXPECT_ERR(err);
+
+	hash_id = reftable_reader_hash_id(rd);
+	EXPECT(hash_id == GIT_SHA1_FORMAT_ID);
+
+	reftable_table_from_reader(&tab[0], rd);
+	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
+	EXPECT_ERR(err);
+
+	reftable_reader_free(rd);
+	reftable_merged_table_free(merged);
+	strbuf_release(&buf);
+}
+
+/* XXX test refs_for(oid) */
+
+int merged_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_merged_between);
+	RUN_TEST(test_merged);
+	RUN_TEST(test_default_write_opts);
+	return 0;
+}
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
new file mode 100644
index 00000000000..1a6d16915ab
--- /dev/null
+++ b/reftable/reftable-merged.h
@@ -0,0 +1,72 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_MERGED_H
+#define REFTABLE_MERGED_H
+
+#include "reftable-iterator.h"
+
+/*
+ * Merged tables
+ *
+ * A ref database kept in a sequence of table files. The merged_table presents a
+ * unified view to reading (seeking, iterating) a sequence of immutable tables.
+ *
+ * The merged tables are on purpose kept disconnected from their actual storage
+ * (eg. files on disk), because it is useful to merge tables aren't files. For
+ * example, the per-workspace and global ref namespace can be implemented as a
+ * merged table of two stacks of file-backed reftables.
+ */
+
+/* A merged table is implements seeking/iterating over a stack of tables. */
+struct reftable_merged_table;
+
+/* A generic reftable; see below. */
+struct reftable_table;
+
+/* reftable_new_merged_table creates a new merged table. It takes ownership of
+   the stack array.
+*/
+int reftable_new_merged_table(struct reftable_merged_table **dest,
+			      struct reftable_table *stack, int n,
+			      uint32_t hash_id);
+
+/* returns an iterator positioned just before 'name' */
+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name);
+
+/* returns an iterator for log entry, at given update_index */
+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
+				      struct reftable_iterator *it,
+				      const char *name, uint64_t update_index);
+
+/* like reftable_merged_table_seek_log_at but look for the newest entry. */
+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name);
+
+/* returns the max update_index covered by this merged table. */
+uint64_t
+reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
+
+/* returns the min update_index covered by this merged table. */
+uint64_t
+reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
+
+/* releases memory for the merged_table */
+void reftable_merged_table_free(struct reftable_merged_table *m);
+
+/* return the hash ID of the merged table. */
+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
+
+/* create a generic table from reftable_merged_table */
+void reftable_table_from_merged_table(struct reftable_table *tab,
+				      struct reftable_merged_table *table);
+
+#endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 0b5a1701df1..8087f2da4e6 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,6 +5,7 @@ int cmd__reftable(int argc, const char **argv)
 {
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	record_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
-- 
gitgitgadget

