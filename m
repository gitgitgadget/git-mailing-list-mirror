Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491CC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26D760041
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWGqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 02:46:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E870C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:44:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso568345wms.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DSVhTlHV01u5uTmTiYFFfbQNNS3DSesXif9txLRUYkM=;
        b=s6J6dECPJgt3ogiQE2n1wC1m6ATE1tYsRhgxCTqn1qQa7M33MKcMQzsxjnrGZ67lZ5
         GchpKUNULGTnJnCcwhHSC387rLRwu3kWZfLszXkuvXmeuIfos01P5gJtoIoTjLIZD24g
         a9xiVZKqEafR4w59rPCdkKAptGkRSQL90DNq3CriZmJNGAPqvt4EhhlSJQIyQLCvu5b5
         dOwYP2/uoA3mrUzwPMbEP+ji//5R1OboeOWJvdwTQ+Pznf+IzI0zLbm1Hipw5SrFNvLy
         NzzkgH3MazNI49qyuCIo2KgkW/dX+UfHcgpjGz3Px9UtJEo609xs550z4mqFTtRn/hp3
         sD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DSVhTlHV01u5uTmTiYFFfbQNNS3DSesXif9txLRUYkM=;
        b=d+IH0sJj8tkuhsitTxxVt+ZSVO5e44CiSDbCjbvc3ksQ3PCX5Fy/EsJCOiv4xwyMWd
         QAq7He6RNeV+Itq4qRc6J9wpuk+A2dq92Scuya6TuDYpYn8Cok6QWkRfrtMliplVaL98
         AqdM5dyorwkcMkaYcf1J0QTGTU3BjP+3OPzuLSI+0Nk+01cYkw82b/HIOPhtCkBeENBz
         Bu57pELXDnIOPJmQLAm0WAcopjATz7D5JjIqidiZ3HeOFTc+o6YITNj62odn6xfsAEin
         I6Op3rxOs/I+VPF5a1Gne/ZMrRWJJTVbh1NzzT3YTDrGSNNlv4PlKqlR8z3lFFUyPDw4
         TPWg==
X-Gm-Message-State: AOAM5322n+9nyZfnW7u13ydjoxn2bBcRrOf6cn0Mlt7G4P4yt8y+cMnc
        NGBhKZSQrlHUYFc93R7nYQrMZuKV9S4=
X-Google-Smtp-Source: ABdhPJwkJxJgZE7dehVXZr2fr8Qgtc7XEHoRCdjVv6uxMP9v9bR6Jdxc4UZuZo649DEHCl3p25ou7w==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr8794378wmj.120.1624430669816;
        Tue, 22 Jun 2021 23:44:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c74sm4464834wme.11.2021.06.22.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 23:44:29 -0700 (PDT)
Message-Id: <pull.985.git.1624430668741.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 06:44:28 +0000
Subject: [PATCH] Support untracked cache with '--untracked-files=all' if
 configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Untracked cache was originally designed to only work with
'-untracked-files=normal', but this is a concern for UI tooling
that wants to see "all" on a frequent basis, and the conditions
that prevented applicability to the "all" mode no longer seem to
apply.

The disqualification of untracked cache is a particular problem on
Windows with the defaulted fscache, where the introduction of
fsmonitor can make the first and costly directory-iteration happen
in untracked file detection, single-threaded, rather than in
preload-index on multiple threads. Improving the performance of a
"normal" 'git status' run with fsmonitor can make
'git status --untracked-files=all' perform much worse.

Here we align the supported directory flags for the stored
untracked cache data with the git config. If a user specifies an
'--untracked-files=' commandline parameter that does not align
with their 'status.showuntrackedfiles' config value, then the
untracked cache will be ignored - as it is for other unsupported
situations like when a pathspec is specified.

If the previously stored flags no longer match the current
configuration, but the currently-applicable flags do match the
current configuration, then the previously stored untracked cache
data is discarded.

For most users there will be no change in behavior. Users who
need '--untracked-files=all' to perform well will have the option
of setting "status.showuntrackedfiles" to "all".

Users who need '--untracked-files=all' to perform well for their
tooling AND prefer to avoid the verbosity of "all" when running
git status explicitly... are out of luck for now.

Users who set "status.showuntrackedfiles" to "all" and yet
most frequently explicitly call
'git status --untracked-files=normal' (and use the untracked
cache) are the only users who will be explicitly disadvantaged
by this change. These should be vanishingly rare, if there are
any at all.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    Support untracked cache with '--untracked-files=all' if configured
    
    This patch aims to make it possible for users of -uall, either by
    preference or by need (eg UI tooling), to benefit from the untracked
    cache when they set their 'status.showuntrackedfiles' config setting to
    'all'. This is very important for large repos in Windows.
    
    More detail on the change and context in the commit message, I assume
    repeating a verbose message here is discouraged.
    
    These changes result from a couple of conversations,
    81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com and
    CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>.
    
    The test suite passes, but as a n00b I do have questions:
    
     * Is there any additional validatiln that could/should be done to
       confirm that "-uall" untracked data can be cached safely? It looks
       that way to me, both from following the code, discussing briefly with
       Elijah Newren in the thread above, and manual testing, but I'm not
       sure what edge-cases to be looking out for
     * Is it OK to check the repo configuration in the body of processing?
       It seems to be a rare pattern
     * Should I be adding test cases? To the existing t7603 untracked cache
       tests, or elsewhere?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-985%2FTaoK%2Ftaok-untracked-cache-with-uall-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-985/TaoK/taok-untracked-cache-with-uall-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/985

 dir.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/dir.c b/dir.c
