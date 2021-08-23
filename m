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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176FC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285426137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhHWMOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhHWMNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9033C0617AE
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15so10379813wmj.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmzhU/CBryVe7vP+R8HblMKuS0r2HDS5CKv/UGBNOVY=;
        b=UpbPZ+OySi28akgX5alJAaE+e+UX/3Tu0dUx2Im4DGA811zx0xd+jnxLTzdBIyf0fo
         Sl9sqmtDczUZwlHyxSwdZ3BfRkR2SM4F1JDBpdlU4+2F3eA+nPVjC4tntvkYcFCae3m7
         Lt17pfZM05P7D3MIB4F/HSggLGidVPTMhjPYzJzyYcADEB/QVfmTXQVD9kxbmDLa1XKH
         qI1Y33DWK6zyf3A/2YCZmS98bl+hk1RiK+0pLy35T/DXfgRXu4b23vg2LwY/flcFgj0C
         InG3CutUCEcxRENTa3zUROHa1pjxCjfIn4NxQY7LGnIS00cO92iRx+QHK8d9LBxmTC6S
         3HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmzhU/CBryVe7vP+R8HblMKuS0r2HDS5CKv/UGBNOVY=;
        b=iMzAJ9yLwLM5cxnR3JvPv6aTNK4UDEQJxQXaQfsLpIMudFzlB/w7pmRbCwuS0KrV0y
         PpGVtpU/7i9p70Y8/zA/V9/J85VV7BvMaLgiubvjpqINFecQji3U1mW+YJ5/kEkpbMkR
         6aT+CJWvOEcO5xAklob2XSiYEa4e7TqNG0n8yEKuWTVOH0SLr9F/jRzfIPbb6v741QHs
         2oUps4hj9t7001eUWfMMy68F+iGlz3MvCm7DoVgU15dZhjN+hlusH7dGihR+BH3xij10
         FOi1B07oJ9aEUnf2fUoUXwTpEBroENJ2M+73vo7SWsM4/EAhC9id4S0u2CvmqPvRKWp6
         xqsQ==
X-Gm-Message-State: AOAM533yVlCDrtvHwflmQ9LUaObwWG8iTA3nGgqB5hVvy8HCtFt2hve0
        ML5V9qgJNit6+0/O2ot/YkiHjVtaqdwv9jo/
X-Google-Smtp-Source: ABdhPJx6c9IgewXOcRAlewDcj3AGPWdGShe2B+xZA7WFUoqnyPgUN9So+ZiiRzk3YvJ9TR6+EFPhrA==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr16007565wmq.101.1629720787193;
        Mon, 23 Aug 2021 05:13:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 14/28] reftable: reftable file level tests
Date:   Mon, 23 Aug 2021 14:12:25 +0200
Message-Id: <patch-v4-14.28-ebe55aa6295-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

With support for reading and writing files in place, we can construct files (in
memory) and attempt to read them back.

Because some sections of the format are optional (eg. indices, log entries), we
have to exercise this code using multiple sizes of input data

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |   1 +
 reftable/readwrite_test.c | 652 ++++++++++++++++++++++++++++++++++++++
 reftable/reftable-tests.h |   2 +-
 t/helper/test-reftable.c  |   1 +
 4 files changed, 655 insertions(+), 1 deletion(-)
 create mode 100644 reftable/readwrite_test.c

