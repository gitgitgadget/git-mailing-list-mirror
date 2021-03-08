Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6BC43333
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD01165210
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCHSgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCHSgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09DC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so12536537wrx.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1KBF5N6/UdlX0Uvlr+J/y3JlDuq6Ng41G1ae0vnw04Y=;
        b=ucoPW2dj/KG54W9UBLcr8BHeZsWveJ2n7DgiCqxqov9D+fqjnrnGq5BkRRHACcmqf8
         vjjcD2nzZz2ElPxsw74KUTkULUq8uopuGJJhg5wCzjoQ9V1D2pECDSzc207ABJDHZCSP
         lNOxyQzWTkRTnBzAXCzDeiPVldeDX7Afh2/S7Ge57DXfzvu3QUwaxEI9nMsxurwESNLX
         +oMQ7pvBI2le+/Nfw1ktyTjfXBGIiEvmDQ9RUnWgRzse+wMVoUcGfVo/5Vm1brdzcVUp
         JNgUXt6o9f97bhWHt6FakLQfufJI636VPhaseRZSgDfwT489p3pbI5CRJP1svE9iTIjf
         RBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1KBF5N6/UdlX0Uvlr+J/y3JlDuq6Ng41G1ae0vnw04Y=;
        b=TzxAXuMPNN8Wx+niKWhoUC0SShcXp82rVnE/bjRdo2sxLAYzK9p2irznLq9vNCNINp
         rwLE3nVQYZbTf+e8G6L3SiX/n0hCpzDj3dT/EBpvQU8jvm3u/4w2W2JVEKOymcPEftYo
         XfcoTY+1vmJtQbwws+BqMpQrAgsX7Bb/x2YPMTkHA+Ypjw419hAT2H88qH4VilELKImD
         AOfMvkKosOLP+f0Ze+2JiTUn2LivRTbG/UEKU+xRkn5mYIaNl+pwAiXZwKwYFREhf1pQ
         V/2wowI6ghf/d3NF+Yw+5tpLWVy6NLWnTThIN6aMShBPr0qsVDUHAmKkAPOEXmvugyZI
         MaQg==
X-Gm-Message-State: AOAM530fe/XSdkkU+AD98fgN5/y1ds1LmPZ08Vkcc2CYVUQkrMoaDGv4
        nARn+XIpsMk7vlyufKQ87v5osB4GQ68=
X-Google-Smtp-Source: ABdhPJyH/YaR1RfpZouZQVXrvSh8dGO4PgkXQhFAv3jRjoEkUyNWS4Mvd7PvC2znXjC9dDK8c8MZuQ==
X-Received: by 2002:adf:c641:: with SMTP id u1mr24494597wrg.332.1615228584160;
        Mon, 08 Mar 2021 10:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm20568353wrx.56.2021.03.08.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:23 -0800 (PST)
Message-Id: <d30365d967651c6090635ec564d2ed2d051e8aec.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:18 +0000
Subject: [PATCH 5/7] init: remove git_init_db_config() while fixing leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

The primary goal of this change is to stop leaking init_db_template_dir.
This leak can happen because:
 1. git_init_db_config() allocates new memory into init_db_template_dir
    without first freeing the existing value.
 2. init_db_template_dir might already contain data, either because:
  2.1 git_config() can be invoked twice with this callback in a single
      process - at least 2 allocations are likely.
  2.2 A single git_config() allocation can invoke the callback multiple
      times for a given key (see further explanation in the function
      docs) - each of those calls will trigger another leak.

