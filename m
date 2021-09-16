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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ACB611EE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbhIPTBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbhIPTBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28EC0A2368
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 70so2552331wme.5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIso6C26T928nZ2IAaMC0unS6mH49rTeKabsSph9BiM=;
        b=nQNJqvxWzl3nhK9rUQdDey01+4PP24kk5uHGVfEMZBQeGSJx0RIs/g0KRZ6ZTvPHuM
         ht7Xv7rt+HUucZOVenudj2+842YpCbAJzBikQ2Hy/Y8HJ/rtIPJwbygjfwbpqIDw89N3
         j7RcT6fQBvVL6Uz1sOY/ZU8EGnhDjqzw5Pc3SKG2JHvK51E3QBU4DaMxo4evYGD7FZkF
         QqVGU0/WRjcnoj+ZpsyqRO0dsq8kibayvaB0u5+ukaSveLZOgimnd5yP4xYHr9GD+av7
         WziNFTOytQCtQ7MIO/S6YgZjmOMn/L1Culf0GpKQqjcPt5ne0l0D/hW/NIMou6ymdW2h
         7vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIso6C26T928nZ2IAaMC0unS6mH49rTeKabsSph9BiM=;
        b=jZ08OohxgPL9f0l0S70Xt+0K7rwFIkwObel0e3EzEadZri2zoHoLLnWfUOswqsuzRn
         WAoe6emhRBKISYLRASmD/PgZSbQoV64kcM+h+Mvr9M960YXZvnwcL+GWkR3pML/M1BYs
         BIf4dhykQMG0A50zfyPl4/9QFJ5tQAix0xF6o/lotl1zfiHwRvgCSWOoS/WKfi0I5hYv
         6GJ/mKy+Ud9Ja0BkrotpoUbrrkYyNgut/ClnjhQY3E3rhUNj3Z65kjdNpdgTLNem9wnV
         6oxnVwYSfEg8ed6y60Z3uSMV7f9UEnxyZ9p9X6Q2CVUX5w64c7RE+fpVBPDXOZhHrRo7
         2uxw==
X-Gm-Message-State: AOAM530XuzSGNQB/wbgajhDeLbok1Tc2O6AC0vP7VFsbSPC1xawjsyS0
        efxpm3/qDHwxFD5uFI6pe8PLF14ZoQBjhw==
X-Google-Smtp-Source: ABdhPJxcJ1fVNyviCyyKMNHjf2wYML95tXDyM0HQf+R4VN7FcFCm9B3uuz0A3m1vbFBAN8kpLM1S2A==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr6500409wmc.150.1631817040521;
        Thu, 16 Sep 2021 11:30:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] repo-settings.c: refactor for clarity, get rid of hacks etc.
Date:   Thu, 16 Sep 2021 20:30:31 +0200
Message-Id: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every time I look at repo-settings.c during a review I get distracted
just trying to figure out how the proposed change interacts with it.

We've got a global extern variable there, a memset() to -1 of "struct
repo_settings" (including of an unsigned one-bit, so we'll set it to
1, not -1), setting defaults, then reading config, then deciding which
we'd prefer instead of setting a default, and then reading config
etc. Then we read some boolean variables and conflate "does the config
exist" with "is the setting 'false''?

This series cleans up the control flow in in repo-settings.c, this is
a net code deletion when accounting for commetns I added. Much of the
code didn't need to exist, e.g. the global variable is replaced by
Patrick's recent "config via env" feature.

I originally submitted this as one patch back in April[1], but since
it conflicted with the in-flight fsmonitor topic I held it back.

Now that the new fsmonitor topic is being submitted piecemeal there's
no in-flight conflict with anything else changing repo-settings.c,
which is why I wanted to submit this now, despite saying I'd try to
hold off on new such topics in general[2]. I'd like the code not to
lure authors into some of the confusing patterns noted here, and in
earlier patch review[3].