diff --git a/Makefile b/Makefile
index 5c857989091..5e2ff446894 100644
--- a/Makefile
+++ b/Makefile
@@ -2469,6 +2469,7 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
new file mode 100644
index 00000000000..5f6bcc2f775
--- /dev/null
+++ b/reftable/readwrite_test.c
@@ -0,0 +1,652 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "block.h"
+#include "blocksource.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+#include "reftable-writer.h"
+
+static const int update_index = 5;
+
+static void test_buffer(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_block_source source = { NULL };
+	struct reftable_block out = { NULL };
+	int n;
+	uint8_t in[] = "hello";
+	strbuf_add(&buf, in, sizeof(in));
+	block_source_from_strbuf(&source, &buf);
+	EXPECT(block_source_size(&source) == 6);
+	n = block_source_read_block(&source, &out, 0, sizeof(in));
+	EXPECT(n == sizeof(in));
+	EXPECT(!memcmp(in, out.data, n));
+	reftable_block_done(&out);
+
+	n = block_source_read_block(&source, &out, 1, 2);
+	EXPECT(n == 2);
+	EXPECT(!memcmp(out.data, "el", 2));
+
+	reftable_block_done(&out);
+	block_source_close(&source);
+	strbuf_release(&buf);
+}
+
+static void write_table(char ***names, struct strbuf *buf, int N,
+			int block_size, uint32_t hash_id)
+{
+	struct reftable_write_options opts = {
+		.block_size = block_size,
+		.hash_id = hash_id,
+	};
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, buf, &opts);
+	struct reftable_ref_record ref = { NULL };
+	int i = 0, n;
+	struct reftable_log_record log = { NULL };
+	const struct reftable_stats *stats = NULL;
+	*names = reftable_calloc(sizeof(char *) * (N + 1));
+	reftable_writer_set_limits(w, update_index, update_index);
+	for (i = 0; i < N; i++) {
+		uint8_t hash[GIT_SHA256_RAWSZ] = { 0 };
+		char name[100];
+		int n;
+
+		set_test_hash(hash, i);
+
+		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
+
+		ref.refname = name;
+		ref.update_index = update_index;
+		ref.value_type = REFTABLE_REF_VAL1;
+		ref.value.val1 = hash;
+		(*names)[i] = xstrdup(name);
+
+		n = reftable_writer_add_ref(w, &ref);
+		EXPECT(n == 0);
+	}
+
+	for (i = 0; i < N; i++) {
+		uint8_t hash[GIT_SHA256_RAWSZ] = { 0 };
+		char name[100];
+		int n;
+
+		set_test_hash(hash, i);
+
+		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
+
+		log.refname = name;
+		log.update_index = update_index;
+		log.value_type = REFTABLE_LOG_UPDATE;
+		log.value.update.new_hash = hash;
+		log.value.update.message = "message";
+
+		n = reftable_writer_add_log(w, &log);
+		EXPECT(n == 0);
+	}
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	stats = writer_stats(w);
+	for (i = 0; i < stats->ref_stats.blocks; i++) {
+		int off = i * opts.block_size;
+		if (off == 0) {
+			off = header_size(
+				(hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
+		}
+		EXPECT(buf->buf[off] == 'r');
+	}
+
+	EXPECT(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+}
+
+static void test_log_buffer_size(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_write_options opts = {
+		.block_size = 4096,
+	};
+	int err;
+	int i;
+	struct reftable_log_record
+		log = { .refname = "refs/heads/master",
+			.update_index = 0xa,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = { .update = {
+					   .name = "Han-Wen Nienhuys",
+					   .email = "hanwen@google.com",
+					   .tz_offset = 100,
+					   .time = 0x5e430672,
+					   .message = "commit: 9\n",
+				   } } };
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	/* This tests buffer extension for log compression. Must use a random
+	   hash, to ensure that the compressed part is larger than the original.
+	*/
+	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
+	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+		hash1[i] = (uint8_t)(rand() % 256);
+		hash2[i] = (uint8_t)(rand() % 256);
+	}
+	log.value.update.old_hash = hash1;
+	log.value.update.new_hash = hash2;
+	reftable_writer_set_limits(w, update_index, update_index);
+	err = reftable_writer_add_log(w, &log);
+	EXPECT_ERR(err);
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
+static void test_log_write_read(void)
+{
+	int N = 2;
+	char **names = reftable_calloc(sizeof(char *) * (N + 1));
+	int err;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { NULL };
+	int i = 0;
+	struct reftable_log_record log = { NULL };
+	int n;
+	struct reftable_iterator it = { NULL };
+	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { NULL };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	reftable_writer_set_limits(w, 0, N);
+	for (i = 0; i < N; i++) {
+		char name[256];
+		struct reftable_ref_record ref = { NULL };
+		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
+		names[i] = xstrdup(name);
+		ref.refname = name;
+		ref.update_index = i;
+
+		err = reftable_writer_add_ref(w, &ref);
+		EXPECT_ERR(err);
+	}
+	for (i = 0; i < N; i++) {
+		uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
+		struct reftable_log_record log = { NULL };
+		set_test_hash(hash1, i);
+		set_test_hash(hash2, i + 1);
+
+		log.refname = names[i];
+		log.update_index = i;
+		log.value_type = REFTABLE_LOG_UPDATE;
+		log.value.update.old_hash = hash1;
+		log.value.update.new_hash = hash2;
+
+		err = reftable_writer_add_log(w, &log);
+		EXPECT_ERR(err);
+	}
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	stats = writer_stats(w);
+	EXPECT(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, names[N - 1]);
+	EXPECT_ERR(err);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	EXPECT_ERR(err);
+
+	/* end of iteration. */
+	err = reftable_iterator_next_ref(&it, &ref);
+	EXPECT(0 < err);
+
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_release(&ref);
+
+	err = reftable_reader_seek_log(&rd, &it, "");
+	EXPECT_ERR(err);
+
+	i = 0;
+	while (1) {
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+
+		EXPECT_ERR(err);
+		EXPECT_STREQ(names[i], log.refname);
+		EXPECT(i == log.update_index);
+		i++;
+		reftable_log_record_release(&log);
+	}
+
+	EXPECT(i == N);
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	strbuf_release(&buf);
+	free_names(names);
+	reader_close(&rd);
+}
+
+static void test_table_read_write_sequential(void)
+{
+	char **names;
+	struct strbuf buf = STRBUF_INIT;
+	int N = 50;
+	struct reftable_iterator it = { NULL };
+	struct reftable_block_source source = { NULL };
+	struct reftable_reader rd = { NULL };
+	int err = 0;
+	int j = 0;
+
+	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, "");
+	EXPECT_ERR(err);
+
+	while (1) {
+		struct reftable_ref_record ref = { NULL };
+		int r = reftable_iterator_next_ref(&it, &ref);
+		EXPECT(r >= 0);
+		if (r > 0) {
+			break;
+		}
+		EXPECT(0 == strcmp(names[j], ref.refname));
+		EXPECT(update_index == ref.update_index);
+
+		j++;
+		reftable_ref_record_release(&ref);
+	}
+	EXPECT(j == N);
+	reftable_iterator_destroy(&it);
+	strbuf_release(&buf);
+	free_names(names);
+
+	reader_close(&rd);
+}
+
+static void test_table_write_small_table(void)
+{
+	char **names;
+	struct strbuf buf = STRBUF_INIT;
+	int N = 1;
+	write_table(&names, &buf, N, 4096, GIT_SHA1_FORMAT_ID);
+	EXPECT(buf.len < 200);
+	strbuf_release(&buf);
+	free_names(names);
+}
+
+static void test_table_read_api(void)
+{
+	char **names;
+	struct strbuf buf = STRBUF_INIT;
+	int N = 50;
+	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { NULL };
+	int err;
+	int i;
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+
+	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, names[0]);
+	EXPECT_ERR(err);
+
+	err = reftable_iterator_next_log(&it, &log);
+	EXPECT(err == REFTABLE_API_ERROR);
+
+	strbuf_release(&buf);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_free(names);
+	reader_close(&rd);
+	strbuf_release(&buf);
+}
+
+static void test_table_read_write_seek(int index, int hash_id)
+{
+	char **names;
+	struct strbuf buf = STRBUF_INIT;
+	int N = 50;
+	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { NULL };
+	int err;
+	int i = 0;
+
+	struct reftable_iterator it = { NULL };
+	struct strbuf pastLast = STRBUF_INIT;
+	struct reftable_ref_record ref = { NULL };
+
+	write_table(&names, &buf, N, 256, hash_id);
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	EXPECT_ERR(err);
+	EXPECT(hash_id == reftable_reader_hash_id(&rd));
+
+	if (!index) {
+		rd.ref_offsets.index_offset = 0;
+	} else {
+		EXPECT(rd.ref_offsets.index_offset > 0);
+	}
+
+	for (i = 1; i < N; i++) {
+		int err = reftable_reader_seek_ref(&rd, &it, names[i]);
+		EXPECT_ERR(err);
+		err = reftable_iterator_next_ref(&it, &ref);
+		EXPECT_ERR(err);
+		EXPECT(0 == strcmp(names[i], ref.refname));
+		EXPECT(REFTABLE_REF_VAL1 == ref.value_type);
+		EXPECT(i == ref.value.val1[0]);
+
+		reftable_ref_record_release(&ref);
+		reftable_iterator_destroy(&it);
+	}
+
+	strbuf_addstr(&pastLast, names[N - 1]);
+	strbuf_addstr(&pastLast, "/");
+
+	err = reftable_reader_seek_ref(&rd, &it, pastLast.buf);
+	if (err == 0) {
+		struct reftable_ref_record ref = { NULL };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		EXPECT(err > 0);
+	} else {
+		EXPECT(err > 0);
+	}
+
+	strbuf_release(&pastLast);
+	reftable_iterator_destroy(&it);
+
+	strbuf_release(&buf);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+	reftable_free(names);
+	reader_close(&rd);
+}
+
+static void test_table_read_write_seek_linear(void)
+{
+	test_table_read_write_seek(0, GIT_SHA1_FORMAT_ID);
+}
+
+static void test_table_read_write_seek_linear_sha256(void)
+{
+	test_table_read_write_seek(0, GIT_SHA256_FORMAT_ID);
+}
+
+static void test_table_read_write_seek_index(void)
+{
+	test_table_read_write_seek(1, GIT_SHA1_FORMAT_ID);
+}
+
+static void test_table_refs_for(int indexed)
+{
+	int N = 50;
+	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
+	int want_names_len = 0;
+	uint8_t want_hash[GIT_SHA1_RAWSZ];
+
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { NULL };
+	int i = 0;
+	int n;
+	int err;
+	struct reftable_reader rd;
+	struct reftable_block_source source = { NULL };
+
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	struct reftable_iterator it = { NULL };
+	int j;
+
+	set_test_hash(want_hash, 4);
+
+	for (i = 0; i < N; i++) {
+		uint8_t hash[GIT_SHA1_RAWSZ];
+		char fill[51] = { 0 };
+		char name[100];
+		uint8_t hash1[GIT_SHA1_RAWSZ];
+		uint8_t hash2[GIT_SHA1_RAWSZ];
+		struct reftable_ref_record ref = { NULL };
+
+		memset(hash, i, sizeof(hash));
+		memset(fill, 'x', 50);
+		/* Put the variable part in the start */
+		snprintf(name, sizeof(name), "br%02d%s", i, fill);
+		name[40] = 0;
+		ref.refname = name;
+
+		set_test_hash(hash1, i / 4);
+		set_test_hash(hash2, 3 + i / 4);
+		ref.value_type = REFTABLE_REF_VAL2;
+		ref.value.val2.value = hash1;
+		ref.value.val2.target_value = hash2;
+
+		/* 80 bytes / entry, so 3 entries per block. Yields 17
+		 */
+		/* blocks. */
+		n = reftable_writer_add_ref(w, &ref);
+		EXPECT(n == 0);
+
+		if (!memcmp(hash1, want_hash, GIT_SHA1_RAWSZ) ||
+		    !memcmp(hash2, want_hash, GIT_SHA1_RAWSZ)) {
+			want_names[want_names_len++] = xstrdup(name);
+		}
+	}
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	EXPECT_ERR(err);
+	if (!indexed) {
+		rd.obj_offsets.is_present = 0;
+	}
+
+	err = reftable_reader_seek_ref(&rd, &it, "");
+	EXPECT_ERR(err);
+	reftable_iterator_destroy(&it);
+
+	err = reftable_reader_refs_for(&rd, &it, want_hash);
+	EXPECT_ERR(err);
+
+	j = 0;
+	while (1) {
+		int err = reftable_iterator_next_ref(&it, &ref);
+		EXPECT(err >= 0);
+		if (err > 0) {
+			break;
+		}
+
+		EXPECT(j < want_names_len);
+		EXPECT(0 == strcmp(ref.refname, want_names[j]));
+		j++;
+		reftable_ref_record_release(&ref);
+	}
+	EXPECT(j == want_names_len);
+
+	strbuf_release(&buf);
+	free_names(want_names);
+	reftable_iterator_destroy(&it);
+	reader_close(&rd);
+}
+
+static void test_table_refs_for_no_index(void)
+{
+	test_table_refs_for(0);
+}
+
+static void test_table_refs_for_obj_index(void)
+{
+	test_table_refs_for(1);
+}
+
+static void test_write_empty_table(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_block_source source = { NULL };
+	struct reftable_reader *rd = NULL;
+	struct reftable_ref_record rec = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_close(w);
+	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+
+	EXPECT(buf.len == header_size(1) + footer_size(1));
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = reftable_new_reader(&rd, &source, "filename");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_ref(rd, &it, "");
+	EXPECT_ERR(err);
+
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT(err > 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_reader_free(rd);
+	strbuf_release(&buf);
+}
+
+static void test_write_key_order(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_ref_record refs[2] = {
+		{
+			.refname = "b",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_SYMREF,
+			.value = {
+				.symref = "target",
+			},
+		}, {
+			.refname = "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_SYMREF,
+			.value = {
+				.symref = "target",
+			},
+		}
+	};
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+	err = reftable_writer_add_ref(w, &refs[0]);
+	EXPECT_ERR(err);
+	err = reftable_writer_add_ref(w, &refs[1]);
+	printf("%d\n", err);
+	EXPECT(err == REFTABLE_API_ERROR);
+	reftable_writer_close(w);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
+static void test_corrupt_table_empty(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_block_source source = { NULL };
+	struct reftable_reader rd = { NULL };
+	int err;
+
+	block_source_from_strbuf(&source, &buf);
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT(err == REFTABLE_FORMAT_ERROR);
+}
+
+static void test_corrupt_table(void)
+{
+	uint8_t zeros[1024] = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_block_source source = { NULL };
+	struct reftable_reader rd = { NULL };
+	int err;
+	strbuf_add(&buf, zeros, sizeof(zeros));
+
+	block_source_from_strbuf(&source, &buf);
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	strbuf_release(&buf);
+}
+
+int readwrite_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_corrupt_table);
+	RUN_TEST(test_corrupt_table_empty);
+	RUN_TEST(test_log_write_read);
+	RUN_TEST(test_write_key_order);
+	RUN_TEST(test_table_read_write_seek_linear_sha256);
+	RUN_TEST(test_log_buffer_size);
+	RUN_TEST(test_table_write_small_table);
+	RUN_TEST(test_buffer);
+	RUN_TEST(test_table_read_api);
+	RUN_TEST(test_table_read_write_sequential);
+	RUN_TEST(test_table_read_write_seek_linear);
+	RUN_TEST(test_table_read_write_seek_index);
+	RUN_TEST(test_table_refs_for_no_index);
+	RUN_TEST(test_table_refs_for_obj_index);
+	RUN_TEST(test_write_empty_table);
+	return 0;
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 5e7698ae654..3d541fa5c0c 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -14,7 +14,7 @@ int block_test_main(int argc, const char **argv);
 int merged_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int refname_test_main(int argc, const char **argv);
-int reftable_test_main(int argc, const char **argv);
+int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 050551fa698..898aba836fd 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,6 +6,7 @@ int cmd__reftable(int argc, const char **argv)
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
 	record_test_main(argc, argv);
+	readwrite_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	return 0;
 }
-- 
2.33.0.662.gbaddc25a55e

