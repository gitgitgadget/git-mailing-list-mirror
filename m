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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171EC433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD561205
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhISIsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbhISIsw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B261C06175F
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w17so14779746wrv.10
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xaMRck/fVTgjoYKcOJXmBfZ48IvAEWbU9E+uPrk5qS0=;
        b=YefICJlPg83eoOA2z9RNRwd3zK/WbKrSU2CDB01rbfGV1PGNaOiGE1hg4AmEDz7kVZ
         fBTNwZw8Ym36zXNO1ugewaEPhA+6nQptiugDH+9MR2hzBULegGH9GvTO3CmgQVxsCqCd
         VQGBZZkw3Nev0sjSCmzfN5KRAwhecjtlZIADjQpPoMk/NjSTK9MRT/4we0XrWjvUVZgr
         cXh2EEvLpGr4zd/85w+NAcLT/GnTb+lH14AVSQJg0J+5Y3RpuLpEiOuEcoJ/ucFteXaG
         DlJM/cTdXKpAvyqswGT0y+PeYpzMVHR8JaovedKcDsf8yMExdDLTvbDogzs3QOgrwFVy
         bRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaMRck/fVTgjoYKcOJXmBfZ48IvAEWbU9E+uPrk5qS0=;
        b=bQE+rtf//p7/xCI5Jpqm8/4iPimGbtjaVtgeDGNkkt5s8MgIIrFX8Xku7v77kJHB5P
         zcglmCt6hs1wicrIKTWeQ0rWG92NZJVX/DJOdXPpa+cFfvNxTCl7+ZbsibE/zegKB3NT
         wiW4iJgbh+AP80pu4005DTYLE+YAWU7kpbaQFDenfjAj5W2/zUqea6WJcjXcgdL/fSmY
         YdoFuzSoPSe4IvOt5puERSivaU5/Kcwm4XZLdBUUh/D01OH8dpMks4skJh+YLejYxPAH
         9cHJi6HNnJEfZQKBC2m1ogAyljjGgb7Gk4l0u3eKHId1SbnG91IVOmQ2p2Q3fMYs0M1i
         PfVQ==
X-Gm-Message-State: AOAM533x4gdJQA1bWivARLSCxvOI70SAv0BMIPtKbYUJ686e2TxXTWto
        v/GhTlso3NralGLu3S1pWs7Et8t9a6/waQ==
X-Google-Smtp-Source: ABdhPJw3mzwtnT0TyhaAeLed8HA2ytVopeQ2eCW4pTh2uwiL3Mx+x382/7zrHldoOoPQx0YcqRX8cA==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr15463512wri.96.1632041245803;
        Sun, 19 Sep 2021 01:47:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] repository.h: don't use a mix of int and bitfields
Date:   Sun, 19 Sep 2021 10:47:19 +0200
Message-Id: <patch-v3-5.5-3cc033b8864-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
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
index 46b9d56aeac..b93e91a212e 100644
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
index bf36744e0a7..02599ae2c98 100644
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

