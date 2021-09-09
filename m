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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9F3C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E9461100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbhIISuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245603AbhIIStO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BAFC0617A8
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i23so30126wrb.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=dBkjwz5++gXyzo6TGyDlHq3lGOfDnYTxO/XvEx1SYZPc1ShvOumSJZEqc5UN6dWzOv
         WlYd1MDFCwgkNv+BCfO95dKPiYVVMEBhz/d1Lj0BJuFKkkv7qR6KhPoX8oHG8vfE/UpG
         KOXA9nuy34f1pAPPhqGOBw3nZfx7Jz2sGUxZsLLRu5EHmvv7BieoPb6Oj3Au3rMYkThH
         Ge/AobpfMkvAxSk5LslzElUH9TlGLVnXqKuLIYwNRDoo/OaR6/3r7LMvRzkekaL2h1vQ
         +5NpvdRElrclhoUSXlaPUVmpSJ6LCY9vxNLpl2dXe+1a3ZGYkVurH18K4clFb8GJWKR5
         flEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=7MLGr//c5pyOtoWCNiIfPYakbbWouDsVSox86YY10VuL81yfM7XPZcRvq7LYDamNp0
         FQ9AsUGg3zBmk3HZBH1nueMldErC8HjNBXRTj54AdtrduCVuTTCWyIMKBHMr6jJz0fFr
         zj4bOnD3dyPAPsFdwHNW9JqsMAyVlKNUI2KnaEhQ49F5W6Xf2FSPz3fxISyLVFkYeVnX
         dSO5Xg5eJyiXBd+rn72L4B9D3reivz6W5ugTIn2VPit08qtR125bxDZ4IuXFvoSG4+kp
         UAPWBtJota8vwYE1etgO6ggUrugPkXkS9AnFvM3smkcdAGK2gJJjjKqeRkJ1sFMzpM3q
         PKrg==
X-Gm-Message-State: AOAM532gC9Ar0CDAsX6WYnauWGsHy3IzgFrWBVyguaBwgHxDoKn/P6PM
        JIo+CHVwzWniv6dCs/UyayoqaqfstOk=
X-Google-Smtp-Source: ABdhPJzwhI7NbzWUecrgz6iN/sXp45Kk6f04IbRsKuyyes56IFiVHDEohSn1qhJgGa3VN0wKsiFw6Q==
X-Received: by 2002:adf:8170:: with SMTP id 103mr5492002wrm.167.1631213277560;
        Thu, 09 Sep 2021 11:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b24sm2200774wmj.43.2021.09.09.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:57 -0700 (PDT)
Message-Id: <a9bebe45bde34ef6c447f9dfa399c0a625ec5ffd.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:43 +0000
Subject: [PATCH v2 18/19] reftable: add dump utility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

