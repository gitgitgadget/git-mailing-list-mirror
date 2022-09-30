Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293AFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiI3SLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiI3SKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F12FD3D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b4so1034599wrs.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xm2PUQAUtcYD7IeMAkl43mdCM2aa93A2uhqW4Sw/Lp0=;
        b=ey0pBFJ5p2Pm8KCFl5UDKjFYs7r6Nav0u+FY1WaVqyyXQLk6cMiPmyxIyLeSFGoQWH
         fMTvcd09rpmO3kh78GdIdRlgRhFamWJ8QDsfEg6NqP8rmkf289meg7A3o+kCCPBwSxJ3
         FDFyyZlHRVzRby8KKb0SCFpO0cluHdpfnH+O8u3ZIWkwemcFrve1Qyh9RByAHWgrhUC5
         fNE2GObehLD8Ha+6sjqThTvZfsAQiM+0YkkNUEwPWKdsZOjRymzYCZQwQT49AJyfYIbl
         buWawfhfmbaImtlMwRX2IHeyxgfA03xegGh21rPAWxkKgFtM1/kOuL6IwtcCzrt9O1X3
         JS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xm2PUQAUtcYD7IeMAkl43mdCM2aa93A2uhqW4Sw/Lp0=;
        b=1XPcl/fBerzG1YmM0IUV8ig8KEbzwcNbvidXFY7ECyFzVGLDH/T3q8gbjwUDPgc6CW
         6gwohMhf7gehl3U9KV0eoPMYbPwoLWTtj6uwIQSpG7tatQOjac4tVCvLsuNGjreggU1A
         jEM43TPQj5A7FPz9HmkAGEYSsDUmtQXKXTW9++27UGonjL4eOk9sGsFrXfW2kGZ24eCq
         FfiTNI4KA6YVt2mpAD0N9uHUWmNrLbr7P85CxPfoeSXLXVkFqK4EMzbXKgnFyX2UMxkl
         vKwr4BQNtWccBeGzHBjFWpgdZOAz5okjTJYEoGvmr0qdOMk+9YwPqar5exHswmXBaVAN
         6fLQ==
X-Gm-Message-State: ACrzQf3CvG0OJkbnZ6S8hhP3I23DB7fRSLcutyQnlMYP58ETXaKB/FSO
        j13MBD34JayqP83+VCx5sn90TIlAEVQU2Q==
X-Google-Smtp-Source: AMsMyM6rgW3Sed4iY4dGdqiZbG32enwRqcrc+W6B1Cd4mkWZBL3Zj7aND994akLt0Z2Vz8fHIsodpA==
X-Received: by 2002:adf:a555:0:b0:22c:dd2a:41b3 with SMTP id j21-20020adfa555000000b0022cdd2a41b3mr4455845wrb.366.1664561376201;
        Fri, 30 Sep 2022 11:09:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:34 -0700 (PDT)
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
Subject: [PATCH v3 26/36] doc txt & -h consistency: add missing options
Date:   Fri, 30 Sep 2022 20:07:49 +0200
Message-Id: <patch-v3-26.36-d57635b2707-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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

