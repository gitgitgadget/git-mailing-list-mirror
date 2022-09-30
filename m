Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A367C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiI3SJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiI3SIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4AB1E556C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso5510882wma.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nNkbx6SCXYob+OedXg3auSylqKuVFK0mjbasjF8pVuY=;
        b=OUZqyRLY6Kl+gK8hTSJR1g8Gsz23x5NKPN4J2V9qS3OeE8nUyw9zZpZ+sPRTb8twyO
         tMqahjx2rAReyxMrYyOWnMr4dileSyN53jo7mIrsfmAZlqVG4X15op6fyNaKkNodnOlt
         aPvdBvEZ0oR9QT3fW98i3scrq4NKQOhffDxCK1v2Rpe8oYZlBd8e46v0mlkidxX5aJJA
         TZUx70G1JNRE/nTIxRXlZOypB+WK//DygV1OQ3nwNqkj6/0JB5k56fZTgf2bbxpON/rU
         Z8nlCDbu6id+CFLWBAon1VVJoykoL9CkNu/VBVzbpy5MWSwKV8Xz9NxtOKtXgNqQNRsZ
         aPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nNkbx6SCXYob+OedXg3auSylqKuVFK0mjbasjF8pVuY=;
        b=foAbvI7qd/EMPiiEP2BNRaS7Or99muATZzz91sM+IC3POEI2LOP65meE4HEn5SvcDx
         VPCLziQvSjhDgdWpmGowStBRYDbi0r6NEXbxr/YBRQwNiPu7srju6wLROPHY4UXg7g/f
         iUT8+H8Nd6VdrzuNkshy0f/Kf6hXWI4WqsSNp1ijevY0SLNPaXhMpiela5lZu1OhECVC
         90w4MYK6es9zDuS+0L/q9K8zW9qkle44uwlUgQatYonKZhl98pd5ly/eUGH2DhHJrahg
         ajac+xg6mXXucgxomUgKSylTBTQ8sDZmlZG01NLVOHAXxcB1Zv8vSpl3l6KMZM5DZPdk
         AXIw==
X-Gm-Message-State: ACrzQf2p4OYtbPS7q7ZRfZlz+t5iuaCzMpMw9rJLM6zeaOpK3Aa8UULC
        fWeEwr8WDVNC7/VqyeidhJ217rgmxXGA7Q==
X-Google-Smtp-Source: AMsMyM7xccPtVnbw2UXn1+kfX/JiaUAfktiiAc5BrSvxKv7a9cHyqKZaaI6gy8k6YmSOlriOthirYQ==
X-Received: by 2002:a05:600c:4f53:b0:3b4:9aad:7845 with SMTP id m19-20020a05600c4f5300b003b49aad7845mr6681981wmq.159.1664561322508;
        Fri, 30 Sep 2022 11:08:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:37 -0700 (PDT)
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
Subject: [PATCH v3 10/36] doc txt & -h consistency: word-wrap
Date:   Fri, 30 Sep 2022 20:07:33 +0200
Message-Id: <patch-v3-10.36-1a02f7c76cd-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation and -h output for those built-in commands
where the *.txt and -h output didn't match as far as word-wrapping was
concerned.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-worktree.txt | 3 ++-
 builtin/bugreport.c            | 3 ++-
 builtin/commit-graph.c         | 8 ++++----
 builtin/commit-tree.c          | 4 ++--
 builtin/diagnose.c             | 3 ++-
 builtin/init-db.c              | 3 ++-
 builtin/interpret-trailers.c   | 4 +++-
 builtin/read-tree.c            | 4 +++-
 builtin/show-branch.c          | 3 ++-
 builtin/show-ref.c             | 4 +++-
 10 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index ada30c86a7c..063d6eeb99d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,8 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+		   [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 530895be55f..faa268f3cfb 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	   "              [--diagnose[=<mode>]"),
 	NULL
 };
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51557fe786e..cd346f95f08 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -13,10 +13,10 @@
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
 
 #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
-	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
-	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
-	   "<split options>")
+	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
+	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
+	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
+	   "                       <split options>")
 
 static const char * builtin_commit_graph_verify_usage[] = {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 63ea3229333..e4b85d29d56 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -15,8 +15,8 @@
 #include "parse-options.h"
 
 static const char * const commit_tree_usage[] = {
-	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
-		"[(-F <file>)...] <tree>"),
+	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]\n"
+	   "                [(-F <file>)...] <tree>"),
 	NULL
 };
 
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 576e0e8e385..28c394a62a5 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,8 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>] [--mode=<mode>]"),
+	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	   "             [--mode=<mode>]"),
 	NULL
 };
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 546f9c595e7..08ba006d55e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,7 +515,8 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]"),
+	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
+	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
 };
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 84748eafc01..4cf0cf265dc 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -13,7 +13,9 @@
 #include "config.h"
 
 static const char * const git_interpret_trailers_usage[] = {
-	N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
+	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
+	   "                       [(--trailer <token>[(=|:)<value>])...]\n"
+	   "                       [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9f1f33e9546..b3a389e1b1f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -38,7 +38,9 @@ static int list_tree(struct object_id *oid)
 }
 
 static const char * const read_tree_usage[] = {
-	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
+	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d3f5715e3e3..c013abaf942 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -14,7 +14,8 @@ static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
        "                [--current] [--color[=<when>] | --no-color] [--sparse]\n"
        "                [--more=<n> | --list | --independent | --merge-base]\n"
-       "                [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+       "                [--no-name | --sha1-name] [--topics]\n"
+       "                [(<rev> | <glob>)...]"),
     N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 48569061087..3af6a53ee97 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -9,7 +9,9 @@
 #include "parse-options.h"
 
 static const char * const show_ref_usage[] = {
-	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
+	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]\n"
+	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]\n"
+	   "             [--heads] [--] [<pattern>...]"),
 	N_("git show-ref --exclude-existing[=<pattern>]"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

