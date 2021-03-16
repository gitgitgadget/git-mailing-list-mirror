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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A0FC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5DE6510B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhCPQoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhCPQnR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909FC061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so7783641wrt.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xeo+ALDrr9sojSvzOq0Dt1thWADRAna/XtjhCXYIYmg=;
        b=QDgo8CF/nB4x6FIRoKTPBnZ5kTF3Q5bg3ArCL1rFnjbg4vzIpML7iErQLDr3XzWMcS
         9XIdmDBChSxreOA31e+MeFfiYgy6UBKLsQDMJTqH28r+UH9b+/3EKu89aSCr4z0otiFx
         C2S/cP3U3WAXw/89zJyPmQ8ZhzJTZkNg4RLSomzy8Iw3zQUeUfmLkpPc7pUYt2ulqVv6
         PRuof9IhtU3iabbfcK2ghpq/vYcB0R3tf44GBvYblFGTPVmpm+xJaNUvbLFGRZVr9AmA
         PLG4Ri40doCrmxpJXReWTtvk1lNjPmVn/JeqW/V1di2iEGrAnuVyk5j0KGWPMhkQetjd
         ZrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xeo+ALDrr9sojSvzOq0Dt1thWADRAna/XtjhCXYIYmg=;
        b=HxBon1cct2Mc2eW1hgvBwTqCp+oG+ahp8SmOVVxvI88uXHtsAJBNPOtfW2+bqGRINT
         UYz0I7EiE422wbyN8lj9h5j0U0nqxHWr1FBSBGmEFDj4bo66I0lweEbA2qx6piK6/WqJ
         p3m5HQj6F5C0jXub2FGPEqOYk6KLeQmJmcd/V++eA03Z3FoCpfVaYV69iKIyFknPIhmA
         EGa/Z8p+W/JBczKgeWvoTjuHFTVBvW5ombxhJiWi/0R49I7VMxz16PdNZF/usjfkZCz6
         da32rJrZouANRrUlHd//oL+4rHQxGfOoywKYpNQdXmMfLkSf+EUr61kJpn7HuBMZ1Fxu
         glfQ==
X-Gm-Message-State: AOAM531REWHlUb3saopO0XpACU7LweHxeUweyi0TCehlDUrAPHBtkdXG
        OEZehzhvBUPc29zcJ+LxrkZsQQTcXoE=
X-Google-Smtp-Source: ABdhPJx25JryrXtf5+Z1Kdq8ViP6vNgBhv9XvCwJbhmhKkNpnWd4ZmM019R+y1OoGYTXO18Er+sB/A==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr5598002wrg.376.1615912995689;
        Tue, 16 Mar 2021 09:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm10408wmd.41.2021.03.16.09.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:15 -0700 (PDT)
Message-Id: <f89891b0ae4e5e8f7b53da41582ca56772de0d16.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:58 +0000
Subject: [PATCH v3 15/20] sparse-index: create extension for compatibility
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

Previously, we enabled the sparse index format only using
GIT_TEST_SPARSE_INDEX=1. This is not a feasible direction for users to
actually select this mode. Further, sparse directory entries are not
understood by the index formats as advertised.

We _could_ add a new index version that explicitly adds these
capabilities, but there are nuances to index formats 2, 3, and 4 that
are still valuable to select as options. Until we add index format
version 5, create a repo extension, "extensions.sparseIndex", that
specifies that the tool reading this repository must understand sparse
directory entries.

This change only encodes the extension and enables it when
GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
mechanism.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/extensions.txt |  8 ++++++
 cache.h                             |  1 +
 repo-settings.c                     |  7 ++++++
 repository.h                        |  3 ++-
 setup.c                             |  3 +++
 sparse-index.c                      | 38 +++++++++++++++++++++++++----
 6 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 4e23d73cdcad..c02e09af0046 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -6,3 +6,11 @@ extensions.objectFormat::
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
+
+extensions.sparseIndex::
+	When combined with `core.sparseCheckout=true` and
+	`core.sparseCheckoutCone=true`, the index may contain entries
+	corresponding to directories outside of the sparse-checkout
+	definition in lieu of containing each path under such directories.
+	Versions of Git that do not understand this extension do not
+	expect directory entries in the index.
diff --git a/cache.h b/cache.h
index 69a32146cd77..4ca6cd7f782c 100644
--- a/cache.h
+++ b/cache.h
@@ -1059,6 +1059,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
diff --git a/repo-settings.c b/repo-settings.c
index d63569e4041e..9677d50f9238 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,4 +85,11 @@ void prepare_repo_settings(struct repository *r)
 	 * removed.
 	 */
 	r->settings.command_requires_full_index = 1;
+
+	/*
+	 * Initialize this as off.
+	 */
+	r->settings.sparse_index = 0;
+	if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
+		r->settings.sparse_index = 1;
 }
diff --git a/repository.h b/repository.h
index e06a23015697..a45f7520fd9e 100644
--- a/repository.h
+++ b/repository.h
@@ -42,7 +42,8 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 
-	unsigned command_requires_full_index:1;
+	unsigned command_requires_full_index:1,
+		 sparse_index:1;
 };
 
 struct repository {
diff --git a/setup.c b/setup.c
index c04cd25a30df..cd8394564613 100644
--- a/setup.c
+++ b/setup.c
@@ -500,6 +500,9 @@ static enum extension_result handle_extension(const char *var,
 			return error("invalid value for 'extensions.objectformat'");
 		data->hash_algo = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "sparseindex")) {
+		data->sparse_index = 1;
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
diff --git a/sparse-index.c b/sparse-index.c
index 7631f7bd00b7..3a6df66faeab 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -102,19 +102,47 @@ static int convert_to_sparse_rec(struct index_state *istate,
 	return num_converted - start_converted;
 }
 
+static int enable_sparse_index(struct repository *repo)
+{
+	const char *config_path = repo_git_path(repo, "config.worktree");
+
+	if (upgrade_repository_format(1) < 0) {
+		warning(_("unable to upgrade repository format to enable sparse-index"));
+		return -1;
+	}
+	git_config_set_in_file_gently(config_path,
+				      "extensions.sparseIndex",
+				      "true");
+
+	prepare_repo_settings(repo);
+	repo->settings.sparse_index = 1;
+	return 0;
+}
+
 int convert_to_sparse(struct index_state *istate)
 {
 	if (istate->split_index || istate->sparse_index ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
+	if (!istate->repo)
+		istate->repo = the_repository;
+
+	/*
+	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
+	 * extensions.sparseIndex config variable to be on.
+	 */
+	if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
+		int err = enable_sparse_index(istate->repo);
+		if (err < 0)
+			return err;
+	}
+
 	/*
-	 * For now, only create a sparse index with the
-	 * GIT_TEST_SPARSE_INDEX environment variable. We will relax
-	 * this once we have a proper way to opt-in (and later still,
-	 * opt-out).
+	 * Only convert to sparse if extensions.sparseIndex is set.
 	 */
-	if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.sparse_index)
 		return 0;
 
 	if (!istate->sparse_checkout_patterns) {
-- 
gitgitgadget

