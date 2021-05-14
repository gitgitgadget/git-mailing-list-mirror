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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B28C43461
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECB661440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhENScc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhENSc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756BC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso1884090wmo.0
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tnv8/RvaEXbX/IGlvdgT6jdK85+oA3TpgnT3UjIuqEE=;
        b=IrfaZiskLcw2xXbrucGPffQmiT7+NOfN+27cCzby6mzT+B9qRumuwNkFQyCehBV8TB
         kxPkWG0FMoeRe6VfbISJPZWl9iHNTQ/qyKa9th+FAfcSRPk2uR0C7z4pxPuiCitxVgCe
         kRvPv68XeNYcT2LxiqUTViveMrTNp7UhDYFvJcoqLnmX3YD6ztckaoTThLdkDNue/rTB
         BwITaBpcYAnKA53LVWgy4l8s0U5CnNTfbDbsBKhHwhc1pS1RC6J7GZ/zLAkqalJcw7cH
         rrmfsAWkjVpkE93xoEhx6p+00AUWxdsUfy0/23yF9FVcAxEKCEvubZgdmmxNEItTuGud
         ljEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tnv8/RvaEXbX/IGlvdgT6jdK85+oA3TpgnT3UjIuqEE=;
        b=JeqheM1qHyaeQBKkmjglQizn2hfvakfV/r3+cwIjawl3BHHRe6LwVMJObXYQ6t/j6U
         Wxc2CU2fI9+PoWjczoVDb98yPWbFt9HhhYuE1jCX//IDyTmPq4z10YGi8G4tW8JJFG8M
         OZeaiOacHUIlEjRr9a1Ef1+UanzOSQCJ55AKtyciujbd2kV5wk3iSBQftTHn5+KG9mRJ
         cnB05Mln9uT6tQr/pwXL7zbmsGUis6Ns6mSdkBUKmJQZSidxfusssgt8LNiYBxZBw8sH
         ri4lbMyXwB8tZhHlAiNFav+oMLh126rVOxz0flf81/5eVxukOpE3Ot/CLp3zOL1KratS
         BIDw==
X-Gm-Message-State: AOAM5339FEopMKEWFMVmPQexP78Hg1XZiFkNDOZsr+mltGXOav11eQMw
        mBUiZZN2BZRm3dese/kUoBhAxnielv0=
X-Google-Smtp-Source: ABdhPJw7Rd+3uEW93+sgzqzfpK9O9M1Y66Ra+Vrg2h6f5OJ+izuH0YbKN/M1pn8Yq7crwZhBElk6fw==
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr10815043wmh.3.1621017074788;
        Fri, 14 May 2021 11:31:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm5790339wmq.19.2021.05.14.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:14 -0700 (PDT)
Message-Id: <5a2ed3d1d701b11c241bf3855db3bb35f5e93994.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:00 +0000
Subject: [PATCH v3 01/12] sparse-index: skip indexes with unmerged entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-index format is designed to be compatible with merge
conflicts, even those outside the sparse-checkout definition. The reason
is that when converting a full index to a sparse one, a cache entry with
nonzero stage will not be collapsed into a sparse directory entry.

However, this behavior was not tested, and a different behavior within
convert_to_sparse() fails in this scenario. Specifically,
cache_tree_update() will fail when unmerged entries exist.
convert_to_sparse_rec() uses the cache-tree data to recursively walk the
tree structure, but also to compute the OIDs used in the
sparse-directory entries.

Add an index scan to convert_to_sparse() that will detect if these merge
conflict entries exist and skip the conversion before trying to update
the cache-tree. This is marked as NEEDSWORK because this can be removed
with a suitable update to cache_tree_update() or a similar method that
can construct a cache-tree with invalid nodes, but still allow creating
the nodes necessary for creating sparse directory entries.

It is possible that in the future we will not need to make such an
update, since if we do not expand a sparse-index into a full one, this
conversion does not need to happen. Thus, this can be deferred until the
merge machinery is made to integrate with the sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c                           | 18 ++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 6f21397e2ee0..1b49898d0cb7 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -125,6 +125,17 @@ int set_sparse_index_config(struct repository *repo, int enable)
 	return res;
 }
 
+static int index_has_unmerged_entries(struct index_state *istate)
+{
+	int i;
+	for (i = 0; i < istate->cache_nr; i++) {
+		if (ce_stage(istate->cache[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
@@ -161,6 +172,13 @@ int convert_to_sparse(struct index_state *istate)
 		return -1;
 	}
 
+	/*
+	 * NEEDSWORK: If we have unmerged entries, then stay full.
+	 * Unmerged entries prevent the cache-tree extension from working.
+	 */
+	if (index_has_unmerged_entries(istate))
+		return 0;
+
 	if (cache_tree_update(istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 12e6c453024f..4f2f09b53a32 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -352,6 +352,28 @@ test_expect_success 'merge with outside renames' '
 	done
 '
 
+# Sparse-index fails to convert the index in the
+# final 'git cherry-pick' command.
+test_expect_success 'cherry-pick with conflicts' '
+	init_repos &&
+
+	write_script edit-conflict <<-\EOF &&
+	echo $1 >conflict
+	EOF
+
+	test_all_match git checkout -b to-cherry-pick &&
+	run_on_all ../edit-conflict ABC &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict to pick" &&
+
+	test_all_match git checkout -B base HEAD~1 &&
+	run_on_all ../edit-conflict DEF &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict in base" &&
+
+	test_all_match test_must_fail git cherry-pick to-cherry-pick
+'
+
 test_expect_success 'clean' '
 	init_repos &&
 
-- 
gitgitgadget

