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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F3C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0583B611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhIUNOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhIUNOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:14:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D8BC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d21so38990781wra.12
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqWdCHbicix/Lj0PqM9Yd4vMeUYr9EcPJYw+LtreHM=;
        b=BFJLJa9rLbjXDBQrf4vft1RYwEUulfIVz86GTLdj0O1MOXUtCdvXyguUZkpR0pPNkG
         tSTflsKY5vW8saD3ge89YN0eoSfEDCYdnT00HPCg2kyazI63tYb2q2EiYHRkNLIb9WXp
         rlN5pPPN2pkm3zbZD49YXCUn78KGyRIQ5Wpam1j+nd74sL2ZVCeT4Uhrmhdfi2FuyfLH
         d1Z+k1EeKr9igFac5VIB7vGhIdbYDjpxRPX3UKH0WW3VA9QHBu+lWgWjwG48m4RZEKgo
         yXGY5+kmHTTnDC45DEiwX7hvg3CI4IEhAoLeXlf+lKHrkMpEWh7nn/ljw1NRYt7g3GEp
         O3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqWdCHbicix/Lj0PqM9Yd4vMeUYr9EcPJYw+LtreHM=;
        b=f52kcvxMhqp71nUH5wWcs8Hd8/B+kTeikwSrasr2jySLG1IWx0uKx8JKHLYjOH/mM3
         yj+HONk7CBxUOm2Nadm7zthNsb4k+rktFpDzLJ3l9hG7xjWsDsfU1Pc8kEOvq6L46cdW
         32LyLJY/2hu1gmb3/iFSC7xx7O9R5x9B1yXf+Ubrahj7Gu4LxdjkuBZCKxFQGEPZr9v2
         h7iIrJclghR+GKafygRk4XjO9yeAPIB9H7lfEkaqgl9FQu3hKEwvJ56N1vBU4e4Wfp4z
         GKMJyhVTEUlqFdigyIZYRb3bP1NPUv0gPEDZiPXUIbxcdfrsAoQl5+KpwC6huGQmXA23
         lZ5g==
X-Gm-Message-State: AOAM533k/vkC67dkkK6WjHk14gXgtWJihIs5g1LIR5Ae+U5Ki9+SvvQ2
        zxkFZMo6TcNnUWwZwHIcOlkXopbsERGwVA==
X-Google-Smtp-Source: ABdhPJyGZbGqCPbrICAvMjQhpuDC6yS/ZPr+YMSMW+NBu4Tg0hErT4yHU8p9swfzhuPfqPb5442Ytg==
X-Received: by 2002:adf:f80e:: with SMTP id s14mr35055429wrp.435.1632229993026;
        Tue, 21 Sep 2021 06:13:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm2733260wml.44.2021.09.21.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:13:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/5] repo-settings.c: simplify the setup
Date:   Tue, 21 Sep 2021 15:13:02 +0200
Message-Id: <patch-v4-4.5-c9f143b26f1-20210921T131003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the setup code in repo-settings.c in various ways, making the
code shorter, easier to read, and requiring fewer hacks to do the same
thing as it did before:

Since 7211b9e7534 (repo-settings: consolidate some config settings,
2019-08-13) we have memset() the whole "settings" structure to -1 in
prepare_repo_settings(), and subsequently relied on the -1 value.

Most of the fields did not need to be initialized to -1, and because
we were doing that we had the enum labels "UNTRACKED_CACHE_UNSET" and
"FETCH_NEGOTIATION_UNSET" purely to reflect the resulting state
created this memset() in prepare_repo_settings(). No other code used
or relied on them, more on that below.

For the rest most of the subsequent "are we -1, then read xyz" can
simply be removed by re-arranging what we read first. E.g. when
setting the "index.version" setting we should have first read
"feature.experimental", so that it (and "feature.manyfiles") can
provide a default for our "index.version".

Instead the code setting it, added when "feature.manyFiles"[1] was
created, was using the UPDATE_DEFAULT_BOOL() macro added in an earlier
commit[2]. That macro is now gone, since it was only needed for this
pattern of reading things in the wrong order.

This also fixes an (admittedly obscure) logic error where we'd
conflate an explicit "-1" value in the config with our own earlier
memset() -1.

We can also remove the UPDATE_DEFAULT_BOOL() wrapper added in
[3]. Using it is redundant to simply using the return value from
repo_config_get_bool(), which is non-zero if the provided key exists
in the config.

Details on edge cases relating to the memset() to -1, continued from
"more on that below" above:

 * UNTRACKED_CACHE_KEEP:

   In [4] the "unset" and "keep" handling for core.untrackedCache was
   consolidated. But it while we understand the "keep" value, we don't
   handle it differently than the case of any other unknown value.

   So let's retain UNTRACKED_CACHE_KEEP and remove the
   UNTRACKED_CACHE_UNSET setting (which was always implicitly
   UNTRACKED_CACHE_KEEP before). We don't need to inform any code
   after prepare_repo_settings() that the setting was "unset", as far
   as anyone else is concerned it's core.untrackedCache=keep. if
   "core.untrackedcache" isn't present in the config.

 * FETCH_NEGOTIATION_UNSET & FETCH_NEGOTIATION_NONE:

   Since these two two enum fields added in [5] don't rely on the
   memzero() setting them to "-1" anymore we don't have to provide
   them with explicit values.

1. c6cc4c5afd2 (repo-settings: create feature.manyFiles setting,
   2019-08-13)
2. 31b1de6a09b (commit-graph: turn on commit-graph by default,
   2019-08-13)
3. 31b1de6a09b (commit-graph: turn on commit-graph by default,
   2019-08-13)
4. ad0fb659993 (repo-settings: parse core.untrackedCache,
   2019-08-13)
