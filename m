Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC8C43141
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2420672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzUB4xmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKWUuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40832 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKWUut (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id y5so11531134wmi.5
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=14O5gkFWCSn30rUpo+90m1gwdTJjvbY8BmMwmgF8Ipo=;
        b=IzUB4xmtTa5KTACpFqHJbBuBYimd+CU2b42seBQzTh+si+l+J0wlGrIFdgU0GYZHRA
         oMfIgjc1HcY9r5AGhAqyTj/I8S24jmPH+AjicqAZ4lim/DqAiLqZdPldDDSQrWU1FxAk
         Xkiarzqwnv/coDQww6kv3IoUpn7gPZWsoudVYN1xeUdzjDUeXWJGllrum5HSyWaZ46CQ
         7zd+ePrXmKruchQCHr0Q3DvJjrZ9UH9rUDfl4wAv5QDoEq4UVnjTnQlppv4y0QGM3SVk
         c/3KOWFyTnWduWHJIp58vlS/Z/U1+RwmcOPglXr9sTqvb4ZPp0XyUfBYkADSHx0EBic4
         deag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=14O5gkFWCSn30rUpo+90m1gwdTJjvbY8BmMwmgF8Ipo=;
        b=lZSjFgsalPFJDXa3z6GOTKw+EbI5uwpaEdYf8LbVF5wKcRRGvJcnDitDagwhM57GDd
         e88T1XZlhmKox2il7CxHK6wYLrlkrHKH+16E6InI36b7oBMbdHgp9XqmAyWWY9Q1sjPv
         D8W4G8HwVsVhBUka8Ep4FD0eNcKhh58hbL1Qhqs1nFj/1a/1sdv+nv4itTUDYlofrFaK
         tY/TiHMfVoW7jFTp1x6ARzCylOXW2q9puK4izu8RcVnl7yom1D+nKKA8fmI9zGez+iWs
         G7cW20fqsfpKMN6Us1VtjrRwjKJnC2Pir7NWUveQUPBSKxRMn4hzsA8/zM8OHpcvf0IL
         l0jg==
X-Gm-Message-State: APjAAAWGqV71fY+S09iX/arFNEG11KMrvC7lS1lCGM8xC/rVLAeJMwSs
        w6tUfKFeijvxxDF302umD46vQvOh
X-Google-Smtp-Source: APXvYqw6RW1vV2v2PtMEzRoT5UUkS4PNabx915R1Y7TB4hR7gI9dpE3D+JeF3fQ9/g4fpjz7FVNYnA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr21481043wmj.32.1574542247085;
        Sat, 23 Nov 2019 12:50:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c193sm3163107wma.8.2019.11.23.12.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:46 -0800 (PST)
Message-Id: <0c8bfe5d18da5c8c5b3d63270aac3f93e793c69c.1574542243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:38 +0000
Subject: [PATCH 4/8] pull: remove support for `--rebase=preserve`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for `git-rebase--preserve-merges.sh` entering its after
life, we remove this (deprecated) option that would still rely on it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/branch.txt        |  4 ----
 Documentation/config/pull.txt          |  4 ----
 Documentation/git-pull.txt             |  6 +-----
 builtin/pull.c                         | 12 +++---------
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index a592d522a7..e9986ddd09 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -85,10 +85,6 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (deprecated in favor of `merges`), also pass
-`--preserve-merges` along to 'git rebase' so that locally committed merge
-commits will not be flattened by running 'git pull'.
-+
 When the value is `interactive`, the rebase is run in interactive mode.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index b87cab31b3..9f2dea0b34 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -18,10 +18,6 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (deprecated in favor of `merges`), also pass
-`--preserve-merges` along to 'git rebase' so that locally committed merge
-commits will not be flattened by running 'git pull'.
-+
 When the value is `interactive`, the rebase is run in interactive mode.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b8..edda860a9a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,7 +101,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|merges|preserve|interactive]::
+--rebase[=false|true|merges|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -112,10 +112,6 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When set to `preserve` (deprecated in favor of `merges`), rebase with the
-`--preserve-merges` option passed to `git rebase` so that locally created
-merge commits will not be flattened.
-+
 When false, merge the current branch into the upstream branch.
 +
 When `interactive`, enable the interactive mode of rebase.
diff --git a/builtin/pull.c b/builtin/pull.c
index d25ff13a60..6c4d91d580 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -30,7 +30,6 @@ enum rebase_type {
 	REBASE_INVALID = -1,
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
-	REBASE_PRESERVE,
 	REBASE_MERGES,
 	REBASE_INTERACTIVE
 };
@@ -38,9 +37,8 @@ enum rebase_type {
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
@@ -51,8 +49,6 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_FALSE;
 	else if (v > 0)
 		return REBASE_TRUE;
-	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
-		return REBASE_PRESERVE;
 	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
 		return REBASE_MERGES;
 	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
@@ -145,7 +141,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "(false|true|merges|preserve|interactive)",
+	  "(false|true|merges|interactive)",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -848,8 +844,6 @@ static int run_rebase(const struct object_id *curr_head,
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_MERGES)
 		argv_array_push(&args, "--rebase-merges");
-	else if (opt_rebase == REBASE_PRESERVE)
-		argv_array_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		argv_array_push(&args, "--interactive");
 	if (opt_diffstat)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..5b37734ef1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2276,7 +2276,7 @@ __git_complete_config_variable_value ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true merges preserve interactive" "" "$cur_"
+		__gitcomp "false true merges interactive" "" "$cur_"
 		return
 		;;
 	remote.pushdefault)
-- 
gitgitgadget

