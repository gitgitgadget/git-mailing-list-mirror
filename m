Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18286C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJDNZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJDNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57752DD7
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu30so1421766wrb.8
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm2PUQAUtcYD7IeMAkl43mdCM2aa93A2uhqW4Sw/Lp0=;
        b=hUFUYOCMelV/zCqIC+xp+8QqVRquibhDJbx+THvAEMM3+YJScH+cwiQEOZXkktMgOh
         YwC43jaclFWAA+Jw8qNUoYA1/jGagQoq5R4N16dekgWiv31GkxztCuPU2rPX2VQh+1C2
         tOEcl4s//XErLbTWZA3QoHyhkU+Yvm/4XheR6zAkE5B5dbbKsBUXlHj/Z056deuEC925
         y3RYlwSMzb+GvtlcZzfuE/6d9VD7GD7LHDC87NLoqgLFF8ROuZWarjPGsTRUAayka4vP
         Qfm6jEjaZAc9FnUSiPSJKJNJa5tIYxubQVahlpPXsYE5WMO4u4ABontWl6EYfYsFhRv1
         o3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm2PUQAUtcYD7IeMAkl43mdCM2aa93A2uhqW4Sw/Lp0=;
        b=hVCVsrqnArcnZTP+eLE9p90flGa9gse7sa082OBk3zgLZwx29Ulu3JOibTetww1Fem
         AMr9goZSwFE1M7c/b/48aP9BH60qlF8gk0tZHeHzQtGS2lpNEG/AQlnn3nN1AjRsHt5u
         UvFJfMUzX/CqPZ4oJr1yUM9f/BeJ/pcZ8vZkRZlr+9WhrddY2CQg2WAGWvlES7xSTmh1
         gwkxJcedYJSka7IDb7L59Ld1tobO14GGLfSs6wooI/65Tuk2UrU4vyiEi38OmhuLSTi9
         4AuLa/LT0QTXGBfM3cnYANmNrgRZVHr/Gik8NLN+99J2AIdy1vjNC+7PSO2dmMArsx3+
         ah5w==
X-Gm-Message-State: ACrzQf0A9KHPEshFNUf1VTuR8Tz4o9Q3K3xH6XkdlzS2gJ3XQWy1/bbq
        ab2UjMUqaT5oKPbc6HVuKdR3+oLXxTp4XA==
X-Google-Smtp-Source: AMsMyM4AYBudnJTetmsjbPfWMdGi7Sd0rFXaYKOU//hC+iq+YrAP4tZ7YWXctiyVwfEHrVaghqG2Bw==
X-Received: by 2002:adf:e8cb:0:b0:22c:d929:e82d with SMTP id k11-20020adfe8cb000000b0022cd929e82dmr15573189wrn.224.1664889861614;
        Tue, 04 Oct 2022 06:24:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:20 -0700 (PDT)
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
Subject: [PATCH v4 24/34] doc txt & -h consistency: add missing options
Date:   Tue,  4 Oct 2022 15:23:38 +0200
Message-Id: <patch-v4-24.34-430d40d3083-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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
index f7916f06ed5..ef273321d0b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -821,7 +821,10 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
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
2.38.0.rc2.935.g6b421ae1592

