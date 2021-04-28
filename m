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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE189C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A90B61107
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhD1Q1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhD1Q1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 12:27:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C8EC061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:26:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so9158658wmi.5
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAd7JBm/RVTE/4lAhWmQJzEqQzOSAnMKlfTFCRqOkkg=;
        b=T4YjzQicf6VxA3HFiWuMr0uCj58TPzTpG02XuIOhzUHK650qrQCW7D4NVbP1AlkDYu
         FEL/asNupv4YHEJJYCC0VNjE2BXlg+qMMsipmJhZ4ukyyLKn750YowgOOV+r9+1niQWh
         8/gQWaab8A4Ws84w6TeF+jcKGbmO6gifiRgaVyM/KAORSh97isXecgT2Ww/qyDYGsh9U
         fzCDMxv/EsDIo2M/uOx1UTKuzcDK5t6GAxcPS+WXtHU9LBvDrWB+FdWdHxA/kIHkyHiK
         SLBmcTnEp7lOGg48ohOgJzkdxD5g+t695t0Q1I+PX2rpOvFr0wyM9tGkLb4vQO6S9F5k
         CZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAd7JBm/RVTE/4lAhWmQJzEqQzOSAnMKlfTFCRqOkkg=;
        b=KYaAK6BB70LKTDeWnOeZ067tAasSpD9/3EiYgGicMwbcQhalqC2jhhLkBkc1v8URpW
         OqaTpNl5GLRgwNrlhLt+U/iz6rnWnkml1/L2VG3GZtnShrrZirVCXtoy0SmMmoFvlaNX
         SspIeucG90tMjk7j8ch07OatiWlYNVK7xA9y6SQexHbZnPIgcRsGd78V3TSbrHygHgkg
         ifKPqbTx30pOWg+cR7UBlhjG7e2mZ75o6oEt3jtOFnlS6a0mIhv03CnjXEVTPoyfxLlE
         +Ni09cB1tJ2O6IIMvH4QDGqqSO+2lKjYXN6d60zUhfEQxhzR6pgtmj+LWCz9uZ7hv8LL
         aiXg==
X-Gm-Message-State: AOAM531ojdFxyUCoOYN4C0WWvqAmXH2Cle5iX8N8fX3FrtsISx5YkiAO
        oN9hVswCVeWdktWjq2UlB9HLD6nihgOgDg==
X-Google-Smtp-Source: ABdhPJxVKGlWYp0ZFLQ32xWUD3UQD6ehZmVaZsQ0QLc7iHsq0zUWLMkyTlBAst9vFon0NTyoXdTVfw==
X-Received: by 2002:a7b:c20e:: with SMTP id x14mr7754363wmi.57.1619627212294;
        Wed, 28 Apr 2021 09:26:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm307274wrx.88.2021.04.28.09.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:26:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] repo-settings.c: simplify the setup
Date:   Wed, 28 Apr 2021 18:26:43 +0200
Message-Id: <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.g8d26f61af32
In-Reply-To: <87k0omzv3h.fsf@evledraar.gmail.com>
References: <87k0omzv3h.fsf@evledraar.gmail.com>
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
2019-08-13) we have memset() the whole "settings" structure to -1, and
subsequently relied on the -1 value. As it turns out most things did
not need to be initialized to -1, and e.g. UNTRACKED_CACHE_UNSET and
FETCH_NEGOTIATION_UNSET existed purely to reflect the previous
internal state of the prepare_repo_settings() function.

Much of the "are we -1, then read xyz" can simply be removed by
re-arranging what we read first. E.g. we should read
feature.experimental first, set some values, and then e.g. an explicit
index.version setting should override that. We don't need to read
index.version first, and then check when reading feature.experimental
if it's still -1.

Instead of the global ignore_untracked_cache_config variable added in
dae6c322fa1 (test-dump-untracked-cache: don't modify the untracked
cache, 2016-01-27) we can make use of the new facility to set config
via environment variables added in d8d77153eaf (config: allow
specifying config entries via envvar pairs, 2021-01-12).

It's arguably a bit hacky to use setenv() and getenv() to pass
messages between the same program, but since the test helpers are not
the main intended audience of repo-settings.c I think it's better than
hardcoding the test-only special-case in prepare_repo_settings().

In ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
the "unset" and "keep" handling for core.untrackedCache was
consolidated. But it apparently wasn't noticed that while we
understand the "keep" value, we actually don't handle it differently
than the case of any other unknown value.

So we can remove UNTRACKED_CACHE_KEEP from the codebase. It's not
handled any differently than UNTRACKED_CACHE_UNSET once we get past
the config parsing step.

