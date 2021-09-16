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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E45C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69623611EE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbhIPTBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbhIPTBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7375C0F26D0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so10998984wrq.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccFl5W+Rb0Q5I4pNTRraXUcaHMBDq6KRL1P1qO/K8A0=;
        b=UxCPtderNHFVw/fQV3/qSnSziK2Vz2bytzmJvJyvsXvoSQy0153o7A0j3lyfeab8lY
         5/5XfAuIrdvSm8B7XA64QE+pvU7IgccaDJIQPJhir33VqPYlgXBexMHnDCNVBYy5Geo2
         UKoNGpDiyqQXaffpPgi4cNkhXPw2FhkpAWQUisxCM7SzxvuJmlC9axByc0QD0SzOn7uA
         bv/V+YYloLFXB20G0ecVmOyycKXby41p2a2uU80Q/STDgSkfjKSzbh9+ZoK0bS+TQNvi
         NFY28EdfPkWOUCuSHCUZ9uFqIZB0Shm99mU5NDXLGMmrOmMbfR6v90aoEBhK12ZcN/F3
         5EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccFl5W+Rb0Q5I4pNTRraXUcaHMBDq6KRL1P1qO/K8A0=;
        b=vlV0Wjl/DUSw0DgnVQXgluYGbsg9ni6x/I3l9gymlOtrCPe9gSMnarS/IQy36Vf4ie
         XA/JxxR39SlE1SOa9sMfPy8jjtCqrYh2byd7rcC9AF/8p642Q/AG/U9USTHdNheEbTpV
         ItisfjjGaqj/KxNsCgXJH4SeiteCWiYyvfLyjZ2eG+ZgBZw0oFYn6uLWXno5Z20UovRb
         vsjgI2M3HjhP4hUjJwLP+Cx/GomqegRLzdSuDStIaoDyyaGXgCMFi7oAAOx2P2vVHe6q
         yzkgO5MAGM/Qm/TTxPEYKwQLuk9eNKSpnQmNFCHwu0e4e+2vAxxVMkiIjTM+QcWrZXLE
         5hcQ==
X-Gm-Message-State: AOAM530arcc0cuXjLOerEjKUId2U+Xf4dvEr8v0N4ybH6Bxq2avVee3x
        e2OonjjoCdg/d+mrook1h06WcUqowJh0gw==
X-Google-Smtp-Source: ABdhPJxF79kx74m1yYdVT9gCf9B3bPHwVkjeTijKtj5ALFpH7acLY7mfpzMoD7Aw9rj/nk2bI6twXg==
X-Received: by 2002:a5d:65d0:: with SMTP id e16mr7773523wrw.182.1631817042186;
        Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] environment.c: remove test-specific "ignore_untracked..." variable
Date:   Thu, 16 Sep 2021 20:30:33 +0200
Message-Id: <patch-v2-2.5-57290842f0f-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
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

