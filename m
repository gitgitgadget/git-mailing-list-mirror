Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB8C6FA86
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiI1IlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiI1IkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D65282A
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so10872108wrb.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yx6UyETppKYcfUn+MfDpcscNis6m/9iHM/B+CaOtwa4=;
        b=ECbJz0RoDNs1q/C5cRzmZ6jdyRTfnRFciGFG5nTt84eyTSEOdqdAW+8H7bp/yAh/IO
         JTvC81LuPs8IDuDodbxBMbTMChbtianaKHn4yLV07/FmGZsbQFHw7MWvtqU96RabTwoc
         aaHjDdYXG3o+zFTx/9WDpGcZIxCkklDaNU2FQsnPv9llUZybbzvQ2IqyAVkf6I/KFg6e
         cWL6sH+oE0GW/Jm84bvIeqYQ6t9GIpg7TI5ZYRzvU8V1QPbhj+qBkf+vvVqcM6jaa5sN
         fZkVVgmoJVA1hhQVkpMFt+bqUAEi1by702ujiYZLjeQ5QHeEKdA1HaNFGWLt5ad+1sLJ
         MG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yx6UyETppKYcfUn+MfDpcscNis6m/9iHM/B+CaOtwa4=;
        b=RW/5m2olsN3J/VRgzevRRObHNy9DA/bOdvYIpwtgNqX77TGekCA+d0ECl2Ky1JQEEE
         AWjPGjSUCK9NuuszLoimVyYroWkEJroQFZUm+Fd6x7Q6wK/9pS1gMjGhy64L3kNx7ilU
         Di/fP3PjNE3oMBB9eT10L+I3o8ejbkSL9UUmXwFEyCoWlrv8GtKto2zVSFSPlUOQSsML
         iLa4EjxakRoBcExbp8UvZjan9rzugGeeTVrb3TTG4or33sua7ZZlQrj5/25n7oIz6Hz1
         6gZh4YBWay6+dxVJp1cVBW32HujXieeYM3eDLMRTfPug4937GYlyPiCo2rLPMCdW2QlE
         EDyg==
X-Gm-Message-State: ACrzQf0i7py/mTAOPfgEzBSv3fM6KYmcfLRt8MDlh0EQ+8KixO1c66vV
        63mW6smw9lxgiz0naX78uMnacPyaGKicbw==
X-Google-Smtp-Source: AMsMyM758Hi+/Wf7UZ/M0vQbg/7vNGk+vFVlqpAAFYDDqM5Mgk80nMxAOszfnG+nLJ0WESmD2iryIg==
X-Received: by 2002:a5d:684a:0:b0:228:d94f:143c with SMTP id o10-20020a5d684a000000b00228d94f143cmr18900659wrw.683.1664354393900;
        Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
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
Subject: [PATCH v2 17/35] doc txt & -h consistency: fix mismatching labels
Date:   Wed, 28 Sep 2022 10:39:12 +0200
Message-Id: <patch-v2-17.35-97873747a1e-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
index 91742633fa8..3f16f200d9a 100644
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
index cd346f95f08..b656a535c05 100644
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
index d91cf5fd3e1..83c9591ea6d 100644
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
2.38.0.rc1.925.gb61c5ccd7da

