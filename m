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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E8C19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5623B42
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLIOCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgLIOCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:02:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629CC0611CE
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so1870629wrt.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QeG/Uiv06sgOLRIt9htHLskysMZMELPOfsIsuyKEoEU=;
        b=GsSgBWmIjt/eV8E81HLGEF9k8eM/BPVMzHTOIpI1ZGQs0V/rHjRxoQ4ap5x4+v6cgs
         rz5PkEPzni4PaS+vF23gZ+2bQ+n/ezYMsJhoPhBwrYBLe4kQ0JBhQm0S9JXlTw2x9yxm
         opLLSU85kRO4wGFQC+QRyMpM3dUuEqy/QGEQdqBFn8HJnB0gXYJkD2KB7qXJ9Svm2xmn
         YXi9QPXOKNBNIicYMSYwflVAkRTdCqRm/bCrc0lzlckEYJDSxrdW54nqn06Trplwdfdl
         q4RsaHHKVGNUvznV7hKqmPQWEzxgZIIacQOI52e11BSgd1VLcWkUppPnKmkPsmOyIbql
         8feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QeG/Uiv06sgOLRIt9htHLskysMZMELPOfsIsuyKEoEU=;
        b=C6p1kEYSEurPMDcgrxBkslEDOCwWhwjk7PJZQvPyfp5x6vjAJnrpjcMhT7fcus+2LD
         m0DSCcaqTZGp3wo7FP9zLrGdhFw+imZfd23cEscNSMnQlaAMlpNMN4gJ8d06FL09IcMh
         5VQ9i1zX01U5Ds71Hn1uwxdN5i4RgmxE9BMWmZZd4HjT0dGGLpokrVSpKvqQYm1Rl1FO
         swv3D1vSLmBnyaRSD01fSg2+VqYkSSWtSpJVAkn1oKj6EbHBQiAGbXp2onye+ntpzONa
         iGMxHYD+y4F+b1h0O9r8cHlG/Z4NQGNqO8j6di471QGBSIA6/2QMK6RMog7MVMV7TAJx
         7egw==
X-Gm-Message-State: AOAM533cJuIW4WCCaQpK/c24R0WNA34o/B1F+UeIKOKBvWW9f1jK1D4B
        Jv0fhtMK9nPLYsM+Oc5JdtoXA+/SPW4=
X-Google-Smtp-Source: ABdhPJyXMJySKYICwXiN2yiVBexLl+RYPDA5ZJazuqd9Oig8DAU8O4qjGu6hgzNhncsPsLKh1T1hWQ==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr2907934wrv.229.1607522446608;
        Wed, 09 Dec 2020 06:00:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm3336137wrj.8.2020.12.09.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:46 -0800 (PST)
Message-Id: <4076ef5d20b4986cf857e70fffe1de9da3bb12e3.1607522430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:29 +0000
Subject: [PATCH v4 15/15] Add "test-tool dump-reftable" command.
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
index 6b7c8a165f4..2f9bf61fffb 100644
--- a/Makefile
+++ b/Makefile
@@ -2409,6 +2409,7 @@ REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
diff --git a/reftable/dump.c b/reftable/dump.c
index 00b444e8c9b..7d620a3cf0f 100644
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
index 3b702f4855e..c1ba131c3a4 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -13,3 +13,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0208a0a41cf..f064440a319 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -56,6 +56,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 1de39ce5b58..226af8c6b89 100644
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
