Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56956C43214
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8066137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhHWMOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhHWMOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370FC061224
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so25977029wrn.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofWw37Cqo8hZ4yvOi2dOhsbGznYBO+vTq17xDpNeBhU=;
        b=sDJtZ5sOubKGfWt3aMAXVhJHJMyJayMHfIl0W1V0XsATmtF+T0QqQOejpzqK+W5dsy
         hBNpPYZp2nNTUBFVldg89aVOzdCRUGypDHLgTkSVNoXWHNwOC7EF07pQxF0kdNnBEixB
         8suHqJJMIVtJyPXkOMGRTri6GR5Ag52FsL54Lh1J4FNLBgI5cmNBtvdu8cPqmJ06bBO8
         M0kaRDNpaQR0lB2/5tyf1q4vdZkKiH9AfvTICluLd5+8ScART+/SEcQ9hEc7iyuAXGiX
         W/TxdeSrUzW77W7CZYlZDnajr+y2FoNZQERuninLRpWsHsmAi9h00v3YHtUn7XeM9+80
         EqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofWw37Cqo8hZ4yvOi2dOhsbGznYBO+vTq17xDpNeBhU=;
        b=KxM3O7MCHcBiZEkqOCZabl8MFaaF0CqK9UPi8LGIudMApL24WDt3f7mACFM+/2qWdd
         fox4nf6xOqNEGKio1uilGMOIdh/524qMyE3xJJ/v3uCr/gh1vi7s5apAMiViLYhX1s7o
         Irs3zbuVpwiIldyrd1eiRROJXVIWHKe2UX/GckRyLlFuQNy48OP94lW4caA6ek8upWpa
         K11SNst3wQXHbQCK1pHXj3XUMVMmeO2pPrbhY1SRA100co7nchnm4V7P0+8yCfFPtSwI
         61tDEulo+SCvVpH+oBm3drZLejI3+3lHo6VUXZEc4+WK63YIT1RpplMXDLVkFe8gI6Ln
         xorw==
X-Gm-Message-State: AOAM530Fft5IE8OMYgZH8c+R2D4Pp8gmgIGWzL0j9QtOGm3qk7vK8arm
        ekJw65c963NmIz6t43bzlul7nUNTLYdnDLCz
X-Google-Smtp-Source: ABdhPJzIFhyOrGVr+XRbNO6hGyy9pfCJMnuuVKeSPh7jXpN/2G5M8oCniZ+71UKBnFHPdGSminHwOw==
X-Received: by 2002:a5d:4d8e:: with SMTP id b14mr13060161wru.422.1629720792000;
        Mon, 23 Aug 2021 05:13:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 19/28] reftable: add dump utility
Date:   Mon, 23 Aug 2021 14:12:30 +0200
Message-Id: <patch-v4-19.28-007c9359f42-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
2.33.0.662.gbaddc25a55e

