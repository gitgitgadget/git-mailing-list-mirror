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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C6DC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2123160F6D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbhIPTBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbhIPTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E87C0F26D5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s24so5462908wmh.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DR2orDb8iCWWuWX4e9TB+rHVQaf0yw7nW1cSkvOBjlw=;
        b=UqeBOp9HsuJroAwFST4l3u3XC7ccLBm6g0mLeM8tZ7oKW2EYqjBG58DEHamgSSQ8iU
         vWM7WNOttkuFMOB91FDVDTWM1xFP97W2EsforItK8AhLXm8M5G6WF3pfqjRKv9XAeVel
         dHkYEeIw+/DOq4LWLZhwPp/tVy91TRLEGWQUxzyKB7dMZyMhJXr5KYf2bp/QJIXIP2X8
         K/VI2RI+SSzx+2QJuimFmAbl+/vHnJh0Q+gd46eK4fZrBZyWLBiNU7he5tQSH3WlGb5W
         0CzyNw5C/xdVETQZh1k828PRCvwqZFb6y4Hdc/KxEApihjPF+FXiJvkJwcK6wA1CYGOp
         OWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DR2orDb8iCWWuWX4e9TB+rHVQaf0yw7nW1cSkvOBjlw=;
        b=NMVvnd4FURlt6m5mOvCVGn+t52KZr6NjFVqMNNGDFagnMdwsyJ96Qep1kQeZa5K1DM
         PGTbJZfzgs7Y6uqUWQtxfAEVg45rLMZdaN5XKPTQB9XHLhoxVtcPTEJmzIGDaipJiYWz
         FQcfqLkilqJ+HXsxRn0IAPl/JzrOWaQoBpZA8G9eil9Knbr7rdmRQkGP1UdxZiGnEO6N
         SUT7pAfZh2oSlS2B7Ug+tRyqSle4ZCsX6YWkDYfPjhiV74at9RqJ7qjbeA1SZKuhUaR6
         JBpCHFjvCDh8N0GHiXNUzWFxZIst3ZtPQTtq7oy6OkIWMYAyBC6Ji/tsIEaJUTGduTvz
         Dejw==
X-Gm-Message-State: AOAM530zUc1EoGZFW5F4Z3c0UlZKIFM5SyExJr1aqTumAFes1Mm9sMYI
        z2EOB7SqnzNBWJB54pxaEbPBqGISI9tg5Q==
X-Google-Smtp-Source: ABdhPJyxmL0HwZQNACYM06l6jUMk2kZYyPaY3scqXJXv9vlaKeiQBpJaZKhSvR4plP5SJjQmOTLXeA==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr6618377wmi.136.1631817043964;
        Thu, 16 Sep 2021 11:30:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] repo-settings.c: simplify the setup
Date:   Thu, 16 Sep 2021 20:30:35 +0200
Message-Id: <patch-v2-4.5-b28ad2b2607-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
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
   handle it differently than the case of any other unknown value. So
   we can remove UNTRACKED_CACHE_KEEP. It's not handled any
   differently than UNTRACKED_CACHE_UNSET once we get past the config
   parsing step.

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
 fetch-negotiator.c |   2 -
 read-cache.c       |   2 +-
 repo-settings.c    | 102 +++++++++++++++++++++++++--------------------
 repository.h       |  15 +++----
 4 files changed, 63 insertions(+), 58 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index e7b5878be7c..273390229fe 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -19,8 +19,6 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_DEFAULT:
-	case FETCH_NEGOTIATION_UNSET:
-	case FETCH_NEGOTIATION_NONE:
 		default_negotiator_init(negotiator);
 		return;
 	}
diff --git a/read-cache.c b/read-cache.c
index 9dd84d69f00..9bbbbbacabe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1952,7 +1952,7 @@ static void tweak_untracked_cache(struct index_state *istate)
 		add_untracked_cache(istate);
 		break;
 	case UNTRACKED_CACHE_UNSET:
-	case UNTRACKED_CACHE_KEEP:
+		/* This includes core.untrackedCache=keep */
 		break;
 	}
 	return;
diff --git a/repo-settings.c b/repo-settings.c
index b0df8b93b86..6355bc67517 100644
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
+	r->settings.core_untracked_cache = UNTRACKED_CACHE_UNSET;
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
+		 * at UNTRACKED_CACHE_UNSET.
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
index 3740c93bc0f..c03fe8da8d0 100644
--- a/repository.h
+++ b/repository.h
@@ -13,18 +13,15 @@ struct submodule_cache;
 struct promisor_remote_config;
 
 enum untracked_cache_setting {
-	UNTRACKED_CACHE_UNSET = -1,
-	UNTRACKED_CACHE_REMOVE = 0,
-	UNTRACKED_CACHE_KEEP = 1,
-	UNTRACKED_CACHE_WRITE = 2
+	UNTRACKED_CACHE_UNSET,
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
2.33.0.1092.g44c994ea1be

