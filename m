Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B2FC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1233B20732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/eu49sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgIPTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgIPTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DFC061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y15so4173808wmi.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6oIbcfrn3HGM9LSPWcI6I2Lqm8aKJ7ffSKfJ71tq5oo=;
        b=V/eu49sxSRCxiVqjV1kb56O9yRxErACS5RjK0va2+N8lP4LqoMOCml3MbV+xC8KFO8
         PihK2AAU2EC0E/Eiq+9VOGLqxhnAmeRgYrkeruPyTG3hCklHovoLM9xOBjUH1/csLaE0
         Usai8O86rk1FNjkWplvh1QCLoqHofyQHpUtPKQohGaw1I7GwOveaGDg4jMjoPCJB/sOT
         Ox+/EAOOWwDJ535u+T4srVjHwf0EpOD2nJBXeANxq4Pxmle6290PMnABpKIhP1N5HkEd
         Uvup1jyrnVn2nOc1Xz2ZsyX+R7m5vbijcwAVPNDDy1Xn9oiFVsuYBcOJ+D/21l73A7n9
         RJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6oIbcfrn3HGM9LSPWcI6I2Lqm8aKJ7ffSKfJ71tq5oo=;
        b=LSAMcgyDf+Y+TwAJ2SDLOac1WpZGZt40ubke0q3q6lxma6wjEyvJH0N+uLJUa0GAj7
         wsl4aDDv8xfuGRUzg0oI4ty0zGGQCnUg6MJrOOEpOQrZAXL2sC0s9lnqwIglaE2JhLZ4
         jn+I+3b9Ls79+hGobUdxjv703JIozKjzCmkQmbvhPomOtsXXKSLWxZfgydgIb746aTPE
         qrZPdhqmGQtr4qVCVYuzz3gpepLFnQ7999k0rnp4tDQgSpafu7NByCx+wu6qVmj3VfHE
         1UKJZNAp0sYsUVPlmjCZQ+OCM3i7gqPWRxItFkVAQGNlTm3eg+hf5lFyIYMf2FZ3n+Fp
         Y3pA==
X-Gm-Message-State: AOAM5335Arg0fZ4/w2wv1dLGSOoAtR/JWTR7pu7W45bc3fqi2piRue9S
        XAHVTbDXKn8cSgiXJZ138zksF4KdgH0=
X-Google-Smtp-Source: ABdhPJwMP4t1xyGEmMDBoLdyetnPXD7Ak/Vz5lDt2iiM+/Vaff6XMCv/tY5Ylr9t4LnqSyMD//hEIg==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4295730wmb.141.1600283427381;
        Wed, 16 Sep 2020 12:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm33742611wrx.50.2020.09.16.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:26 -0700 (PDT)
Message-Id: <64d98e60b2609f6b4d27f69545d16bd00c8578ba.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:15 +0000
Subject: [PATCH 12/13] reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will be further split up once preceding commits have passed review.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |    8 +-
 reftable/VERSION         |    1 +
 reftable/dump.c          |  212 +++++++
 reftable/merged.c        |  358 +++++++++++
 reftable/merged.h        |   39 ++
 reftable/merged_test.c   |  331 +++++++++++
 reftable/pq.c            |  115 ++++
 reftable/pq.h            |   34 ++
 reftable/refname.c       |  209 +++++++
 reftable/refname.h       |   38 ++
 reftable/refname_test.c  |  100 ++++
 reftable/stack.c         | 1224 ++++++++++++++++++++++++++++++++++++++
 reftable/stack.h         |   50 ++
 reftable/stack_test.c    |  787 ++++++++++++++++++++++++
 reftable/update.sh       |   22 +
 t/helper/test-reftable.c |    3 +
 16 files changed, 3530 insertions(+), 1 deletion(-)
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100755 reftable/update.sh

diff --git a/Makefile b/Makefile
index 22dd31e7ff..6652259baf 100644
--- a/Makefile
+++ b/Makefile
@@ -2347,12 +2347,16 @@ XDIFF_OBJS += xdiff/xutils.o
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
-REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/compat.o
 REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/refname.o
 REFTABLE_OBJS += reftable/reftable.o
+REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/strbuf.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
@@ -2360,7 +2364,9 @@ REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/refname_test.o
 REFTABLE_TEST_OBJS += reftable/reftable_test.o
+REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/strbuf_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
diff --git a/reftable/VERSION b/reftable/VERSION
new file mode 100644
index 0000000000..7553c395eb
--- /dev/null
+++ b/reftable/VERSION
@@ -0,0 +1 @@
+b8ec0f74c74cb6752eb2033ad8e755a9c19aad15 C: add missing header
diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 0000000000..00b444e8c9
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,212 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "reftable.h"
+#include "reftable-tests.h"
+
+static uint32_t hash_id;
+
+static int dump_table(const char *tablename)
+{
+	struct reftable_block_source src = { 0 };
+	int err = reftable_block_source_from_file(&src, tablename);
+	struct reftable_iterator it = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_reader *r = NULL;
+
+	if (err < 0)
+		return err;
+
+	err = reftable_new_reader(&r, &src, tablename);
+	if (err < 0)
+		return err;
+
+	err = reftable_reader_seek_ref(r, &it, "");
+	if (err < 0) {
+		return err;
+	}
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_ref_record_print(&ref, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_clear(&ref);
+
+	err = reftable_reader_seek_log(r, &it, "");
+	if (err < 0) {
+		return err;
+	}
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_log_record_print(&log, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_log_record_clear(&log);
+
+	reftable_reader_free(r);
+	return 0;
+}
+
+static int compact_stack(const char *stackdir)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options cfg = {};
+
+	int err = reftable_new_stack(&stack, stackdir, cfg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_stack_compact_all(stack, NULL);
+	if (err < 0)
+		goto done;
+done:
+	if (stack != NULL) {
+		reftable_stack_destroy(stack);
+	}
+	return err;
+}
+
+static int dump_stack(const char *stackdir)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options cfg = {};
+	struct reftable_iterator it = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_merged_table *merged = NULL;
+
+	int err = reftable_new_stack(&stack, stackdir, cfg);
+	if (err < 0)
+		return err;
+
+	merged = reftable_stack_merged_table(stack);
+
+	err = reftable_merged_table_seek_ref(merged, &it, "");
+	if (err < 0) {
+		return err;
+	}
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_ref_record_print(&ref, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_clear(&ref);
+
+	err = reftable_merged_table_seek_log(merged, &it, "");
+	if (err < 0) {
+		return err;
+	}
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_log_record_print(&log, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_log_record_clear(&log);
+
+	reftable_stack_destroy(stack);
+	return 0;
+}
+
+static void print_help(void)
+{
+	printf("usage: dump [-cst] arg\n\n"
+	       "options: \n"
+	       "  -c compact\n"
+	       "  -t dump table\n"
+	       "  -s dump stack\n"
+	       "  -h this help\n"
+	       "  -2 use SHA256\n"
+	       "\n");
+}
+
+int reftable_dump_main(int argc, char *const *argv)
+{
+	int err = 0;
+	int opt;
+	int opt_dump_table = 0;
+	int opt_dump_stack = 0;
+	int opt_compact = 0;
+	const char *arg = NULL;
+	while ((opt = getopt(argc, argv, "2chts")) != -1) {
+		switch (opt) {
+		case '2':
+			hash_id = 0x73323536;
+			break;
+		case 't':
+			opt_dump_table = 1;
+			break;
+		case 's':
+			opt_dump_stack = 1;
+			break;
+		case 'c':
+			opt_compact = 1;
+			break;
+		case '?':
+		case 'h':
+			print_help();
+			return 2;
+			break;
+		}
+	}
+
+	if (argv[optind] == NULL) {
+		fprintf(stderr, "need argument\n");
+		print_help();
+		return 2;
+	}
+
+	arg = argv[optind];
+
+	if (opt_dump_table) {
+		err = dump_table(arg);
+	} else if (opt_dump_stack) {
+		err = dump_stack(arg);
+	} else if (opt_compact) {
+		err = compact_stack(arg);
+	}
+
+	if (err < 0) {
+		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
+			reftable_error_str(err));
+		return 1;
+	}
+	return 0;
+}
diff --git a/reftable/merged.c b/reftable/merged.c
new file mode 100644
index 0000000000..22b071cb5d
--- /dev/null
+++ b/reftable/merged.c
@@ -0,0 +1,358 @@
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
+#include "reftable.h"
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
+	struct merged_iter *mi = (struct merged_iter *)p;
+	int i = 0;
+	merged_iter_pqueue_clear(&mi->pq);
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
+	struct merged_iter *mi = (struct merged_iter *)p;
+	if (merged_iter_pqueue_is_empty(mi->pq))
+		return 1;
+
+	return merged_iter_next(mi, rec);
+}
+
+struct reftable_iterator_vtable merged_iter_vtable = {
+	.next = &merged_iter_next_void,
+	.close = &merged_iter_close,
+};
+
+static void iterator_from_merged_iter(struct reftable_iterator *it,
+				      struct merged_iter *mi)
+{
+	assert(it->ops == NULL);
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
+	m = (struct reftable_merged_table *)reftable_calloc(
+		sizeof(struct reftable_merged_table));
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
+void merged_table_clear(struct reftable_merged_table *mt)
+{
+	FREE_AND_NULL(mt->stack);
+	mt->stack_len = 0;
+}
+
+void reftable_merged_table_free(struct reftable_merged_table *mt)
+{
+	if (mt == NULL) {
+		return;
+	}
+	merged_table_clear(mt);
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
+int merged_table_seek_record(struct reftable_merged_table *mt,
+			     struct reftable_iterator *it,
+			     struct reftable_record *rec)
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
+	struct reftable_record rec = { 0 };
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
+	struct reftable_record rec = { 0 };
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
+	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
+					rec);
+}
+
+static uint32_t reftable_merged_table_hash_id_void(void *tab)
+{
+	return reftable_merged_table_hash_id(
+		(struct reftable_merged_table *)tab);
+}
+
+static uint64_t reftable_merged_table_min_update_index_void(void *tab)
+{
+	return reftable_merged_table_min_update_index(
+		(struct reftable_merged_table *)tab);
+}
+
+static uint64_t reftable_merged_table_max_update_index_void(void *tab)
+{
+	return reftable_merged_table_max_update_index(
+		(struct reftable_merged_table *)tab);
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
+	assert(tab->ops == NULL);
+	tab->ops = &merged_table_vtable;
+	tab->table_arg = merged;
+}
diff --git a/reftable/merged.h b/reftable/merged.h
new file mode 100644
index 0000000000..66a1d71830
--- /dev/null
+++ b/reftable/merged.h
@@ -0,0 +1,39 @@
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
+#include "reftable.h"
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
+void merged_table_clear(struct reftable_merged_table *mt);
+int merged_table_seek_record(struct reftable_merged_table *mt,
+			     struct reftable_iterator *it,
+			     struct reftable_record *rec);
+
+#endif
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
new file mode 100644
index 0000000000..18a0fe1dac
--- /dev/null
+++ b/reftable/merged_test.c
@@ -0,0 +1,331 @@
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
+#include "pq.h"
+#include "reader.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_pq(void)
+{
+	char *names[54] = { 0 };
+	int N = ARRAY_SIZE(names) - 1;
+
+	struct merged_iter_pqueue pq = { 0 };
+	const char *last = NULL;
+
+	int i = 0;
+	for (i = 0; i < N; i++) {
+		char name[100];
+		snprintf(name, sizeof(name), "%02d", i);
+		names[i] = xstrdup(name);
+	}
+
+	i = 1;
+	do {
+		struct reftable_record rec =
+			reftable_new_record(BLOCK_TYPE_REF);
+		struct pq_entry e = { 0 };
+
+		reftable_record_as_ref(&rec)->refname = names[i];
+		e.rec = rec;
+		merged_iter_pqueue_add(&pq, e);
+		merged_iter_pqueue_check(pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct reftable_ref_record *ref =
+			reftable_record_as_ref(&e.rec);
+
+		merged_iter_pqueue_check(pq);
+
+		if (last != NULL) {
+			assert(strcmp(last, ref->refname) < 0);
+		}
+		last = ref->refname;
+		ref->refname = NULL;
+		reftable_free(ref);
+	}
+
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+
+	merged_iter_pqueue_clear(&pq);
+}
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
+		assert(n == 0);
+		assert(before == refs[i].update_index);
+	}
+
+	err = reftable_writer_close(w);
+	assert_err(err);
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
+		assert_err(err);
+		reftable_table_from_reader(&tabs[i], (*readers)[i]);
+	}
+
+	err = reftable_new_merged_table(&mt, tabs, n, SHA1_ID);
+	assert_err(err);
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
+	uint8_t hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
+
+	struct reftable_ref_record r1[] = { {
+		.refname = "b",
+		.update_index = 1,
+		.value = hash1,
+	} };
+	struct reftable_ref_record r2[] = { {
+		.refname = "a",
+		.update_index = 2,
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
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	assert_err(err);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	assert_err(err);
+	assert(ref.update_index == 2);
+	reftable_ref_record_clear(&ref);
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
+	uint8_t hash1[SHA1_SIZE] = { 1 };
+	uint8_t hash2[SHA1_SIZE] = { 2 };
+	struct reftable_ref_record r1[] = { {
+						    .refname = "a",
+						    .update_index = 1,
+						    .value = hash1,
+					    },
+					    {
+						    .refname = "b",
+						    .update_index = 1,
+						    .value = hash1,
+					    },
+					    {
+						    .refname = "c",
+						    .update_index = 1,
+						    .value = hash1,
+					    } };
+	struct reftable_ref_record r2[] = { {
+		.refname = "a",
+		.update_index = 2,
+	} };
+	struct reftable_ref_record r3[] = {
+		{
+			.refname = "c",
+			.update_index = 3,
+			.value = hash2,
+		},
+		{
+			.refname = "d",
+			.update_index = 3,
+			.value = hash1,
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
+	struct reftable_iterator it = { 0 };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	struct reftable_ref_record *out = NULL;
+	size_t len = 0;
+	size_t cap = 0;
+	int i = 0;
+
+	assert_err(err);
+	while (len < 100) { /* cap loops/recursion. */
+		struct reftable_ref_record ref = { 0 };
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
+	assert(ARRAY_SIZE(want) == len);
+	for (i = 0; i < len; i++) {
+		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
+	}
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_clear(&out[i]);
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
+	struct reftable_block_source source = { 0 };
+	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
+	uint32_t hash_id;
+	struct reftable_reader *rd = NULL;
+	struct reftable_merged_table *merged = NULL;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	assert_err(err);
+
+	err = reftable_writer_close(w);
+	assert_err(err);
+	reftable_writer_free(w);
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = reftable_new_reader(&rd, &source, "filename");
+	assert_err(err);
+
+	hash_id = reftable_reader_hash_id(rd);
+	assert(hash_id == SHA1_ID);
+
+	reftable_table_from_reader(&tab[0], rd);
+	err = reftable_new_merged_table(&merged, tab, 1, SHA1_ID);
+	assert_err(err);
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
+	add_test_case("test_merged_between", &test_merged_between);
+	add_test_case("test_pq", &test_pq);
+	add_test_case("test_merged", &test_merged);
+	add_test_case("test_default_write_opts", &test_default_write_opts);
+	return test_main(argc, argv);
+}
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 0000000000..5fa1b5f437
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,115 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "pq.h"
+
+#include "reftable.h"
+#include "system.h"
+#include "basics.h"
+
+int pq_less(struct pq_entry a, struct pq_entry b)
+{
+	struct strbuf ak = STRBUF_INIT;
+	struct strbuf bk = STRBUF_INIT;
+	int cmp = 0;
+	reftable_record_key(&a.rec, &ak);
+	reftable_record_key(&b.rec, &bk);
+
+	cmp = strbuf_cmp(&ak, &bk);
+
+	strbuf_release(&ak);
+	strbuf_release(&bk);
+
+	if (cmp == 0)
+		return a.index > b.index;
+
+	return cmp < 0;
+}
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
+{
+	return pq.heap[0];
+}
+
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+{
+	return pq.len == 0;
+}
+
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+{
+	int i = 0;
+	for (i = 1; i < pq.len; i++) {
+		int parent = (i - 1) / 2;
+
+		assert(pq_less(pq.heap[parent], pq.heap[i]));
+	}
+}
+
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	struct pq_entry e = pq->heap[0];
+	pq->heap[0] = pq->heap[pq->len - 1];
+	pq->len--;
+
+	i = 0;
+	while (i < pq->len) {
+		int min = i;
+		int j = 2 * i + 1;
+		int k = 2 * i + 2;
+		if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
+			min = j;
+		}
+		if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
+			min = k;
+		}
+
+		if (min == i) {
+			break;
+		}
+
+		SWAP(pq->heap[i], pq->heap[min]);
+		i = min;
+	}
+
+	return e;
+}
+
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+{
+	int i = 0;
+	if (pq->len == pq->cap) {
+		pq->cap = 2 * pq->cap + 1;
+		pq->heap = reftable_realloc(pq->heap,
+					    pq->cap * sizeof(struct pq_entry));
+	}
+
+	pq->heap[pq->len++] = e;
+	i = pq->len - 1;
+	while (i > 0) {
+		int j = (i - 1) / 2;
+		if (pq_less(pq->heap[j], pq->heap[i])) {
+			break;
+		}
+
+		SWAP(pq->heap[j], pq->heap[i]);
+
+		i = j;
+	}
+}
+
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	for (i = 0; i < pq->len; i++) {
+		reftable_record_destroy(&pq->heap[i].rec);
+	}
+	FREE_AND_NULL(pq->heap);
+	pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 0000000000..918ac3990d
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef PQ_H
+#define PQ_H
+
+#include "record.h"
+
+struct pq_entry {
+	int index;
+	struct reftable_record rec;
+};
+
+int pq_less(struct pq_entry a, struct pq_entry b);
+
+struct merged_iter_pqueue {
+	struct pq_entry *heap;
+	size_t len;
+	size_t cap;
+};
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq);
+
+#endif
diff --git a/reftable/refname.c b/reftable/refname.c
new file mode 100644
index 0000000000..423e2b06bc
--- /dev/null
+++ b/reftable/refname.c
@@ -0,0 +1,209 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+#include "reftable.h"
+#include "basics.h"
+#include "refname.h"
+#include "strbuf.h"
+
+struct find_arg {
+	char **names;
+	const char *want;
+};
+
+static int find_name(size_t k, void *arg)
+{
+	struct find_arg *f_arg = (struct find_arg *)arg;
+	return strcmp(f_arg->names[k], f_arg->want) >= 0;
+}
+
+int modification_has_ref(struct modification *mod, const char *name)
+{
+	struct reftable_ref_record ref = { 0 };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = name,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
+			return 0;
+		}
+	}
+
+	if (mod->del_len > 0) {
+		struct find_arg arg = {
+			.names = mod->del,
+			.want = name,
+		};
+		int idx = binsearch(mod->del_len, find_name, &arg);
+		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
+			return 1;
+		}
+	}
+
+	err = reftable_table_read_ref(&mod->tab, name, &ref);
+	reftable_ref_record_clear(&ref);
+	return err;
+}
+
+static void modification_clear(struct modification *mod)
+{
+	/* don't delete the strings themselves; they're owned by ref records.
+	 */
+	FREE_AND_NULL(mod->add);
+	FREE_AND_NULL(mod->del);
+	mod->add_len = 0;
+	mod->del_len = 0;
+}
+
+int modification_has_ref_with_prefix(struct modification *mod,
+				     const char *prefix)
+{
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = prefix,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len &&
+		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
+			goto done;
+	}
+	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
+	if (err)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err)
+			goto done;
+
+		if (mod->del_len > 0) {
+			struct find_arg arg = {
+				.names = mod->del,
+				.want = ref.refname,
+			};
+			int idx = binsearch(mod->del_len, find_name, &arg);
+			if (idx < mod->del_len &&
+			    !strcmp(ref.refname, mod->del[idx])) {
+				continue;
+			}
+		}
+
+		if (strncmp(ref.refname, prefix, strlen(prefix))) {
+			err = 1;
+			goto done;
+		}
+		err = 0;
+		goto done;
+	}
+
+done:
+	reftable_ref_record_clear(&ref);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int validate_refname(const char *name)
+{
+	while (1) {
+		char *next = strchr(name, '/');
+		if (!*name) {
+			return REFTABLE_REFNAME_ERROR;
+		}
+		if (!next) {
+			return 0;
+		}
+		if (next - name == 0 || (next - name == 1 && *name == '.') ||
+		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
+			return REFTABLE_REFNAME_ERROR;
+		name = next + 1;
+	}
+	return 0;
+}
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz)
+{
+	struct modification mod = {
+		.tab = tab,
+		.add = reftable_calloc(sizeof(char *) * sz),
+		.del = reftable_calloc(sizeof(char *) * sz),
+	};
+	int i = 0;
+	int err = 0;
+	for (; i < sz; i++) {
+		if (reftable_ref_record_is_deletion(&recs[i])) {
+			mod.del[mod.del_len++] = recs[i].refname;
+		} else {
+			mod.add[mod.add_len++] = recs[i].refname;
+		}
+	}
+
+	err = modification_validate(&mod);
+	modification_clear(&mod);
+	return err;
+}
+
+static void strbuf_trim_component(struct strbuf *sl)
+{
+	while (sl->len > 0) {
+		int is_slash = (sl->buf[sl->len - 1] == '/');
+		strbuf_setlen(sl, sl->len - 1);
+		if (is_slash)
+			break;
+	}
+}
+
+int modification_validate(struct modification *mod)
+{
+	struct strbuf slashed = STRBUF_INIT;
+	int err = 0;
+	int i = 0;
+	for (; i < mod->add_len; i++) {
+		err = validate_refname(mod->add[i]);
+		if (err)
+			goto done;
+		strbuf_reset(&slashed);
+		strbuf_addstr(&slashed, mod->add[i]);
+		strbuf_addstr(&slashed, "/");
+
+		err = modification_has_ref_with_prefix(mod, slashed.buf);
+		if (err == 0) {
+			err = REFTABLE_NAME_CONFLICT;
+			goto done;
+		}
+		if (err < 0)
+			goto done;
+
+		strbuf_reset(&slashed);
+		strbuf_addstr(&slashed, mod->add[i]);
+		while (slashed.len) {
+			strbuf_trim_component(&slashed);
+			err = modification_has_ref(mod, slashed.buf);
+			if (err == 0) {
+				err = REFTABLE_NAME_CONFLICT;
+				goto done;
+			}
+			if (err < 0)
+				goto done;
+		}
+	}
+	err = 0;
+done:
+	strbuf_release(&slashed);
+	return err;
+}
diff --git a/reftable/refname.h b/reftable/refname.h
new file mode 100644
index 0000000000..13bf1e6861
--- /dev/null
+++ b/reftable/refname.h
@@ -0,0 +1,38 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+#ifndef REFNAME_H
+#define REFNAME_H
+
+#include "reftable.h"
+
+struct modification {
+	struct reftable_table tab;
+
+	char **add;
+	size_t add_len;
+
+	char **del;
+	size_t del_len;
+};
+
+// -1 = error, 0 = found, 1 = not found
+int modification_has_ref(struct modification *mod, const char *name);
+
+// -1 = error, 0 = found, 1 = not found.
+int modification_has_ref_with_prefix(struct modification *mod,
+				     const char *prefix);
+
+// 0 = OK.
+int validate_refname(const char *name);
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz);
+
+int modification_validate(struct modification *mod);
+
+#endif
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
new file mode 100644
index 0000000000..f3dcaade2a
--- /dev/null
+++ b/reftable/refname_test.c
@@ -0,0 +1,100 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable.h"
+
+#include "basics.h"
+#include "block.h"
+#include "blocksource.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "refname.h"
+#include "system.h"
+
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct testcase {
+	char *add;
+	char *del;
+	int error_code;
+};
+
+static void test_conflict(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_ref_record rec = {
+		.refname = "a/b",
+		.target = "destination", /* make sure it's not a symref. */
+		.update_index = 1,
+	};
+	int err;
+	int i;
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct testcase cases[] = {
+		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
+		{ "b", NULL, 0 },
+		{ "a", NULL, REFTABLE_NAME_CONFLICT },
+		{ "a", "a/b", 0 },
+
+		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
+
+		{ "a/b/c", "a/b", 0 },
+		{ NULL, "a//b", 0 },
+	};
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	assert_err(err);
+
+	err = reftable_writer_close(w);
+	assert_err(err);
+	reftable_writer_free(w);
+
+	block_source_from_strbuf(&source, &buf);
+	err = reftable_new_reader(&rd, &source, "filename");
+	assert_err(err);
+
+	reftable_table_from_reader(&tab, rd);
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct modification mod = {
+			.tab = tab,
+		};
+
+		if (cases[i].add != NULL) {
+			mod.add = &cases[i].add;
+			mod.add_len = 1;
+		}
+		if (cases[i].del != NULL) {
+			mod.del = &cases[i].del;
+			mod.del_len = 1;
+		}
+
+		err = modification_validate(&mod);
+		assert(err == cases[i].error_code);
+	}
+
+	reftable_reader_free(rd);
+	strbuf_release(&buf);
+}
+
+int refname_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_conflict", &test_conflict);
+	return test_main(argc, argv);
+}
diff --git a/reftable/stack.c b/reftable/stack.c
new file mode 100644
index 0000000000..cf8a8e854b
--- /dev/null
+++ b/reftable/stack.c
@@ -0,0 +1,1224 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+#include "merged.h"
+#include "reader.h"
+#include "refname.h"
+#include "reftable.h"
+#include "writer.h"
+
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config)
+{
+	struct reftable_stack *p =
+		reftable_calloc(sizeof(struct reftable_stack));
+	struct strbuf list_file_name = STRBUF_INIT;
+	int err = 0;
+
+	if (config.hash_id == 0) {
+		config.hash_id = SHA1_ID;
+	}
+
+	*dest = NULL;
+
+	strbuf_reset(&list_file_name);
+	strbuf_addstr(&list_file_name, dir);
+	strbuf_addstr(&list_file_name, "/tables.list");
+
+	p->list_file = strbuf_detach(&list_file_name, NULL);
+	p->reftable_dir = xstrdup(dir);
+	p->config = config;
+
+	err = reftable_stack_reload_maybe_reuse(p, 1);
+	if (err < 0) {
+		reftable_stack_destroy(p);
+	} else {
+		*dest = p;
+	}
+	return err;
+}
+
+static int fd_read_lines(int fd, char ***namesp)
+{
+	off_t size = lseek(fd, 0, SEEK_END);
+	char *buf = NULL;
+	int err = 0;
+	if (size < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	err = lseek(fd, 0, SEEK_SET);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	buf = reftable_malloc(size + 1);
+	if (read(fd, buf, size) != size) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	buf[size] = 0;
+
+	parse_names(buf, size, namesp);
+
+done:
+	reftable_free(buf);
+	return err;
+}
+
+int read_lines(const char *filename, char ***namesp)
+{
+	int fd = open(filename, O_RDONLY, 0644);
+	int err = 0;
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			*namesp = reftable_calloc(sizeof(char *));
+			return 0;
+		}
+
+		return REFTABLE_IO_ERROR;
+	}
+	err = fd_read_lines(fd, namesp);
+	close(fd);
+	return err;
+}
+
+struct reftable_merged_table *
+reftable_stack_merged_table(struct reftable_stack *st)
+{
+	return st->merged;
+}
+
+/* Close and free the stack */
+void reftable_stack_destroy(struct reftable_stack *st)
+{
+	if (st->merged != NULL) {
+		reftable_merged_table_free(st->merged);
+		st->merged = NULL;
+	}
+
+	if (st->readers != NULL) {
+		int i = 0;
+		for (i = 0; i < st->readers_len; i++) {
+			reftable_reader_free(st->readers[i]);
+		}
+		st->readers_len = 0;
+		FREE_AND_NULL(st->readers);
+	}
+	FREE_AND_NULL(st->list_file);
+	FREE_AND_NULL(st->reftable_dir);
+	reftable_free(st);
+}
+
+static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
+						   int cur_len)
+{
+	struct reftable_reader **cur =
+		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
+	int i = 0;
+	for (i = 0; i < cur_len; i++) {
+		cur[i] = st->readers[i];
+	}
+	return cur;
+}
+
+static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
+				      int reuse_open)
+{
+	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
+	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	int err = 0;
+	int names_len = names_length(names);
+	struct reftable_reader **new_readers =
+		reftable_calloc(sizeof(struct reftable_reader *) * names_len);
+	struct reftable_table *new_tables =
+		reftable_calloc(sizeof(struct reftable_table) * names_len);
+	int new_readers_len = 0;
+	struct reftable_merged_table *new_merged = NULL;
+	int i;
+
+	while (*names) {
+		struct reftable_reader *rd = NULL;
+		char *name = *names++;
+
+		/* this is linear; we assume compaction keeps the number of
+		   tables under control so this is not quadratic. */
+		int j = 0;
+		for (j = 0; reuse_open && j < cur_len; j++) {
+			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
+				rd = cur[j];
+				cur[j] = NULL;
+				break;
+			}
+		}
+
+		if (rd == NULL) {
+			struct reftable_block_source src = { 0 };
+			struct strbuf table_path = STRBUF_INIT;
+			strbuf_addstr(&table_path, st->reftable_dir);
+			strbuf_addstr(&table_path, "/");
+			strbuf_addstr(&table_path, name);
+
+			err = reftable_block_source_from_file(&src,
+							      table_path.buf);
+			strbuf_release(&table_path);
+
+			if (err < 0)
+				goto done;
+
+			err = reftable_new_reader(&rd, &src, name);
+			if (err < 0)
+				goto done;
+		}
+
+		new_readers[new_readers_len] = rd;
+		reftable_table_from_reader(&new_tables[new_readers_len], rd);
+		new_readers_len++;
+	}
+
+	/* success! */
+	err = reftable_new_merged_table(&new_merged, new_tables,
+					new_readers_len, st->config.hash_id);
+	if (err < 0)
+		goto done;
+
+	new_tables = NULL;
+	st->readers_len = new_readers_len;
+	if (st->merged != NULL) {
+		merged_table_clear(st->merged);
+		reftable_merged_table_free(st->merged);
+	}
+	if (st->readers != NULL) {
+		reftable_free(st->readers);
+	}
+	st->readers = new_readers;
+	new_readers = NULL;
+	new_readers_len = 0;
+
+	new_merged->suppress_deletions = 1;
+	st->merged = new_merged;
+	for (i = 0; i < cur_len; i++) {
+		if (cur[i] != NULL) {
+			reader_close(cur[i]);
+			reftable_reader_free(cur[i]);
+		}
+	}
+
+done:
+	for (i = 0; i < new_readers_len; i++) {
+		reader_close(new_readers[i]);
+		reftable_reader_free(new_readers[i]);
+	}
+	reftable_free(new_readers);
+	reftable_free(new_tables);
+	reftable_free(cur);
+	return err;
+}
+
+/* return negative if a before b. */
+static int tv_cmp(struct timeval *a, struct timeval *b)
+{
+	time_t diff = a->tv_sec - b->tv_sec;
+	int udiff = a->tv_usec - b->tv_usec;
+
+	if (diff != 0)
+		return diff;
+
+	return udiff;
+}
+
+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st, int reuse_open)
+{
+	struct timeval deadline = { 0 };
+	int err = gettimeofday(&deadline, NULL);
+	int64_t delay = 0;
+	int tries = 0;
+	if (err < 0)
+		return err;
+
+	deadline.tv_sec += 3;
+	while (1) {
+		char **names = NULL;
+		char **names_after = NULL;
+		struct timeval now = { 0 };
+		int err = gettimeofday(&now, NULL);
+		int err2 = 0;
+		if (err < 0) {
+			return err;
+		}
+
+		/* Only look at deadlines after the first few times. This
+		   simplifies debugging in GDB */
+		tries++;
+		if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
+			break;
+		}
+
+		err = read_lines(st->list_file, &names);
+		if (err < 0) {
+			free_names(names);
+			return err;
+		}
+		err = reftable_stack_reload_once(st, names, reuse_open);
+		if (err == 0) {
+			free_names(names);
+			break;
+		}
+		if (err != REFTABLE_NOT_EXIST_ERROR) {
+			free_names(names);
+			return err;
+		}
+
+		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
+		   writer. Check if there was one by checking if the name list
+		   changed.
+		*/
+		err2 = read_lines(st->list_file, &names_after);
+		if (err2 < 0) {
+			free_names(names);
+			return err2;
+		}
+
+		if (names_equal(names_after, names)) {
+			free_names(names);
+			free_names(names_after);
+			return err;
+		}
+		free_names(names);
+		free_names(names_after);
+
+		delay = delay + (delay * rand()) / RAND_MAX + 1;
+		sleep_millisec(delay);
+	}
+
+	return 0;
+}
+
+/* -1 = error
+ 0 = up to date
+ 1 = changed. */
+static int stack_uptodate(struct reftable_stack *st)
+{
+	char **names = NULL;
+	int err = read_lines(st->list_file, &names);
+	int i = 0;
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < st->readers_len; i++) {
+		if (names[i] == NULL) {
+			err = 1;
+			goto done;
+		}
+
+		if (strcmp(st->readers[i]->name, names[i])) {
+			err = 1;
+			goto done;
+		}
+	}
+
+	if (names[st->merged->stack_len] != NULL) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	free_names(names);
+	return err;
+}
+
+int reftable_stack_reload(struct reftable_stack *st)
+{
+	int err = stack_uptodate(st);
+	if (err > 0)
+		return reftable_stack_reload_maybe_reuse(st, 1);
+	return err;
+}
+
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write)(struct reftable_writer *wr, void *arg),
+		       void *arg)
+{
+	int err = stack_try_add(st, write, arg);
+	if (err < 0) {
+		if (err == REFTABLE_LOCK_ERROR) {
+			/* Ignore error return, we want to propagate
+			   REFTABLE_LOCK_ERROR.
+			*/
+			reftable_stack_reload(st);
+		}
+		return err;
+	}
+
+	if (!st->disable_auto_compact)
+		return reftable_stack_auto_compact(st);
+
+	return 0;
+}
+
+static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
+{
+	char buf[100];
+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
+	strbuf_reset(dest);
+	strbuf_addstr(dest, buf);
+}
+
+struct reftable_addition {
+	int lock_file_fd;
+	struct strbuf lock_file_name;
+	struct reftable_stack *stack;
+	char **names;
+	char **new_tables;
+	int new_tables_len;
+	uint64_t next_update_index;
+};
+
+#define REFTABLE_ADDITION_INIT                \
+	{                                     \
+		.lock_file_name = STRBUF_INIT \
+	}
+
+static int reftable_stack_init_addition(struct reftable_addition *add,
+					struct reftable_stack *st)
+{
+	int err = 0;
+	add->stack = st;
+
+	strbuf_reset(&add->lock_file_name);
+	strbuf_addstr(&add->lock_file_name, st->list_file);
+	strbuf_addstr(&add->lock_file_name, ".lock");
+
+	add->lock_file_fd = open(add->lock_file_name.buf,
+				 O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (add->lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = REFTABLE_LOCK_ERROR;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	err = stack_uptodate(st);
+	if (err < 0)
+		goto done;
+
+	if (err > 1) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	add->next_update_index = reftable_stack_next_update_index(st);
+done:
+	if (err) {
+		reftable_addition_close(add);
+	}
+	return err;
+}
+
+void reftable_addition_close(struct reftable_addition *add)
+{
+	int i = 0;
+	struct strbuf nm = STRBUF_INIT;
+	for (i = 0; i < add->new_tables_len; i++) {
+		strbuf_reset(&nm);
+		strbuf_addstr(&nm, add->stack->list_file);
+		strbuf_addstr(&nm, "/");
+		strbuf_addstr(&nm, add->new_tables[i]);
+		unlink(nm.buf);
+		reftable_free(add->new_tables[i]);
+		add->new_tables[i] = NULL;
+	}
+	reftable_free(add->new_tables);
+	add->new_tables = NULL;
+	add->new_tables_len = 0;
+
+	if (add->lock_file_fd > 0) {
+		close(add->lock_file_fd);
+		add->lock_file_fd = 0;
+	}
+	if (add->lock_file_name.len > 0) {
+		unlink(add->lock_file_name.buf);
+		strbuf_release(&add->lock_file_name);
+	}
+
+	free_names(add->names);
+	add->names = NULL;
+	strbuf_release(&nm);
+}
+
+void reftable_addition_destroy(struct reftable_addition *add)
+{
+	if (add == NULL) {
+		return;
+	}
+	reftable_addition_close(add);
+	reftable_free(add);
+}
+
+int reftable_addition_commit(struct reftable_addition *add)
+{
+	struct strbuf table_list = STRBUF_INIT;
+	int i = 0;
+	int err = 0;
+	if (add->new_tables_len == 0)
+		goto done;
+
+	for (i = 0; i < add->stack->merged->stack_len; i++) {
+		strbuf_addstr(&table_list, add->stack->readers[i]->name);
+		strbuf_addstr(&table_list, "\n");
+	}
+	for (i = 0; i < add->new_tables_len; i++) {
+		strbuf_addstr(&table_list, add->new_tables[i]);
+		strbuf_addstr(&table_list, "\n");
+	}
+
+	err = write(add->lock_file_fd, table_list.buf, table_list.len);
+	strbuf_release(&table_list);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = close(add->lock_file_fd);
+	add->lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = rename(add->lock_file_name.buf, add->stack->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = reftable_stack_reload(add->stack);
+
+done:
+	reftable_addition_close(add);
+	return err;
+}
+
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st)
+{
+	int err = 0;
+	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	*dest = reftable_calloc(sizeof(**dest));
+	**dest = empty;
+	err = reftable_stack_init_addition(*dest, st);
+	if (err) {
+		reftable_free(*dest);
+		*dest = NULL;
+	}
+	return err;
+}
+
+int stack_try_add(struct reftable_stack *st,
+		  int (*write_table)(struct reftable_writer *wr, void *arg),
+		  void *arg)
+{
+	struct reftable_addition add = REFTABLE_ADDITION_INIT;
+	int err = reftable_stack_init_addition(&add, st);
+	if (err < 0)
+		goto done;
+	if (err > 0) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	err = reftable_addition_add(&add, write_table, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_addition_commit(&add);
+done:
+	reftable_addition_close(&add);
+	return err;
+}
+
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg)
+{
+	struct strbuf temp_tab_file_name = STRBUF_INIT;
+	struct strbuf tab_file_name = STRBUF_INIT;
+	struct strbuf next_name = STRBUF_INIT;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+	int tab_fd = 0;
+
+	strbuf_reset(&next_name);
+	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	strbuf_addstr(&temp_tab_file_name, add->stack->reftable_dir);
+	strbuf_addstr(&temp_tab_file_name, "/");
+	strbuf_addbuf(&temp_tab_file_name, &next_name);
+	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+
+	tab_fd = mkstemp(temp_tab_file_name.buf);
+	if (tab_fd < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
+				 &add->stack->config);
+	err = write_table(wr, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_writer_close(wr);
+	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = stack_check_addition(add->stack, temp_tab_file_name.buf);
+	if (err < 0)
+		goto done;
+
+	if (wr->min_update_index < add->next_update_index) {
+		err = REFTABLE_API_ERROR;
+		goto done;
+	}
+
+	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	strbuf_addstr(&next_name, ".ref");
+
+	strbuf_addstr(&tab_file_name, add->stack->reftable_dir);
+	strbuf_addstr(&tab_file_name, "/");
+	strbuf_addbuf(&tab_file_name, &next_name);
+
+	/* TODO: should check destination out of paranoia */
+	err = rename(temp_tab_file_name.buf, tab_file_name.buf);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	add->new_tables = reftable_realloc(add->new_tables,
+					   sizeof(*add->new_tables) *
+						   (add->new_tables_len + 1));
+	add->new_tables[add->new_tables_len] = strbuf_detach(&next_name, NULL);
+	add->new_tables_len++;
+done:
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (temp_tab_file_name.len > 0) {
+		unlink(temp_tab_file_name.buf);
+	}
+
+	strbuf_release(&temp_tab_file_name);
+	strbuf_release(&tab_file_name);
+	strbuf_release(&next_name);
+	reftable_writer_free(wr);
+	return err;
+}
+
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
+{
+	int sz = st->merged->stack_len;
+	if (sz > 0)
+		return reftable_reader_max_update_index(st->readers[sz - 1]) +
+		       1;
+	return 1;
+}
+
+static int stack_compact_locked(struct reftable_stack *st, int first, int last,
+				struct strbuf *temp_tab,
+				struct reftable_log_expiry_config *config)
+{
+	struct strbuf next_name = STRBUF_INIT;
+	int tab_fd = -1;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+
+	format_name(&next_name,
+		    reftable_reader_min_update_index(st->readers[first]),
+		    reftable_reader_max_update_index(st->readers[first]));
+
+	strbuf_reset(temp_tab);
+	strbuf_addstr(temp_tab, st->reftable_dir);
+	strbuf_addstr(temp_tab, "/");
+	strbuf_addbuf(temp_tab, &next_name);
+	strbuf_addstr(temp_tab, ".temp.XXXXXX");
+
+	tab_fd = mkstemp(temp_tab->buf);
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+
+	err = stack_write_compact(st, wr, first, last, config);
+	if (err < 0)
+		goto done;
+	err = reftable_writer_close(wr);
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+
+done:
+	reftable_writer_free(wr);
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (err != 0 && temp_tab->len > 0) {
+		unlink(temp_tab->buf);
+		strbuf_release(temp_tab);
+	}
+	strbuf_release(&next_name);
+	return err;
+}
+
+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
+			int first, int last,
+			struct reftable_log_expiry_config *config)
+{
+	int subtabs_len = last - first + 1;
+	struct reftable_table *subtabs = reftable_calloc(
+		sizeof(struct reftable_table) * (last - first + 1));
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_iterator it = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+
+	uint64_t entries = 0;
+
+	int i = 0, j = 0;
+	for (i = first, j = 0; i <= last; i++) {
+		struct reftable_reader *t = st->readers[i];
+		reftable_table_from_reader(&subtabs[j++], t);
+		st->stats.bytes += t->size;
+	}
+	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
+				   st->readers[last]->max_update_index);
+
+	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
+					st->config.hash_id);
+	if (err < 0) {
+		reftable_free(subtabs);
+		goto done;
+	}
+
+	err = reftable_merged_table_seek_ref(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
+			continue;
+		}
+
+		err = reftable_writer_add_ref(wr, &ref);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+	reftable_iterator_destroy(&it);
+
+	err = reftable_merged_table_seek_log(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+		if (first == 0 && reftable_log_record_is_deletion(&log)) {
+			continue;
+		}
+
+		if (config != NULL && config->time > 0 &&
+		    log.time < config->time) {
+			continue;
+		}
+
+		if (config != NULL && config->min_update_index > 0 &&
+		    log.update_index < config->min_update_index) {
+			continue;
+		}
+
+		err = reftable_writer_add_log(wr, &log);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	if (mt != NULL) {
+		merged_table_clear(mt);
+		reftable_merged_table_free(mt);
+	}
+	reftable_ref_record_clear(&ref);
+	reftable_log_record_clear(&log);
+	st->stats.entries_written += entries;
+	return err;
+}
+
+/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
+static int stack_compact_range(struct reftable_stack *st, int first, int last,
+			       struct reftable_log_expiry_config *expiry)
+{
+	struct strbuf temp_tab_file_name = STRBUF_INIT;
+	struct strbuf new_table_name = STRBUF_INIT;
+	struct strbuf lock_file_name = STRBUF_INIT;
+	struct strbuf ref_list_contents = STRBUF_INIT;
+	struct strbuf new_table_path = STRBUF_INIT;
+	int err = 0;
+	int have_lock = 0;
+	int lock_file_fd = 0;
+	int compact_count = last - first + 1;
+	char **listp = NULL;
+	char **delete_on_success =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	char **subtable_locks =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	int i = 0;
+	int j = 0;
+	int is_empty_table = 0;
+
+	if (first > last || (expiry == NULL && first == last)) {
+		err = 0;
+		goto done;
+	}
+
+	st->stats.attempts++;
+
+	strbuf_reset(&lock_file_name);
+	strbuf_addstr(&lock_file_name, st->list_file);
+	strbuf_addstr(&lock_file_name, ".lock");
+
+	lock_file_fd =
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	/* Don't want to write to the lock for now.  */
+	close(lock_file_fd);
+	lock_file_fd = 0;
+
+	have_lock = 1;
+	err = stack_uptodate(st);
+	if (err != 0)
+		goto done;
+
+	for (i = first, j = 0; i <= last; i++) {
+		struct strbuf subtab_file_name = STRBUF_INIT;
+		struct strbuf subtab_lock = STRBUF_INIT;
+		int sublock_file_fd = -1;
+
+		strbuf_addstr(&subtab_file_name, st->reftable_dir);
+		strbuf_addstr(&subtab_file_name, "/");
+		strbuf_addstr(&subtab_file_name, reader_name(st->readers[i]));
+
+		strbuf_reset(&subtab_lock);
+		strbuf_addbuf(&subtab_lock, &subtab_file_name);
+		strbuf_addstr(&subtab_lock, ".lock");
+
+		sublock_file_fd = open(subtab_lock.buf,
+				       O_EXCL | O_CREAT | O_WRONLY, 0644);
+		if (sublock_file_fd > 0) {
+			close(sublock_file_fd);
+		} else if (sublock_file_fd < 0) {
+			if (errno == EEXIST) {
+				err = 1;
+			} else {
+				err = REFTABLE_IO_ERROR;
+			}
+		}
+
+		subtable_locks[j] = subtab_lock.buf;
+		delete_on_success[j] = subtab_file_name.buf;
+		j++;
+
+		if (err != 0)
+			goto done;
+	}
+
+	err = unlink(lock_file_name.buf);
+	if (err < 0)
+		goto done;
+	have_lock = 0;
+
+	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
+				   expiry);
+	/* Compaction + tombstones can create an empty table out of non-empty
+	 * tables. */
+	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
+	if (is_empty_table) {
+		err = 0;
+	}
+	if (err < 0)
+		goto done;
+
+	lock_file_fd =
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	have_lock = 1;
+
+	format_name(&new_table_name, st->readers[first]->min_update_index,
+		    st->readers[last]->max_update_index);
+	strbuf_addstr(&new_table_name, ".ref");
+
+	strbuf_reset(&new_table_path);
+	strbuf_addstr(&new_table_path, st->reftable_dir);
+	strbuf_addstr(&new_table_path, "/");
+	strbuf_addbuf(&new_table_path, &new_table_name);
+
+	if (!is_empty_table) {
+		err = rename(temp_tab_file_name.buf, new_table_path.buf);
+		if (err < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
+
+	for (i = 0; i < first; i++) {
+		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+	if (!is_empty_table) {
+		strbuf_addbuf(&ref_list_contents, &new_table_name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+	for (i = last + 1; i < st->merged->stack_len; i++) {
+		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+
+	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+	err = close(lock_file_fd);
+	lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+
+	err = rename(lock_file_name.buf, st->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+	have_lock = 0;
+
+	/* Reload the stack before deleting. On windows, we can only delete the
+	   files after we closed them.
+	*/
+	err = reftable_stack_reload_maybe_reuse(st, first < last);
+
+	listp = delete_on_success;
+	while (*listp) {
+		if (strcmp(*listp, new_table_path.buf)) {
+			unlink(*listp);
+		}
+		listp++;
+	}
+
+done:
+	free_names(delete_on_success);
+
+	listp = subtable_locks;
+	while (*listp) {
+		unlink(*listp);
+		listp++;
+	}
+	free_names(subtable_locks);
+	if (lock_file_fd > 0) {
+		close(lock_file_fd);
+		lock_file_fd = 0;
+	}
+	if (have_lock) {
+		unlink(lock_file_name.buf);
+	}
+	strbuf_release(&new_table_name);
+	strbuf_release(&new_table_path);
+	strbuf_release(&ref_list_contents);
+	strbuf_release(&temp_tab_file_name);
+	strbuf_release(&lock_file_name);
+	return err;
+}
+
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+}
+
+static int stack_compact_range_stats(struct reftable_stack *st, int first,
+				     int last,
+				     struct reftable_log_expiry_config *config)
+{
+	int err = stack_compact_range(st, first, last, config);
+	if (err > 0) {
+		st->stats.failures++;
+	}
+	return err;
+}
+
+static int segment_size(struct segment *s)
+{
+	return s->end - s->start;
+}
+
+int fastlog2(uint64_t sz)
+{
+	int l = 0;
+	if (sz == 0)
+		return 0;
+	for (; sz; sz /= 2) {
+		l++;
+	}
+	return l - 1;
+}
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
+{
+	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
+	int next = 0;
+	struct segment cur = { 0 };
+	int i = 0;
+
+	if (n == 0) {
+		*seglen = 0;
+		return segs;
+	}
+	for (i = 0; i < n; i++) {
+		int log = fastlog2(sizes[i]);
+		if (cur.log != log && cur.bytes > 0) {
+			struct segment fresh = {
+				.start = i,
+			};
+
+			segs[next++] = cur;
+			cur = fresh;
+		}
+
+		cur.log = log;
+		cur.end = i + 1;
+		cur.bytes += sizes[i];
+	}
+	segs[next++] = cur;
+	*seglen = next;
+	return segs;
+}
+
+struct segment suggest_compaction_segment(uint64_t *sizes, int n)
+{
+	int seglen = 0;
+	struct segment *segs = sizes_to_segments(&seglen, sizes, n);
+	struct segment min_seg = {
+		.log = 64,
+	};
+	int i = 0;
+	for (i = 0; i < seglen; i++) {
+		if (segment_size(&segs[i]) == 1) {
+			continue;
+		}
+
+		if (segs[i].log < min_seg.log) {
+			min_seg = segs[i];
+		}
+	}
+
+	while (min_seg.start > 0) {
+		int prev = min_seg.start - 1;
+		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
+			break;
+		}
+
+		min_seg.start = prev;
+		min_seg.bytes += sizes[prev];
+	}
+
+	reftable_free(segs);
+	return min_seg;
+}
+
+static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+{
+	uint64_t *sizes =
+		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
+	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
+	int overhead = header_size(version) - 1;
+	int i = 0;
+	for (i = 0; i < st->merged->stack_len; i++) {
+		sizes[i] = st->readers[i]->size - overhead;
+	}
+	return sizes;
+}
+
+int reftable_stack_auto_compact(struct reftable_stack *st)
+{
+	uint64_t *sizes = stack_table_sizes_for_compaction(st);
+	struct segment seg =
+		suggest_compaction_segment(sizes, st->merged->stack_len);
+	reftable_free(sizes);
+	if (segment_size(&seg) > 0)
+		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+						 NULL);
+
+	return 0;
+}
+
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st)
+{
+	return &st->stats;
+}
+
+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_table tab = { NULL };
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+	return reftable_table_read_ref(&tab, refname, ref);
+}
+
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log)
+{
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
+	int err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_log(&it, log);
+	if (err)
+		goto done;
+
+	if (strcmp(log->refname, refname) ||
+	    reftable_log_record_is_deletion(log)) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	if (err) {
+		reftable_log_record_clear(log);
+	}
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
+{
+	int err = 0;
+	struct reftable_block_source src = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct reftable_ref_record *refs = NULL;
+	struct reftable_iterator it = { NULL };
+	int cap = 0;
+	int len = 0;
+	int i = 0;
+
+	if (st->config.skip_name_check)
+		return 0;
+
+	err = reftable_block_source_from_file(&src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&rd, &src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_reader_seek_ref(rd, &it, "");
+	if (err > 0) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		struct reftable_ref_record ref = { 0 };
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0)
+			goto done;
+
+		if (len >= cap) {
+			cap = 2 * cap + 1;
+			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
+		}
+
+		refs[len++] = ref;
+	}
+
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+
+	err = validate_ref_record_addition(tab, refs, len);
+
+done:
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_clear(&refs[i]);
+	}
+
+	free(refs);
+	reftable_iterator_destroy(&it);
+	reftable_reader_free(rd);
+	return err;
+}
diff --git a/reftable/stack.h b/reftable/stack.h
new file mode 100644
index 0000000000..5ef138b025
--- /dev/null
+++ b/reftable/stack.h
@@ -0,0 +1,50 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef STACK_H
+#define STACK_H
+
+#include "reftable.h"
+#include "system.h"
+
+struct reftable_stack {
+	char *list_file;
+	char *reftable_dir;
+	int disable_auto_compact;
+
+	struct reftable_write_options config;
+
+	struct reftable_reader **readers;
+	size_t readers_len;
+	struct reftable_merged_table *merged;
+	struct reftable_compaction_stats stats;
+};
+
+int read_lines(const char *filename, char ***lines);
+int stack_try_add(struct reftable_stack *st,
+		  int (*write_table)(struct reftable_writer *wr, void *arg),
+		  void *arg);
+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
+			int first, int last,
+			struct reftable_log_expiry_config *config);
+int fastlog2(uint64_t sz);
+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
+void reftable_addition_close(struct reftable_addition *add);
+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+				      int reuse_open);
+
+struct segment {
+	int start, end;
+	int log;
+	uint64_t bytes;
+};
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
+struct segment suggest_compaction_segment(uint64_t *sizes, int n);
+
+#endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
new file mode 100644
index 0000000000..de806441dc
--- /dev/null
+++ b/reftable/stack_test.c
@@ -0,0 +1,787 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+
+#include "merged.h"
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+#include <sys/types.h>
+#include <dirent.h>
+
+static void test_read_file(void)
+{
+	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
+	int fd = mkstemp(fn);
+	char out[1024] = "line1\n\nline2\nline3";
+	int n, err;
+	char **names = NULL;
+	char *want[] = { "line1", "line2", "line3" };
+	int i = 0;
+
+	assert(fd > 0);
+	n = write(fd, out, strlen(out));
+	assert(n == strlen(out));
+	err = close(fd);
+	assert(err >= 0);
+
+	err = read_lines(fn, &names);
+	assert_err(err);
+
+	for (i = 0; names[i] != NULL; i++) {
+		assert(0 == strcmp(want[i], names[i]));
+	}
+	free_names(names);
+	remove(fn);
+}
+
+static void test_parse_names(void)
+{
+	char buf[] = "line\n";
+	char **names = NULL;
+	parse_names(buf, strlen(buf), &names);
+
+	assert(NULL != names[0]);
+	assert(0 == strcmp(names[0], "line"));
+	assert(NULL == names[1]);
+	free_names(names);
+}
+
+static void test_names_equal(void)
+{
+	char *a[] = { "a", "b", "c", NULL };
+	char *b[] = { "a", "b", "d", NULL };
+	char *c[] = { "a", "b", NULL };
+
+	assert(names_equal(a, a));
+	assert(!names_equal(a, b));
+	assert(!names_equal(a, c));
+}
+
+static int write_test_ref(struct reftable_writer *wr, void *arg)
+{
+	struct reftable_ref_record *ref = arg;
+	reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
+	return reftable_writer_add_ref(wr, ref);
+}
+
+struct write_log_arg {
+	struct reftable_log_record *log;
+	uint64_t update_index;
+};
+
+static int write_test_log(struct reftable_writer *wr, void *arg)
+{
+	struct write_log_arg *wla = arg;
+
+	reftable_writer_set_limits(wr, wla->update_index, wla->update_index);
+	return reftable_writer_add_log(wr, wla->log);
+}
+
+static void test_reftable_stack_add_one(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st, ref.refname, &dest);
+	assert_err(err);
+	assert(0 == strcmp("master", dest.target));
+
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_uptodate(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st1 = NULL;
+	struct reftable_stack *st2 = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int err;
+	struct reftable_ref_record ref1 = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.refname = "branch2",
+		.update_index = 2,
+		.target = "master",
+	};
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st1, dir, cfg);
+	assert_err(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st1, &write_test_ref, &ref1);
+	assert_err(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	assert(err == REFTABLE_LOCK_ERROR);
+
+	err = reftable_stack_reload(st2);
+	assert_err(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	assert_err(err);
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_transaction_api(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_addition *add = NULL;
+
+	struct reftable_ref_record ref = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_new_addition(&add, st);
+	assert_err(err);
+
+	err = reftable_addition_add(add, &write_test_ref, &ref);
+	assert_err(err);
+
+	err = reftable_addition_commit(add);
+	assert_err(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_read_ref(st, ref.refname, &dest);
+	assert_err(err);
+	assert(0 == strcmp("master", dest.target));
+
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_validate_refname(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int i;
+	struct reftable_ref_record ref = {
+		.refname = "a/b",
+		.update_index = 1,
+		.target = "master",
+	};
+	char *additions[] = { "a", "a/b/c" };
+
+	assert(mkdtemp(dir));
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	for (i = 0; i < ARRAY_SIZE(additions); i++) {
+		struct reftable_ref_record ref = {
+			.refname = additions[i],
+			.update_index = 1,
+			.target = "master",
+		};
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		assert(err == REFTABLE_NAME_CONFLICT);
+	}
+
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+static int write_error(struct reftable_writer *wr, void *arg)
+{
+	return *((int *)arg);
+}
+
+static void test_reftable_stack_update_index_check(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref1 = {
+		.refname = "name1",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.refname = "name2",
+		.update_index = 1,
+		.target = "master",
+	};
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref1);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref2);
+	assert(err == REFTABLE_API_ERROR);
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_lock_failure(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err, i;
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
+		err = reftable_stack_add(st, &write_error, &i);
+		assert(err == i);
+	}
+
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_add(void)
+{
+	int i = 0;
+	int err = 0;
+	struct reftable_write_options cfg = {
+		.exact_log_message = 1,
+	};
+	struct reftable_stack *st = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_ref_record refs[2] = { { 0 } };
+	struct reftable_log_record logs[2] = { { 0 } };
+	int N = ARRAY_SIZE(refs);
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+	st->disable_auto_compact = 1;
+
+	for (i = 0; i < N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+		refs[i].refname = xstrdup(buf);
+		refs[i].value = reftable_malloc(SHA1_SIZE);
+		refs[i].update_index = i + 1;
+		set_test_hash(refs[i].value, i);
+
+		logs[i].refname = xstrdup(buf);
+		logs[i].update_index = N + i + 1;
+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+		logs[i].email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		assert_err(err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		struct reftable_ref_record dest = { 0 };
+		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
+		assert_err(err);
+		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
+		reftable_ref_record_clear(&dest);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct reftable_log_record dest = { 0 };
+		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
+		assert_err(err);
+		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
+		reftable_log_record_clear(&dest);
+	}
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_clear(&refs[i]);
+		reftable_log_record_clear(&logs[i]);
+	}
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_log_normalize(void)
+{
+	int err = 0;
+	struct reftable_write_options cfg = {
+		0,
+	};
+	struct reftable_stack *st = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+
+	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
+
+	struct reftable_log_record input = {
+		.refname = "branch",
+		.update_index = 1,
+		.new_hash = h1,
+		.old_hash = h2,
+	};
+	struct reftable_log_record dest = {
+		.update_index = 0,
+	};
+	struct write_log_arg arg = {
+		.log = &input,
+		.update_index = 1,
+	};
+
+	assert(mkdtemp(dir));
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	input.message = "one\ntwo";
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	assert(err == REFTABLE_API_ERROR);
+
+	input.message = "one";
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	assert_err(err);
+
+	err = reftable_stack_read_log(st, input.refname, &dest);
+	assert_err(err);
+	assert(0 == strcmp(dest.message, "one\n"));
+
+	input.message = "two\n";
+	arg.update_index = 2;
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	assert_err(err);
+	err = reftable_stack_read_log(st, input.refname, &dest);
+	assert_err(err);
+	assert(0 == strcmp(dest.message, "two\n"));
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	reftable_log_record_clear(&dest);
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_tombstone(void)
+{
+	int i = 0;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record refs[2] = { { 0 } };
+	struct reftable_log_record logs[2] = { { 0 } };
+	int N = ARRAY_SIZE(refs);
+	struct reftable_ref_record dest = { 0 };
+	struct reftable_log_record log_dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		const char *buf = "branch";
+		refs[i].refname = xstrdup(buf);
+		refs[i].update_index = i + 1;
+		if (i % 2 == 0) {
+			refs[i].value = reftable_malloc(SHA1_SIZE);
+			set_test_hash(refs[i].value, i);
+		}
+		logs[i].refname = xstrdup(buf);
+		/* update_index is part of the key. */
+		logs[i].update_index = 42;
+		if (i % 2 == 0) {
+			logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+			set_test_hash(logs[i].new_hash, i);
+			logs[i].email = xstrdup("identity@invalid");
+		}
+	}
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		assert_err(err);
+	}
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	assert(err == 1);
+	reftable_ref_record_clear(&dest);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	assert(err == 1);
+	reftable_log_record_clear(&log_dest);
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	assert(err == 1);
+	reftable_ref_record_clear(&dest);
+	reftable_log_record_clear(&log_dest);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_clear(&refs[i]);
+		reftable_log_record_clear(&logs[i]);
+	}
+	reftable_clear_dir(dir);
+}
+
+static void test_reftable_stack_hash_id(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+
+	struct reftable_ref_record ref = {
+		.refname = "master",
+		.target = "target",
+		.update_index = 1,
+	};
+	struct reftable_write_options cfg32 = { .hash_id = SHA256_ID };
+	struct reftable_stack *st32 = NULL;
+	struct reftable_write_options cfg_default = { 0 };
+	struct reftable_stack *st_default = NULL;
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	/* can't read it with the wrong hash ID. */
+	err = reftable_new_stack(&st32, dir, cfg32);
+	assert(err == REFTABLE_FORMAT_ERROR);
+
+	/* check that we can read it back with default config too. */
+	err = reftable_new_stack(&st_default, dir, cfg_default);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st_default, "master", &dest);
+	assert_err(err);
+
+	assert(!strcmp(dest.target, ref.target));
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st_default);
+	reftable_clear_dir(dir);
+}
+
+static void test_log2(void)
+{
+	assert(1 == fastlog2(3));
+	assert(2 == fastlog2(4));
+	assert(2 == fastlog2(5));
+}
+
+static void test_sizes_to_segments(void)
+{
+	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
+	/* .................0  1  2  3  4  5 */
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(segs[2].log == 3);
+	assert(segs[2].start == 5);
+	assert(segs[2].end == 6);
+
+	assert(segs[1].log == 2);
+	assert(segs[1].start == 2);
+	assert(segs[1].end == 5);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_empty(void)
+{
+	uint64_t sizes[0];
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(seglen == 0);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_all_equal(void)
+{
+	uint64_t sizes[] = { 5, 5 };
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(seglen == 1);
+	assert(segs[0].start == 0);
+	assert(segs[0].end == 2);
+	reftable_free(segs);
+}
+
+static void test_suggest_compaction_segment(void)
+{
+	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
+	/* .................0    1    2  3   4  5  6 */
+	struct segment min =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	assert(min.start == 2);
+	assert(min.end == 7);
+}
+
+static void test_suggest_compaction_segment_nothing(void)
+{
+	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
+	struct segment result =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	assert(result.start == result.end);
+}
+
+static void test_reflog_expire(void)
+{
+	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	struct reftable_log_record logs[20] = { { 0 } };
+	int N = ARRAY_SIZE(logs) - 1;
+	int i = 0;
+	int err;
+	struct reftable_log_expiry_config expiry = {
+		.time = 10,
+	};
+	struct reftable_log_record log = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 1; i <= N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+
+		logs[i].refname = xstrdup(buf);
+		logs[i].update_index = i;
+		logs[i].time = i;
+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+		logs[i].email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].new_hash, i);
+	}
+
+	for (i = 1; i <= N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	err = reftable_stack_compact_all(st, &expiry);
+	assert_err(err);
+
+	err = reftable_stack_read_log(st, logs[9].refname, &log);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, logs[11].refname, &log);
+	assert_err(err);
+
+	expiry.min_update_index = 15;
+	err = reftable_stack_compact_all(st, &expiry);
+	assert_err(err);
+
+	err = reftable_stack_read_log(st, logs[14].refname, &log);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, logs[16].refname, &log);
+	assert_err(err);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i <= N; i++) {
+		reftable_log_record_clear(&logs[i]);
+	}
+	reftable_clear_dir(dir);
+	reftable_log_record_clear(&log);
+}
+
+static int write_nothing(struct reftable_writer *wr, void *arg)
+{
+	reftable_writer_set_limits(wr, 1, 1);
+	return 0;
+}
+
+static void test_empty_add(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_stack *st2 = NULL;
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_nothing, NULL);
+	assert_err(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	assert_err(err);
+	reftable_clear_dir(dir);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st2);
+}
+
+static void test_reftable_stack_auto_compaction(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int err, i;
+	int N = 100;
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.target = "master",
+		};
+		snprintf(name, sizeof(name), "branch%04d", i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		assert_err(err);
+
+		assert(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+	}
+
+	assert(reftable_stack_compaction_stats(st)->entries_written <
+	       (uint64_t)(N * fastlog2(N)));
+
+	reftable_stack_destroy(st);
+	reftable_clear_dir(dir);
+}
+
+int stack_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_reftable_stack_uptodate",
+		      &test_reftable_stack_uptodate);
+	add_test_case("test_reftable_stack_transaction_api",
+		      &test_reftable_stack_transaction_api);
+	add_test_case("test_reftable_stack_hash_id",
+		      &test_reftable_stack_hash_id);
+	add_test_case("test_sizes_to_segments_all_equal",
+		      &test_sizes_to_segments_all_equal);
+	add_test_case("test_reftable_stack_auto_compaction",
+		      &test_reftable_stack_auto_compaction);
+	add_test_case("test_reftable_stack_validate_refname",
+		      &test_reftable_stack_validate_refname);
+	add_test_case("test_reftable_stack_update_index_check",
+		      &test_reftable_stack_update_index_check);
+	add_test_case("test_reftable_stack_lock_failure",
+		      &test_reftable_stack_lock_failure);
+	add_test_case("test_reftable_stack_log_normalize",
+		      &test_reftable_stack_log_normalize);
+	add_test_case("test_reftable_stack_tombstone",
+		      &test_reftable_stack_tombstone);
+	add_test_case("test_reftable_stack_add_one",
+		      &test_reftable_stack_add_one);
+	add_test_case("test_empty_add", test_empty_add);
+	add_test_case("test_reflog_expire", test_reflog_expire);
+	add_test_case("test_suggest_compaction_segment",
+		      &test_suggest_compaction_segment);
+	add_test_case("test_suggest_compaction_segment_nothing",
+		      &test_suggest_compaction_segment_nothing);
+	add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
+	add_test_case("test_sizes_to_segments_empty",
+		      &test_sizes_to_segments_empty);
+	add_test_case("test_log2", &test_log2);
+	add_test_case("test_parse_names", &test_parse_names);
+	add_test_case("test_read_file", &test_read_file);
+	add_test_case("test_names_equal", &test_names_equal);
+	add_test_case("test_reftable_stack_add", &test_reftable_stack_add);
+	return test_main(argc, argv);
+}
diff --git a/reftable/update.sh b/reftable/update.sh
new file mode 100755
index 0000000000..4dadd875f4
--- /dev/null
+++ b/reftable/update.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+set -eu
+
+# Override this to import from somewhere else, say "../reftable".
+SRC=${SRC:-origin}
+BRANCH=${BRANCH:-master}
+
+((git --git-dir reftable-repo/.git fetch -f ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
+   git clone https://github.com/google/reftable reftable-repo)
+
+cp reftable-repo/c/*.[ch] reftable/
+cp reftable-repo/c/include/*.[ch] reftable/
+cp reftable-repo/LICENSE reftable/
+
+git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
+  > reftable/VERSION
+
+mv reftable/system.h reftable/system.h~
+sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
+
+git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 2273fdfe39..def8883439 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -4,9 +4,12 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	block_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	record_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	reftable_test_main(argc, argv);
 	strbuf_test_main(argc, argv);
+	stack_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

