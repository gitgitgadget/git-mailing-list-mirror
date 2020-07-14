Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5CC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F2821655
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVg958St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGNB1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNB1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 21:27:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E8C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so2479602wmf.5
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WW3xJ+8LufhRd5qtp5Kdsal9hLoMDrlgpqoj30QgSfE=;
        b=CVg958St85yGlZ1J9AM4IpqoTliZlYj5dckwvCpVzW5mamnEbhx9/QukMwScH64ral
         lKqx9ILfadNCnp0+FrfI/OAt2cwXIw9/qtZqYRxHpE77foaVGlEKntJGSIU9L2fZfkbT
         /w7iXCgXEwdj0uu29FuhEWGxiLs5yeShS3Mrce6tYKswFJ1+37I6KyFZhfMWB5Wtj3zw
         7Fitnxg6lx9FYbSlbZxDnznqEWlOe+oZM+e0CdgtjluG7ZWdtlQ15Ll7jKc8RaNzFcLz
         QYr9dYT6P9R5dlMOex9K+TU6rf6v/Zt6EA0i/oHiFsf5I6pMM7yK6lXEaqJwPJlMq+b2
         vVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WW3xJ+8LufhRd5qtp5Kdsal9hLoMDrlgpqoj30QgSfE=;
        b=JNfhvS5auqJgg3PfWMrwbiZ70+CpOxcDORqiTWNjHppgKIDmofe8XsclKM3RDUIy8P
         3UY39+q84XzU61YQbPkY203/paw58mU4iAimLkgwaxp6bCzBbTPLSlLDjGY94WRsLl1d
         oNAeOiOLD+++D9vTkmenL+W+ZsYcmqt/e8S/sJ67sVtsMEUDmfslWn14e9V//Cdc2cY5
         hN0exjpTm2tpU3XngTetBuoxWI11tnatcY5IahaexGC4K8GdoQ8p5Y2c5ILWYwNxhLrf
         BELGzDEm4a2c+0lWHjsxYUXwuqi47mEeBHhhbodhIR2nTigiecj3nNgKI8AAUcmlHVId
         4Xlg==
X-Gm-Message-State: AOAM531GfaecD2axsmHcHcz2aYvQNRe6vy01ZhJciVivLTELsigzaa3p
        j6AMXKnnvEN/FWnlXls/AN4a5qXs
X-Google-Smtp-Source: ABdhPJzUsx4liZQqwsYbP927FhwHzOe+yH2092M9SqvuMuo14haDP7UownpsqoxWlgfDdncWdWlWww==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr1950372wmj.112.1594690019803;
        Mon, 13 Jul 2020 18:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm26948726wro.71.2020.07.13.18.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 18:26:59 -0700 (PDT)
Message-Id: <1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jul 2020 01:26:56 +0000
Subject: [PATCH v2 1/2] setup: tweak upgrade policy to grandfather
 worktreeconfig
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, delphij@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Prior to 14c7fa269e4 (check_repository_format_gently(): refuse extensions
for old repositories, 2020-06-05), Git was honoring configured
extensions, even if core.repositoryFormatVersion was 0 (or unset). This
was incorrect, and is now fixed.

The issue now is that users who relied on that previously bad behavior
will upgrade to the next version of Git and suddently be in a bad
situation. In particular, users of the 'git sparse-checkout' command
will rely on the extensions.worktreeConfig for the core.sparseCheckout
and core.sparseCheckoutCone config options. Without that extension,
these users will suddenly have repositories stop acting like a sparse
repo.

What is worse is that a user will be confronted with the following
error if they try to run 'git sparse-checkout init' again:

	warning: unable to upgrade repository format from 0 to 1

This is because the logic in 14c7fa269e4 refuses to upgrae repos when
the version is unset but extensions exist.

One possible way to alert a user of this issue is to warn them when Git
notices an extension exists, but core.repositoryFormatVersion is not a
correct value. However,

 - it requires the end-user to read, understand and execute the
   manual upgrade

 - it encourages to follow the same procedure blindly, making the
   protection even less useful

Let's instead keep failing hard without teaching how to bypass the
repository protection, but allow upgrading even when only the
worktreeconfig extension exists in an old repository, which is
likely to be set by a broke version of Git that did not update the
repository version when setting the extension.

This change of behavior is made visible by testing how 'git
sparse-checkout init' behaves to upgrade the repository format version
even if the extension.worktreeConfig is already set. This would
previously fail without a clear way forward.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h                            |  2 +-
 setup.c                            | 12 ++++++++----
 t/t1091-sparse-checkout-builtin.sh | 12 ++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index e5885cc9ea..8ff46857f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,8 +1042,8 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
-	int has_extensions;
 	char *work_tree;
+	int has_unallowed_extensions;
 	struct string_list unknown_extensions;
 };
 
diff --git a/setup.c b/setup.c
index eb066db6d8..65270440a9 100644
--- a/setup.c
+++ b/setup.c
@@ -455,12 +455,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
-		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
 		 * check_repository_format will complain
 		 */
+		int is_unallowed_extension = 1;
+
 		if (!strcmp(ext, "noop"))
 			;
 		else if (!strcmp(ext, "preciousobjects"))
@@ -469,10 +470,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else if (!strcmp(ext, "worktreeconfig"))
+		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-		else
+			is_unallowed_extension = 0;
+		} else
 			string_list_append(&data->unknown_extensions, ext);
+
+		data->has_unallowed_extensions |= is_unallowed_extension;
 	}
 
 	return read_worktree_config(var, value, vdata);
@@ -560,7 +564,7 @@ int upgrade_repository_format(int target_version)
 		return 0;
 
 	if (verify_repository_format(&repo_fmt, &err) < 0 ||
-	    (!repo_fmt.version && repo_fmt.has_extensions)) {
+	    (!repo_fmt.version && repo_fmt.has_unallowed_extensions)) {
 		warning("unable to upgrade repository format from %d to %d: %s",
 			repo_fmt.version, target_version, err.buf);
 		strbuf_release(&err);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 88cdde255c..6e339c7c8e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -68,6 +68,18 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
+test_expect_success 'git sparse-checkout works if repository format is wrong' '
+	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
+	git -C repo config --unset core.repositoryFormatVersion &&
+	git -C repo sparse-checkout init &&
+	git -C repo config core.repositoryFormatVersion >actual &&
+	echo 1 >expect &&
+	git -C repo config core.repositoryFormatVersion 0 &&
+	git -C repo sparse-checkout init &&
+	git -C repo config core.repositoryFormatVersion >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
-- 
gitgitgadget

