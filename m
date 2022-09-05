Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C815DECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiIEI1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiIEI10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15317A80
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b16so10278422wru.7
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d7ZZHpAhwYAXKkLgc7p6ExfWq3e/GHMQGKR+KfXoVkQ=;
        b=IQA8UOTNuWXUYTbCJUVNj4iBWdrJ78AwBLx5SFMLMeQL6y2QkLukq0HJ9pU8WjOG+N
         Tfgp6TqVUxK3l7st/nQIzbOsEtfPgNKoXKgMNdr8UixMzBzZi66C5rYqE/57B+H0ojsy
         wFcyE/7gO61EXpyd8zOuF6kcJtctpSSCp8u/a2XqnWnAFkCMqi4DqFhkccEV3FEZN7L8
         hpolKg8GQeH81KnJqKhdHf8dfsAFBweD8dz8qLd7MAwcRxDnuRMXstfa09A1Cj9DC8f2
         yFWhtQzGU6ISP6VUWCuOwezacmChBVFxU9U9K2Ecmusqwtoh9Ua5S16fQREvPrE3Bz6T
         VQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d7ZZHpAhwYAXKkLgc7p6ExfWq3e/GHMQGKR+KfXoVkQ=;
        b=FyDEuMEhoRwIVd8GQ+hZYIUn9E6siMDRrkAhnO1LkAh94Wi1iZmvipmj0TmV7OMyx3
         PjxxS3t7bRu3FExMJvv+JZ7MZD0phXCrV/g/zXAjso87D8Hevd0muBwJWBY73FbHcJnV
         VDaJBvJ/TUCSCFucmCa4pxNDGhcB4KkCRlh05WG7exASmP/q/6BZGRSIEr7pD+uCQ6Fo
         EoVuAqAJ+CGmjXCx2UBX80e3Ix+o0mlilGMzyYXR6+HPVAjSFTh4Ygwc1Qj+SN877sxD
         JF7igurwlkyQvKiK4iWmkuoWdQMo8XWjk/hxP3aoWNAwnmmhVLBKGKszvJ2yPYUUaUUQ
         girw==
X-Gm-Message-State: ACgBeo2dHEWy8m/i92VuOb0bU54/gXX1tV/5GerekHA5w/PWe8QfREIK
        XpOXCImiQQ6vGCfpfeEF6dktWn0Nf1dsEQ==
X-Google-Smtp-Source: AA6agR4iPeF9xkeYWy7ihggB0UyhzYBMGBqM5WYAbg0TMIBiyQPrTUGkCoXe2zCCb9WKBZGRlG3cEA==
X-Received: by 2002:a05:6000:706:b0:226:e456:1896 with SMTP id bs6-20020a056000070600b00226e4561896mr16507637wrb.177.1662366428282;
        Mon, 05 Sep 2022 01:27:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:07 -0700 (PDT)
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
Subject: [PATCH 17/34] doc txt & -h consistency: fix mismatching labels
Date:   Mon,  5 Sep 2022 10:26:28 +0200
Message-Id: <patch-17.34-517f9f9a53f-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various inconsistencies between command SYNOPSIS and the
corresponding -h output where our translatable labels didn't match
up.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clean.txt                    | 6 +++---
 Documentation/git-credential-cache--daemon.txt | 2 +-
 Documentation/git-mv.txt                       | 2 +-
 Documentation/git-receive-pack.txt             | 2 +-
 Documentation/git-tag.txt                      | 2 +-
 Documentation/git-upload-archive.txt           | 4 ++--
 builtin/bugreport.c                            | 2 +-
 builtin/clean.c                                | 2 +-
 builtin/commit-graph.c                         | 4 ++--
 builtin/credential-cache--daemon.c             | 2 +-
 builtin/for-each-repo.c                        | 2 +-
 builtin/pack-redundant.c                       | 2 +-
 builtin/rerere.c                               | 2 +-
 builtin/rev-list.c                             | 2 +-
 builtin/stash.c                                | 2 +-
 builtin/unpack-file.c                          | 2 +-
 builtin/upload-archive.c                       | 2 +-
 builtin/worktree.c                             | 2 +-
 18 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a7f309dff5a..13e3a0844f8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>...
 
 DESCRIPTION
 -----------
@@ -20,13 +20,13 @@ Normally, only files unknown to Git are removed, but if the `-x`
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
-If any optional `<path>...` arguments are given, only those paths
+If any optional `<pathspec>...` arguments are given, only those paths
 are affected.
 
 OPTIONS
 -------
 -d::