The UPDATE_DEFAULT_BOOL() wrapper added in 31b1de6a09b (commit-graph:
turn on commit-graph by default, 2019-08-13) is redundant to simply
using the return value from repo_config_get_bool(), which is non-zero
if the provided key exists in the config.

This also fixes an (admittedly obscure) logic error in the previous
code where we'd conflate an explicit "-1" value in the config with our
own earlier memset() -1.

Since the two enum fields added in aaf633c2ad1 (repo-settings: create
feature.experimental setting, 2019-08-13) and
ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
don't rely on the memzero() setting them to "-1" anymore we don't have
to provide them with explicit values. Let's also explicitly use the
enum type in read-cache.c and fetch-negotiator.c for
self-documentation. Since the FETCH_NEGOTIATION_UNSET is gone we can
remove the "default" case in fetch-negotiator.c, and rely on the
compiler to complain about missing enum values instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Apr 28 2021, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Apr 27 2021, Derrick Stolee wrote:
>
>> This is correct. I suppose it would be a good change to make some time.
>> Such a rename could be combined with the refactor above.
>>
>> I would recommend waiting until such a change isn't conflicting with
>> ongoing topics, such as this one.
>
> I'm not planning to work on it, but thought I'd ask/prod the original
> author if they were interested :)

Seems I'm pretty bad at sticking to my plans. Here's that refactoring,
since I mostly had this hacked-up locally anyway.

The conflict with the fsmonitor work can be resolved by adding:

	repo_config_get_bool_or(r, "core.usebuiltinfsmonitor",
				&r->settings.use_builtin_fsmonitor, 0);

To the "Boolean config or default, does not cascade (simple)" section
in my version. I.e. I assume nothing past 04/23 cares about the case
where it was set to "-1", which as noted in the commit message above
was (like many other setting variables) leaking an internal
implementation detail.

 cache.h                              |   7 --
 environment.c                        |   7 --
 fetch-negotiator.c                   |   6 +-
 read-cache.c                         |  17 ++--
 repo-settings.c                      | 119 +++++++++++++++------------
 repository.h                         |  15 ++--
 t/helper/test-dump-untracked-cache.c |   6 +-
 7 files changed, 92 insertions(+), 85 deletions(-)

diff --git a/cache.h b/cache.h
index 148d9ab5f18..7ea0feb3462 100644
--- a/cache.h
+++ b/cache.h
@@ -1684,13 +1684,6 @@ int update_server_info(int);
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
-/*
- * This is a hack for test programs like test-dump-untracked-cache to
- * ensure that they do not modify the untracked cache when reading it.
- * Do not use it otherwise!
- */
-extern int ignore_untracked_cache_config;
-
 int committer_ident_sufficiently_given(void);
 int author_ident_sufficiently_given(void);
 
