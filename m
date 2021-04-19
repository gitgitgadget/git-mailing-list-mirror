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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E352C43461
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AA361166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDSLkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhDSLis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F7C061347
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e5so4998780wrg.7
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xsBNNa3Z37m0YFtvv7zPjn4YHzUGqQGgDw0mkoJ8I8s=;
        b=Luq56eJMhvxc+8DkUmtfZ8ov1tMtbwlepZTxRayUa4l+NhhxR2n+GB45MalHuCbnDx
         30k9i4NELBEi9sfl+sNeGdCgF94Q7MJj8lfmYzqsicR8xOPa27LZN4FCcMdMCCeAXFfe
         ukQIFqYtIDyDTgPhiJw9nnhQzW77sWCO9LPXej1YpgCF0b359UHpI/C1HhRteWqt08qH
         9cflUqHxbRy601s8pa6bfv/6xyM2ZOspc+pTh9QwLqB6VFK8ONN1yZG7w5UxZ1sdxZ6w
         YLLbQvFBcPECW/p3DFnokkMUZrR2aE/6UjjIvd3s7AiTWlN71srbqHrjCoalaQfWBBDa
         25cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xsBNNa3Z37m0YFtvv7zPjn4YHzUGqQGgDw0mkoJ8I8s=;
        b=HW2J4IcoWbhSuI6WckCMuynGQ8P3FhOe3Er0tJX5gDZ4YDZ4BKieGO4SjYnkvRk8iK
         8cW3nwp5oyuSYw9Lagzr2IyhwTw8XlesSAfyxN5LGI0lP1xB54f+mDnbLArMR7fWV/Cg
         IZ3Kk6w9JfRYkuY8QcEwTLwQ6bsJKNxWHry4mMBCH/YIzc0eyXXP+wnFaq0k2Kd0GOmo
         LUp5RfA67Qa/S5rqcJMEh2KTfcd8/Vxabh55yBU8hfwSlk4BJQW4elztL+OJfgnfgD69
         v2L7M0d50ts47pOYXvOKd/F9J1sYDlqRu0pFeEyrALDAzrciDTfDdt0r/VOGbhJOzkMZ
         LR5g==
X-Gm-Message-State: AOAM531FPvzXx5MHkAXDu+pgRQb+7PnGBh7+uf52g0jrBvqCm1fN/psX
        e4Cg/TX7KeFcsl8w2kmEwrPNk9PwESM=
X-Google-Smtp-Source: ABdhPJwwwRrdHaksUgmHNF0d0FehYDhJVtR+aF7sZ8G95eZohMRSZZSFkMrlS7C0AeAQttBASo2hHQ==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr14156164wrv.346.1618832290816;
        Mon, 19 Apr 2021 04:38:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm22414321wrp.46.2021.04.19.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:10 -0700 (PDT)
Message-Id: <dc04ec88cf5388fc6eb7aa643f4462f57dc909c9.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:45 +0000
Subject: [PATCH v7 17/28] reftable: reftable file level tests
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
 reftable/readwrite_test.c | 621 ++++++++++++++++++++++++++++++++++++++
 reftable/reftable-tests.h |   2 +-
 t/helper/test-reftable.c  |   1 +
 4 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 reftable/readwrite_test.c

diff --git a/Makefile b/Makefile
index 6593e632ac08..26a805afb5ad 100644
--- a/Makefile
+++ b/Makefile
@@ -2425,6 +2425,7 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
new file mode 100644
index 000000000000..6520447a346d
--- /dev/null
+++ b/reftable/readwrite_test.c
@@ -0,0 +1,621 @@
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
+		log.update.new_hash = hash;
+		log.update.message = "message";
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
+			off = header_size((hash_id == GIT_SHA256_HASH_ID) ? 2 :
+										  1);
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
+	struct reftable_log_record log = { .refname = "refs/heads/master",
+					   .update_index = 0xa,
+					   .value_type = REFTABLE_LOG_UPDATE,
+					   .update = {
+						   .name = "Han-Wen Nienhuys",
+						   .email = "hanwen@google.com",
+						   .tz_offset = 100,
+						   .time = 0x5e430672,
+						   .message = "commit: 9\n",
+					   } };
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	/* This tests buffer extension for log compression. Must use a random
+	   hash, to ensure that the compressed part is larger than the original.
+	*/
+	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
+	for (int i = 0; i < GIT_SHA1_RAWSZ; i++) {
+		hash1[i] = (uint8_t)(rand() % 256);
+		hash2[i] = (uint8_t)(rand() % 256);
+	}
+	log.update.old_hash = hash1;
+	log.update.new_hash = hash2;
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
+		log.update.old_hash = hash1;
+		log.update.new_hash = hash2;
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
+	write_table(&names, &buf, N, 256, GIT_SHA1_HASH_ID);
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
+	write_table(&names, &buf, N, 4096, GIT_SHA1_HASH_ID);
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
+	write_table(&names, &buf, N, 256, GIT_SHA1_HASH_ID);
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
+	test_table_read_write_seek(0, GIT_SHA1_HASH_ID);
+}
+
+static void test_table_read_write_seek_linear_sha256(void)
+{
+	test_table_read_write_seek(0, GIT_SHA256_HASH_ID);
+}
+
+static void test_table_read_write_seek_index(void)
+{
+	test_table_read_write_seek(1, GIT_SHA1_HASH_ID);
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
+static void test_table_empty(void)
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
+int readwrite_test_main(int argc, const char *argv[])
+{
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
+	RUN_TEST(test_table_empty);
+	return 0;
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 5e7698ae654e..3d541fa5c0ce 100644
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
index 050551fa6985..898aba836fd1 100644
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
gitgitgadget

