Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447BBC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJDNYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiJDNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AD52FFD
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b4so14349763wrs.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F4fcGOV7yo9Wz8wwYjRT6ofm5yVTX43WteKJ+ieqAo=;
        b=q6crbCdQ9wAX1b2Bp6HU0Dl0/NuQbNH4vPQMOgUj6tVFFUQcSqUtp3aEvFqFrbwVqd
         TQQOEp2f0Oiph5R6JSkDLdaZ4mnuVYJONLIPwFZnrOPndeiC2Lha4Pb/5mjgPfAS/46y
         VwI6rcGgoYwVfgTr8SmG9Cepk4tH2cEEyNPUR2IqMTDMvV63F49uEsl7X5v4bPYqMeXc
         UcbNz1ALuMTXwCwTbYgXVwtEGt8V5eRhlrgxiJXYP7NIwa8JHsIvWMAxql/R2DUmwd+U
         5F08HtmkItj25vZhURe2TA3oVVstpMeDxWMS2RKj+naOKgZXPF/T6M5/ubfSeFK0yggo
         TFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F4fcGOV7yo9Wz8wwYjRT6ofm5yVTX43WteKJ+ieqAo=;
        b=YWE6AXbV+afAwZB7pUgWiUMcuBfkcKWywTjM8QZ68ZdH4TjhWxdka6o+h3NupUhRim
         mXMMB2CmPbLNuwOSDcqUw9/HiEynY8jVoDa+AbSkT35l/Co0LiEyE7GrTAjOVYC8agcV
         ZvhKuKDcmfKCba44Ij7AqQeu7ihTG9/y2WAJINubr6r7PA5V0psU2IDPWCopr8f8NVUO
         JzlHXzva5ze0I572yAKa2D4xm4liyIEO7TTWTmJsQFnlJEXN5glLRkT9n+m6FEYzULeK
         l/s8xmUMqUz5SP/MEx6LT+OTzyGB9vIKA/o/f0YiU3IHizLg6JieGZpghyk59tJ6IXK2
         PYFg==
X-Gm-Message-State: ACrzQf102roEp9NW7kiT958vbMfFys7W1NC+ovRvb3um6goLl8B0065/
        F+coVPEy8LfwmaD+0DlsMjxQDfDQOa+FCg==
X-Google-Smtp-Source: AMsMyM6MUXKV3yuh0tMfX6IS6zZsDFikHIhWv3sU8uUZzZ4iQ+PTNJpdtbeFbC7OpJ9P9EPG7ago0g==
X-Received: by 2002:a05:6000:5ca:b0:22e:5477:1296 with SMTP id bh10-20020a05600005ca00b0022e54771296mr1597063wrb.377.1664889841424;
        Tue, 04 Oct 2022 06:24:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:00 -0700 (PDT)
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
Subject: [PATCH v4 08/34] doc txt & -h consistency: word-wrap
Date:   Tue,  4 Oct 2022 15:23:22 +0200
Message-Id: <patch-v4-08.34-1b9b6a91916-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation and -h output for those built-in commands
where both the -h output and *.txt were lacking in word-wrapping.

There are many more built-ins that could use this treatment, this
change is narrowed to those where this whitespace change is needed to
make the -h and *.txt consistent in the end.

In the case of "Documentation/git-hash-object.txt" and
"builtin/hash-object.c" this is not a "doc txt & -h consistency"
change, as we're changing both versions, doing so here makes a
subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 3 ++-
 Documentation/git-worktree.txt    | 3 ++-
 builtin/bugreport.c               | 3 ++-
 builtin/commit-graph.c            | 8 ++++----
 builtin/commit-tree.c             | 4 ++--
 builtin/diagnose.c                | 3 ++-
 builtin/hash-object.c             | 3 ++-
 builtin/init-db.c                 | 3 ++-
 builtin/interpret-trailers.c      | 4 +++-
 builtin/read-tree.c               | 4 +++-
 builtin/show-branch.c             | 3 ++-
 builtin/show-ref.c                | 4 +++-
 12 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bdb..58670ef12f7 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,8 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
+		[--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
 
 DESCRIPTION
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
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index fbae878c2b9..f7c16802f0c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -80,7 +80,8 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
-		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
+		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
+		   "                [--stdin] [--] <file>..."),
 		"git hash-object  --stdin-paths",
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

