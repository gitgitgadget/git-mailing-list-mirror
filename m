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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155CC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A0E64E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBWUQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhBWUPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF1C061797
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a132so3645154wmc.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5oJwzTEAwDQe46DTGB1dKLdJIdkx0jvsjBXCc8Gy0xg=;
        b=P1Boaqcy0REXetEpKacwISEWT5VsagabAi+ANRdDNn+bMJ+mHngXuypOedI+WVjeDe
         QM/ZhCJu0v9/bTgW1aPhw3XwBZDb/Eo3l3PhoXN+58DatKcItMjNCo/atpDgotsM0/7C
         Y+6LYyRvVEUVCu6KHRWAY47rTM5ETyFfRGOgWIrNT/uyyW92k/Hd1ophPsOq5NeYsUfo
         B0CSOXw5GuWY2BnqFkqzu+wIiIihJxBDDe8nIWuUDo9sQmP1xFENYBHNgVAA7PNXaknl
         WfwHkbkRyFlVdUSfb9kp+bXa2Lc6UcNFJDJ+fngI9Pn/7083WiMC34+YnNHG0xUct4L4
         Treg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5oJwzTEAwDQe46DTGB1dKLdJIdkx0jvsjBXCc8Gy0xg=;
        b=Gtbi3y00zXU03d1FXMc6K1AfzVx+UhEsaUQ7oeb1se03glt5Nv8PXlH964fLPQjJ/P
         zk/eYPvC8rl+sr07O9Z4bJvCBvqHme/0VPAFw6vEPc+y4hieYEqKEfBJYf0bdY/P8kLK
         Ofzq19RSnRm/UUl4/7NimNTZhNVis9lU6H7mzK4aY0pw9n0cXcMiWl4v/z7Aln/4lj9j
         KlEtZaO8D3gf1UXGfqMLqVX2EAn+3vF4h0FAOhk84V64Ms2kAQZPwn3Yc+Hvic98Z5x6
         lP8K+ji3c4x+zO7uW5vlRILyyieGPz5gG4/Oi3ZX0+G8yYwrj2NorEmfQpsi0iy32OOH
         yqqw==
X-Gm-Message-State: AOAM530rk3dmKbrKHrXOlb9d/zhRr/0lit984mtApfxGXGjFrvc2EZlI
        uQ9co6+VTGlog+MjdRB1woJ6hag3R8Y=
X-Google-Smtp-Source: ABdhPJzbtAN3Mvuu/d2DRnPdQfsqn4KtfvFKWrWDHsMpP5OYAmal9fV/UGXEbsxefRqiHHnzPlrMwA==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr447565wmz.84.1614111275346;
        Tue, 23 Feb 2021 12:14:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm277086wmg.10.2021.02.23.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:35 -0800 (PST)
Message-Id: <3d92df7a0cf9655dd34895f106cfac26ea44ad94.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:16 +0000
Subject: [PATCH 07/20] test-read-cache: print cache entries with --table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 t/helper/test-read-cache.c | 50 ++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 244977a29bdf..e4c3492f7d3e 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,35 +2,65 @@
 #include "cache.h"
 #include "config.h"
 
+static void print_cache_entry(struct cache_entry *ce)
+{
+	printf("%06o ", ce->ce_mode & 0777777);
+
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		printf("tree ");
+	else if (S_ISGITLINK(ce->ce_mode))
+		printf("commit ");
+	else
+		printf("blob ");
+
+	printf("%s\t%s\n",
+	       oid_to_hex(&ce->oid),
+	       ce->name);
+}
+
+static void print_cache(struct index_state *cache)
+{
+	int i;
+	for (i = 0; i < the_index.cache_nr; i++)
+		print_cache_entry(the_index.cache[i]);
+}
+
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