-	Normally, when no <path> is specified, git clean will not
+	Normally, when no <pathspec> is specified, git clean will not
 	recurse into untracked directories to avoid removing too much.
 	Specify -d to have it recurse into such directories as well.
 	If any paths are specified, -d is irrelevant; all untracked
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
index 01e1c214dd8..74832d06806 100644
--- a/Documentation/git-credential-cache--daemon.txt
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user credentials in memory
 SYNOPSIS
 --------
 [verse]
-'git credential-cache{litdd}daemon' [--debug] <socket>
+'git credential-cache{litdd}daemon' [--debug] <socket-path>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 972a055fbd8..c612a5fd5b9 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' [<options>] <args>...
+'git mv' [<options>] <source>... <destination>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 014a78409b9..eec1268b10f 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repository
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <directory>
+'git-receive-pack' <git-dir>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c5..c15ec895720 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
+'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index fba0f1c1b27..e8eb10baad7 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -9,7 +9,7 @@ git-upload-archive - Send archive back to git-archive
 SYNOPSIS
 --------
 [verse]
-'git upload-archive' <directory>
+'git upload-archive' <repository>
 
 DESCRIPTION
 -----------
@@ -54,7 +54,7 @@ access via non-smart-http.
 
 OPTIONS
 -------
-<directory>::
+<repository>::
 	The repository to get a tar archive from.
 
 GIT
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 61d93383f51..96052541cbf 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <file>] [(-s | --suffix) <format>]\n"
+	N_("git bugreport [(-o | --output-directory) <path>] [(-s | --suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
diff --git a/builtin/clean.c b/builtin/clean.c
index 5466636e666..6f039f555b2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -26,7 +26,7 @@ static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>..."),
 	NULL
 };
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 50b1a171566..0d906c4aa42 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,10 +10,10 @@
 #include "tag.h"
 
 #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
+	N_("git commit-graph verify [--object-dir <dir>] [--shallow] [--[no-]progress]")
 
 #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
-	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
+	N_("git commit-graph write [--object-dir <dir>] [--append]\n" \
 	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
 	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
 	   "                       <split options>")
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0de..ca672a6a619 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
-		"git-credential-cache--daemon [opts] <socket_path>",
+		"git-credential-cache--daemon [opts] <socket-path>",
 		NULL
 	};
 	int debug = 0;
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index fd86e5a8619..c6379b783c8 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <command-args>"),
+	N_("git for-each-repo --config=<config> <arguments>"),
 	NULL
 };
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ed9b9013a5f..ecd49ca268f 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -14,7 +14,7 @@
 #define BLKSIZE 512
 
 static const char pack_redundant_usage[] =
-"git pack-redundant [--verbose] [--alt-odb] (--all | <filename.pack>...)";
+"git pack-redundant [--verbose] [--alt-odb] (--all | <pack-filename>...)";
 
 static int load_all_packs, verbose, alt_odb;
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 83d7a778e37..12570537d37 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -10,7 +10,7 @@
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <path>... | status | remaining | diff | gc]"),
+	N_("git rerere [clear | forget <pathspec>... | status | remaining | diff | gc]"),
 	NULL,
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f67e2b33555..ada68a4af5e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit-id>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [-- <path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
diff --git a/builtin/stash.c b/builtin/stash.c
index 7d82ead6760..614bb0dd4a2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -22,7 +22,7 @@
 #define INCLUDE_ALL_FILES 2
 
 static const char * const git_stash_usage[] = {
-	N_("git stash list [<options>]"),
+	N_("git stash list [<log-options>]"),
 	N_("git stash show [<options>] [<stash>]"),
 	N_("git stash drop [-q | --quiet] [<stash>]"),
 	N_("git stash (pop | apply) [--index] [-q | --quiet] [<stash>]"),
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 58652229f27..9e8119dd354 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -27,7 +27,7 @@ int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
-		usage("git unpack-file <sha1>");
+		usage("git unpack-file <blob>");
 	if (get_oid(argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 98d028dae67..945ee2b4126 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -10,7 +10,7 @@
 #include "strvec.h"
 
 static const char upload_archive_usage[] =
-	"git upload-archive <repo>";
+	"git upload-archive <repository>";
 
 static const char deadchild[] =
 "git upload-archive: archiver died with error";
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c6710b25520..5bfc18e5a24 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -23,7 +23,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree prune [<options>]"),
 	N_("git worktree remove [<options>] <worktree>"),
 	N_("git worktree repair [<path>...]"),
-	N_("git worktree unlock <path>"),
+	N_("git worktree unlock <worktree>"),
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

