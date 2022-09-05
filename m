Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FFDECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiIEI2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiIEI1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CC73CBC9
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bz13so6873063wrb.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kwPD4w0C2e2J1wMxQ9r0+Npq70hmfLTuiXU7NUGNTpc=;
        b=QFgqVytAoBVfalY0mzW49wMxgL7ds1nDOzbzaGqjhJdJGo956ilGONp2/Qw/IFLcsA
         QZ5DqzYN2dy0Ie4iUSVo+dfmqgl8REISM07P7JGynawF8p3gRuCnIoGEY0DnbmZX8IFO
         Z0dLV7RCDxjZWTSbcmt6rt5muyJFHInN2AgaUjTZjraLuBChki3Mor6niKEGyv52iVK3
         sxsHGN2FCsp/6Qw9XQVBhxSxcExWGN/ca0vf3r9rBu3NAQOkNhmM9706XIYw1KY/FGEl
         vVXo1468+nEN2qAtrPDeSsX+Zx54MsdeBnzlWQy6qDvTahsyjQ0gmljicdrx9Ma/pNP5
         /ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kwPD4w0C2e2J1wMxQ9r0+Npq70hmfLTuiXU7NUGNTpc=;
        b=cXbx9uc13rOrcPXNamqtRgCnm3MzojK9L/7uYxslIaVso4pv2P6sNc7aAoDbQ7B4oN
         h4wB5wXDlwTM4513ZaQwlc44/EAYXl28JH1tu4dLrzsubh3TbxghLHU3DouYeN1tiC7y
         ErIVhO1AMr5LEp4Pdd1WHHA3D1wWGeeS1fkhU1swfL0+aZAOqSHSPHActjU4MStyFm/K
         QXiHeXwMHjym0ErHHK/QjRlQ6btVew8/ulTK6OZGj1Km+qVX2DfENQ5zA0vBZmsfV2eX
         4z+4t1+p1CwmwcXgmmgoXpayZz7gs+gr59BjM6JCsTPnMB2ZmeDeOTGnqL+fHx1L4maA
         xGCA==
X-Gm-Message-State: ACgBeo0OJ+R8SeFAKkQrxDGNvyXJY8SkseFNmJLsNNFiR2oNT9erlKIz
        qbExAnM7uuXabVfRPkVktpJgBljzrRjnDw==
X-Google-Smtp-Source: AA6agR6jqzl8NpSGOOEmsAIoGyg9zgPryu5owyYffYd+EyynEzWvLgC4l5C1EfRydUsXYnUCzdfM4A==
X-Received: by 2002:a05:6000:170a:b0:226:def1:9410 with SMTP id n10-20020a056000170a00b00226def19410mr17605535wrc.142.1662366436234;
        Mon, 05 Sep 2022 01:27:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:15 -0700 (PDT)
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
Subject: [PATCH 25/34] doc txt & -h consistency: add missing options
Date:   Mon,  5 Sep 2022 10:26:36 +0200
Message-Id: <patch-25.34-3b0295e3467-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
index 047decdb65b..f158ada90ea 100644
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
index 956a01d184f..057744e6d73 100644
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
index 6c73092f10d..d9d163eabe4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -819,7 +819,10 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
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
2.37.3.1425.g73df845bcb2

