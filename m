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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A1C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880BB221E9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+WWIW6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405263AbgKZTmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405218AbgKZTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:53 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8297C0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so3356051wrt.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xtc07IM+71Y8wPDt9N7+A0pTFuovONSX24IPpPDUhS0=;
        b=o+WWIW6jpQH4i9flb+IOTOmHuTxDIhNfYUFTGe4WM4RmvVcH707XPL+rqHpiD5ZW6I
         RmiGVNt5fivSRQctxrY8Vum4LNfJZYaWwZgHelEEezGfJ2JiOz2lSMx8ox3+yFCrPO/m
         Nav0JeJXvC/5MMOXgkNwmO6T3bKy4ToPUuS9t6AZP+tfvtYmt7SNjSgM1dF3AGsx8Thb
         5+70TZgMgwygOnV0SYUYF9cbF4/EU8ELwpguACBTlTt8zHD4eez9ogKql2mOZHlNMPiR
         bBlHOJbzUI6IAn+aIp/aCLmu/f6sZhBZAux+0FpdtCjhJmYIwfs9iDyuVcfcFsCPoVus
         7jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xtc07IM+71Y8wPDt9N7+A0pTFuovONSX24IPpPDUhS0=;
        b=SNmkg8ViASnZGx5LeA3S9sBjjSCNFMYZ1qob/4DZDEN/GtVJ/+PMxkx8m0kvlzNfp8
         vHNgy6Dt4Da29JzhJAygCoPdXd5cCtETLFrGgtsZBReUDeUJ795URwswq3igwF11LrcC
         CuTOyfRP4KYFBQ6TU1/KWY3DXrIHp/LoR6Ukqv7pCALqxUbh7XfsTgj+rUkSkxakyoXd
         QIN++1XTFzV40mGbuKLQvmJAdiynNFWrRgpvUeMEtGesIDH0zjb6VaRBWFwfz2NYpug3
         odEumZXYiHRJjYcLe/kRQvnuUWh57y/Y1w31UTppeiNSjpDnA+cZ2DfJOLSH8HQsFJed
         ixzg==
X-Gm-Message-State: AOAM530Jlp+Sjzv6K0sMdFGDyATV+2/9Ud6bYIgJ9yANhY5rbnbZKqHz
        2u0+VN0JqFe5NrlbcV0O9VngKhzeFxY=
X-Google-Smtp-Source: ABdhPJxoMtq2vNxGP/iTxH7HDsSUCkL2hPDBFYmGh0MU8jwBBH4tpok+JPW8PJ7z5WkZIed/VtLMUA==
X-Received: by 2002:adf:ea50:: with SMTP id j16mr5838649wrn.140.1606419771252;
        Thu, 26 Nov 2020 11:42:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm9373075wmg.28.2020.11.26.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:50 -0800 (PST)
Message-Id: <6229da992e43f4a2d6f4ccaccf2dbbdf11bd5a4a.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:31 +0000
Subject: [PATCH v3 16/16] Add "test-tool dump-reftable" command.
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |  1 +
 reftable/dump.c          | 31 +++++++++++++++++++------------
 t/helper/test-reftable.c |  5 +++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 5 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index ec91fa14f4..6154db5615 100644
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
index 00b444e8c9..0bd7a1cfa6 100644
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
@@ -95,9 +102,9 @@ static int dump_stack(const char *stackdir)
 {
 	struct reftable_stack *stack = NULL;
 	struct reftable_write_options cfg = {};
-	struct reftable_iterator it = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_log_record log = { 0 };
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
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 3b702f4855..c1ba131c3a 100644
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
index 0208a0a41c..f064440a31 100644
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
index 1de39ce5b5..226af8c6b8 100644
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
