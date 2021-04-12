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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B278C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4861356
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhDLT06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbhDLT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB20C061343
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y204so6066244wmg.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QKv0YKmpVM9P9g2Xd45S4BlvGngzGS7pmPQPkX0gIv0=;
        b=ftiW2xmfMB2g+0tScRCBGjm2IadOxjoYJpUOn5UBvEddSg2qKba7I2j/fvVAVXfARy
         oyPFyvSH0tKA9ogNqqETu/CD9FFODHfeoe6DWBA7mMO+5U2wg0O9lOhBfLdtQui+c2hA
         8dBm2jOo8oaW4feWMCck6DfLkMS1lEdx4hGINcCfs2xlU7wZXFNrRkn7Ey7FoxekfE0O
         X3xnXXjPSo+wlwponTyjqAeijYNqb3nFAMkztWWRZtmfUwXTy0uN4ZZCh/cV9XMw/gVZ
         LvEkZb0A07drAPMNxnAiLVpqczwAMwN6WfPhr2K/tmYzsjBETyymoUK3pIHUz8YZzXYt
         hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QKv0YKmpVM9P9g2Xd45S4BlvGngzGS7pmPQPkX0gIv0=;
        b=R1+OQ3ZgGLfDy+AuSDwsCGn/zN0SPhD6m3vYgi78gUQNcgU5AIhmGFXWrAhHNxUrTZ
         +719koEfp/DXv+LFHAqwDgO/Lr3CTAriWg1BzIA5pYRaW+DlHa1fLNF9+gsjnqRa/d0W
         pdms6O9/OSOSKE+cXfkVSrEPArQL8tCmRsULwQKYaN+1nuefwbxU1cpzVt+MbzMp8DwA
         g4R6+ld4T6tU8iLtSRI7vZAeGryQlJXsn5TtHa0+0dck2Qe7mdoRVtwn8jmAGUk6IqPE
         fjKrVj7t1e8lqvNtdiGxzqOpqwlHQOYZA2emAXMJtZe6if6dysaoiDXGRjnIGXu0dtga
         7gpA==
X-Gm-Message-State: AOAM531HkIWSjE7gRw2B24cc52/PHW+iRwaBkHqmIdgJmxDheLaUOwo1
        ZGhMqraZakalTxWOx9+Thqt4HOJe7a0=
X-Google-Smtp-Source: ABdhPJy+N6RKsE03ciRQdDDoEnH7SDJP127TPc01qo0dZDii02MlU+MN/KeZ724wdeTQpXa4e2YsKw==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr613374wmc.114.1618255567204;
        Mon, 12 Apr 2021 12:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm18435729wrt.22.2021.04.12.12.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:26:06 -0700 (PDT)
Message-Id: <39e644b9436b42fd42da463d6ddec2bf64572ef5.1618255553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:52 +0000
Subject: [PATCH v6 20/20] Add "test-tool dump-reftable" command.
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
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |  1 +
 reftable/dump.c          | 67 ++++++++++++++++++++--------------------
 t/helper/test-reftable.c |  5 +++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 5 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 5890e7d1cbb2..870155d48b58 100644
--- a/Makefile
+++ b/Makefile
@@ -2420,6 +2420,7 @@ REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
diff --git a/reftable/dump.c b/reftable/dump.c
index 00b444e8c9b8..7d620a3cf0fe 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -12,18 +12,25 @@ license that can be found in the LICENSE file or at
 #include <unistd.h>
 #include <string.h>
 
-#include "reftable.h"
+#include "reftable-blocksource.h"
+#include "reftable-error.h"
+#include "reftable-merged.h"
+#include "reftable-record.h"
 #include "reftable-tests.h"
+#include "reftable-writer.h"
+#include "reftable-iterator.h"
+#include "reftable-reader.h"
+#include "reftable-stack.h"
 
 static uint32_t hash_id;
 
 static int dump_table(const char *tablename)
 {
-	struct reftable_block_source src = { 0 };
+	struct reftable_block_source src = { NULL };
 	int err = reftable_block_source_from_file(&src, tablename);
-	struct reftable_iterator it = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_log_record log = { NULL };
 	struct reftable_reader *r = NULL;
 
 	if (err < 0)
@@ -49,7 +56,7 @@ static int dump_table(const char *tablename)
 		reftable_ref_record_print(&ref, hash_id);
 	}
 	reftable_iterator_destroy(&it);
