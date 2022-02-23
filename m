Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EDC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiBWS0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiBWSZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711004AE06
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso4906925wme.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZJNTdDJqVb503/vN/Ny1Tp4YD/HfLqHE/0fnL1DoQs4=;
        b=iBQSwvDmB5UYl0P8N4AZ4JdwV/M2V8Danm1Oxa1skboYxFnZxsMRJjgMomzAn60KKx
         QwR1+DpAQOUwIWnsE6wy6dSLs+ex133uRF09HlgypfmjvUOBkW9OlL59C6tKddUbYA6k
         TPI8rGdWGdu4pvTWuy70oiLUVIjwsTRYFhrYMFcEYfZWijFtKZAuSuwjsZfxP5uiHHoF
         a1oHF/mMb6nvbZh34eejfd334EkNi8d713qKgl1NmCigLBhyjFZbLfBosw+wiomgkH6d
         JeiD6WGlBnHEkDVIgEsAN9Yr1bk8n5CoXiLM+fwMZLVVxhNaSatbnl7/8fAurqCV6sFh
         IAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZJNTdDJqVb503/vN/Ny1Tp4YD/HfLqHE/0fnL1DoQs4=;
        b=0LcTEDpFmUOqmJnwrqRCNseNEL1JgHPBzql94UN1GH0Z6gDetH8qK1Ik2CsZADM9T6
         rqLnAc4DueplHN+inA4hyHODA6SI3Wfr1lbhOt8e1QKLD5yszRjBJnhrO6utAuMENiyx
         IUCiJIlLG/I7wN9p/DXk1Ydz8Pr+J/+CveoCCzhb3GXm0jWbdJEc4pYBEr+UByEQT/YV
         cuUvP2Bf8vm/8NkDcGfZaCM/8UIptiyAXMpOodmA1/ZA6NPnb1jk59WJVAWwdTbPfvvp
         8MgzgmEa1gVsag7Zd+Zb810Idxa8QUM+8qy911SkmbeqClW5FMfveRzO6cBtBsVlzGYJ
         oTfw==
X-Gm-Message-State: AOAM532lKJfOM6vLcuVQMW3LqVU0eEZzMC84x3ZEUndWSbbDE2fD4gpn
        A178vBYLZmoc8yMMA1UluHiuURdX9Pw=
X-Google-Smtp-Source: ABdhPJxHhKZQVpetiHkjqc+HVHafo7S2sJsojqlMvw3wZJ3Y3rA9yh7EiX4Dwj6h5IhNW7QWWPcLpA==
X-Received: by 2002:a05:600c:2e47:b0:37d:62d7:24bb with SMTP id q7-20020a05600c2e4700b0037d62d724bbmr8579786wmf.71.1645640721826;
        Wed, 23 Feb 2022 10:25:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm253387wmb.25.2022.02.23.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:21 -0800 (PST)
Message-Id: <5ee193bfa8733b55d74cb0b8e1d8944be52984c2.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:13 +0000
Subject: [PATCH 4/7] read-tree: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of sparse index in 'git read-tree'. The integration in this patch
is limited only to usage of 'read-tree' that does not need additional
functional changes for the sparse index to behave as expected (i.e., produce
the same user-facing results as a non-sparse index sparse-checkout). To
ensure no unexpected behavior occurs, the index is explicitly expanded when:

* '--no-sparse-checkout' is specified (because it disables sparse-checkout)
* '--prefix' is specified (if the prefix is inside a sparse directory, the
  prefixed tree cannot be properly traversed)
* two or more <tree-ish> arguments are specified ('twoway_merge' and
  'threeway_merge' do not yet support merging sparse directories)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      | 21 +++++++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2109c4c9e5c..c2fdbc2657f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -160,8 +160,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, cmd_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
@@ -169,6 +167,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.reset)
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
 	/*
 	 * NEEDSWORK
 	 *
@@ -210,6 +213,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
+	/* TODO: audit sparse index behavior in unpack_trees */
+	if (opts.skip_sparse_checkout || opts.prefix)
+		ensure_full_index(&the_index);
+
 	if (opts.merge) {
 		switch (stage - 1) {
 		case 0:
@@ -219,11 +226,21 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
 		case 2:
+			/*
+			 * TODO: update twoway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = twoway_merge;
 			opts.initial_checkout = is_cache_unborn();
 			break;
 		case 3:
 		default:
+			/*
+			 * TODO: update threeway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = threeway_merge;
 			break;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9d58da4e925..ae44451a0a9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1407,6 +1407,17 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'sparse index is not expanded: read-tree' '
+	init_repos &&
+
+	ensure_not_expanded checkout -b test-branch update-folder1 &&
+	for MERGE_TREES in "update-folder2"
+	do
+		ensure_not_expanded read-tree -mu $MERGE_TREES &&
+		ensure_not_expanded reset --hard HEAD || return 1
+	done
+'
+
 test_expect_success 'ls-files' '
 	init_repos &&
 
-- 
gitgitgadget

