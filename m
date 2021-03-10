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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A2C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB88B64FD3
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhCJTbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCJTbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BAC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so11454189wmj.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wxlia8VnIU4u5D64V+OKvd3HYkcbJivGBzhX7AKEUNw=;
        b=PiVdj1lcENFi4l8zjmUY/ML6OT/CHSeBTi9KIgfB+qTPLT/x0G722LgOcnslmvMpFL
         kH2SUFUqbSnWKW1EnMILgta55GPdKSzAkgjpKrOYydHiiQYglzobkeFiUdC/WKp6JCcI
         +BEkE5a9te/NxxOBRgLwoyrIjhrQ8rzXWl0sw1kQrIg2ll2ftoBLtA8D8Inm861FzJNW
         7wwn0VNMsr2YdppTrUKdsJZb971QihfWwSNor08/9WbgAle0i8qmQTyVb7mNox5O0+O4
         EZJl5ZRv6OoyCHQ4gGILRViPET7DogcoZ2FCTUWRkPAuTFQiLjREw0ANJxZsrZFQgoI3
         7X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wxlia8VnIU4u5D64V+OKvd3HYkcbJivGBzhX7AKEUNw=;
        b=mtH3JUGn/tXQzIvP571qDd0WhlxuyvPG5fHHXiO+kIRbRKNa3DERnpcP6+8xNHrq4C
         20xzoGWMcWZAbZyPbfGmhs8IbzBq3p053sG6D2kAHAk9P8VFWtMKvyQkWIn7YGBsl75T
         X6Whr3PA6rhMWlaSEdfZh/a0V9osJDxtKuqrGGp1F+OEJfe8duWOUKOx2Wc5TdE8lpHy
         DbLzqjKUvJPp/MKwrQIAuw1taJEUPv/FGutq/TfAateTA1n9gwcor/4y5w9ilb1mL4+c
         yTe3UA2qJRY3BVordhlYixU+s99iIYRi1jO3e+vsHNwCG6FG3jDhU4tc87GvqNz5BEyb
         Ktpw==
X-Gm-Message-State: AOAM532C06zm1xjK7cVrnu6Tuo3kkpVBaZhzkFFmFWmgW9zyWEypsvKp
        7m0xa6DeMm/Qgo52Kp44TDQBBP2ZcHg=
X-Google-Smtp-Source: ABdhPJxh2CYKXf0jNpOayqzPo8PP0BLZSF07PD4952b21ZBA8A+mBrCSn/+UG9BqyL63I772zL7v7g==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4732854wmi.127.1615404671652;
        Wed, 10 Mar 2021 11:31:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm386602wrm.36.2021.03.10.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:11 -0800 (PST)
Message-Id: <e9c82d2eda821ff4c0fe2984d56e12d9db3e2dcc.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:50 +0000
Subject: [PATCH v2 07/20] test-read-cache: print cache entries with --table
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
        Derrick Stolee <derrickstolee@github.com>,
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

