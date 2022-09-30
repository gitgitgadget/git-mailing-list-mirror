Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B9C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiI3SKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiI3SJi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A91EB184
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so7995488wrp.11
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+7/4d3c4iCZeiRuAahlIFU9DjkolPvqpEoTcJ48f4l4=;
        b=qBwAJd+7mnoKFj+LF0gI/2D3Wxo0/scCsPj6PS7qTy7+GRjrYQuhn1qLY0bolazTuU
         P1YQkI7ljdIYMxEtIKslDfwCeVoTAE3+j6W+6VTt7xIZ/wOlFdLcIBbC3VHRiFcXQB0k
         aVT6pdYLNMUiko74tBL8dtQR2KiF3JqLzI3Zu60eMphQ0hb5TpFjwAV6/TZW+34wnBTf
         H/H0WWiuCVdeK4SxrgOz9vbtCUs7djtILVbhh9o1LP4GaJmfKgteOBWyMzgAz4IH49Eq
         0DglmQNKvypV8j5Rd1ULO8kR3Z/+lSz5O/D1T10JMpjZB8Ew0nsOYCdMhmoGdRHTl8OE
         ZlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+7/4d3c4iCZeiRuAahlIFU9DjkolPvqpEoTcJ48f4l4=;
        b=2cP+X832Gsf6rLsVZFZgfD48d4RsXuq0SwJczAZIVyRIS0WRTjJYN8WI5PKx9e/f2I
         1a2J+J02xGlbSsK0hbtlMpSfCelt5KWrDQG73AZyhmmo6/el1jWSQ5MU6lFynXslqsWe
         2J833F84kCJAQd2PcSEQygv84MZ6ab7sFcRzYRkDJAFEL6dg2rxpcZsFYoOgY6JHvzkK
         XEfJUoat/WbBqL2dZFyHNl6qCn5bIYUZ9StgaDHKng7ACLNHp5BNSsp/jGJ/Nlp/fGDh
         /1TwoMeXzo1FHKuxwcgWzElVzbTBf0KZJbsZ+Xuozk4IFS4USVqSV0+0VeYgTdGt6T/0
         WtNw==
X-Gm-Message-State: ACrzQf2w5GBzqjhupfbjfSUIV5EnjxWWWL8rw/ybu5oBvXTlrJxID7zT
        DXX3gyErQh50cuzCM5k1a/kTlnwLKV468g==
X-Google-Smtp-Source: AMsMyM4cgZpzFVo8kDjwThD5Hg89bob4UcKRJoD1/tJWR+9MlteSH6PJxO1MMLaSLK1Lt5iW8dmU2Q==
X-Received: by 2002:a5d:6343:0:b0:22e:50b:6e31 with SMTP id b3-20020a5d6343000000b0022e050b6e31mr1435227wrw.27.1664561351414;
        Fri, 30 Sep 2022 11:09:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:09 -0700 (PDT)
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
Subject: [PATCH v3 18/36] doc txt & -h consistency: fix mismatching labels
Date:   Fri, 30 Sep 2022 20:07:41 +0200
Message-Id: <patch-v3-18.36-3a439c4401d-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
 builtin/verify-pack.c                          | 2 +-
 builtin/worktree.c                             | 2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)

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
index 13cbb75ca28..e8f77f535f3 100644
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
 	   "                       [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]\n" \
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
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 05c52135946..db9ac5c4606 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
 	NULL
 };
 
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
2.38.0.rc2.935.g6b421ae1592

