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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3DAC4320E
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A760EE4
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhHPUSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhHPUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB80C061796
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u1so12338405wmm.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=TKAL1x22H1SiCwqaUWu7Pkabx9wQ5cdIMeMFZeOHLRp7j376NToDzb4KvXbdJbpouz
         ufqwu2aYLv51zE0pJuQSlz0w0yNQOPyPP8YKXPwOsYJOv6pltitaFN2cZ/U6htlzGroC
         lPOhOIP/FurrMYDrhkxlVUvEJk4VCglCXynCGhmX47VDrZHnmjHUWGQGL8dGgahAV9TS
         G30zxei6QKwlbjq6CBDC/ytUmbYvcYYCVmJdKk4CE9MhiAWa1d+ZVjKrbvspEgWPB1wC
         7bWyKvdXnLoA7hRsArHmWM3MhHPTK+bQurdXFKJX0dui88Y+cng8nkq6ZxFXYnBtr7BZ
         Z6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=jlE42ggbhe2dlqMH5B6GlmeRNlDRFBMbe4X8GqTHtp9618ChDHDo5FvKzXdCO9CYgu
         /wGt7e9ltOBENwPK46VVIkM03dVql6da5xnNqtXWodoIb/BaOpkgf08G1o8V/YWVzUWy
         u6zn9T1+1IuHWaZk5yMjZtnDZMh5TY3W5zQTa0xx7T2usaBGXpFSb+DK58FNTvVn4c/1
         APlGSPvh8fJ/oIZRmbiMWrguGq3HTBUZi7MnrlwQuuOO4qrxhPdN2VZxIAgCsgv2htfJ
         ucyijY4ovPZV72l1kqbyBxRGOcUTeHe291Ixd2TVmQrJJt2sPOAL44RvkRoP1TTZy0zj
         ifTg==
X-Gm-Message-State: AOAM531YHjbbXwEGjQrJTmIrnsvpZzvUmuCFtZu5VWT1g9cfA59Vxyhu
        CC4jbO2GEuh/apRrcqZAoneOmPa1kt0=
X-Google-Smtp-Source: ABdhPJxyYT8iKnr65vujSSbSy7IpW2EeTzfyKUbRQggYJa10OXHYfEb0xLi6RVbt9829CqB0x6KL3w==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr16339wmj.152.1629145057983;
        Mon, 16 Aug 2021 13:17:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm155154wmi.0.2021.08.16.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:37 -0700 (PDT)
Message-Id: <0f682be20bd360e68118a4e5dfa4ae817ad7cc50.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:10 +0000
Subject: [PATCH v2 19/25] reftable: add dump utility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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
Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/dump.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 reftable/dump.c

diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 00000000000..155953d1b82
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,107 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "git-compat-util.h"
+#include "hash.h"
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

