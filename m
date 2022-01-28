Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960CC4332F
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiA1AMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiA1AMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB268C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so2898276wms.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mdwYbmfpxXxQWqIxnJnhMQt2vU29GH/o224FSkBRs0w=;
        b=ISWeK6N52PhQ2NPqV0iJwc0dyJWu1PdTih/2YM9HZM3gzQWsGBCTLB9XeuvcpRLtW4
         ucJ1NAsnNbcOJMJM04kChBiwIbZxjP7w1rMKJN7IyFbrnVN8tKMKaA1wxyIYBrTgtlfk
         962D3tCipEsd9nj+tTZStmlvahs+WAi/9Z5opQHP2+PtAg4bnvibHus2nDcNW89ZErzK
         BFiKJb2Dv0fD3i3YoRVh+T9x7neHuqABXjpT3OuevmfVyerUUyhv62x02Sd5/5f3+pPo
         T2hXkKZy+JGZuTZAfLHrRNCiA/vLAOUAfnAHyFY8O7SNUGPbZ0Cpgskze7vCbJpALhya
         XfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mdwYbmfpxXxQWqIxnJnhMQt2vU29GH/o224FSkBRs0w=;
        b=p29SV481j47/w8KdhDBTIFx/SMaMmoBW2MWFTEFB3wde3wVqPK3ZWiLofsr0NHVlJq
         8aUrYztVvIbAJuBTCkUwRcJpuRmu1jrr+5I9doOQOxftKSAJAxkDrJHGg2nj4vWTy2OM
         TTeyIycV11u50uWXp6tys1xcXWeNwiEaXUZXgtVlB6MLpbYGmQBRDjXWXofhF3fi/wTM
         RdNzKx6TY1l5NvXygWNURdAx6YTjJMxloIPC5623W8NeHNUTkjC71mft0RaJoJJvIrwV
         abX9UvGqLzhpS3N9glxGOOFoRGFhoJK6ltYq4+GqEnbCfRY4vbRnxNmUYzor6sfXqI+w
         8XgQ==
X-Gm-Message-State: AOAM530cWf+BalN5hjAtEXEtVzWn0ntvFDwEo8o7pnQZQ37Qn/7zyf4r
        L6d1aLodh2p3gIYD00JDMDpiaePitLw=
X-Google-Smtp-Source: ABdhPJxV/Jt+7JMTQm42jsWSYAW+ehMI7cGX5vWaeCc5rpnzSaxmF4bjOsNhsFc5erK6PEZQm4PZyQ==
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr5251653wmq.106.1643328760328;
        Thu, 27 Jan 2022 16:12:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm672316wmg.36.2022.01.27.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:39 -0800 (PST)
Message-Id: <1c0bd8a326f482d1a6c485b7f93f510268dade20.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:30 +0000
Subject: [PATCH 09/11] Turn `git bisect` into a full built-in.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the shell script hands off to the `bisect--helper` to do
_anything_ (except to show the help), it is but a tiny step to let the
helper implement the actual `git bisect` command instead.

This retires `git-bisect.sh`, concluding a multi-year journey that many
hands helped with, in particular Pranit Bauna, Tanushree Tumane and
Miriam Rubio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                               |  3 +--
 builtin.h                              |  2 +-
 builtin/{bisect--helper.c => bisect.c} |  2 +-
 git-bisect.sh                          | 37 --------------------------
 git.c                                  |  2 +-
 5 files changed, 4 insertions(+), 42 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)
 delete mode 100755 git-bisect.sh

diff --git a/Makefile b/Makefile
index 5580859afdb..ce2eabeca58 100644
--- a/Makefile
+++ b/Makefile
@@ -595,7 +595,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1064,7 +1063,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed63..b5567ea3a9d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
similarity index 99%
rename from builtin/bisect--helper.c
rename to builtin/bisect.c
index 009c919a989..189aca9dd22 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1182,7 +1182,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	}
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
 	struct option options[] = {
diff --git a/git-bisect.sh b/git-bisect.sh
deleted file mode 100755
index 028d39cd9ce..00000000000
--- a/git-bisect.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
-LONG_USAGE='git bisect help
-	print this long help message.
-git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
-git bisect (bad|new) [<rev>]
-	mark <rev> a known-bad revision/
-		a revision after change in a given property.
-git bisect (good|old) [<rev>...]
-	mark <rev>... known-good revisions/
-		revisions before change in a given property.
-git bisect terms [--term-good | --term-bad]
-	show the terms used for old and new commits (default: bad, good)
-git bisect skip [(<rev>|<range>)...]
-	mark <rev>... untestable revisions.
-git bisect next
-	find next bisection to test and check it out.
-git bisect reset [<commit>]
-	finish bisection search and go back to commit.
-git bisect (visualize|view)
-	show bisect status in gitk.
-git bisect replay <logfile>
-	replay bisection log.
-git bisect log
-	show bisect log.
-git bisect run <cmd>...
-	use <cmd>... to automatically bisect.
-
-Please use "git help bisect" to get the full man page.'
-
-OPTIONS_SPEC=
-. git-sh-setup
-
-exec git bisect--helper "$@"
diff --git a/git.c b/git.c
index edda922ce6d..a8500132a28 100644
--- a/git.c
+++ b/git.c
@@ -490,7 +490,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
gitgitgadget

