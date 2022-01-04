Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B369C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiADRhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiADRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53BC06179B
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o3so19458078wrh.10
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bQGAMdsnsZf9gd+pRoCKK4mgwMk5BiSZ1vBBtyZvhEI=;
        b=UzuMHhaueEc4/jJunBTgDtEZvYSP2sBEUz+HQKwAg5UMGUtE9sknhLoJ2KC2QQhgZN
         yXZ1iYvniZdZRGAEyO1bb69tj1vqThv1Sr1++DXWUUsfQwfKSMftmNcKaUcFZiV9py6A
         C/nNv9aU/DhAyhEvw0rF+mquRorEXoKcqPP+cDhrhtJB0sl54o9KAwwV6itfk3CLSNrg
         vGoag5h/NvtA6Jpz+lYUOFINAeBQeMDm4v/buq2YE4NzkbAMyX1o+RxqVTo/H4r8C4ht
         HEV+f3bpOEmPBwDFQHx6Nx86No6Cko+hEQ7b7cE0szrLz1siSLxfO7R613sbuXY6WIWw
         sUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bQGAMdsnsZf9gd+pRoCKK4mgwMk5BiSZ1vBBtyZvhEI=;
        b=J+bibXZjEJcEyO8Oxc6uL4iydwG+yTMgsR8z7XKqjbQCX3nHAtJdwVqMoqdO4s8aos
         SyHU5Ktr7Dkoj3X8cjKWAKs+AIO8UgmAVrZp7/M/42nsA8ShHck2/EYhz6PxR/9L54t+
         8Hzu97z105w0/Ww4KqzK6T4t3IlLm3P6nDKgrwc+Cg3mC8DWtINzjR1iZk/HJz8LgLyQ
         APST0YByfv8PY4l8p3D63x3f4d1KYqOYy74nAJYdnBDJQV1lOMElVZtzs7OUtBzAmd1U
         GPHI0MM6HhiXKq53t2IUunC+3+zFxNnkPqrFJQngC6ta4HFoKW4JsuSqIhoBk31DPWdC
         gGfQ==
X-Gm-Message-State: AOAM530T5603i34vV2FXx4z6YipYwlNTIU6IEORVumOaeTL5ZanZY5s0
        DsTl4W/90hnvtrz3vc1LQnZJ7y/lWP4=
X-Google-Smtp-Source: ABdhPJynlZ902mw5hPnTOaC0xSfnDU1+qlD4MviqRwV+2CucBOw5wUGrm5i6AGk9Pg+Yr0RrmttR6A==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr43466710wrv.694.1641317827513;
        Tue, 04 Jan 2022 09:37:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm23741wms.16.2022.01.04.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:07 -0800 (PST)
Message-Id: <c5b98e36516b8f832576816c202be7581f261909.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:59 +0000
Subject: [PATCH 8/9] update-index: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable usage of the sparse index with `update-index`. Most variations of
`update-index` work without explicitly expanding the index or making any
other updates in or outside of `update-index.c`.

The one usage requiring additional changes is `--cacheinfo`; if a file
inside a sparse directory was specified, the index would not be expanded
until after the cache tree is invalidated, leading to a mismatch between the
index and cache tree. This scenario is handled by rearranging
`add_index_entry_with_check`, allowing `index_name_stage_pos` to expand the
index *before* attempting to invalidate the relevant cache tree path,
avoiding cache tree/index corruption.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c                   |  3 +++
 read-cache.c                             | 10 +++++++---
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..605cc693bbd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1077,6 +1077,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(r);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* we will diagnose later if it turns out that we need to update it */
 	newfd = hold_locked_index(&lock_file, 0);
 	if (newfd < 0)
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..b4600e954b6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1339,9 +1339,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
-	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
-		cache_tree_invalidate_path(istate, ce->name);
-
 	/*
 	 * If this entry's path sorts after the last entry in the index,
 	 * we can avoid searching for it.
@@ -1352,6 +1349,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	else
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
 
+	/*
+	 * Cache tree path should be invalidated only after index_name_stage_pos,
+	 * in case it expands a sparse index.
+	 */
+	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
+		cache_tree_invalidate_path(istate, ce->name);
+
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
 		if (!new_only)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 6804ab23a27..bc0741c970d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1216,6 +1216,18 @@ test_expect_success 'sparse index is not expanded: blame' '
 	done
 '
 
+test_expect_success 'sparse index is not expanded: update-index' '
+	init_repos &&
+
+	echo "test" >sparse-index/README.md &&
+	echo "test2" >sparse-index/a &&
+	rm -f sparse-index/deep/a &&
+
+	ensure_not_expanded update-index --add README.md &&
+	ensure_not_expanded update-index a &&
+	ensure_not_expanded update-index --remove deep/a
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

