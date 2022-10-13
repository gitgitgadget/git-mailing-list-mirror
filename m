Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3646C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJMPlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJMPkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39B42AEA
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so3415694wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpOkJi50ZkEpFRAv0I7XDMaWIja69OjYn6HuTpDPQAw=;
        b=dDJawPn5prM6fg4NwUpzZ1nxtKcFosCB/5mhgZH1SPZ1eTZ0i0OnZv+Q9qVkHlOCSp
         4Dq8qq5NMGnqnK0Xg3tEohWBEFDYIz8ZijxSB+23bkm4t6Q+xZXzdn60NKGO7e6pwsCQ
         DMxMqmn3N6SHsfUz94h6738++3nxvZJqO2X4ZcXolwP7Znnxx5/alqn9A6V2uXuOLMV9
         hZnw1hE0OaMEFv2lHZPswaRZ2JDJnmzs0YtD7QZ93cd9256gNBMZ4r3jDC85l+1GnT2/
         o+OBDCbValJNuXb7laxEeHR6NwW6kQkSeMMjwNFfMMTnjwBi7KAg5NcPsP+/OAVSkzUP
         4JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpOkJi50ZkEpFRAv0I7XDMaWIja69OjYn6HuTpDPQAw=;
        b=NK3yDHQVeba55X1WblCG2wZ4/9rjtubkcyUoofUtzgLlQLTjvcaao1G8civSGZXaH3
         RPP2MNzB/G0qC1kvzXvyMSxIYXpswC/WqGiVFngIqTb5wp/VZdC5STN4Hm4bb+/g5R/w
         ttMQbBBcMpuPegB9MC+fR8Umr4Gh7+GaEKrdtJz/pokegwZYTN6+yMYKr84KYf6BOpBL
         zoWCnHAs7VSVBjeT/LOCd0E8U30vcCk0yDxDaUQn/WCL6K1A6vhCOxrUucGZ4rL3qhnP
         sS4jfQdMzBFNIG0UOmL6yhceRV8OwE+qZtOVYyg9RBRLky0HPtFqnV2rBmbubSs7Si0n
         D19w==
X-Gm-Message-State: ACrzQf1pJaEUI9M+rho73T8nYcBWg8SKmf9rwXSs7t6aUwOoX33sydSw
        ONLSXCWORytWuIs37x6RLd5GNyavzye4Yg==
X-Google-Smtp-Source: AMsMyM6QbN5SnXFZ20dEDZfQrqgzMyhmRAxDnUmGRTAAjUOAtL9JJ9XFYNojh/kNdYkQ0FOr0w9AZQ==
X-Received: by 2002:a05:6000:1e14:b0:22e:6224:1e78 with SMTP id bj20-20020a0560001e1400b0022e62241e78mr433542wrb.56.1665675599993;
        Thu, 13 Oct 2022 08:39:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:59 -0700 (PDT)
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
Subject: [PATCH v5 24/34] doc txt & -h consistency: add missing options
Date:   Thu, 13 Oct 2022 17:39:18 +0200
Message-Id: <patch-v5-24.34-bacce14d438-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those built-in commands that were attempting to exhaustively
list the options in the "-h" output to actually do so, and always
have *.txt documentation know about the exhaustive list of options.

Let's also fix the documentation and -h output for those built-in
commands where the *.txt and -h output was a mismatch of missing
options on both sides.

In the case of "interpret-trailers" fixing the missing options reveals
that the *.txt version was implicitly claiming that the command had
two operating modes, which a look at the -h version (and studying the
documentation) will show is not the case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit-graph.txt       | 5 ++++-
 Documentation/git-interpret-trailers.txt | 5 +++--
 builtin/commit-tree.c                    | 1 +
 builtin/fsck.c                           | 5 ++++-
 builtin/hash-object.c                    | 4 ++--
 builtin/init-db.c                        | 2 ++
 builtin/interpret-trailers.c             | 2 +-
 builtin/rm.c                             | 4 +++-
 8 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 36fe56c2c71..c8dbceba014 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,7 +10,10 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
-'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
+'git commit-graph write' [--object-dir <dir>] [--append]
+			[--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]
+			[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
+			<split options>
 
 
 DESCRIPTION
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 6d6197cd0a4..22ff3a603e0 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -8,8 +8,9 @@ git-interpret-trailers - Add or parse structured information in commit messages
 SYNOPSIS
 --------
 [verse]
-'git interpret-trailers' [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
-'git interpret-trailers' [<options>] [--parse] [<file>...]
+'git interpret-trailers' [--in-place] [--trim-empty]
+			[(--trailer <token>[(=|:)<value>])...]
+			[--parse] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index e4b85d29d56..cc8d584be2f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 
 static const char * const commit_tree_usage[] = {
+	N_("git commit-tree <tree> [(-p <parent>)...]"),
 	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]\n"
 	   "                [(-F <file>)...] <tree>"),
 	NULL
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 41acbc229e4..7436e1a68ef 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -820,7 +820,10 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 }
 
 static char const * const fsck_usage[] = {
-	N_("git fsck [<options>] [<object>...]"),
+	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
+	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
+	   "         [--[no-]dangling] [--[no-]progress] [--connectivity-only]\n"
+	   "         [--[no-]name-objects] [<object>...]"),
 	NULL
 };
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index f7c16802f0c..b5063815020 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -81,8 +81,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
-		   "                [--stdin] [--] <file>..."),
-		"git hash-object  --stdin-paths",
+		   "                [--stdin [--literally]] [--] <file>..."),
+		N_("git hash-object [-t <type>] [-w] --stdin-paths [--no-filters]"),
 		NULL
 	};
 	const char *type = blob_type;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 08ba006d55e..dcaaf102eaf 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -516,6 +516,8 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 
 static const char *const init_db_usage[] = {
 	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
+	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
+	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
 	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
 };
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 4cf0cf265dc..e58627c72a9 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -15,7 +15,7 @@
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
 	   "                       [(--trailer <token>[(=|:)<value>])...]\n"
-	   "                       [<file>...]"),
+	   "                       [--parse] [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/rm.c b/builtin/rm.c
index b6ba859fe42..f0d025a4e23 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -17,7 +17,9 @@
 #include "pathspec.h"
 
 static const char * const builtin_rm_usage[] = {
-	N_("git rm [<options>] [--] <file>..."),
+	N_("git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]\n"
+	   "       [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "       [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.1085.gb7e61c3016c