1. https://lore.kernel.org/git/patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com/#t
2. https://lore.kernel.org/git/87mtog4pai.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/87k0omzv3h.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (5):
  wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
  environment.c: remove test-specific "ignore_untracked..." variable
  read-cache & fetch-negotiator: check "enum" values in switch()
  repo-settings.c: simplify the setup
  repository.h: don't use a mix of int and bitfields

 cache.h                              |   7 --
 environment.c                        |  10 +--
 fetch-negotiator.c                   |   1 -
 git-compat-util.h                    |   2 +
 read-cache.c                         |  15 ++--
 repo-settings.c                      | 115 +++++++++++++--------------
 repository.h                         |  20 ++---
 t/helper/test-dump-untracked-cache.c |   6 +-
 wrapper.c                            |  18 +++++
 9 files changed, 100 insertions(+), 94 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  49706b26642 wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
-:  ----------- > 2:  57290842f0f environment.c: remove test-specific "ignore_untracked..." variable
-:  ----------- > 3:  9f1bb0496ed read-cache & fetch-negotiator: check "enum" values in switch()
1:  29406a40f9b ! 4:  b28ad2b2607 repo-settings.c: simplify the setup
    @@ Commit message
         thing as it did before:
     
         Since 7211b9e7534 (repo-settings: consolidate some config settings,
    -    2019-08-13) we have memset() the whole "settings" structure to -1, and
    -    subsequently relied on the -1 value. As it turns out most things did
    -    not need to be initialized to -1, and e.g. UNTRACKED_CACHE_UNSET and
    -    FETCH_NEGOTIATION_UNSET existed purely to reflect the previous
    -    internal state of the prepare_repo_settings() function.
    -
    -    Much of the "are we -1, then read xyz" can simply be removed by
    -    re-arranging what we read first. E.g. we should read
    -    feature.experimental first, set some values, and then e.g. an explicit
    -    index.version setting should override that. We don't need to read
    -    index.version first, and then check when reading feature.experimental
    -    if it's still -1.
    -
    -    Instead of the global ignore_untracked_cache_config variable added in
    -    dae6c322fa1 (test-dump-untracked-cache: don't modify the untracked
    -    cache, 2016-01-27) we can make use of the new facility to set config
    -    via environment variables added in d8d77153eaf (config: allow
    -    specifying config entries via envvar pairs, 2021-01-12).
    -
    -    It's arguably a bit hacky to use setenv() and getenv() to pass
    -    messages between the same program, but since the test helpers are not
    -    the main intended audience of repo-settings.c I think it's better than
    -    hardcoding the test-only special-case in prepare_repo_settings().
    -
    -    In ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
    -    the "unset" and "keep" handling for core.untrackedCache was
    -    consolidated. But it apparently wasn't noticed that while we
    -    understand the "keep" value, we actually don't handle it differently
    -    than the case of any other unknown value.
    -
    -    So we can remove UNTRACKED_CACHE_KEEP from the codebase. It's not
    -    handled any differently than UNTRACKED_CACHE_UNSET once we get past
    -    the config parsing step.
    -
    -    The UPDATE_DEFAULT_BOOL() wrapper added in 31b1de6a09b (commit-graph:
    -    turn on commit-graph by default, 2019-08-13) is redundant to simply
    -    using the return value from repo_config_get_bool(), which is non-zero
    -    if the provided key exists in the config.
    -
    -    This also fixes an (admittedly obscure) logic error in the previous
    -    code where we'd conflate an explicit "-1" value in the config with our
    -    own earlier memset() -1.
    -
    -    Since the two enum fields added in aaf633c2ad1 (repo-settings: create
    -    feature.experimental setting, 2019-08-13) and
    -    ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
    -    don't rely on the memzero() setting them to "-1" anymore we don't have
    -    to provide them with explicit values. Let's also explicitly use the
    -    enum type in read-cache.c and fetch-negotiator.c for
    -    self-documentation. Since the FETCH_NEGOTIATION_UNSET is gone we can
    -    remove the "default" case in fetch-negotiator.c, and rely on the
    -    compiler to complain about missing enum values instead.
    +    2019-08-13) we have memset() the whole "settings" structure to -1 in
    +    prepare_repo_settings(), and subsequently relied on the -1 value.
    +
    +    Most of the fields did not need to be initialized to -1, and because
    +    we were doing that we had the enum labels "UNTRACKED_CACHE_UNSET" and
    +    "FETCH_NEGOTIATION_UNSET" purely to reflect the resulting state
    +    created this memset() in prepare_repo_settings(). No other code used
    +    or relied on them, more on that below.
    +
    +    For the rest most of the subsequent "are we -1, then read xyz" can
    +    simply be removed by re-arranging what we read first. E.g. when
    +    setting the "index.version" setting we should have first read
    +    "feature.experimental", so that it (and "feature.manyfiles") can
    +    provide a default for our "index.version".
    +
    +    Instead the code setting it, added when "feature.manyFiles"[1] was
    +    created, was using the UPDATE_DEFAULT_BOOL() macro added in an earlier
    +    commit[2]. That macro is now gone, since it was only needed for this
    +    pattern of reading things in the wrong order.
    +
    +    This also fixes an (admittedly obscure) logic error where we'd
    +    conflate an explicit "-1" value in the config with our own earlier
    +    memset() -1.
    +
    +    We can also remove the UPDATE_DEFAULT_BOOL() wrapper added in
    +    [3]. Using it is redundant to simply using the return value from
    +    repo_config_get_bool(), which is non-zero if the provided key exists
    +    in the config.
    +
    +    Details on edge cases relating to the memset() to -1, continued from
    +    "more on that below" above:
    +
    +     * UNTRACKED_CACHE_KEEP:
    +
    +       In [4] the "unset" and "keep" handling for core.untrackedCache was
    +       consolidated. But it while we understand the "keep" value, we don't
    +       handle it differently than the case of any other unknown value. So
    +       we can remove UNTRACKED_CACHE_KEEP. It's not handled any
    +       differently than UNTRACKED_CACHE_UNSET once we get past the config
    +       parsing step.
    +
    +     * FETCH_NEGOTIATION_UNSET & FETCH_NEGOTIATION_NONE:
    +
    +       Since these two two enum fields added in [5] don't rely on the
    +       memzero() setting them to "-1" anymore we don't have to provide
    +       them with explicit values.
    +
    +    1. c6cc4c5afd2 (repo-settings: create feature.manyFiles setting,
    +       2019-08-13)
    +    2. 31b1de6a09b (commit-graph: turn on commit-graph by default,
    +       2019-08-13)
    +    3. 31b1de6a09b (commit-graph: turn on commit-graph by default,
    +       2019-08-13)
    +    4. ad0fb659993 (repo-settings: parse core.untrackedCache,
    +       2019-08-13)
    +    5. aaf633c2ad1 (repo-settings: create feature.experimental setting,
    +       2019-08-13)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## cache.h ##
    -@@ cache.h: int update_server_info(int);
    - const char *get_log_output_encoding(void);
    - const char *get_commit_output_encoding(void);
    - 
    --/*
    -- * This is a hack for test programs like test-dump-untracked-cache to
    -- * ensure that they do not modify the untracked cache when reading it.
    -- * Do not use it otherwise!
    -- */
    --extern int ignore_untracked_cache_config;
    --
    - int committer_ident_sufficiently_given(void);
    - int author_ident_sufficiently_given(void);
    - 
    -
    - ## environment.c ##
    -@@ environment.c: int auto_comment_line_char;
    - /* Parallel index stat data preload? */
    - int core_preload_index = 1;
    - 
    --/*
    -- * This is a hack for test programs like test-dump-untracked-cache to
    -- * ensure that they do not modify the untracked cache when reading it.
    -- * Do not use it otherwise!
    -- */
    --int ignore_untracked_cache_config;
    --
    - /* This is set by setup_git_dir_gently() and/or git_default_config() */
    - char *git_work_tree_cfg;
    - 
    -
      ## fetch-negotiator.c ##
    -@@
    - void fetch_negotiator_init(struct repository *r,
    - 			   struct fetch_negotiator *negotiator)
    - {
    -+	enum fetch_negotiation_setting setting;
    - 	prepare_repo_settings(r);
    --	switch(r->settings.fetch_negotiation_algorithm) {
    -+	setting = r->settings.fetch_negotiation_algorithm;
    -+
    -+	switch (setting) {
    - 	case FETCH_NEGOTIATION_SKIPPING:
    - 		skipping_negotiator_init(negotiator);
    - 		return;
     @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
      		return;
      
      	case FETCH_NEGOTIATION_DEFAULT:
    --	default:
    +-	case FETCH_NEGOTIATION_UNSET:
    +-	case FETCH_NEGOTIATION_NONE:
      		default_negotiator_init(negotiator);
      		return;
      	}
     
      ## read-cache.c ##
    -@@ read-cache.c: static void check_ce_order(struct index_state *istate)
    - static void tweak_untracked_cache(struct index_state *istate)
    - {
    - 	struct repository *r = the_repository;
    -+	enum untracked_cache_setting setting;
    - 
    - 	prepare_repo_settings(r);
    -+	setting = r->settings.core_untracked_cache;
    - 
    --	if (r->settings.core_untracked_cache  == UNTRACKED_CACHE_REMOVE) {
    -+	switch (setting) {
    -+	case UNTRACKED_CACHE_REMOVE:
    - 		remove_untracked_cache(istate);
    --		return;
    --	}
    --
    --	if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
    -+		break;
    -+	case UNTRACKED_CACHE_WRITE:
    +@@ read-cache.c: static void tweak_untracked_cache(struct index_state *istate)
      		add_untracked_cache(istate);
    -+		break;
    -+	case UNTRACKED_CACHE_UNSET:
    + 		break;
    + 	case UNTRACKED_CACHE_UNSET:
    +-	case UNTRACKED_CACHE_KEEP:
     +		/* This includes core.untrackedCache=keep */
    -+		break;
    -+	}
    -+	return;
    - }
    - 
    - static void tweak_split_index(struct index_state *istate)
    + 		break;
    + 	}
    + 	return;
     
      ## repo-settings.c ##
     @@
    @@ repo-settings.c
      #include "midx.h"
      
     -#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
    -+static void repo_config_get_bool_or(struct repository *r, const char *key,
    -+				    int *dest, int def)
    ++static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
    ++			  int def)
     +{
     +	if (repo_config_get_bool(r, key, dest))
     +		*dest = def;
    @@ repo-settings.c
      
      void prepare_repo_settings(struct repository *r)
      {
    --	int value;
     +	int experimental;
    -+	int intval;
    + 	int value;
      	char *strval;
     +	int manyfiles;
      
    - 	if (r->settings.initialized)
    +-	if (r->settings.initialized)
    ++	if (r->settings.initialized++)
      		return;
      
      	/* Defaults */
    @@ repo-settings.c
     +	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
     +
     +	/* Booleans config or default, cascades to other settings */
    -+	repo_config_get_bool_or(r, "feature.manyfiles", &manyfiles, 0);
    -+	repo_config_get_bool_or(r, "feature.experimental", &experimental, 0);
    -+
    -+	/* Defaults modified by feature.* */
    -+	if (experimental) {
    -+		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
    -+	}
    -+	if (manyfiles) {
    -+		r->settings.index_version = 4;
    -+		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
    -+	}
    ++	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
    ++	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
      
     -	if (!repo_config_get_bool(r, "core.commitgraph", &value))
     -		r->settings.core_commit_graph = value;
    @@ repo-settings.c
     -	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
     -	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
     -	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
    ++	/* Defaults modified by feature.* */
    ++	if (experimental) {
    ++		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
    ++	}
    ++	if (manyfiles) {
    ++		r->settings.index_version = 4;
    ++		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
    ++	}
    ++
     +	/* Boolean config or default, does not cascade (simple)  */
    -+	repo_config_get_bool_or(r, "core.commitgraph",
    -+				&r->settings.core_commit_graph, 1);
    -+	repo_config_get_bool_or(r, "commitgraph.readchangedpaths",
    -+				&r->settings.commit_graph_read_changed_paths, 1);
    -+	repo_config_get_bool_or(r, "gc.writecommitgraph",
    -+				&r->settings.gc_write_commit_graph, 1);
    -+	repo_config_get_bool_or(r, "fetch.writecommitgraph",
    -+				&r->settings.fetch_write_commit_graph, 0);
    -+	repo_config_get_bool_or(r, "pack.usesparse",
    -+				&r->settings.pack_use_sparse, 1);
    -+	repo_config_get_bool_or(r, "core.multipackindex",
    -+				&r->settings.core_multi_pack_index, 1);
    - 
    --	if (!repo_config_get_int(r, "index.version", &value))
    --		r->settings.index_version = value;
    --	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
    --		if (value == 0)
    --			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
    --		else
    --			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
    --	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
    --		if (!strcasecmp(strval, "keep"))
    --			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
    ++	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
    ++	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
    ++	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
    ++	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
    ++	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
    ++	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
    ++
     +	/*
     +	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
     +	 * either it *or* the config sets
     +	 * r->settings.core_multi_pack_index if true. We don't take
     +	 * the environment variable if it exists (even if false) over
    -+	 * any config, as in other cases.
    ++	 * any config, as in most other cases.
     +	 */
     +	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
     +		r->settings.core_multi_pack_index = 1;
    @@ repo-settings.c
     +	/*
     +	 * Non-boolean config
     +	 */
    -+	if (!repo_config_get_int(r, "index.version", &intval))
    -+		r->settings.index_version = intval;
    -+
    + 	if (!repo_config_get_int(r, "index.version", &value))
    + 		r->settings.index_version = value;
    +-	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
    +-		if (value == 0)
    +-			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
    +-		else
    +-			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
    +-	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
    +-		if (!strcasecmp(strval, "keep"))
    +-			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
    + 
     +	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
    -+		int maybe_bool = git_parse_maybe_bool(strval);
    -+		if (maybe_bool == -1) {
    -+			/*
    -+			 * Set to "keep", or some other non-boolean
    -+			 * value. In either case we do nothing but
    -+			 * keep UNTRACKED_CACHE_UNSET.
    -+			 */
    -+		} else {
    -+			r->settings.core_untracked_cache = maybe_bool
    -+				? UNTRACKED_CACHE_WRITE
    -+				: UNTRACKED_CACHE_REMOVE;
    -+		}
    ++		int v = git_parse_maybe_bool(strval);
    ++
    ++		/*
    ++		 * If it's set to "keep", or some other non-boolean
    ++		 * value then "v < 0". Then we do nothing and keep it
    ++		 * at UNTRACKED_CACHE_UNSET.
    ++		 */
    ++		if (v >= 0)
    ++			r->settings.core_untracked_cache = v ?
    ++				UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
      		free(strval);
      	}
      
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     -		else
     -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
      	}
    --
    + 
     -	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     -		r->settings.pack_use_sparse = value;
     -	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     -	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
     -		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
     -
    --	/* Hack for test programs like test-dump-untracked-cache */
    --	if (ignore_untracked_cache_config)
    --		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
    --	else
    --		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
    --
    +-	UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     -	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
    - }
    +-
    + 	/*
    + 	 * This setting guards all index reads to require a full index
    + 	 * over a sparse index. After suitable guards are placed in the
     
      ## repository.h ##
    -@@ repository.h: struct raw_object_store;
    - struct submodule_cache;
    +@@ repository.h: struct submodule_cache;
    + struct promisor_remote_config;
      
      enum untracked_cache_setting {
     -	UNTRACKED_CACHE_UNSET = -1,
    @@ repository.h: struct raw_object_store;
      };
      
      struct repo_settings {
    -
    - ## t/helper/test-dump-untracked-cache.c ##
    -@@ t/helper/test-dump-untracked-cache.c: int cmd__dump_untracked_cache(int ac, const char **av)
    - 	struct untracked_cache *uc;
    - 	struct strbuf base = STRBUF_INIT;
    - 
    --	/* Hack to avoid modifying the untracked cache when we read it */
    --	ignore_untracked_cache_config = 1;
    -+	/* Set core.untrackedCache=keep before setup_git_directory() */
    -+	setenv("GIT_CONFIG_COUNT", "1", 1);
    -+	setenv("GIT_CONFIG_KEY_0", "core.untrackedCache", 1);
    -+	setenv("GIT_CONFIG_VALUE_0", "keep", 1);
    - 
    - 	setup_git_directory();
    - 	if (read_cache() < 0)
-:  ----------- > 5:  0b5f213a639 repository.h: don't use a mix of int and bitfields
-- 
2.33.0.1092.g44c994ea1be

