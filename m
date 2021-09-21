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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E757C611BD
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhIUNOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhIUNOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:14:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F7C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so37292425wrg.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCEOWZXAqPd7DhK96pWEwHbEJdxJ4wt1/JzZzaKjz/I=;
        b=DJ1r29OQHWaceKqRWMkzXGTy9JBjO4CXaKE1eL9Fo3yWqfNo63x9bylIfm93+v5p0Y
         KXbssyh7fpOzmNIZg49X8TB8S0GtgfC1yAq++FwIhwKZ9MwII6tWwqDXplKF5qSMKRjX
         dv6JCNu6Cfp9CSonFFK2hPYynQK6jhaHPNIaSaS7LLguRlSZPuMLjHU2n8mM8oV+gawf
         KeK1LSeYidxk5ET5bd89pdTMypkxjmXU2PoLPdjdNwPGfiVuVCu0bT/sHl0kNRaWwl+l
         JNSfhU3WSEaLZwxEnNGZJFr3I8MYbhUPti0hXHawn8Y0q0Kt5eTtT1SpXwXhAY/Ah9mU
         uMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCEOWZXAqPd7DhK96pWEwHbEJdxJ4wt1/JzZzaKjz/I=;
        b=GtdqoyHr4JIQYMkFXzGtGJ7kOcJoGSsh+Hlj7NeWJS0I4luVl8I9gngKs+wgG1kVaZ
         7WuYwxwGk7kZPfxTVypOjAnEvTcTlDC/RQgiZGkDE6wmh4yHtiGeRkjuj4o+wfpNwcSj
         lSkbUJwSfaStFTT5x6y/ND22ZmO86bYoJtUQL1tmgGVKfNdbfP75/EfrUe+sIEaWIEbg
         16eShFptmTpdMnJ6YSKtq3k0o3VUJgjjH2pA5HdXye/OmvDm01E8h+CInnpuOUU0IpgG
         CNGu5jQLBhN9L/ne1pgQih8GRbt/XgFGYiMfMTVVuNU80i3QCx9EnRZHfw3E/dqUxILC
         jlcQ==
X-Gm-Message-State: AOAM533rulDwCHQKnwLhU8SRvs5vJ+yXYduBJqZYNMJtL9HvfuUxEmdH
        KUspRrnLFSMHsW3t+PCljAImsgz8aWT/Fg==
X-Google-Smtp-Source: ABdhPJzvFsa8wgwTV4QmfLOdqsGh1frDmowRuHLHXVYqFM6+jn0K6BdwzpUzR/aJBLKom0GNeuUYAw==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr35486502wrs.404.1632229989841;
        Tue, 21 Sep 2021 06:13:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm2733260wml.44.2021.09.21.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:13:08 -0700 (PDT)
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
Subject: [PATCH v4 2/5] environment.c: remove test-specific "ignore_untracked..." variable
Date:   Tue, 21 Sep 2021 15:13:00 +0200
Message-Id: <patch-v4-2.5-3dc37521184-20210921T131003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of the global ignore_untracked_cache_config variable added in
dae6c322fa1 (test-dump-untracked-cache: don't modify the untracked
cache, 2016-01-27) we can make use of the new facility to set config
via environment variables added in d8d77153eaf (config: allow
specifying config entries via envvar pairs, 2021-01-12).

It's arguably a bit hacky to use setenv() and getenv() to pass
messages between the same program, but since the test helpers are not
the main intended audience of repo-settings.c I think it's better than
hardcoding the test-only special-case in prepare_repo_settings().

This uses the xsetenv() wrapper added in the preceding commit, if we
don't set these in the environment we'll fail in
t7063-status-untracked-cache.sh, but let's fail earlier anyway if that
were to happen.

This breaks any parent process that's potentially using the
GIT_CONFIG_* and GIT_CONFIG_PARAMETERS mechanism to pass one-shot
config setting down to a git subprocess, but in this case we don't
care about the general case of such potential parents. This process
neither spawns other "git" processes, nor is it interested in other
configuration. We might want to pick up other test modes here, but
those will be passed via GIT_TEST_* environment variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h                              | 7 -------
 environment.c                        | 7 -------
 repo-settings.c                      | 7 +------
 t/helper/test-dump-untracked-cache.c | 6 ++++--
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 0c245d4f105..8941cc62c59 100644
--- a/cache.h
+++ b/cache.h
@@ -1726,13 +1726,6 @@ int update_server_info(int);
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
index 7d8a949285c..d73dd0c42f7 100644
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
 
diff --git a/repo-settings.c b/repo-settings.c
index 0cfe8b787db..b0df8b93b86 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -70,12 +70,7 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
 
-	/* Hack for test programs like test-dump-untracked-cache */
-	if (ignore_untracked_cache_config)
-		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-	else
-		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
-
+	UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
 	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
 
 	/*
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index cf0f2c7228e..99010614f6d 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -45,8 +45,10 @@ int cmd__dump_untracked_cache(int ac, const char **av)
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
 
-	/* Hack to avoid modifying the untracked cache when we read it */
-	ignore_untracked_cache_config = 1;
+	/* Set core.untrackedCache=keep before setup_git_directory() */
+	xsetenv("GIT_CONFIG_COUNT", "1", 1);
+	xsetenv("GIT_CONFIG_KEY_0", "core.untrackedCache", 1);
+	xsetenv("GIT_CONFIG_VALUE_0", "keep", 1);
 
 	setup_git_directory();
 	if (read_cache() < 0)
-- 
2.33.0.1098.gf02a64c1a2d

