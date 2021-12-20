Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0104C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhLTP5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhLTP5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5646C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so20977582wrg.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygHQYgXnIJEpJwZ5HKT23OLaaY3ZiHMixagGnCWrzyo=;
        b=X4+laB3hgz/xEsbTAN7hCMlw8cj9gQ9ugRbfRq/jxOOQ/hxf8KcuyyAtcPPNcosr6S
         p9pfFPZwOYYjzslRldyfmnUU/Zcsj/omkmqpT7sdydz3t92t7fraAIJzpr8xYpbXpNCR
         RW+u50/4mgp72xWryZXX4GdnwlFOQ0TOW0GTuI9/XC6frA5OnfhCNC5synAukIQI2mF7
         mrFCxXSDbUYGHsv36H+H4i+wBKlXTqWzDxY3UG0tKZbEgD4RmyUn1JoVTsZk28tkBqKO
         B9b9XAlip9LcrgDZbY16EZgIGVa0mle/1ll+DdNxOt92PIqHIGV71a0I5jmbjpGe0pR4
         3Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygHQYgXnIJEpJwZ5HKT23OLaaY3ZiHMixagGnCWrzyo=;
        b=NjNNX25OnLL9Jw9MpJMpXT6wfFeMNI9Han1gDTufFU5BQzmUioEtbzpRAeHGia5KOx
         O2T7tuLM0kMYr3oWgYV6JqLw5jAZHM7XWZVH93q9hwHFVdT+QXp6GQ+JskEYIKUQz4cI
         7rntfHDTYg7p5EGv0QoG7+gCPs1+QYvWFtS4QnEpdpWNQH0mmjJvuTOeLx1XtbgaYTfM
         BFNaU09B0CiRgYa/l67Frdl5J5tZ0tJ77UUY7hwVU8Uc+Q0GIwqN0rLYGt7fp8WBzzx2
         kEgL/AJkrCt/iioXyyoJe0Nsv4Sg1lBI1o+VC52j0+pYZJrSPMotHEMRDQDF0ldaGWTT
         bHmQ==
X-Gm-Message-State: AOAM533r6fnH1CHpd9KTN1yKTIjVz2UOTduRutseJQ36G737/90Qbe3K
        W/WmF5drEyx7Z77yhiW9UhhgQIE61VE=
X-Google-Smtp-Source: ABdhPJwPWA4nV3rx0bZhLBBpCP6W6me56s/20q4W2oDSpdvg6LrV+p+ECUXw/kjGkzmS3Y0Ub0wm4w==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr13618974wri.309.1640015848358;
        Mon, 20 Dec 2021 07:57:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm10959382wru.66.2021.12.20.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:57:28 -0800 (PST)
Message-Id: <6202f767f4ae8012ce8cdf78d3234eba478d6681.1640015845.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:57:24 +0000
Subject: [PATCH 4/4] sparse-checkout: use repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change added repo_config_set_worktree_gently() to assist
writing config values into the worktree.config file, especially when
that may not have been initialized.

When the base repo is bare, running 'git sparse-checkout init' in a
worktree will create the config.worktree file for the worktree, but that
will start causing the worktree to parse the bare repo's core.bare=true
value and start treating the worktree as bare. This causes more problems
as other commands are run in that worktree.

The fix is to have this assignment into config.worktree be handled by
the repo_config_set_worktree_gently() helper.

Reported-by: Sean Allred <allred.sean@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 25 ++++++++-----------------
 sparse-index.c                     | 10 +++-------
 t/t1091-sparse-checkout-builtin.sh | 14 +++++++++++++-
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 34447f87cd8..ec2c9a146cc 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -356,26 +356,17 @@ enum sparse_checkout_mode {
 
 static int set_config(enum sparse_checkout_mode mode)
 {
-	const char *config_path;
-
-	if (upgrade_repository_format(the_repository, 1) < 0)
-		die(_("unable to upgrade repository format to enable worktreeConfig"));
-	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
-		error(_("failed to set extensions.worktreeConfig setting"));
+	if (repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckout",
+					    mode ? "true" : "false") ||
+	    repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckoutCone",
+					    mode == MODE_CONE_PATTERNS ?
+						"true" : "false"))
 		return 1;
-	}
-
-	config_path = git_path("config.worktree");
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckout",
-				      mode ? "true" : NULL);
-
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckoutCone",
-				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
 
 	if (mode == MODE_NO_PATTERNS)
-		set_sparse_index_config(the_repository, 0);
+		return set_sparse_index_config(the_repository, 0);
 
 	return 0;
 }
diff --git a/sparse-index.c b/sparse-index.c
index a1d505d50e9..e93609999e0 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -99,13 +99,9 @@ static int convert_to_sparse_rec(struct index_state *istate,
 
 int set_sparse_index_config(struct repository *repo, int enable)
 {
-	int res;
-	char *config_path = repo_git_path(repo, "config.worktree");
-	res = git_config_set_in_file_gently(config_path,
-					    "index.sparse",
-					    enable ? "true" : NULL);
-	free(config_path);
-
+	int res = repo_config_set_worktree_gently(repo,
+						  "index.sparse",
+						  enable ? "true" : "false");
 	prepare_repo_settings(repo);
 	repo->settings.sparse_index = enable;
 	return res;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..3ff125c5fd6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -71,6 +71,18 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
+test_expect_success 'init in a worktree of a bare repo' '
+	test_when_finished rm -rf bare worktree &&
+	git clone --bare repo bare &&
+	git -C bare worktree add ../worktree &&
+	(
+		cd worktree &&
+		git sparse-checkout init &&
+		test_cmp_config false core.bare &&
+		git sparse-checkout set /*
+	)
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
@@ -219,7 +231,7 @@ test_expect_success 'sparse-index enabled and disabled' '
 		test-tool -C repo read-cache --table >cache &&
 		! grep " tree " cache &&
 		git -C repo config --list >config &&
-		! grep index.sparse config
+		test_cmp_config -C repo false index.sparse
 	)
 '
 
-- 
gitgitgadget