index ebe5ec046e..49fc13c111 100644
--- a/dir.c
+++ b/dir.c
@@ -2668,13 +2668,33 @@ static void set_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
-static void new_untracked_cache(struct index_state *istate)
+static unsigned configured_default_dir_flags(struct index_state *istate)
+{
+	/* This logic is coordinated with the setting of these flags in
+	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
+	 * of the config setting in commit.c#git_status_config()
+	 */
+	char *status_untracked_files_config_value;
+	int config_outcome = repo_config_get_string(istate->repo,
+								"status.showuntrackedfiles",
+								&status_untracked_files_config_value);
+	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
+		return 0;
+	} else {
+		/*
+		 * The default, if "all" is not set, is "normal" - leading us here.
+		 * If the value is "none" then it really doesn't matter.
+		 */
+		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	}
+}
+
+static void new_untracked_cache(struct index_state *istate, unsigned flags)
 {
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	/* should be the same flags used by git-status */
-	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	uc->dir_flags = flags;
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
@@ -2683,11 +2703,13 @@ static void new_untracked_cache(struct index_state *istate)
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
-		new_untracked_cache(istate);
+		new_untracked_cache(istate,
+				configured_default_dir_flags(istate));
 	} else {
 		if (!ident_in_untracked(istate->untracked)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate);
+			new_untracked_cache(istate,
+					configured_default_dir_flags(istate));
 		}
 	}
 }
@@ -2703,10 +2725,12 @@ void remove_untracked_cache(struct index_state *istate)
 
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
-						      const struct pathspec *pathspec)
+						      const struct pathspec *pathspec,
+							  struct index_state *istate)
 {
 	struct untracked_cache_dir *root;
 	static int untracked_cache_disabled = -1;
+	unsigned configured_dir_flags;
 
 	if (!dir->untracked)
 		return NULL;
@@ -2734,17 +2758,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (base_len || (pathspec && pathspec->nr))
 		return NULL;
 
-	/* Different set of flags may produce different results */
-	if (dir->flags != dir->untracked->dir_flags ||
-	    /*
-	     * See treat_directory(), case index_nonexistent. Without
-	     * this flag, we may need to also cache .git file content
-	     * for the resolve_gitlink_ref() call, which we don't.
-	     */
-	    !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
-	    /* We don't support collecting ignore files */
-	    (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
-			   DIR_COLLECT_IGNORED)))
+	/* We don't support collecting ignore files */
+	if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
+			DIR_COLLECT_IGNORED))
 		return NULL;
 
 	/*
@@ -2767,6 +2783,40 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
+	/* We don't support using or preparing the untracked cache if
+	 * the current effective flags don't match the configured
+	 * flags.
+	 */
+	configured_dir_flags = configured_default_dir_flags(istate);
+	if (dir->flags != configured_dir_flags)
+		return NULL;
+
+	/* If the untracked structure we received does not have the same flags
+	 * as configured, but the configured flags do match the effective flags,
+	 * then we need to reset / create a new "untracked" structure to match
+	 * the new config.
+	 * Keeping the saved and used untracked cache in-line with the
+	 * configuration provides an opportunity for frequent users of
+	 * "git status -uall" to leverage the untracked cache by aligning their
+	 * configuration (setting "status.showuntrackedfiles" to "all" or
+	 * "normal" as appropriate), where previously this option was
+	 * incompatible with untracked cache and *consistently* caused
+	 * surprisingly bad performance (with fscache and fsmonitor enabled) on
+	 * Windows.
+	 *
+	 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
+	 * to not be as bound up with the desired output in a given run,
+	 * and instead iterated through and stored enough information to
+	 * correctly serve both "modes", then users could get peak performance
+	 * with or without '-uall' regardless of their
+	 * "status.showuntrackedfiles" config.
+	 */
+	if (dir->flags != dir->untracked->dir_flags) {
+		free_untracked_cache(istate->untracked);
+		new_untracked_cache(istate, configured_dir_flags);
+		dir->untracked = istate->untracked;
+	}
+
 	if (!dir->untracked->root)
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
 
@@ -2838,7 +2888,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec);
+	untracked = validate_untracked_cache(dir, len, pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,

base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
-- 
gitgitgadget
