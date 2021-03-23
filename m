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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0566C433E3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6036199F
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhCWNo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhCWNol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A9C0613DC
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e9so20829325wrw.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b0SPiO5pLHpc3Yqb6Wr4cuzcLpirEqK37PQkp7wDU/s=;
        b=hCAB/BHbIMPP40KnQ+jvcUWXuYNOWtQ9SVXWr9En7LPMY6AYanZX1WJRDU9eDxoEkR
         4a71Ea5WcM7UwXZyb/geYBFkeyCG7xhxeKDOtfgTOSPvKB0zBQ4van19Nqu6qcjuhHGZ
         ApztaNVcydkXkq2vfymrcaBjOumcEm8PW/kHvz8mfDr99wkQrbo+xuyuCfn0gZhzgTcF
         0drNBBs4y80pNd19T/Xx/SN/60414G5p2yV9rvobAWAZ0ZRKFJpBXvZMmcjsbsMuMOVp
         rqgNezNSCACBH924cSuw/6Holxl8JOLdpYzYMTcRgW2H4s+gnuaSIEn3XYrzzNaRpC+v
         xDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b0SPiO5pLHpc3Yqb6Wr4cuzcLpirEqK37PQkp7wDU/s=;
        b=Kq5f5he7W26//IlVAsr2GmKyzzTPl8Ig2KynOij6x+y3FsgNKCUU0XXE5crp5ZESl6
         OrFta5WnqDpHTZDmJ2g3sYNTL/Kz0e31eez+qg6UILVmPW7d2T4wObj0JBNMXzUKkG88
         Qv3ZXCkr1uWin2awNUZpzqnpCHjzrdW9x1zJrjQC/j/aaacFU2kPvmyNqJqTU/KV43w+
         eGl1BxtIP8aTEdZnWi/eGtp/pMTfSvddDID5+v9hh2K8opd58SQynPB5oIxOlp24hvpr
         XLqgHFoi+YB2Yn+Y/Dmt8+Av2iwc1vgcynd53Bo9PvmZeThUe6/kTt9CUyHP4Mnvh+nL
         wS7g==
X-Gm-Message-State: AOAM531+329wOi2KWnkUhzgOiSgSFiPWFLESQNfBAXm9712ef0LDLK2a
        u4Km0RDKVgd6HiNX2/mInSyQESXGjYc=
X-Google-Smtp-Source: ABdhPJyugpXZAnyy/+euD7QrajCVC2PUJFZY1QloFYbcnNh/flyMU1SGt13PbHj+0qofhn6zWDdKgA==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr4090812wrr.297.1616507077054;
        Tue, 23 Mar 2021 06:44:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm24771261wrl.19.2021.03.23.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:36 -0700 (PDT)
Message-Id: <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:15 +0000
Subject: [PATCH v4 07/20] test-read-cache: print cache entries with --table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This table is helpful for discovering data in the index to ensure it is
being written correctly, especially as we build and test the
sparse-index. This table includes an output format similar to 'git
ls-tree', but should not be compared to that directly. The biggest
reasons are that 'git ls-tree' includes a tree entry for every
subdirectory, even those that would not appear as a sparse directory in
a sparse-index. Further, 'git ls-tree' does not use a trailing directory
separator for its tree rows.

This does not print the stat() information for the blobs. That will be
added in a future change with another option. The tests that are added
in the next few changes care only about the object types and IDs.
However, this future need for full index information justifies the need
for this test helper over extending a user-facing feature, such as 'git
ls-files'.

To make the option parsing slightly more robust, wrap the string
comparisons in a loop adapted from test-dir-iterator.c.

Care must be taken with the final check for the 'cnt' variable. We
continue the expectation that the numerical value is the final argument.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c | 55 +++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 244977a29bdf..6cfd8f2de71c 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,36 +1,71 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "blob.h"
+#include "commit.h"
+#include "tree.h"
+
+static void print_cache_entry(struct cache_entry *ce)
+{
+	const char *type;
+	printf("%06o ", ce->ce_mode & 0177777);
+
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		type = tree_type;
+	else if (S_ISGITLINK(ce->ce_mode))
+		type = commit_type;
+	else
+		type = blob_type;
+
+	printf("%s %s\t%s\n",
+	       type,
+	       oid_to_hex(&ce->oid),
+	       ce->name);
+}
+
+static void print_cache(struct index_state *istate)
+{
+	int i;
+	for (i = 0; i < istate->cache_nr; i++)
+		print_cache_entry(istate->cache[i]);
+}
 
 int cmd__read_cache(int argc, const char **argv)
 {
+	struct repository *r = the_repository;
 	int i, cnt = 1;
 	const char *name = NULL;
+	int table = 0;
 
-	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
-		argc--;
-		argv++;
+	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
+		if (skip_prefix(*argv, "--print-and-refresh=", &name))
+			continue;
+		if (!strcmp(*argv, "--table"))
+			table = 1;
 	}
 
-	if (argc == 2)
-		cnt = strtol(argv[1], NULL, 0);
+	if (argc == 1)
+		cnt = strtol(argv[0], NULL, 0);
 	setup_git_directory();
 	git_config(git_default_config, NULL);
+
 	for (i = 0; i < cnt; i++) {
-		read_cache();
+		repo_read_index(r);
 		if (name) {
 			int pos;
 
-			refresh_index(&the_index, REFRESH_QUIET,
+			refresh_index(r->index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos = index_name_pos(&the_index, name, strlen(name));
+			pos = index_name_pos(r->index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
-			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
+			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
-		discard_cache();
+		if (table)
+			print_cache(r->index);
+		discard_index(r->index);
 	}
 	return 0;
 }
-- 
gitgitgadget