5. aaf633c2ad1 (repo-settings: create feature.experimental setting,
   2019-08-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-negotiator.c |   3 --
 read-cache.c       |   8 +++-
 repo-settings.c    | 102 +++++++++++++++++++++++++--------------------
 repository.h       |  15 +++----
 4 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index e61e40cb299..273390229fe 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -21,8 +21,5 @@ void fetch_negotiator_init(struct repository *r,
 	case FETCH_NEGOTIATION_DEFAULT:
 		default_negotiator_init(negotiator);
 		return;
-	case FETCH_NEGOTIATION_NONE:
-	case FETCH_NEGOTIATION_UNSET:
-		BUG("FETCH_NEGOTIATION_{NONE,UNSET} used outside of prepare_repo_settings()!");
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index e4ae35ccdb2..b0a06db5c55 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1952,9 +1952,13 @@ static void tweak_untracked_cache(struct index_state *istate)
 		add_untracked_cache(istate);
 		break;
 	case UNTRACKED_CACHE_KEEP:
+		/*
+		 * Either an explicit "core.untrackedCache=keep", the
+		 * default if "core.untrackedCache" isn't configured,
+		 * or a fallback on an unknown "core.untrackedCache"
+		 * value.
+		 */
 		break;
-	case UNTRACKED_CACHE_UNSET:
-		BUG("UNTRACKED_CACHE_UNSET used outside of prepare_repo_settings()!");
 	}
 }
 
diff --git a/repo-settings.c b/repo-settings.c
index b0df8b93b86..46b9d56aeac 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,40 +3,76 @@
 #include "repository.h"
 #include "midx.h"
 
-#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
+static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
+			  int def)
+{
+	if (repo_config_get_bool(r, key, dest))
+		*dest = def;
+}
 
 void prepare_repo_settings(struct repository *r)
 {
+	int experimental;
 	int value;
 	char *strval;
+	int manyfiles;
 
-	if (r->settings.initialized)
+	if (r->settings.initialized++)
 		return;
 
 	/* Defaults */
-	memset(&r->settings, -1, sizeof(r->settings));
+	r->settings.index_version = -1;
+	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+
+	/* Booleans config or default, cascades to other settings */
+	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
+	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
 
-	if (!repo_config_get_bool(r, "core.commitgraph", &value))
-		r->settings.core_commit_graph = value;
-	if (!repo_config_get_bool(r, "commitgraph.readchangedpaths", &value))
-		r->settings.commit_graph_read_changed_paths = value;
-	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
-		r->settings.gc_write_commit_graph = value;
-	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
-	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
-	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
+	/* Defaults modified by feature.* */
+	if (experimental) {
+		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+	}
+	if (manyfiles) {
+		r->settings.index_version = 4;
+		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+	}
+
+	/* Boolean config or default, does not cascade (simple)  */
+	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
+	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
+	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
+
+	/*
+	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
+	 * either it *or* the config sets
+	 * r->settings.core_multi_pack_index if true. We don't take
+	 * the environment variable if it exists (even if false) over
+	 * any config, as in most other cases.
+	 */
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		r->settings.core_multi_pack_index = 1;
 
+	/*
+	 * Non-boolean config
+	 */
 	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version = value;
-	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
-		if (value == 0)
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
-		else
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
-	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
-		if (!strcasecmp(strval, "keep"))
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
 
+	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
+		int v = git_parse_maybe_bool(strval);
+
+		/*
+		 * If it's set to "keep", or some other non-boolean
+		 * value then "v < 0". Then we do nothing and keep it
+		 * at the default of UNTRACKED_CACHE_KEEP.
+		 */
+		if (v >= 0)
+			r->settings.core_untracked_cache = v ?
+				UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
 		free(strval);
 	}
 
@@ -45,34 +81,8 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
-		else
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
 
-	if (!repo_config_get_bool(r, "pack.usesparse", &value))
-		r->settings.pack_use_sparse = value;
-	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
-
-	value = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0);
-	if (value || !repo_config_get_bool(r, "core.multipackindex", &value))
-		r->settings.core_multi_pack_index = value;
-	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
-
-	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
-		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
-		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
-	}
-
-	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
-		r->settings.fetch_write_commit_graph = value;
-	UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 0);
-
-	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
-		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
-
-	UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
-	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
-
 	/*
 	 * This setting guards all index reads to require a full index
 	 * over a sparse index. After suitable guards are placed in the
diff --git a/repository.h b/repository.h
index 3740c93bc0f..bf36744e0a7 100644
--- a/repository.h
+++ b/repository.h
@@ -13,18 +13,15 @@ struct submodule_cache;
 struct promisor_remote_config;
 
 enum untracked_cache_setting {
-	UNTRACKED_CACHE_UNSET = -1,
-	UNTRACKED_CACHE_REMOVE = 0,
-	UNTRACKED_CACHE_KEEP = 1,
-	UNTRACKED_CACHE_WRITE = 2
+	UNTRACKED_CACHE_KEEP,
+	UNTRACKED_CACHE_REMOVE,
+	UNTRACKED_CACHE_WRITE,
 };
 
 enum fetch_negotiation_setting {
-	FETCH_NEGOTIATION_UNSET = -1,
-	FETCH_NEGOTIATION_NONE = 0,
-	FETCH_NEGOTIATION_DEFAULT = 1,
-	FETCH_NEGOTIATION_SKIPPING = 2,
-	FETCH_NEGOTIATION_NOOP = 3,
+	FETCH_NEGOTIATION_DEFAULT,
+	FETCH_NEGOTIATION_SKIPPING,
+	FETCH_NEGOTIATION_NOOP,
 };
 
 struct repo_settings {
-- 
2.33.0.1098.gf02a64c1a2d

