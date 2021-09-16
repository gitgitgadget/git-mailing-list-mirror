Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25696C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E3360F6D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbhIPTBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345149AbhIPTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EDCC0A236B
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so3990993wri.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAg3oasL5ER8YHk9ng4wvtJ8heTj3J7irQ9C3VPhR/g=;
        b=a95I6cGgyJnqT7DjAVVXQz/tMpKAoMPuxNGb8kPA/pVctrGZ++OvLNyQDY+gGhgF2J
         5LiTHup2bBb2W9y81nsyEPVihKiu0XjCq3S3qFF31qQy6wNKgGQOgINIOzzRLgvrk5h1
         Gcree6IFCl2JTPi1tbjV5Fk//By1KxrcIBLL53SrmdTI/wSYgylxIruMFgBChHgcVqAS
         QIYnS48orL6XOpP1IfRYi5qRlX8jCK5ypFvRgFb89p7sycXJC2BwPavrJKPgGs1CqZ33
         mY6n6TvX3DQ/GqWZFZtHrLSdaQEIJVbcFW5b1gpgnGHmfBR6Oeakst90dPKnJJiUMCsS
         E7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAg3oasL5ER8YHk9ng4wvtJ8heTj3J7irQ9C3VPhR/g=;
        b=pwzVzL/Y4n+EDtFoPsRF+qrZQfecch9tbx8Y/LQm42cqVHFqGyRyv79uvW78jhQHB1
         MotQXzRvJsurOJtQZlGsGjJtNoLZlF/DrJ/NlF3O6viPqIv8zBqQG9FsiGeyG0ObAG7g
         pDLCkCR7RBXdlOfjuImqHGzj9q9Bp+Ap+p5kxsf2hxP328QQMwHMgDvS0oX0GmwqJjjp
         QQxIYodmQQ5AAusyVBHv5LVg4fTtxsnLPN/E/skAtXDqTWxFhlS+pDwGvmopUWSMV9IN
         sCydxrc2QPcZEQShnsGV7U2Fp+KSdCZICOt9Ep/dti6Ljpx04RwmxtDK1BShqce/auES
         6tzg==
X-Gm-Message-State: AOAM5308E4KujKw4UEl0Ys6NFmyWOqn5Sm7348dZ9CiGntDeW4nfpP2H
        oqhPcf393IMj//6xOsRts7/RtqIym9MRvA==
X-Google-Smtp-Source: ABdhPJxQFwxiBbJZiWl/kNeWs65Lqgse8cyn0lmlUxAEJw5oUOEplVcW3yKegaJoywtzFf611qcRmw==
X-Received: by 2002:adf:df0d:: with SMTP id y13mr7658956wrl.335.1631817044759;
        Thu, 16 Sep 2021 11:30:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] repository.h: don't use a mix of int and bitfields
Date:   Thu, 16 Sep 2021 20:30:36 +0200
Message-Id: <patch-v2-5.5-0b5f213a639-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the bitfield added in 58300f47432 (sparse-index: add
index.sparse config option, 2021-03-30) and 3964fc2aae7 (sparse-index:
add guard to ensure full index, 2021-03-30) to just use an "int"
boolean instead.

It might be smart to optimize the space here in the future, but by
consistently using an "int" we can take its address and pass it to
repo_cfg_bool(), and therefore don't need to handle "sparse_index" as
a special-case when reading the "index.sparse" setting.

There's no corresponding config for "command_requires_full_index", but
let's change it too for consistency and to prevent future bugs
creeping in due to one of these being "unsigned".

Using "int" consistently also prevents subtle bugs or undesired
control flow creeping in here. Before the preceding commit the
initialization of "command_requires_full_index" in
prepare_repo_settings() did nothing, i.e. this:

    r->settings.command_requires_full_index = 1

Was redundant to the earlier memset() to -1. Likewise for
"sparse_index" added in 58300f47432 (sparse-index: add index.sparse
config option, 2021-03-30) the code and comment added there was
misleading, we weren't initializing it to off, but re-initializing it
from "1" to "0", and then finally checking the config, and perhaps
setting it to "1" again. I.e. we could have applied this patch before
the preceding commit:

	+	assert(r->settings.command_requires_full_index == 1);
	 	r->settings.command_requires_full_index = 1;

	 	/*
	 	 * Initialize this as off.
	 	 */
	+	assert(r->settings.sparse_index == 1);
	 	r->settings.sparse_index = 0;
	 	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
	 		r->settings.sparse_index = 1;

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 repo-settings.c | 8 +-------
 repository.h    | 5 ++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 6355bc67517..5f5bdddb1b2 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -45,6 +45,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
+	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
@@ -90,11 +91,4 @@ void prepare_repo_settings(struct repository *r)
 	 * removed.
 	 */
 	r->settings.command_requires_full_index = 1;
-
-	/*
-	 * Initialize this as off.
-	 */
-	r->settings.sparse_index = 0;
-	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
-		r->settings.sparse_index = 1;
 }
diff --git a/repository.h b/repository.h
index c03fe8da8d0..5f8a48b8a5c 100644
--- a/repository.h
+++ b/repository.h
@@ -31,6 +31,8 @@ struct repo_settings {
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
+	int command_requires_full_index;
+	int sparse_index;
 
 	int index_version;
 	enum untracked_cache_setting core_untracked_cache;
@@ -39,9 +41,6 @@ struct repo_settings {
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-
-	unsigned command_requires_full_index:1,
-		 sparse_index:1;
 };
 
 struct repository {
-- 
2.33.0.1092.g44c994ea1be

