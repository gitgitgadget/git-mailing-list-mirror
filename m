Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75240C43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKDN0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKDN0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:26:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238882FFD4
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v17so7578580edc.8
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBdzku4GFWxQbPQypBERtBhAwYhsuMn/S4bKV0ZkDWs=;
        b=BZPnCpS54MTUhiyQnU/jxyI2D6bJ2BMYwot0F40gUOfMk/eRjPPoOslunY3P9nYct7
         B7nK5qXOfccSmawWYOuDCn4QccqKNmb6ejbZ3ODS/4/SbV/LUbhkjsq68+oPetIc65Z0
         sdpEpjB1QuKU9oHVFHKi25b41kk8JXm3VlJ4Px3oY6GMcrJQi5Iir5shN1i2s2avoab2
         VkovPaPFVGEOFMJiBMp4RyFQR3J85vd+lleX/pp8mdTThs2R42Qpl9mUOQlLilztWeaH
         ncdadtydQRj4wcym+VBEItLgNqeb6Mm3FxJlcP1E/K345MVKf12n5uTJjV/5EWPhWzUS
         vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBdzku4GFWxQbPQypBERtBhAwYhsuMn/S4bKV0ZkDWs=;
        b=sxtlwqTjmjiMojiQNYDSzLbw+0UE29n70VZIHpRq86cFCUYcju6XaPV38TAlgxjXri
         YlkGlIWAk0gpU4te7D6RSGOlL+3oUYu0iq7z/5HMBkuGkIdc2N/DOIO9rFHrHwhii4I/
         X3lErw/7I9LDhocpCBymHugZzlXBKMAiKlDbKtX4l0IQFtW8VSdB6L6l40d8lBnAl1UN
         PFKFmx4otIsLkS/HTiZaxViy+laXMfqj3PbsR7NTYQR7FRbfea+RUmvMakOfU0ujK51b
         sAutt2VUMW5Y48XtGjq4tDacypoSOkSrR5gZeypM+wQkczo55CBokL4t6PGzmEF7yAXd
         Fwpg==
X-Gm-Message-State: ACrzQf3DQ84doXW+HvCWkIbYFMsZOUC6X5czLjMGcqXy1oudTEZ/lc0L
        6argEqLLa+5EQNfHJHl4UiQIvlEZdOLfSg==
X-Google-Smtp-Source: AMsMyM6cNrqLCSouHHono9MA+nchOrjNPIsFWLlZuwSrn3caflxi8U5QldrVvHOpCOggI4De4/WbrA==
X-Received: by 2002:aa7:dd57:0:b0:453:2d35:70bb with SMTP id o23-20020aa7dd57000000b004532d3570bbmr36112939edw.26.1667568305190;
        Fri, 04 Nov 2022 06:25:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 13/13] Turn `git bisect` into a full built-in
Date:   Fri,  4 Nov 2022 14:22:50 +0100
Message-Id: <patch-13.13-37bed06ec4e-20221104T132118Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                               |  3 +-
 builtin.h                              |  2 +-
 builtin/{bisect--helper.c => bisect.c} |  5 +-
 git-bisect.sh                          | 69 --------------------------
 git.c                                  |  2 +-
 5 files changed, 4 insertions(+), 77 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)
 delete mode 100755 git-bisect.sh

diff --git a/Makefile b/Makefile
index 4927379184c..78785c6b843 100644
--- a/Makefile
+++ b/Makefile
@@ -627,7 +627,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1137,7 +1136,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 8901a34d6bf..aa955466b4e 100644
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
index c92197b0ea5..9d66da2148b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1325,7 +1325,7 @@ static int pick_subcommand_cb(const struct option *option,
 	return 0;
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	bisect_fn *fn = NULL;
 	int res = 0;
@@ -1370,9 +1370,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} else if (fn == bisect_state) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-	} else if (fn == bisect_log) {
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
 	} else if (fn == bisect_replay) {
 		if (argc != 1)
 			return error(_("no logfile given"));
diff --git a/git-bisect.sh b/git-bisect.sh
deleted file mode 100755
index c6e12f60f83..00000000000
--- a/git-bisect.sh
+++ /dev/null
@@ -1,69 +0,0 @@
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
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	start)
-		git bisect--helper start "$@" ;;
-	skip)
-		git bisect--helper skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper visualize "$@" || exit;;
-	reset)
-		git bisect--helper reset "$@" ;;
-	replay)
-		git bisect--helper replay "$@" || exit;;
-	log)
-		git bisect--helper log || exit ;;
-	run)
-		git bisect--helper run "$@" || exit;;
-	terms)
-		git bisect--helper terms "$@" || exit;;
-	*)
-		git bisect--helper "$cmd" "$@" ;;
-	esac
-esac
diff --git a/git.c b/git.c
index ee7758dcb0e..f18a5750313 100644
--- a/git.c
+++ b/git.c
@@ -492,7 +492,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
2.38.0.1452.g710f45c7951

