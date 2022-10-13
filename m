Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B89C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMPkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJMPjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF8F024
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so3467715wrr.3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iLcWE1FXj/YoP58KEiL9XBFUXmpuDBITEyc5YcrCgs=;
        b=GjT4YynhlQ4Ll4ho2IP+u+W7WUJFC9UaYt7zDj21em7VoYqixBT56QK3pplF5W2tio
         oRoigAX50kY16Fu+INuJvzxSh09CsqqDb13iV67Fd4HAs//CejuYQXgh029O+MVWXRFy
         RSbScm7bHEHI6Jowv2Zr2orJ1jpeD1Lx8ppag9k82Zd6IqDX3146XzdhtO7q+HlUAO/2
         gGGpHAx3igD1qTRrwGvRdRGFG2nf/12vgAM48UtpRiV5iV3hPrsgg4VUgQpgnB7WZzrZ
         JucW18IyR/fgDCSEKZFtLHOVzsL5yN9lkuVbFGWkeAZgBT9ED19qI7yV8iEsSuGgvo6t
         mFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iLcWE1FXj/YoP58KEiL9XBFUXmpuDBITEyc5YcrCgs=;
        b=kWtk3f6uaexIP+Zemx2InNHsfHpq/LIw3vE7EG+WKiWyzs04e68sNhbkiARoM8/QpA
         8142tsdjwxK6zJOXWgUgnCpNh9al6yx+tfwEB7+CQb9Syt4gpyt1okFGEDPh9lsovLmu
         fG5UmQ/LTt+ueOnHCjbLF2s4Z5nIna9dChWnHyzrOZP2yOwJf950PHJAaefIEUSbWMe7
         2qFY7rZhzvcc2PXWPu88t6esHlkuVBFxU2gCeKvCZoPfHWPr9Md2Peo9MkK5cLsgJlY8
         Ricp2Q6nqemdUthm+BamNuV91ux3QnOrjSxsvyHyuIw7NMcDM5UeqP7KHtiUXVaHGovE
         Oo/g==
X-Gm-Message-State: ACrzQf15b3fG5an5kRToVmPDjUkiRkci7pOv4QWDvCw7uXnSxvB827lZ
        t/Yd0Ua3Dbx1Pkzn5TrN0IqbmDbJGwz9NQ==
X-Google-Smtp-Source: AMsMyM7aeKx6ebai1AW7STo3/p0tO082N4pbYoQybHlyylEjRT35aiUJFsQSRM7ZFG3M3ilv7Rh1UQ==
X-Received: by 2002:a05:6000:1787:b0:231:9b3f:ce98 with SMTP id e7-20020a056000178700b002319b3fce98mr394743wrg.253.1665675583270;
        Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/34] doc txt & -h consistency: fix incorrect alternates syntax
Date:   Thu, 13 Oct 2022 17:39:03 +0200
Message-Id: <patch-v5-09.34-d878b1fd91d-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This syntax issue for "bugreport" originated in
238b439d698 (bugreport: add tool to generate debugging info,
2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
"bugreport" documentation and code.

In the case of "Documentation/git-stash.txt" and "builtin/stash.c"
this is not a "doc txt & -h consistency" change, as we're changing
both versions, doing so here makes a subsequent change smaller.

In that case fix the incorrect "[-o | --option <argument>]" syntax,
which should be "[(-o | --option) <argument>]", we were previously
claiming that only the long option accepted the "<argument>", which
isn't what we meant.

The "stash" issue has been with us in both the "-h" and *.txt versions
since bd514cada4b (stash: introduce 'git stash store', 2013-06-15).

We could claim that this isn't a syntax issue if a "vertical bar binds
tighter than option and its argument", but such a rule would change
e.g. this "cat-file" SYNOPSIS example to mean something we don't:

	... [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]

We have various other examples where the post-image here is already
used, e.g. for "format-patch" ("-o"), "grep" ("-m"),
"submodule" ("set-branch -b") etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 builtin/bugreport.c         | 2 +-
 builtin/diagnose.c          | 2 +-
 builtin/stash.c             | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c5d70918283..4856f452511 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,12 +14,12 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
+	     [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
+'git stash' store [(-m|--message) <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
 -----------
@@ -47,7 +47,7 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 COMMANDS
 --------
 
-push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
+push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [(-m|--message) <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index faa268f3cfb..23170113cc8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]"),
 	NULL
 };
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 28c394a62a5..474de9ec647 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
diff --git a/builtin/stash.c b/builtin/stash.c
index 2274aae2556..51d40efaac7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -29,7 +29,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
 	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
@@ -73,13 +73,13 @@ static const char * const git_stash_clear_usage[] = {
 };
 
 static const char * const git_stash_store_usage[] = {
-	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
+	N_("git stash store [(-m|--message) <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
 static const char * const git_stash_push_usage[] = {
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
-- 
2.38.0.1085.gb7e61c3016c

