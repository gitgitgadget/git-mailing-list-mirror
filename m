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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12EAC43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3965109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhCPQnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhCPQnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CAC061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a18so10800170wrc.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wxlia8VnIU4u5D64V+OKvd3HYkcbJivGBzhX7AKEUNw=;
        b=i7M6/2wwKtBtZgZa4T7Zl0frKTS3tc2JqA6qb7en8h0g5CD6d0KCCFoTF+z52ypel7
         5DVWRybIXwXMJ1E3kETRMhYt6k5dYQ20p4yShTnc44ppE2NU9XN+okkYGI0TZu2K6N+9
         eTcTT++C0/Sf49wkbXsuxmULqtI0IvvG7YoVBCoqjhb6djhj0ADaBiiG7+tUjaErMMGS
         OYU7hyf6XUBCwTt9kK6aZXk2720LZMMVZVn/EATGW7qrvrAkJoDS6wY3WvVtRJBIAxWj
         +EXHBCQNyMKinT4AgF4E90Py0AyApcuqJT+5RQekKw/i+k6PvEosvSJR4/khG4+AMZ5L
         J6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wxlia8VnIU4u5D64V+OKvd3HYkcbJivGBzhX7AKEUNw=;
        b=gHcp5+4lRN6FbdqjZ+cL1tMyRJaADU0uodbop8OMEUEK6j1EWSJLegyzhWpba4S1IK
         /rMQJ+gl4nmMsK2COft7N0UfsbxdQNV9EIZGQ5SxAMeX/OD5JWAjzROmFT9bcwBYVaQw
         dK0P9pYZSEa4kON5xkyk9gamNLo+cTUTNF0rVy2oqhEjLrOtoVfROYrEvk+dJErndysU
         KGneaV9AzK1U09YOIcVi6YbTZSCF7dxHwKcpwYX4yZwY7izhFo7uFfIKngHkBFJJ+pIc
         44LdRI1fOEtnAFF6lZ3bUWSkXmzIWFLbI4gyK25KTt3v4xQcTrju67YV/FRNtw5icOmK
         /t5g==
X-Gm-Message-State: AOAM532D0iKDNH/ylEO07UGxWG2IBpjoW9FOHywzC8TO9arHiltNmgCe
        NVJ2i/VgC+f/FPnmvgqkcgqvU4QWlyw=
X-Google-Smtp-Source: ABdhPJwu3HppJediaHMoY7X/tLOrT0Z1QZC7h99bylMOqiQ8OFrYXYfFTl3YbdtCn0c5ooSRipprzw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr5842773wrq.39.1615912990067;
        Tue, 16 Mar 2021 09:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm22765209wrt.17.2021.03.16.09.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:09 -0700 (PDT)
Message-Id: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:50 +0000
Subject: [PATCH v3 07/20] test-read-cache: print cache entries with --table
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

This does not print the stat() information for the blobs. That could be
added in a future change with another option. The tests that are added
in the next few changes care only about the object types and IDs.

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