-	reftable_ref_record_clear(&ref);
+	reftable_ref_record_release(&ref);
 
 	err = reftable_reader_seek_log(r, &it, "");
 	if (err < 0) {
@@ -66,7 +73,7 @@ static int dump_table(const char *tablename)
 		reftable_log_record_print(&log, hash_id);
 	}
 	reftable_iterator_destroy(&it);
-	reftable_log_record_clear(&log);
+	reftable_log_record_release(&log);
 
 	reftable_reader_free(r);
 	return 0;
@@ -75,7 +82,7 @@ static int dump_table(const char *tablename)
 static int compact_stack(const char *stackdir)
 {
 	struct reftable_stack *stack = NULL;
-	struct reftable_write_options cfg = {};
+	struct reftable_write_options cfg = { 0 };
 
 	int err = reftable_new_stack(&stack, stackdir, cfg);
 	if (err < 0)
@@ -94,10 +101,10 @@ static int compact_stack(const char *stackdir)
 static int dump_stack(const char *stackdir)
 {
 	struct reftable_stack *stack = NULL;
-	struct reftable_write_options cfg = {};
-	struct reftable_iterator it = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_log_record log = { 0 };
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_log_record log = { NULL };
 	struct reftable_merged_table *merged = NULL;
 
 	int err = reftable_new_stack(&stack, stackdir, cfg);
@@ -122,7 +129,7 @@ static int dump_stack(const char *stackdir)
 		reftable_ref_record_print(&ref, hash_id);
 	}
 	reftable_iterator_destroy(&it);
-	reftable_ref_record_clear(&ref);
+	reftable_ref_record_release(&ref);
 
 	err = reftable_merged_table_seek_log(merged, &it, "");
 	if (err < 0) {
@@ -139,7 +146,7 @@ static int dump_stack(const char *stackdir)
 		reftable_log_record_print(&log, hash_id);
 	}
 	reftable_iterator_destroy(&it);
-	reftable_log_record_clear(&log);
+	reftable_log_record_release(&log);
 
 	reftable_stack_destroy(stack);
 	return 0;
@@ -160,40 +167,34 @@ static void print_help(void)
 int reftable_dump_main(int argc, char *const *argv)
 {
 	int err = 0;
-	int opt;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
 	int opt_compact = 0;
-	const char *arg = NULL;
-	while ((opt = getopt(argc, argv, "2chts")) != -1) {
-		switch (opt) {
-		case '2':
-			hash_id = 0x73323536;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
 			break;
-		case 't':
+		else if (!strcmp("-2", argv[1]))
+			hash_id = 0x73323536;
+		else if (!strcmp("-t", argv[1]))
 			opt_dump_table = 1;
-			break;
-		case 's':
+		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
-			break;
-		case 'c':
+		else if (!strcmp("-c", argv[1]))
 			opt_compact = 1;
-			break;
-		case '?':
-		case 'h':
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
-			break;
 		}
-	}
 
-	if (argv[optind] == NULL) {
+	if (argc != 2) {
 		fprintf(stderr, "need argument\n");
 		print_help();
 		return 2;
 	}
 
-	arg = argv[optind];
+	arg = argv[1];
 
 	if (opt_dump_table) {
 		err = dump_table(arg);
@@ -204,7 +205,7 @@ int reftable_dump_main(int argc, char *const *argv)
 	}
 
 	if (err < 0) {
-		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
 			reftable_error_str(err));
 		return 1;
 	}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 2efe48b23bbb..09e727721fe9 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -14,3 +14,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 814d2606f8ca..bf4958492386 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,6 +57,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 789c26f302dd..f195a7539cd2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -18,6 +18,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
-- 
gitgitgadget
