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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A7C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C95A611CE
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhDSLl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbhDSLiu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D56C06134D
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so29932366wrt.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mtJ17GtIFARnnXXIo8kaVIhsHNZ1mhpmxXlnXL3RfoA=;
        b=daEBFLTscqPxwws7KAvytJdloJK6MWe7U5oZiPA2oMaN9kSBVGBONGVUdR6wvxwr3b
         8ib152zvSICPjeNMcTUsLatnw+S6FhBEZk8uBvl5PwH+CU4s9uJLk0R7nLHyn8JRGnBL
         m36PIAqmySHAAMjqpyByUsx588IOH0ZWqJCSCIBk3v79Asc8ww7NT5Fy+HS5FYV8bm8O
         HANYF/sjOYXhS5l336Tp704klArEc5y0c/oclPTP7JZeGHOJdfdyoPxtEhimo5maMgDe
         iiHCXHZk+stuNS5ZXlnDavzubOViOfdFUBNXhKkGeQWjduAGYgDjaAj1pfZmHtpflqEv
         VHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mtJ17GtIFARnnXXIo8kaVIhsHNZ1mhpmxXlnXL3RfoA=;
        b=HbbDWAWmwrhCCPUu2N5YaMgVOFY5qvDb0uNaOUrVzderNqBmLvDBQfy/rUUkI48mev
         VnjDaHUBlwfsSHFRG/oF7FjNi9J1Fo7w9GIKhdgUp1/1yV/vfcr1bkh6r9JiPFF2jXJQ
         9hYpXvGxwt6Na/rbWs42wOD24Or03VePvtxdiYyFE+1EfTYRmZNN3U+ifKC6Vvt2qGxu
         D62k/NsXBGcZWpQw/VgzuZwsz5jIPcyWAnQJzhl6HzgJ5lAlFh0c3GiiQWBf6UfTYcVc
         UXcLmU2YJQE023gkFBCSeVoPGhnDw3vGibT8hjJnUFWZPczvk6VJlymMXfYi7ETFb5Za
         UoMg==
X-Gm-Message-State: AOAM531IHcmn//MI2AwKGjvx70sAKRZLvcN5VCzwZ/nkKKG7dOOq/jTn
        Sr6YVwIFV4kC6u+Z2x+TR3hHDvS6CVw=
X-Google-Smtp-Source: ABdhPJw65ROD2PlZwm1i34vmdGhY/0SFy9/lqfU+79O0Dr++ADN006oLFAnX9qSVcui9laSBgScXsg==
X-Received: by 2002:adf:f250:: with SMTP id b16mr13710852wrp.347.1618832294082;
        Mon, 19 Apr 2021 04:38:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm23143794wrs.84.2021.04.19.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:13 -0700 (PDT)
Message-Id: <b2ac95a25af804c172d474cd2d33b83cf3bdae4f.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:50 +0000
Subject: [PATCH v7 22/28] reftable: add dump utility
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

provide a command-line utility for inspecting individual tables, and
inspecting a complete ref database

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/dump.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 reftable/dump.c

diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 000000000000..c4201f826b0c
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,100 @@
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
+#include "reftable-blocksource.h"
+#include "reftable-error.h"
+#include "reftable-merged.h"
+#include "reftable-record.h"
+#include "reftable-tests.h"
+#include "reftable-writer.h"
+#include "reftable-iterator.h"
+#include "reftable-reader.h"
+#include "reftable-stack.h"
+#include "reftable-generic.h"
+
+static int compact_stack(const char *stackdir)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options cfg = { 0 };
+
+	int err = reftable_new_stack(&stack, stackdir, cfg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_stack_compact_all(stack, NULL);
+	if (err < 0)
+		goto done;
+done:
+	if (stack) {
+		reftable_stack_destroy(stack);
+	}
+	return err;
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
+	       "\n");
+}
+
+int reftable_dump_main(int argc, char *const *argv)
+{
+	int err = 0;
+	int opt_dump_table = 0;
+	int opt_dump_stack = 0;
+	int opt_compact = 0;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
+			break;
+		else if (!strcmp("-t", argv[1]))
+			opt_dump_table = 1;
+		else if (!strcmp("-s", argv[1]))
+			opt_dump_stack = 1;
+		else if (!strcmp("-c", argv[1]))
+			opt_compact = 1;
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
+			print_help();
+			return 2;
+		}
+
+	if (argc != 2) {
+		fprintf(stderr, "need argument\n");
+		print_help();
+		return 2;
+	}
+
+	arg = argv[1];
+
+	if (opt_dump_table) {
+		err = reftable_reader_print_file(arg);
+	} else if (opt_dump_stack) {
+		err = reftable_stack_print_directory(arg);
+	} else if (opt_compact) {
+		err = compact_stack(arg);
+	}
+
+	if (err < 0) {
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
+			reftable_error_str(err));
+		return 1;
+	}
+	return 0;
+}
-- 
gitgitgadget

