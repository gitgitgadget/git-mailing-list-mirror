Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E8C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLGUXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbhLGUXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8924BC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so148396wrn.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xyXToDaHI5bVr+pUHwm8E97g5xRAM3UPz78TQ/whhLw=;
        b=htHgCM0kF4OJEMHM1k/ZF/ecaoJYR/eqbF8Mat7HoDOp5Lrn/H1TXkz+jQB/v1oLtc
         Xk2y+3iiosA8mAYFNUQiHnMiLn3TJr50M6yYqVsIJ8+4wXDLORqVp3hchswtNfCdgJ3F
         ak3/TFSxmOdKaZrzzYkDE8mKlq3Ke9h4PJzMq8Xlfdr8mX9Q9n41ZSYPKeQig3MKbwUw
         ZYYHHafyFn1vkXnOH5k23LKd36YFQ9/yKJHiPyVBKfsW8900ngGrt0CJl92f/rXYzvHL
         N8/QkZTtjCt+ydWow1QvkjYPJKOvF6Ba3TnzrHu0PiETfNCNmH3SlXKO0PC39Hl1O5kQ
         XA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xyXToDaHI5bVr+pUHwm8E97g5xRAM3UPz78TQ/whhLw=;
        b=MueN2PAIiNVDqPpSzt2YAG3tE7mhisKqK25IVwAzgpf9jN0vDKfhCH5fKlSVnuJeoZ
         b6i2yxJyKV4KV/asBOh3iKXHNbvku9pLUczNM4qU5tksZhfqqLfFg4tbgTMUP+Xwm8Df
         obeLJtUPEmy17JsuVKsSoxhicFV7waM7ccApbyJWeuedXI84DGD1SGkryuqyH3DrzwBA
         Td0qH5s63h0ifri97pXl0y6KaIVgaIhGTEik5zz2R3PY4p36EEXwVWRZmrrtuNc64M3C
         5HExPq+1oMHSjJlOSVWPa07g7Ja7oIrg3rv+mc2YVgc8f+ZHHfX/9iC4iWsZAmlZBQ6G
         hZLA==
X-Gm-Message-State: AOAM5320ojZCAhtRRIvO1In31vrQUnIVmBh1DWqvNUGOattzV3uJwNtj
        5U8KxlJf7MVUnXb1B/2RAG7bLV7sR5M=
X-Google-Smtp-Source: ABdhPJx+NZKdecXKT+tftpKlkxQAuN5u2C3binlr0cZ0+dTAr0riwLSe/1AapylMVnyZLR0gNwImsA==
X-Received: by 2002:a5d:5008:: with SMTP id e8mr52668111wrt.83.1638908415806;
        Tue, 07 Dec 2021 12:20:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm699154wrt.36.2021.12.07.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:15 -0800 (PST)
Message-Id: <3f5255eeef9b540da14afa90c9ef0bbe1b448c0f.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:05 +0000
Subject: [PATCH v2 05/10] sparse-checkout: split out code for tweaking
 settings config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

`init` has some code for handling updates to either cone mode or
the sparse-index setting.  We would like to be able to reuse this
elsewhere, namely in `set` and `reapply`.  Split this function out,
and make it slightly more general so it can handle being called from
the new callers.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 56 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0ee28f48134..f176435b6be 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -383,6 +383,41 @@ static int set_config(enum sparse_checkout_mode mode)
 	return 0;
 }
 
+static int update_modes(int *cone_mode, int *sparse_index)
+{
+	int mode, record_mode;
+
+	/* Determine if we need to record the mode; ensure sparse checkout on */
+	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+
+	/* If not specified, use previous definition of cone mode */
+	if (*cone_mode == -1 && core_apply_sparse_checkout)
+		*cone_mode = core_sparse_checkout_cone;
+
+	/* Set cone/non-cone mode appropriately */
+	core_apply_sparse_checkout = 1;
+	if (*cone_mode == 1) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else {
+		mode = MODE_ALL_PATTERNS;
+	}
+	if (record_mode && set_config(mode))
+		return 1;
+
+	/* Set sparse-index/non-sparse-index mode if specified */
+	if (*sparse_index >= 0) {
+		if (set_sparse_index_config(the_repository, *sparse_index) < 0)
+			die(_("failed to modify sparse-index config"));
+
+		/* force an index rewrite */
+		repo_read_index(the_repository);
+		the_repository->index->updated_workdir = 1;
+	}
+
+	return 0;
+}
+
 static char const * const builtin_sparse_checkout_init_usage[] = {
 	N_("git sparse-checkout init [--cone] [--[no-]sparse-index]"),
 	NULL
@@ -399,7 +434,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	int res;
 	struct object_id oid;
-	int mode;
 	struct strbuf pattern = STRBUF_INIT;
 
 	static struct option builtin_sparse_checkout_init_options[] = {
@@ -412,19 +446,14 @@ static int sparse_checkout_init(int argc, const char **argv)
 
 	repo_read_index(the_repository);
 
+	init_opts.cone_mode = -1;
 	init_opts.sparse_index = -1;
 
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	if (init_opts.cone_mode) {
-		mode = MODE_CONE_PATTERNS;
-		core_sparse_checkout_cone = 1;
-	} else
-		mode = MODE_ALL_PATTERNS;
-
-	if (set_config(mode))
+	if (update_modes(&init_opts.cone_mode, &init_opts.sparse_index))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -432,17 +461,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
 
-	if (init_opts.sparse_index >= 0) {
-		if (set_sparse_index_config(the_repository, init_opts.sparse_index) < 0)
-			die(_("failed to modify sparse-index config"));
-
-		/* force an index rewrite */
-		repo_read_index(the_repository);
-		the_repository->index->updated_workdir = 1;
-	}
-
-	core_apply_sparse_checkout = 1;
-
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
-- 
gitgitgadget

