Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhLNEJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLNEJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53924C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o29so13390459wms.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ct1DndFFRiF7Tn13kqO+Louo5bwVR+lM58b4WOxSE4w=;
        b=dlt8sVbjWvmPiUmK+Qq+IagvlJMTGJmyKWQxOre6ggEUhrYqd100VwUWNGoyYouKiA
         Sk8BQWBbUHiS2jhzQ88fEaNBeuut6g/RxwRJIW89YkrPssgR1+YgWdh1oW5essCVWqAE
         LvampSR4xq5I8s1Q6xErU6mq9BAjPE3HmUi9sQz65CwpCU2+kjMSyxYRuvr6yUN9cOhj
         bNQN+hi3ykvXXts2+bFk+C5s82UnalK9Si1t/KjnKS/F1xPgSiI6USqaR/PlYiT0CmKq
         PjLOnpcJaE0/y8Hi2zHCyoY+BYk0VBO9BntNXCkKqr/ScMCmrtyqrnNCWii6Feb6JUdr
         iYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ct1DndFFRiF7Tn13kqO+Louo5bwVR+lM58b4WOxSE4w=;
        b=hEilMi4NDnkry08yQiWEAOnspghGcMFR+xzeXKxwQE/4FB9TEdW139sLQDGficeJs0
         vSd9CDfYAECd/TY+rZbE8yA16PlX/j3pvX0em9jqVPhijWUlUcWurM9UZKacjAu/IEix
         NYZoFPtd0phihCEeVJDPmIomlDI2VD7Eug4jo/DFJuAr+1LQD3+uvyUfnCPuwvdUV5Iv
         CG4bi8gh0Ng2ZOia4bJyKGRS73N5QdI0i40nDRqBu6Mthy265KM/72hw6HZCtXMzU76r
         /LbVMINXJf+rK5xoYKpZhwz/uPN2J3Wu6QLiJ9GvMStbU5sH+Wpenqc4mVv0b2nreKt7
         l4IA==
X-Gm-Message-State: AOAM533zddrgKtCzJfslXsijwZs3k1Ku5uiEK7IkvmebXX+HJUVBCRGq
        mgakBiP7B0hKy60yKTiQFmBd2S+LFdw=
X-Google-Smtp-Source: ABdhPJynfaKqr3/17N7M6frK4rHvWsP0PWjlJmfzXk/L9yLyg6amqUOeAiVppbxzf2z6Abn7sL/Ubg==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr45219291wmb.10.1639454956768;
        Mon, 13 Dec 2021 20:09:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm844292wmq.42.2021.12.13.20.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:16 -0800 (PST)
Message-Id: <595ba13860352abcbd857c454c0b2d7e83efd6c0.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:08 +0000
Subject: [PATCH v4 06/10] sparse-checkout: enable `set` to initialize
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3b74779bb48..16daae84975 100644
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

