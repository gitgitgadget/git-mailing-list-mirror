Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A3C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB206109D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbhIGVGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346428AbhIGVGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53050C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso307458wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GJpCBUAafsBhvlYNm+bc+NgVhecmY8SHcco/BAwxD/s=;
        b=jK3obes1wGN6L5fOQZTCVl5k1VPW6sjkFKWHLCcx9pFkLBIEqVbRrvx4Md+DdobZPc
         fBUNIeKStLPV862QVDz/8P8HDHOjfQUyy/jvEDgKUQwEG/0WWzUqNK2F9kIJjVQLAmr/
         ZarmF5FP939R5oBFmoLwQ/CmFjVQ8pPVajBkadMwTrf+oI7r3XJGvOsFPQemLlXDbgfn
         gswt+2kODHL4uef+ntiKcVFzH1fuwpEV8NqBpO4dAlwi0XZ1Gb4jj2HjarwXqcQvq4mf
         UI6Qo/ST7qL6RbuAIr4Jig7MOpc5p2wkkAra4yKZ9i8WJJEVjg13Jd49ygOPYqJjmgvJ
         Ntww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GJpCBUAafsBhvlYNm+bc+NgVhecmY8SHcco/BAwxD/s=;
        b=JgqHajwk8bbii1LbDhT2gz3gqMYx7AaXPOaGhAJdl74WP+UYiRspvEDSPT4l8GbuDi
         tJh7dGag77itVEypp3PZW2wxLkBYBVYT0SXEpTzAH0aOecpL1EMCbJyC1+bF1pI+1iD0
         7WspOKSMym50kZyOwMysJcMxPjYUvVsqneS2jOl+5sjxgOlPaqgq3u+FrIxEAcm6qwdq
         QrLzW1TE0afLSKgaY+rbc4SGk3nYAN8a1mA3mUthKTmNK36rj1EF0h6cAeAOfmUDT0VK
         JSHomkWDSO1RzEpc3sqUEgDaF3ekw2RcIfnj+hJWfifMZiHdio7uSrD5h0eCe9LNxzYO
         jFmQ==
X-Gm-Message-State: AOAM531ZDLYwdnXb4cYyQuaA+39DnMruA6EdBK6hKT68z4gTwWMwuac5
        v1RC4BaSSqGkZXTYbHG5ogzwAk9Cw/c=
X-Google-Smtp-Source: ABdhPJyugEukh9Ztwebs9IEUeefNXslYl4uVsupUvjI3oLWttCkYpjKT54gSxTXpDl/MyEJU+X3ejQ==
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr206516wmq.107.1631048716838;
        Tue, 07 Sep 2021 14:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm108793wrh.24.2021.09.07.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:16 -0700 (PDT)
Message-Id: <6e45e90abe59395a13ae5872ab706aff173152f4.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:05 +0000
Subject: [PATCH v3 04/11] pull: remove support for `--rebase=preserve`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for `git-rebase--preserve-merges.sh` entering its after
life, we remove this (deprecated) option that would still rely on it.

To help users transition who still did not receive the memo about the
deprecation, we offer a helpful error message instead of throwing our
hands in the air and saying that we don't know that option, never heard
of it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/branch.txt        | 4 ----
 Documentation/config/pull.txt          | 4 ----
 Documentation/git-pull.txt             | 6 +-----
 builtin/pull.c                         | 9 +++------
 contrib/completion/git-completion.bash | 2 +-
 rebase.c                               | 5 +++--
 rebase.h                               | 1 -
 7 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc5..d323d7327f6 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -85,10 +85,6 @@ When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
-`--preserve-merges` along to 'git rebase' so that locally committed merge
-commits will not be flattened by running 'git pull'.
-+
 When the value is `interactive` (or just 'i'), the rebase is run in interactive
 mode.
 +
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 54048306095..9349e09261b 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -18,10 +18,6 @@ When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
-`--preserve-merges` along to 'git rebase' so that locally committed merge
-commits will not be flattened by running 'git pull'.
-+
 When the value is `interactive` (or just 'i'), the rebase is run in interactive
 mode.
 +
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7f4b2d1982e..7144690a0cb 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -102,7 +102,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|merges|preserve|interactive]::
+--rebase[=false|true|merges|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -113,10 +113,6 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When set to `preserve` (deprecated in favor of `merges`), rebase with the
-`--preserve-merges` option passed to `git rebase` so that locally created
-merge commits will not be flattened.
-+
 When false, merge the upstream branch into the current branch.
 +
 When `interactive`, enable the interactive mode of rebase.
diff --git a/builtin/pull.c b/builtin/pull.c
index 3e13f810843..bda5c32ab6f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -30,9 +30,8 @@
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "merges", returns REBASE_MERGES. If value is "preserve", returns
- * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
- * fatal is true, otherwise returns REBASE_INVALID.
+ * "merges", returns REBASE_MERGES. If value is a invalid value, dies with
+ * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
  */
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
@@ -126,7 +125,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-		"(false|true|merges|preserve|interactive)",
+		"(false|true|merges|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -883,8 +882,6 @@ static int run_rebase(const struct object_id *newbase,
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_MERGES)
 		strvec_push(&args, "--rebase-merges");
-	else if (opt_rebase == REBASE_PRESERVE)
-		strvec_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		strvec_push(&args, "--interactive");
 	if (opt_diffstat)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc87..5dab8bd579e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2543,7 +2543,7 @@ __git_complete_config_variable_value ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true merges preserve interactive" "" "$cur_"
+		__gitcomp "false true merges interactive" "" "$cur_"
 		return
 		;;
 	remote.pushdefault)
diff --git a/rebase.c b/rebase.c
index f8137d859b5..6775cddb284 100644
--- a/rebase.c
+++ b/rebase.c
@@ -1,5 +1,6 @@
 #include "rebase.h"
 #include "config.h"
+#include "gettext.h"
 
 /*
  * Parses textual value for pull.rebase, branch.<name>.rebase, etc.
@@ -20,12 +21,12 @@ enum rebase_type rebase_parse_value(const char *value)
 		return REBASE_FALSE;
 	else if (v > 0)
 		return REBASE_TRUE;
-	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
-		return REBASE_PRESERVE;
 	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
 		return REBASE_MERGES;
 	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
 		return REBASE_INTERACTIVE;
+	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
+		error(_("%s: 'preserve' superseded by 'merges'"), value);
 	/*
 	 * Please update _git_config() in git-completion.bash when you
 	 * add new rebase modes.
diff --git a/rebase.h b/rebase.h
index cc723d47489..203b4372823 100644
--- a/rebase.h
+++ b/rebase.h
@@ -5,7 +5,6 @@ enum rebase_type {
 	REBASE_INVALID = -1,
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
-	REBASE_PRESERVE,
 	REBASE_MERGES,
 	REBASE_INTERACTIVE
 };
-- 
gitgitgadget

