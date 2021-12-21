Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2DC433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhLUTOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhLUTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C25C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so9511wrd.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E5s3dvAoFicyBoAUjQuu/VMOk7fwtJ6lZsgxhzhDnIU=;
        b=UqnOOPusBZ9EyoQvwBhJgOtivOpFq7ewboDzyzyk9t68acAb+l1Ac9zEyiY+hmMAwV
         HRAXs25UobqkIX+v0qr4w1EIShVfcAInVft+hkYv5ym6YQWKC9V0k2T5J77/gAnFKWY0
         8KuAQpLOqe3RCf4KlY3v390VugmLjVGntQ9hsI3EoisYTsghnSqxo7vELnkFo0+ou4dZ
         j3sFZ0lqXEI19HDWbz+XdGhwy3FDSWa0dIhfke+lrkGNOB7+ZnY51ZcdBUP4sUaD6CCH
         BwGat2ogLp+S3UmNMHDbZ/mN6ydDrfnGQDPVGfWa2J198mz2KVFfFdKz0AElEQiSs/ZR
         LsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E5s3dvAoFicyBoAUjQuu/VMOk7fwtJ6lZsgxhzhDnIU=;
        b=NVNnnp12XLBlMHCv2crbL3IEzNX7khb9wdUB7ww4H6ZYvzuyZc4dPytWN4gwT/qzmJ
         V7Neon8S4iwnNZKu7320wT2OvN3a3rKdH3DOPcYtIIcky/2buBbLkj6ncP8Ri9UYEp1W
         GepOOTPGgj8qThsr5/8YY01gwCV0rFd2zxjFuMjeL2+HQKEblBg/29vphnfh8Dxe8r3l
         7mxjVN4DO9Y3gvYgeEfN0gwtB69ss3EF6u+LQQdaj2A52mBnKwePEnB49ApRFFMINRaL
         KANTH2ayGQ5DWY0Q2/vpKqKWR1P6BArG0QSb5HiIXTavcfREWrIVY7vjk5Gnn6+KbS2S
         Oo7w==
X-Gm-Message-State: AOAM533+BSSz8YA49CftYCK/JksqDoYnUbYsKLqrHpRMq9T/n38tlfDg
        4W5D3oBrkB4hxF6bETjUOqpyxfGD8p4=
X-Google-Smtp-Source: ABdhPJxZVmb7l7zwHjCern0mFsctFdelDyibgnNNnO0vtsCpIeUX4kknUq3hmL7HN/B9ZU8sAz8UDg==
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr3838257wrd.198.1640114052751;
        Tue, 21 Dec 2021 11:14:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm19187280wrb.2.2021.12.21.11.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:12 -0800 (PST)
Message-Id: <06457fafa78e18b7bb7f6d87408b0759d98344d8.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:08 +0000
Subject: [PATCH v2 5/5] sparse-checkout: use repo_config_set_worktree_gently()
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
 t/t1091-sparse-checkout-builtin.sh | 16 +++++++++++++++-
 3 files changed, 26 insertions(+), 25 deletions(-)

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
index 272ba1b566b..b563ccfeb36 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -71,6 +71,20 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
+test_expect_success 'init in a worktree of a bare repo' '
+	test_when_finished rm -rf bare worktree &&
+	git clone --bare repo bare &&
+	git -C bare worktree add ../worktree &&
+	(
+		cd worktree &&
+		git sparse-checkout init &&
+		test_must_fail git config core.bare &&
+		git sparse-checkout set /*
+	) &&
+	git -C bare config --list --show-origin >actual &&
+	grep "file:config.worktree	core.bare=true" actual
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
@@ -219,7 +233,7 @@ test_expect_success 'sparse-index enabled and disabled' '
 		test-tool -C repo read-cache --table >cache &&
 		! grep " tree " cache &&
 		git -C repo config --list >config &&
-		! grep index.sparse config
+		test_cmp_config -C repo false index.sparse
 	)
 '
 
-- 
gitgitgadget
