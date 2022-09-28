Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B69C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiI1Ilk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiI1IkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C24456F
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay36so8079789wmb.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OzcVrCVWRNHXd88dUB1FARHe7D4lQQBbEHCKsB51pXc=;
        b=AkxJSN+wGog9jc8NzoSDgPnrDhNnuHURTbfXBAXreYolWxZfw5UHoHSZQyncURZm1d
         5Toe9FaQgdXFWelsEd9Bvp7Jnh7js+AQ77Hh7L31KDbpmSgq4CUt3wWEx5v4b6FhRHw8
         +xz7kMp0kql/yVkwL2uAUAB76BEx+dttnugwrAtRd4OSfKXU3FpX4WLGfLnp4DFvnU9b
         6KSBOl/k8jqyIXpeZUijg12mF1mCcSHhVf7mgo+/RvMDfkZpWzPhYlM1Czdk2Y3SNCD9
         uLg5esc6eoy3TMXx4liEsqP4YcrrIvofPUp+p3HzT7tucM14KEAj1zxUYJC1zjfzCNT+
         YzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OzcVrCVWRNHXd88dUB1FARHe7D4lQQBbEHCKsB51pXc=;
        b=vxdS6lM32swUtLGvRYMssbbbu55qR4r5D/ivxxkD+2samRwXHuFvO0NmJd7vLDh0cK
         pLKmw+ui50JuXNhHz8iEmScFybk1Hw6JMecesxA8sF+QW/GXHRSa5/UqlesdQb7im4IC
         5u410nQODuC2iAYfkRwLok3uAhaf/9nAMDdDAxYCyZRQe5ZuGA0q2KSFxuE9uSaTRPM/
         ErKdVLPQnAa8fQe5O+PDZd+M8CsIpwbtg7ireewQfkHPrystpsyPGC7o8dLcvXb0gSJ8
         V9TWfS6xdHSQRS3ZqjE5aZxY14xE3HD8DrJvcuI2aTUv6xfyk24pCIDFuLTB5RU5uLnb
         LXIQ==
X-Gm-Message-State: ACrzQf0uYJsrO8OlqJVOEGAtmG4ThRkaWOq8CyzgMxQQSS7MiMzH1K6q
        rrjSvSe1XSyEhsMQSNv+EeqzqwSbua4khg==
X-Google-Smtp-Source: AMsMyM7GVYkIHwn98gYsY8ownVBlDT6M31GxQP5X39stXjhUYZIMtS0YG4GTOciG9Y34N23w65rxyA==
X-Received: by 2002:a05:600c:1d83:b0:3b4:c0db:8683 with SMTP id p3-20020a05600c1d8300b003b4c0db8683mr5825774wms.102.1664354402531;
        Wed, 28 Sep 2022 01:40:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 25/35] doc txt & -h consistency: add missing options
Date:   Wed, 28 Sep 2022 10:39:20 +0200
Message-Id: <patch-v2-25.35-a4d75ea691c-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those built-in commands that were attempting to exhaustively
the options in the "-h" output to actually do so, and always
have *.txt documentation know about the exhaustive list of options.

Let's also fix the documentation and -h output for those built-in
commands where the *.txt and -h output was a mismatch of missing
options on both sides.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit-graph.txt       | 5 ++++-
 Documentation/git-interpret-trailers.txt | 5 +++--
 builtin/commit-tree.c                    | 1 +
 builtin/fsck.c                           | 5 ++++-
 builtin/hash-object.c                    | 5 +++--
 builtin/init-db.c                        | 2 ++
 builtin/interpret-trailers.c             | 2 +-
 builtin/rm.c                             | 4 +++-
 8 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 36fe56c2c71..82175ae62a1 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,7 +10,10 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
-'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
+'git commit-graph write' [--object-dir <dir>] [--append]
+			[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]
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
index fbae878c2b9..11c3dfe0441 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -80,8 +80,9 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
-		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
-		"git hash-object  --stdin-paths",
+		N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters]\n"
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
2.38.0.rc1.925.gb61c5ccd7da