The simplest fix for the leak would be to free(init_db_template_dir)
before overwriting it. Instead we choose to convert to fetching
init.templatedir via git_config_get_value() as that is more explicit,
more efficient, and avoids allocations (the returned result is owned by
the config cache, so we aren't responsible for freeing it).

If we remove init_db_template_dir, git_init_db_config() ends up being
responsible only for forwarding core.* config values to
platform_core_config(). However platform_core_config() already ignores
non-core.* config values, so we can safely remove git_init_db_config()
and invoke git_config() directly with platform_core_config() as the
callback.

The platform_core_config forwarding was originally added in:
  287853392a (mingw: respect core.hidedotfiles = false in git-init again, 2019-03-11
And I suspect the potential for a leak existed since the original
implementation of git_init_db_config in:
  90b45187ba (Add `init.templatedir` configuration variable., 2010-02-17)

LSAN output from t0001:

Direct leak of 73 byte(s) in 1 object(s) allocated from:
    #0 0x49a859 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9a7276 in xrealloc /home/ahunt/oss-fuzz/git/wrapper.c:126:8
    #2 0x9362ad in strbuf_grow /home/ahunt/oss-fuzz/git/strbuf.c:98:2
    #3 0x936eaa in strbuf_add /home/ahunt/oss-fuzz/git/strbuf.c:295:2
    #4 0x868112 in strbuf_addstr /home/ahunt/oss-fuzz/git/./strbuf.h:304:2
    #5 0x86a8ad in expand_user_path /home/ahunt/oss-fuzz/git/path.c:758:2
    #6 0x720bb1 in git_config_pathname /home/ahunt/oss-fuzz/git/config.c:1287:10
    #7 0x5960e2 in git_init_db_config /home/ahunt/oss-fuzz/git/builtin/init-db.c:161:11
    #8 0x7255b8 in configset_iter /home/ahunt/oss-fuzz/git/config.c:1982:7
    #9 0x7253fc in repo_config /home/ahunt/oss-fuzz/git/config.c:2311:2
    #10 0x725ca7 in git_config /home/ahunt/oss-fuzz/git/config.c:2399:2
    #11 0x593e8d in create_default_files /home/ahunt/oss-fuzz/git/builtin/init-db.c:225:2
    #12 0x5935c6 in init_db /home/ahunt/oss-fuzz/git/builtin/init-db.c:449:11
    #13 0x59588e in cmd_init_db /home/ahunt/oss-fuzz/git/builtin/init-db.c:714:9
    #14 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #15 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #16 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #17 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #18 0x69c4de in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #19 0x7f23552d6349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/init-db.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcc45bef5148..d31dbc883746 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -25,7 +25,6 @@
 
 static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
-static const char *init_db_template_dir;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			     DIR *dir)
@@ -94,7 +93,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	}
 }
 
-static void copy_templates(const char *template_dir)
+static void copy_templates(const char *template_dir, const char *init_template_dir)
 {
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf template_path = STRBUF_INIT;
@@ -107,7 +106,7 @@ static void copy_templates(const char *template_dir)
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
-		template_dir = init_db_template_dir;
+		template_dir = init_template_dir;
 	if (!template_dir)
 		template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
 	if (!template_dir[0]) {
@@ -154,17 +153,6 @@ static void copy_templates(const char *template_dir)
 	clear_repository_format(&template_format);
 }
 
-static int git_init_db_config(const char *k, const char *v, void *cb)
-{
-	if (!strcmp(k, "init.templatedir"))
-		return git_config_pathname(&init_db_template_dir, k, v);
-
-	if (starts_with(k, "core."))
-		return platform_core_config(k, v, cb);
-
-	return 0;
-}
-
 /*
  * If the git_dir is not directly inside the working tree, then git will not
  * find it by default, and we need to set the worktree explicitly.
@@ -212,10 +200,7 @@ static int create_default_files(const char *template_path,
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
-
-	/* Just look for `init.templatedir` */
-	init_db_template_dir = NULL; /* re-set in case it was set before */
-	git_config(git_init_db_config, NULL);
+	const char *init_template_dir = NULL;
 
 	/*
 	 * First copy the templates -- we might have the default
@@ -226,7 +211,8 @@ static int create_default_files(const char *template_path,
 	 * values (since we've just potentially changed what's available on
 	 * disk).
 	 */
-	copy_templates(template_path);
+	git_config_get_value("init.templatedir", &init_template_dir);
+	copy_templates(template_path, init_template_dir);
 	git_config_clear();
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
@@ -422,8 +408,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
-	/* Just look for `core.hidedotfiles` */
-	git_config(git_init_db_config, NULL);
+	/* Ensure `core.hidedotfiles` is processed */
+	git_config(platform_core_config, NULL);
 
 	safe_create_dir(git_dir, 0);
 
-- 
gitgitgadget

