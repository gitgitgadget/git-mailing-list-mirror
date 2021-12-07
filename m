Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DBCC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbhLGUXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbhLGUXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53AC0617A2
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so185842wrb.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GSUX/KNdWOya3b96MZCDiQu53awa7mlUiP+FhcDO5Ss=;
        b=cKw/I9+gtCPQ5h+9cOzoEFcny/p3ob7ty48SjekHKzEXv7utGV5rxmjc73DNWMHfAe
         RRfz3vwnbDcxQCihpiXwQ/E7M80L856TaEfT+BtteWbm4L5pDr+LRTLFCdeOa6/3UkXP
         KC5V6f3Sv2f5M1Cq/nQqLovG1XBS840h5NfDr1jiX2y7w6fxxP8s5DFipjmemdmHV6Qs
         A7CfnwpxOhoJoZx3xkiMSB5PyWaMgZlJzpXEdYkJMfm+AmJhQLPQYJIZqY/eH4kb47AO
         JOoxiwc/vAbt4ZbkERo7BGAYnKLt+J9GVjvLZpbLvhBFWYa0Pj5CQ8v1mLoGjxRoy+gw
         wxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GSUX/KNdWOya3b96MZCDiQu53awa7mlUiP+FhcDO5Ss=;
        b=UKB188u2zBOtfoytN3mu1lB+0/wVQKn3cMAfkKN+S+KAPLScArzaPNV178GfMWAoYl
         bjbdVwNNe8YS7zIUmNCfq5JvcmUvqj7vLQQjnl1NhU+XHdx/B7rnv6v5UIl8BRmw1P1C
         z7F9njPnCPeZSkcYh/bKfkw7a8msJUE4m0d3EkIjKxEcl5tk/J2IMKG3bsc60ZiY4XYy
         izVi5jDaJ/aMYkskAO0ULsMQBrmUJJOl8jCXfWEPHZYKI6higUERGYZzlyviVIbCFf7U
         obVJE/+oEF7G4Fq9PSptcd4IhuYnHbZKxejcqMpEL4lVnfGdDhiU82OGDDqDnFejj6Rb
         cmjQ==
X-Gm-Message-State: AOAM531echsAiGA3ZjvZs1E1+TBf4VRpYPHsXRfC4suAmn6grkAZ46Xj
        u8od661qRGKQ7ytRAmX+Hle9Jj09jNU=
X-Google-Smtp-Source: ABdhPJybD6rtR4FS/dE8oRFFOO2/rEcY5fZjbdeH9imhSYyfmV9pVlDJmq4NknkcN8gSh9PL0Lbo6w==
X-Received: by 2002:a5d:4bc9:: with SMTP id l9mr54395884wrt.503.1638908416757;
        Tue, 07 Dec 2021 12:20:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm3782077wmi.36.2021.12.07.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:16 -0800 (PST)
Message-Id: <3c640f5bcef7b6b89e8c4759a44ef3cbe57e75bc.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:06 +0000
Subject: [PATCH v2 06/10] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
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

The previously suggested workflow:
  git sparse-checkout init ...
  git sparse-checkout set ...

Suffered from three problems:
  1) It would delete nearly all files in the first step, then
     restore them in the second.  That was poor performance and
     forced unnecessary rebuilds.
  2) The two-step process resulted in two progress bars, which
     was suboptimal from a UI point of view for wrappers that
     invoked both of these commands but only exposed a single
     command to their end users.
  3) With cone mode, the first step would delete nearly all
     ignored files everywhere, because everything was considered
     to be outside of the specified sparsity paths.  (The user was
     not allowed to specify any sparsity paths in the `init` step.)

Avoid these problems by teaching `set` to understand the extra
parameters that `init` takes and performing any necessary initialization
if not already in a sparse checkout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f176435b6be..1ecdc3ddd5a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -706,17 +706,26 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_set_opts {
+	int cone_mode;
+	int sparse_index;
 	int use_stdin;
 } set_opts;
 
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
+	int default_patterns_nr = 2;
+	const char *default_patterns[] = {"/*", "!/*/", NULL};
+
 	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "cone", &set_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
 			   N_("read patterns from standard in"),
 			   PARSE_OPT_NONEG),
@@ -725,11 +734,27 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 	repo_read_index(the_repository);
 
+	set_opts.cone_mode = -1;
+	set_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
+		return 1;
+
+	/*
+	 * Cone mode automatically specifies the toplevel directory.  For
+	 * non-cone mode, if nothing is specified, manually select just the
+	 * top-level directory (much as 'init' would do).
+	 */
+	if (!core_sparse_checkout_cone && argc == 0) {
+		argv = default_patterns;
+		argc = default_patterns_nr;
+	}
+
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
 }
 
-- 
gitgitgadget

