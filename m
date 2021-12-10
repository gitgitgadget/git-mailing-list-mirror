Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA0C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhLJD75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhLJD7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49948C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u17so12937315wrt.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IpLeF4DkdJttTfwVjwJ/T7r+jgGFHv1KUqMNW7E0gF0=;
        b=MEdfKsZurkyPUglJIY1u0Dz/BxHskMLONR1GSzrDXnqywtLtMn6AJAzpNoK0SOtRzp
         L4MpdRpaENRTasDUSxAi1wpLqfeGXZSCrYP9H2eVopGpGWuy3tREZO1rLLaAht8uNqQL
         APfpmZfvr8ESvdri8R32kOJY47NjvSKh7iFyEyaY7cZBMX66wcnIaGRwvTXOnOsFrYlq
         Yhv71hAabFNtsggXkW4dweYaY+zqW9wOZIyTfHhkh+8m91YhuzX+CSiRsAPLr3lP77c8
         +tWfBgfqf8Hq9U4zjnnjWrcdlI8aHbXr7YQutRdXmLcOZbo3bDR/E7V8Qcy1vJJdYy3H
         5bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IpLeF4DkdJttTfwVjwJ/T7r+jgGFHv1KUqMNW7E0gF0=;
        b=5aWHEctc1ugejTyV9MHRfyOiMFxlqOwVQDad/00OtmRLifGO1Kn/nL4tgLvC0ofYAW
         JadCL3O2vt6vcTOnhyuTK7oX/LtUcD5zqH/Zbh9eRqdpnl4NnShqHgXqR0n73VXee47p
         BmlX3BcG8vzJVQLEUJqI8IyA9tEEpyaxtg/InDwdM7C/J/lNYztA+4bBowiJVf/uxwPm
         dQWfzU/eLitss1uo7WJup6xyBxFi4B7H/OHBumKiVyfjdaOQV6ID2fvryi+pheWD1iY8
         GMZS5DefBC/yxJok0ObJubPLfoOIxLG582sjcdNvJUumvV4G7EhcQFxCk2iCvW3Pt49O
         DnLw==
X-Gm-Message-State: AOAM530YHQDGhPTbfaB9o7t5YhwIJ28fKy+lM+qiXjKjc9+Q1duWQos9
        JlHkhSt47VKnLbIKjFz96eITJJsSQrg=
X-Google-Smtp-Source: ABdhPJzo0QrVoPnLuepu2BSTct/o+zOewJohcMibmyWk/L7FmsWsikyFzQw+oi8ONKIknJSPkS4mpQ==
X-Received: by 2002:a05:6000:2ae:: with SMTP id l14mr11184531wry.142.1639108578744;
        Thu, 09 Dec 2021 19:56:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm1542279wmc.40.2021.12.09.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:18 -0800 (PST)
Message-Id: <7167a4b3118f1bdc2092303182782f2de983ec36.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:09 +0000
Subject: [PATCH v3 06/10] sparse-checkout: enable `set` to initialize
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

