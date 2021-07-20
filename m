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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA258C6377A
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C9F61209
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhGTQ1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhGTQYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10801C0613E2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so26749657wrf.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BXTqlXi+8kq0ggef5dQ5t34RlFRqURObkEYrTzF2j8U=;
        b=lqs2mWe9iW4zx3J0sweWsbRyyAfW+4ZC+AXbaV7acl2Qf7q3/p+xay2Byl5Q4s4/K8
         yfN60w0LVJORRMNSkLlmuFJSXjIyajNX6qsArAZE/iA/9B6tHNjBPDMviJ6Up9LcR4Om
         X/8/fSXbFHsmn+xlE2MW2b9A7gcojH7JB34R9MW/CElw2+jp23LPL5Wh5Qo7AYWK4kj6
         GN4JRHKj3BCJwnmk88phMeC5aBttitPWO3EEL7Fq0J+587021cLX9vb9Gs/4g7ip0smf
         t85p1OPrq0Pu2j4qTRRX8hABKIC+N0K6aD0JCP1HMV9G83ZkqLCIG929n3BZitTJMVtc
         MMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BXTqlXi+8kq0ggef5dQ5t34RlFRqURObkEYrTzF2j8U=;
        b=TIZHDziLTLOxOjGHZia82QbQ86mTD8HtUOVAnI4Jm6CXyokNXXKgl5V7aIVQSwAB9i
         iI837V8Sj9YczrizmkWodQL3i4bmLu/CfGJ1+ZBvE278srUO2MP85XsjWaTw+NtBlSZn
         HsiijvDwCdsL3wWBvabTPx6mZom5DTmtqrQTS8+uHZqgEz2FgygIzv4ULQhStP2NIJ0+
         dJx5Sda8ufarYEclcRT7VMxZIWTNZHWfyyB3G+cH/4h9w8oax7teszthH91KJF4BTzeB
         84zIkkWi9QNnKe6iMvOR+B043zc2Pp/deITxFpV2w6UvLXuJGE1pt0jaY+abLWeEajY4
         soWw==
X-Gm-Message-State: AOAM531LFMpcIpHTfd08PHdjK6GMn1OdK3PFzH9eVfC+CAaRcEVTP1p7
        c4/76bx5l/3PFChuAR1WIXyoOIy62TA=
X-Google-Smtp-Source: ABdhPJyhPKqyu7vywZ8fsJvA5l7+JYhg2nzPvoIdXBDoM3P5L8zOt/6+iol6wieR1bzg7Duw75W/rg==
X-Received: by 2002:adf:e805:: with SMTP id o5mr4618561wrm.321.1626800700627;
        Tue, 20 Jul 2021 10:05:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm28282989wrg.18.2021.07.20.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:00 -0700 (PDT)
Message-Id: <05e46f7e1d8ec53a80740c312234065eb65e3fe0.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:39 +0000
Subject: [PATCH 19/26] reftable: add dump utility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

provide a command-line utility for inspecting individual tables, and
inspecting a complete ref database

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/dump.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 reftable/dump.c

diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 00000000000..668cfa89965
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,105 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
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
+#include "hash.h"
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
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
+	       "  -6 sha256 hash format\n"
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
+	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
+			break;
+		else if (!strcmp("-t", argv[1]))
+			opt_dump_table = 1;
+		else if (!strcmp("-6", argv[1]))
+			opt_hash_id = GIT_SHA256_FORMAT_ID;
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
+		err = reftable_stack_print_directory(arg, opt_hash_id);
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