diff --git a/environment.c b/environment.c
index 2f27008424a..bc825cc7e05 100644
--- a/environment.c
+++ b/environment.c
@@ -96,13 +96,6 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
-/*
- * This is a hack for test programs like test-dump-untracked-cache to
- * ensure that they do not modify the untracked cache when reading it.
- * Do not use it otherwise!
- */
-int ignore_untracked_cache_config;
-
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 57ed5784e14..c7c0eda7e21 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -8,8 +8,11 @@
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator)
 {
+	enum fetch_negotiation_setting setting;
 	prepare_repo_settings(r);
-	switch(r->settings.fetch_negotiation_algorithm) {
+	setting = r->settings.fetch_negotiation_algorithm;
+
+	switch (setting) {
 	case FETCH_NEGOTIATION_SKIPPING:
 		skipping_negotiator_init(negotiator);
 		return;
@@ -19,7 +22,6 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_DEFAULT:
-	default:
 		default_negotiator_init(negotiator);
 		return;
 	}
diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb5..1aefe4a5c23 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1889,16 +1889,23 @@ static void check_ce_order(struct index_state *istate)
 static void tweak_untracked_cache(struct index_state *istate)
 {
 	struct repository *r = the_repository;
+	enum untracked_cache_setting setting;
 
 	prepare_repo_settings(r);
+	setting = r->settings.core_untracked_cache;
 
-	if (r->settings.core_untracked_cache  == UNTRACKED_CACHE_REMOVE) {
+	switch (setting) {
+	case UNTRACKED_CACHE_REMOVE:
 		remove_untracked_cache(istate);
-		return;
-	}
-
-	if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
+		break;
+	case UNTRACKED_CACHE_WRITE:
 		add_untracked_cache(istate);
+		break;
+	case UNTRACKED_CACHE_UNSET:
+		/* This includes core.untrackedCache=keep */
+		break;
+	}
+	return;
 }
 
 static void tweak_split_index(struct index_state *istate)
diff --git a/repo-settings.c b/repo-settings.c
index f7fff0f5ab8..2be242fde1d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,40 +3,84 @@
 #include "repository.h"
 #include "midx.h"
 
-#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
+static void repo_config_get_bool_or(struct repository *r, const char *key,
+				    int *dest, int def)
+{
+	if (repo_config_get_bool(r, key, dest))
+		*dest = def;
+}
 
 void prepare_repo_settings(struct repository *r)
 {
-	int value;
+	int experimental;
+	int intval;
 	char *strval;
+	int manyfiles;
 
 	if (r->settings.initialized)
 		return;
 
 	/* Defaults */
-	memset(&r->settings, -1, sizeof(r->settings));
+	r->settings.index_version = -1;
+	r->settings.core_untracked_cache = UNTRACKED_CACHE_UNSET;
+	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+
+	/* Booleans config or default, cascades to other settings */
+	repo_config_get_bool_or(r, "feature.manyfiles", &manyfiles, 0);
+	repo_config_get_bool_or(r, "feature.experimental", &experimental, 0);
+
+	/* Defaults modified by feature.* */
+	if (experimental) {
+		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+	}
+	if (manyfiles) {
+		r->settings.index_version = 4;
+		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+	}
 
-	if (!repo_config_get_bool(r, "core.commitgraph", &value))
-		r->settings.core_commit_graph = value;
-	if (!repo_config_get_bool(r, "commitgraph.readchangedpaths", &value))
-		r->settings.commit_graph_read_changed_paths = value;
-	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
-		r->settings.gc_write_commit_graph = value;
-	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
-	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
-	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
+	/* Boolean config or default, does not cascade (simple)  */
+	repo_config_get_bool_or(r, "core.commitgraph",
+				&r->settings.core_commit_graph, 1);
+	repo_config_get_bool_or(r, "commitgraph.readchangedpaths",
+				&r->settings.commit_graph_read_changed_paths, 1);
+	repo_config_get_bool_or(r, "gc.writecommitgraph",
+				&r->settings.gc_write_commit_graph, 1);
+	repo_config_get_bool_or(r, "fetch.writecommitgraph",
+				&r->settings.fetch_write_commit_graph, 0);
+	repo_config_get_bool_or(r, "pack.usesparse",
+				&r->settings.pack_use_sparse, 1);
+	repo_config_get_bool_or(r, "core.multipackindex",
+				&r->settings.core_multi_pack_index, 1);
 
-	if (!repo_config_get_int(r, "index.version", &value))
-		r->settings.index_version = value;
-	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
-		if (value == 0)
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
-		else
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
-	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
-		if (!strcasecmp(strval, "keep"))
-			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+	/*
+	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
+	 * either it *or* the config sets
+	 * r->settings.core_multi_pack_index if true. We don't take
+	 * the environment variable if it exists (even if false) over
+	 * any config, as in other cases.
+	 */
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		r->settings.core_multi_pack_index = 1;
 
+	/*
+	 * Non-boolean config
+	 */
+	if (!repo_config_get_int(r, "index.version", &intval))
+		r->settings.index_version = intval;
+
+	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
+		int maybe_bool = git_parse_maybe_bool(strval);
+		if (maybe_bool == -1) {
+			/*
+			 * Set to "keep", or some other non-boolean
+			 * value. In either case we do nothing but
+			 * keep UNTRACKED_CACHE_UNSET.
+			 */
+		} else {
+			r->settings.core_untracked_cache = maybe_bool
+				? UNTRACKED_CACHE_WRITE
+				: UNTRACKED_CACHE_REMOVE;
+		}
 		free(strval);
 	}
 
@@ -45,36 +89,5 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
-		else
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
-
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
-	/* Hack for test programs like test-dump-untracked-cache */
-	if (ignore_untracked_cache_config)
-		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-	else
-		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
-
-	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
 }
diff --git a/repository.h b/repository.h
index b385ca3c94b..9345423c5ba 100644
--- a/repository.h
+++ b/repository.h
@@ -12,18 +12,15 @@ struct raw_object_store;
 struct submodule_cache;
 
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
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index cf0f2c7228e..8b73a2f8bc3 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -45,8 +45,10 @@ int cmd__dump_untracked_cache(int ac, const char **av)
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
 
-	/* Hack to avoid modifying the untracked cache when we read it */
-	ignore_untracked_cache_config = 1;
+	/* Set core.untrackedCache=keep before setup_git_directory() */
+	setenv("GIT_CONFIG_COUNT", "1", 1);
+	setenv("GIT_CONFIG_KEY_0", "core.untrackedCache", 1);
+	setenv("GIT_CONFIG_VALUE_0", "keep", 1);
 
 	setup_git_directory();
 	if (read_cache() < 0)
-- 
2.31.1.734.g8d26f61af32

