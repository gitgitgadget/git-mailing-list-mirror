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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E2C19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACB423B52
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgLIOCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbgLIOB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE4C0611CA
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k10so1575104wmi.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HRt6qg3HoxpfIfenQCqKgOh/4F42DjruqupfohsyS+Y=;
        b=tJoCDMDQxzk8EWg+Wk4s4c0Hw2+RoCz4na/xxzW7BWEZOuE97ZLdkafe9oQ21ZxLSo
         HCR5uF7pD6iorUSUnWGhmuui4YNGEeR3+OlZ9Zpdsw+OXZtaUsaUypFg+8aPkBAO9cLw
         1mYepY/uDhDLNnDmTH9belfybwNW9/9BQcoTLY+uMhlhRmcXhzGd4v/VwSOyOeDqSZmr
         jSlheJ5JXN9Sqn3CJUcv2uzRvAy2CYTMWmbdkMuu0I8SNRz3xBZ8DwOaIB1+V/c0Pwoe
         2bx3TKcnZJ4STgVNtbTba5sMcsIRJM8QxvpM9YuMHngutIKIcDB8upKK/4k+U2ybl52n
         MTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HRt6qg3HoxpfIfenQCqKgOh/4F42DjruqupfohsyS+Y=;
        b=NvVwvpORSsieWzPvQ88h7SV902OdN1Z9iK6HMIybdzsSwPyi//ckZNXR1p6yt68zmi
         7NebzFBNq9KPxFbOSOG/I7otWIUDxK4QP4BlWvbtIo9aO0cnUI3ssp80ki+p48S0ShpU
         svrDuYJxijJMugZoJZiFgBPjT0W+PFjSnJiMMNrXWBw66mYUOc1xYRCPepA+eDrICzuI
         rzNBK22uJxZpW3mW8kPjZt1X1qdIXcp62Y9itv2/1XM9UFTpDDegyx9CwJXPuXdIiW0q
         hVNDKUp+qQ1Eem8aF8Di/NiYGr2xvJyxPJQwVqMagWKVgkTnppFg9QIOx+LFAlErGZOj
         YjNA==
X-Gm-Message-State: AOAM530S5drVaf2nVZaLpaYz1cO9VLHlO75Y4Ot2QOqRgMCLnb23LT94
        hnC4WpS4apH674nq11SQm0odBw1I2EM=
X-Google-Smtp-Source: ABdhPJxTHEMzMSpfQiQamKEpiwmwW1PR5YBTxzgssS22X3Nty/ZlE+l/F1hWN4audBrtwW+DF2QOdg==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr2933389wmi.179.1607522442111;
        Wed, 09 Dec 2020 06:00:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm3433400wml.34.2020.12.09.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:41 -0800 (PST)
Message-Id: <03681b820d132a270a08a52040c1ad55c12b8f4b.1607522429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:25 +0000
Subject: [PATCH v4 11/15] reftable: reftable file level tests
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

With support for reading and writing files in place, we can construct files (in
memory) and attempt to read them back.

Because some sections of the format are optional (eg. indices, log entries), we
have to exercise this code using multiple sizes of input data

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |   1 +
 reftable/reftable_test.c | 580 +++++++++++++++++++++++++++++++++++++++
 t/helper/test-reftable.c |   1 +
 3 files changed, 582 insertions(+)
 create mode 100644 reftable/reftable_test.c

diff --git a/Makefile b/Makefile
index 2bafcb1b62a..c913e90b643 100644
--- a/Makefile
+++ b/Makefile
@@ -2405,6 +2405,7 @@ REFTABLE_OBJS += reftable/zlib-compat.o
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/reftable_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/reftable_test.c b/reftable/reftable_test.c
new file mode 100644
index 00000000000..c58f7061833
--- /dev/null
+++ b/reftable/reftable_test.c
@@ -0,0 +1,580 @@
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
+#include "reftable-stack.h"
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
+		uint8_t hash[SHA256_SIZE] = { 0 };
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
+		uint8_t hash[SHA256_SIZE] = { 0 };
+		char name[100];
+		int n;
+
+		set_test_hash(hash, i);
+
+		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
+
+		log.refname = name;
+		log.new_hash = hash;
+		log.update_index = update_index;
+		log.message = "message";
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
+			off = header_size((hash_id == SHA256_ID) ? 2 : 1);
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
+	struct reftable_log_record log = {
+		.refname = "refs/heads/master",
+		.name = "Han-Wen Nienhuys",
+		.email = "hanwen@google.com",
+		.tz_offset = 100,
+		.time = 0x5e430672,
+		.update_index = 0xa,
+		.message = "commit: 9\n",
+	};
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+
+	/* This tests buffer extension for log compression. Must use a random
+	   hash, to ensure that the compressed part is larger than the original.
+	*/
+	uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
+	for (int i = 0; i < SHA1_SIZE; i++) {
+		hash1[i] = (uint8_t)(rand() % 256);
+		hash2[i] = (uint8_t)(rand() % 256);
+	}
+	log.old_hash = hash1;
+	log.new_hash = hash2;
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
+		uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
+		struct reftable_log_record log = { NULL };
+		set_test_hash(hash1, i);
+		set_test_hash(hash2, i + 1);
+
+		log.refname = names[i];
+		log.update_index = i;
+		log.old_hash = hash1;
+		log.new_hash = hash2;
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
+	write_table(&names, &buf, N, 256, SHA1_ID);
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
+	write_table(&names, &buf, N, 4096, SHA1_ID);
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
+	write_table(&names, &buf, N, 256, SHA1_ID);
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
+	test_table_read_write_seek(0, SHA1_ID);
+}
+
+static void test_table_read_write_seek_linear_sha256(void)
+{
+	test_table_read_write_seek(0, SHA256_ID);
+}
+
+static void test_table_read_write_seek_index(void)
+{
+	test_table_read_write_seek(1, SHA1_ID);
+}
+
+static void test_table_refs_for(int indexed)
+{
+	int N = 50;
+	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
+	int want_names_len = 0;
+	uint8_t want_hash[SHA1_SIZE];
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
+		uint8_t hash[SHA1_SIZE];
+		char fill[51] = { 0 };
+		char name[100];
+		uint8_t hash1[SHA1_SIZE];
+		uint8_t hash2[SHA1_SIZE];
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
+		if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
+		    !memcmp(hash2, want_hash, SHA1_SIZE)) {
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
+int reftable_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_log_write_read);
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
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 050551fa698..fdf92586737 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,6 +6,7 @@ int cmd__reftable(int argc, const char **argv)
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
 	record_test_main(argc, argv);
+	reftable_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

