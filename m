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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB846C43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1E161358
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbhDLT0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhDLT0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A0C06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c15so5132190wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fodV0rxWTzIpPlnBrgeQol6U1Nk6PfxpK2fJ9yKOoAI=;
        b=vJhUhrpXpcJeFz4EotwIJ/R1tiYv2P+Qcfg9cp8Y91xvZ5r+XmZ3wSKUWv0eB3bOLn
         66in5Pbdsssbda4+3deInf0+eOutXA/QO/s12/kIqfOVly48dGyWs0THy3ERkKXX2aR7
         UZV5OeI1m7VlxqdmJ3y8BdzQubThX3g21DyAXhX33+DHtDr2QzRxSoT/RfqGoQCE1Hm0
         QIQ+mw7cgNIj4+yO0W0UrW5dDLTrCHdOI5sMxBILLbH2dTMFIO6DmnEP9gQE0/ZdCa2n
         KgAuDxhphTndWwapV3bSvZuXA/I/t9VW9Ufe20Ue2y4pzPy5wK8wheausHJNRO/jYMUS
         HFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fodV0rxWTzIpPlnBrgeQol6U1Nk6PfxpK2fJ9yKOoAI=;
        b=L7fvHPp3ZpMmGsoAjXbS2WKDqzVs7KKURcqqpdz9H7/YXE1SX+MyizcxjOV+PDvDDZ
         rMoQLHtMcmdG6V6Vi6Nw1U+EH1t6B0J9U3hLDOehm5o8TXiB5nQo+1JYzZ5vhNk30K7R
         WZEjTnrH7e98ejoBL99gXc0SdBepiIj/Ao0X/MTT5oPl1nD4e42MvXnJ10qHRY/LZNfn
         7nn91LF/PwQ9oR4UZ8oEs9wZKz/yFe0/RlLRbssyEvFeetXOEc0vr02Uof2xOFpvWEn6
         8x+IfRD7tPPnvj3kXGM0wqTkJAg3rVmOggk3aSTXelN06I+DFz4sId8ZBROMq/Vog30a
         wxYw==
X-Gm-Message-State: AOAM530plpQLDNPUv2ucYq+Oz2gt0XYeOmW6qoriOg9L2C8LnT5IIPyI
        MzS3uax8Z9ICnGCVJfzGAPiJ3R0tiMs=
X-Google-Smtp-Source: ABdhPJxz/aIzF5+j5iSMNbvOs1nVZbmeFkE8Q2s4zvMcxzj2gb510UScepjYVR8/EEZnplct1lTBBQ==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr5729516wrw.289.1618255565239;
        Mon, 12 Apr 2021 12:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23sm278754wmo.33.2021.04.12.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:26:04 -0700 (PDT)
Message-Id: <5db7c8ab7f2307d2a1e91e8bd862e1144abbe9cd.1618255553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:49 +0000
Subject: [PATCH v6 17/20] reftable: add dump utility
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

provide a command-line utility for inspecting individual tables, and
inspecting a complete ref database

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/dump.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 reftable/dump.c

diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 000000000000..00b444e8c9b8
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
-- 
gitgitgadget

