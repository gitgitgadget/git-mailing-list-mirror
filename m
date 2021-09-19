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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC96C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D05611C3
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhISIsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhISIsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA847C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so21209020wrg.5
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIAOOKqV80LUBbkULEqtI0O3L2Wh0rj6xzKUtZXAEIg=;
        b=aIcFTSNRxLCJcpYJPFJZARWzMeYKDf0vyva4kjhFHNzIj1tABKm3B6DT4l8J2E3skK
         sTWo8nfoj20y6HTTGxutCN0S1n9KZvpbZu5z2j0IR0y4RF1OhLeNQcF34nFe6swg/2im
         gb3hPrePEKHi73fj69tLfwNiEtoJDR81jabbta7weGXoLun9AGo2LraZb8BcanStCRpJ
         29acEY7CkQ5+EskZ3wvupfkBaIjOoMPd3YskFYZmbNlR9QNshOub8GBDq4hyhCWH14gj
         WM+de1VOy4ONjvacLSjt4EB/YEVyjvAWGFvZzYZo2Fk20/ZC+rsgFRbLzz1hUEHjFoJi
         xSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIAOOKqV80LUBbkULEqtI0O3L2Wh0rj6xzKUtZXAEIg=;
        b=f3XWuV7RmoOJk8EQG7gIs+L4PDwLvz8Fv6K7jIrZQTa2WjAVbe/ZVsnP6WNS08BkjO
         PGM2yYLDdU/QS5DQARGCuE1+w8aGCGqKCIVfkDl7i1YwRWAVhfERY7VxNCa42133adH+
         pbIoUPUo/Mw9/pN4NlcbaBfSJgdPkm5gKoSiEmX0hinYZCfFxVl2kViJW3uzxYA3Hfpw
         fQt170sK+GJV71RUy05dREHZwjSuV8FT4rxE8re1ykoEQEp5gkxXqO6072VKPriSM15N
         1tTHTWcgzULBXBEGVOSdu/c3BzVJjWfU/I3k/ZLCQpStmCZEbj1kkKuu5Taph1aiAb18
         yjQg==
X-Gm-Message-State: AOAM532jUOCqUYWwsaSFEOf/DrCP7cVuyrYIxSoqnQ2eWII3jCwde54F
        prsCvDyjbl+TLMRk0SWEeDt09LWIBTOLNg==
X-Google-Smtp-Source: ABdhPJxgQ5brG4CgeojWvbEPNTYYobYIfF9P9aLLPi1uXgarKP/E7pU4cwOHYgfgGolJ+H+fl93p7g==
X-Received: by 2002:adf:e390:: with SMTP id e16mr21753579wrm.217.1632041243113;
        Sun, 19 Sep 2021 01:47:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] environment.c: remove test-specific "ignore_untracked..." variable
Date:   Sun, 19 Sep 2021 10:47:16 +0200
Message-Id: <patch-v3-2.5-ece340af764-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
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
index d23de693680..8e60fdd2a12 100644
--- a/cache.h
+++ b/cache.h
@@ -1719,13 +1719,6 @@ int update_server_info(int);
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
2.33.0.1092.g44c994ea1be

