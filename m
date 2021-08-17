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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B0C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D366460EE0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhHQNms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5FC0612A9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r6so28730940wrt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=kuERMzdWFyebWEQ0vq4iXKpopHP0+zjQIcj4BcC5/JZHerJcYK5ZxpNTqYs5qbnuJ5
         uvS3RBMQuCP0xkiYajYceWg/56B+xrpJjI6izGvRXlWLtgW3rUbqajKOwvxqUzzE3ivx
         XHGuv8mEZ7qmDChB271xVL1osDic5ACFLW7zU6hRMu6iAD8TT+eLq7WNEEJH2P7/eUQv
         f7ZySmDUj+cceM4ha3V42MRHn8JG7bVSDW79S48aCZnXlTLnVOY7yowjmoJy0QAQH8F6
         5VthtUK5OWBtdngd01ponPnrWfkcPKz4xIaSqXWp9jHo0YUPAtt1W2sGlskWFqyRWP6m
         iBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=d9M+70eQV3pC9VufGa8f128gBLjNaT42qcunny2kkoByZyb2u5OpX3NzsiWkvGempV
         +fRKxn8knyqEqoWwOvp3XpLe9o4ZVR/wZlLhNq+Kf+p+4Ubc+E9tAda0Ecd83CM6TIfQ
         M/o03IKvBsXTBwc7Ak/1bl4LOpE52Z4WZd1ieoO8KhJgaCSYQ8yzdk2C1FsEvQO49IPY
         7dIYx6wzViXmjNsnoUjad84uxJaaPPyDlI5ZCilWETm+ZFozJQwmSVfqg0dLP2YqCKAf
         jZ9gKqytUoIj8/6bdkryL1KZcdcYRp49d+2vCyVjiJs+yXuOuQFpaAOzquEEeVbvlkHh
         wEkA==
X-Gm-Message-State: AOAM530s+gf05DRotFYIsXu9ziD8fSMOcOyR+NZyPEEOb0eT6RzV5Nvo
        eKRdGIjkfsmA8Eq4WP74UiTEFd7P1HI=
X-Google-Smtp-Source: ABdhPJy6wtBVX4eYJunOME/GdxYbr/02lKjFqZ5fgkOwZOFZYY3AUL/CiEyFVp/8Vc4S6oAYNfUSBg==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr4099620wrp.176.1629207646336;
        Tue, 17 Aug 2021 06:40:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm2964976wrx.72.2021.08.17.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:45 -0700 (PDT)
Message-Id: <88dbab683dc254f430ff70e852d65b1e41ef4959.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:01 +0000
Subject: [PATCH v3 19/25] reftable: add dump utility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

