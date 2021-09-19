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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FCC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CC761268
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhISIs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhISIsw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84325C061764
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so22937791wrr.9
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWfDZ+rtrnG21Skj48lW5WkTkD3Y1oEspdbO9ufkms0=;
        b=jGLyXhkyT5bnkcY1PxRHyqmSUT408/9Cb83h3pZDIBgpr8JQ+CYQ9l8D7Mn3sR/CUT
         tBIViyWWRXatWN+IZZORhNPfhqPxwTCSsCQRm8bPwhoFEy7vhl0AkQBn3QpOMle9H1AA
         Jp7oorVkT+/2q/za0b22cta6M9m8wZL1Ajxk3D2g4ie3wHNHYkPxactMEgyL37Jv9iE5
         Keh4/5cGAZgXX0Gk0JmqNyaBVLkgQcSK5xCIjb2jSCyIS8iy/tr2atdp6A6zBRk+1Ga8
         BAQM1ZWdEXlvk9KIpjq+Be1ALekuMmum/mGpdlJYGchW+o/6/gfaGvso8C7szXuqmt69
         ppKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWfDZ+rtrnG21Skj48lW5WkTkD3Y1oEspdbO9ufkms0=;
        b=uwiihva7N0GJ4XrLNpRjf/86QqUf1lFlFG8DqGZZKCkhpPiE56q6Rt8ztgC04C701/
         016WOZSXFbqPqDXd/8bih1PmxHACma2v8cdrR/PO1rik0gaKAFuDVtnjF9FHL7RqDKlc
         scQ3eJsr3RDLDvivzlO7lrN+q8lqlWZOgzDSj6a2QdtxZblwZNOH9e979l2jhKjfF9LV
         Au96pKleqv7/34iwrNgvmD3AE/VubjICdTlfCcGvvthYQ85OpoLypz/R4M1IZhxo5pn8
         d3onh9B7IwiAoELrf4fLZjDK71blvCVlbUIL9a25jG1h9KwDNoS78yNBmQcS2QsQnyDl
         vnCg==
X-Gm-Message-State: AOAM531ShdrgERHR6/Uq1uJeNwm1rR2bDKIW0I0MOVRAFl7p1aj9WCJ+
        UXHdwpZo97pZJgupdLgQnFOQkglLgZvQng==
X-Google-Smtp-Source: ABdhPJw9XJr6SDBWC40ZxAS4yS+VSfWyuGGzYAxDc5E78fuRbPmdrEfa18Rv+/EwdAm5Zp4XDvgmDw==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr22229024wrd.24.1632041244869;
        Sun, 19 Sep 2021 01:47:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] repo-settings.c: simplify the setup
Date:   Sun, 19 Sep 2021 10:47:18 +0200
Message-Id: <patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
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
index 237f92b8696..273390229fe 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -21,8 +21,5 @@ void fetch_negotiator_init(struct repository *r,
 	case FETCH_NEGOTIATION_DEFAULT:
 		default_negotiator_init(negotiator);
 		return;
-	case FETCH_NEGOTIATION_NONE:
-	case FETCH_NEGOTIATION_UNSET:
-		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index 6918dc3d8b2..147660c3090 100644
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
-		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
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
2.33.0.1092.g44c994ea1be

