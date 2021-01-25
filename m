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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE864C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B509E2251F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbhAYSDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbhAYRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CFC06121C
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so39233wml.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GJ4WeDWijjlg9pmh5tttLlHgELqjWYp/L8J8l1rm5LI=;
        b=bkU5WVMlGCWTNdIS4XIrPqcUOl28M5ddKHvqZEHE1wzuZn+3amfoFCLgoXCgXQwybH
         Cs1Eev/7slnC9sTDCiHps+vbS3HWhasAULS47jM8mYYcUfeA6Gp6vimtyxQGOBMgly0B
         UB6gbj80xRTZYWx4EQo38WNdYXtZMwtP4D+dYdIqwFvLWycFNjT4VinuIAzDPM5vKbz2
         /5JPshtT3MjUjcEN0dN0v7LyP1T431VJXMXpgs8twhyuc8GNTUxHKMbph3OFO9eiYd/N
         PtpA5T0OHqzWLdM2lBMXZqd7SDAisMnImTN18L2ojC720cdT+xVPsUwVbMOhn9pxGU42
         3nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GJ4WeDWijjlg9pmh5tttLlHgELqjWYp/L8J8l1rm5LI=;
        b=jroHtbaHw+RYMuSnPP1PfJk1VXFE519vTsW70brls0JqfwqNdbX2PKa8JEJWFD5vRi
         QzCm0J4vjBJsUlVO75zI/hhtImka9dcEMqLIu3cMdQfmdjDvKiqB/gq/+8Qb4MeL6GJd
         IxQHB/AA4o4yHXSX2fVOIE3A0gatjNIeaoM2o49R9/nl2GmoY4jvQjkzGWMnF9EMyGP2
         wkhAyTrZO0Sa55XyPcNIoutSZPnpqiFO8zQWxhtX87osLnIX7thzaJsQbTEq9D/nK4ya
         z7/w6Haa6s3NrkVyCButNIKjbGlQEIqgGQzMsfbrhl32cCLf/TKrxmAA0YRElrwk8OcD
         8MTA==
X-Gm-Message-State: AOAM533xcxLoBGehIS7w2mNbvAl0E86jtJjHCNJKeT/y+yCK3wqCxlrS
        iwRRFU1vfuicgap30J4dMu+AEKnCuOw=
X-Google-Smtp-Source: ABdhPJysMujhwxphLyuDXQc0UFhcQJ5Fa3kHVpxu2DMfaSuSwgJ49BzJd3Cz8BMYb/PHNTbxqvhE4Q==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr1150328wmq.93.1611596547378;
        Mon, 25 Jan 2021 09:42:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm50617wma.6.2021.01.25.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:26 -0800 (PST)
Message-Id: <d15f67c40ea10eff8d83df72a86b8677607f4ee3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:59 +0000
Subject: [PATCH 13/27] sparse-index: create extension for compatibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
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
are still valuable to select as options. For now, create a repo
extension, "extensions.sparseIndex", that specifies that the tool
reading this repository must understand sparse directory entries.

This change only encodes the extension and enables it when
GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
mechanism.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/extensions.txt |  7 ++++++
 cache.h                             |  1 +
 repo-settings.c                     |  7 ++++++
 repository.h                        |  3 ++-
 setup.c                             |  3 +++
 sparse-index.c                      | 38 +++++++++++++++++++++++++----
 6 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 4e23d73cdca..5c86b364873 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -6,3 +6,10 @@ extensions.objectFormat::
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
+
+extensions.sparseIndex::
+	When combined with `core.sparseCheckout=true` and
+	`core.sparseCheckoutCone=true`, the index may contain entries
+	corresponding to directories outside of the sparse-checkout
+	definition. Versions of Git that do not understand this extension
+	do not expect directory entries in the index.
diff --git a/cache.h b/cache.h
index b05341cc687..dcf089b7006 100644
--- a/cache.h
+++ b/cache.h
@@ -1054,6 +1054,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
diff --git a/repo-settings.c b/repo-settings.c
index d63569e4041..9677d50f923 100644
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
index e06a2301569..a45f7520fd9 100644
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
index c04cd25a30d..cd839456461 100644
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
index 5dd0b835b9d..71544095267 100644
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

