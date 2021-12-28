Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDEC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhL1Vcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhL1Vcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34966C061401
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c66so12384574wma.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=znDrSuS0qJDmMNdY4aat1qMorpeFr3VuLb0gkrLPcZ4=;
        b=d24Z6f87AtfrHdFYktN6LYh71AyNtkCsndwe6vGbHEFc4q0oT9aH04e6cotzaofds3
         3KZGPQSRVu76X+plhzQnXgNpUKiXWV4ieUc79yhNtC6ftzHna35Mn8zhKxIBHJMT69rd
         Pcj/Vqes8ZHedIJh86BOa/M4DmPDHefh4IbIOvPb13B5SU2hs6gb/gSdMfHbpiGOVvuA
         EkNWmsoOiKOcSjKIQjZNKdBS3Ur4gjycNwBbFuPiKm9cmdp0SdG7xsM1Do/yJLtopHiK
         DSjqmeR/Lukz9gN2/GkSsqegwJ9BtmdJuXbE68aTX9cUd7PruTmxzKWxKg3DylCpeJ/z
         eODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=znDrSuS0qJDmMNdY4aat1qMorpeFr3VuLb0gkrLPcZ4=;
        b=tWs6rXyTLG9wAdvhw/Sw4NcTfnPSltxS6nZv+ixbcpWCNIzOtrxFakwThEp6uBK33r
         KxhqReZCxI/rqHTKnzFrIK9qFymcJARsUBFc6XJz/Xuxd2afnOumV/tz4/bRxsKxymlJ
         9V758Npef9GEsol/luDVbF0pmN70u4VcotsVqJ8GOX00f5jqA8poga0B3e56AFonO8ev
         D8wjjXhglok9RCuQY/oVcSoV+buaFRq2geL/cVItSxCrUV4sCoj2Yr5IcvhtX+xmUtjp
         /F5dFBoZlUTEUZJQdLkt8RODeMBDykqyrBxOQE3XZWUserD8LPIQJvWYzUIAckoPqIAE
         aOog==
X-Gm-Message-State: AOAM5322LEGy8tyusFAzrOqjbnb32trwZcq5GOb14WRoaZkHKpUzvhlX
        /KPf/NOGmo/hsS0vBPCrsjFgHXbDOGc=
X-Google-Smtp-Source: ABdhPJwjefKCd55vkrmZWZ5EP7JyNXfufUGdRlOziNNitUIg1wSXFv4mKXl5cKRqaFzGG3qsSVS8eg==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr19328331wml.0.1640727149575;
        Tue, 28 Dec 2021 13:32:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm34998wrz.113.2021.12.28.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:29 -0800 (PST)
Message-Id: <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:23 +0000
Subject: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config on
 add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When adding a new worktree, it is reasonable to expect that we want to
use the current set of sparse-checkout settings for that new worktree.
This is particularly important for repositories where the worktree would
become too large to be useful. This is even more important when using
partial clone as well, since we want to avoid downloading the missing
blobs for files that should not be written to the new worktree.

The only way to create such a worktree without this intermediate step of
expanding the full worktree is to copy the sparse-checkout patterns and
config settings during 'git worktree add'. Each worktree has its own
sparse-checkout patterns, and the default behavior when the
sparse-checkout file is missing is to include all paths at HEAD. Thus,
we need to have patterns from somewhere, they might as well be the
current worktree's patterns. These are then modified independently in
the future.

In addition to the sparse-checkout file, copy the worktree config file
if worktree config is enabled and the file exists. This will copy over
any important settings to ensure the new worktree behaves the same as
the current one.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/worktree.c                 | 41 +++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 53 ++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 937ee6fc38b..bca49a55f13 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -336,6 +336,47 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
+	/*
+	 * If the current worktree has sparse-checkout enabled, then copy
+	 * the sparse-checkout patterns from the current worktree.
+	 */
+	if (core_apply_sparse_checkout) {
+		char *from_file = git_pathdup("info/sparse-checkout");
+		char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
+					realpath.buf, name);
+
+		if (file_exists(from_file)) {
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666))
+				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
+				      from_file, to_file);
+		}
+
+		free(from_file);
+		free(to_file);
+	}
+
+	/*
+	 * If we are using worktree config, then copy all currenct config
+	 * values from the current worktree into the new one, that way the
+	 * new worktree behaves the same as this one.
+	 */
+	if (repository_format_worktree_config) {
+		char *from_file = git_pathdup("config.worktree");
+		char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
+					realpath.buf, name);
+
+		if (file_exists(from_file)) {
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666))
+				error(_("failed to copy worktree config from '%s' to '%s'"),
+				      from_file, to_file);
+		}
+
+		free(from_file);
+		free(to_file);
+	}
+
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 15403158c49..ce84819e1f5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -180,6 +180,53 @@ test_expect_success 'set enables config' '
 '
 
 test_expect_success 'set enables worktree config, if enabled' '
+	git init worktree-patterns &&
+	(
+		cd worktree-patterns &&
+		test_commit test file &&
+		mkdir dir dir2 &&
+		test_commit dir dir/file &&
+		test_commit dir2 dir2/file &&
+
+		# By initializing the worktree config here...
+		git worktree init-worktree-config &&
+
+		# This set command places config values in worktree-
+		# specific config...
+		git sparse-checkout set --cone dir &&
+
+		# Which must be copied, along with the sparse-checkout
+		# patterns, here.
+		git worktree add --detach ../worktree-patterns2
+	) &&
+	test_cmp_config -C worktree-patterns true core.sparseCheckout &&
+	test_cmp_config -C worktree-patterns2 true core.sparseCheckout &&
+	test_cmp_config -C worktree-patterns true core.sparseCheckoutCone &&
+	test_cmp_config -C worktree-patterns2 true core.sparseCheckoutCone &&
+	test_cmp worktree-patterns/.git/info/sparse-checkout \
+		 worktree-patterns/.git/worktrees/worktree-patterns2/info/sparse-checkout &&
+
+	ls worktree-patterns >expect &&
+	ls worktree-patterns2 >actual &&
+	test_cmp expect actual &&
+
+	# Double check that the copy works from a non-main worktree.
+	(
+		cd worktree-patterns2 &&
+		git sparse-checkout set dir2 &&
+		git worktree add --detach ../worktree-patterns3
+	) &&
+	test_cmp_config -C worktree-patterns3 true core.sparseCheckout &&
+	test_cmp_config -C worktree-patterns3 true core.sparseCheckoutCone &&
+	test_cmp worktree-patterns/.git/worktrees/worktree-patterns2/info/sparse-checkout \
+		 worktree-patterns/.git/worktrees/worktree-patterns3/info/sparse-checkout &&
+
+	ls worktree-patterns2 >expect &&
+	ls worktree-patterns3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'worktree add copies sparse-checkout patterns' '
 	git init worktree-config &&
 	(
 		cd worktree-config &&
@@ -547,11 +594,11 @@ test_expect_success 'interaction with submodules' '
 
 test_expect_success 'different sparse-checkouts with worktrees' '
 	git -C repo worktree add --detach ../worktree &&
-	check_files worktree "a deep folder1 folder2" &&
+	check_files worktree "a folder1" &&
 	git -C worktree sparse-checkout init --cone &&
-	git -C repo sparse-checkout set folder1 &&
+	git -C repo sparse-checkout set folder1 folder2 &&
 	git -C worktree sparse-checkout set deep/deeper1 &&
-	check_files repo a folder1 &&
+	check_files repo a folder1 folder2 &&
 	check_files worktree a deep
 '
 
-- 
gitgitgadget
