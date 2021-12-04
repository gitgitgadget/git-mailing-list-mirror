Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3480AC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378919AbhLDUDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377689AbhLDUDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE44AC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso7453151wml.1
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vikPXS4ebcpen2mKDPM95t+Hv2rEDd3qZ8KEeQvkuSI=;
        b=Rslw52SswALWYxyymMuSlixBsZU8Qf10EGgNRzA/7DYIDxdPeHx9IldiHPPvGAd1Nb
         9Gz3kErqeIu+j+5zEd48yK6j1Y4tntClNseBzTefVMKkTgrk7ZMoV/FjfIBjQg7pBG0c
         PRxDTuayxe7T0Ah8BvKW2JE6TiblJyuW4+EZiAlyDErK2dUEpGYDMATJ4G4Yq7tc2Jzs
         W7UCgM+FweLFkYtjxw6ktS230Tfgbm/OsfYjk1j642PEFVbrlvNoMrLdVzQsLT2+m95j
         iBcZ0SK9Ofv1mMW+qrbdpdeK4rT1HjWvP2g5D4beHnvW9GelwWKlDvVANwAD61EE1p6N
         OPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vikPXS4ebcpen2mKDPM95t+Hv2rEDd3qZ8KEeQvkuSI=;
        b=sP2J3IGybaAearAVpNjZtvVg3U/d+xnXqwffL04CdQxlPoAUZ3kf9HJKOGPwx+ky9N
         7vG/aGGdWGT7RteB6Z/MoKRqwtH6SjII2nenUApETdfZZnnpLHaaYwaRbUwDmQVwtT8i
         QcXmxf4bklPMKlIyE7oXv5xMfAz3hLX0dahTuib3rO/vUlUBAx/Z9SC+aE+1wn2IzsxN
         QZhoFmNYn1AI54dWeYD459CiRCyOvUO7i07l0gA9bQsSbDwgjYoC7ClZlMJvNjrZzkMI
         F4di2mefxzuyPFyxN7G+FWutRH6ZdmyEziOhqKgcRH77OugN0u802DuuG+yDDZASir+Q
         3Y5g==
X-Gm-Message-State: AOAM531bnvh97XrNLSl9Y4sffYU3uBYQTLu4oUTK7KBRciLAfwKWM4Pi
        PzqLC3N07yAC/9GG+AeDeaAtoQiaQCA=
X-Google-Smtp-Source: ABdhPJzYZPHpz8mEPmUi02oSF6e5vP72E6JLewBfHxOLVRodA7nlP5vKPnFUh4ow7nXDcZWhJtTTJA==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr26342733wmi.61.1638648024289;
        Sat, 04 Dec 2021 12:00:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm8978575wmq.15.2021.12.04.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:23 -0800 (PST)
Message-Id: <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:17 +0000
Subject: [PATCH 3/6] sparse-checkout: enable `set` to initialize
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
 builtin/sparse-checkout.c | 52 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e252b82136e..cf6a6c6c3a7 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -682,17 +682,26 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	N_("git sparse-checkout set [--cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
 	NULL
 };
 
 static struct sparse_checkout_set_opts {
+	int cone_mode;
+	int sparse_index;
 	int use_stdin;
 } set_opts;
 
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
+	int mode, record_mode;
+	const char *default_patterns[] = {"/*", "!/*/"};
+
 	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "cone", &set_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
 			 N_("read patterns from standard in")),
 		OPT_END(),
@@ -700,11 +709,52 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 	repo_read_index(the_repository);
 
+	set_opts.cone_mode = -1;
+	set_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	/* Determine if we need to record the mode; ensure sparse checkout on */
+	record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
+	core_apply_sparse_checkout = 1;
+
+	/* If not specified, use previous definition of cone mode */
+	if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)
+		set_opts.cone_mode = core_sparse_checkout_cone;
+
+	/* Set cone/non-cone mode appropriately */
+	if (set_opts.cone_mode == 1) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else {
+		mode = MODE_ALL_PATTERNS;
+	}
+	if (record_mode && set_config(mode))
+		return 1;
+
+	/* Set sparse-index/non-sparse-index mode if specified */
+	if (set_opts.sparse_index >= 0) {
+		if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
+			die(_("failed to modify sparse-index config"));
+
+		/* force an index rewrite */
+		repo_read_index(the_repository);
+		the_repository->index->updated_workdir = 1;
+	}
+
+	/*
+	 * Cone mode automatically specifies the toplevel directory.  For
+	 * non-cone mode, if nothing is specified, manually select just the
+	 * top-level directory (much as 'init' would do).
+	 */
+	if (!core_sparse_checkout_cone && argc == 0) {
+		argv = default_patterns;
+		argc = 2;
+	}
+
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
 }
 
-- 
gitgitgadget

