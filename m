Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED723C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJMPkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJMPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C252386BB
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w18so3447115wro.7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8FadSrmlOZLyAbiub4y2c7LobVItOV31nYxQs25pTQ=;
        b=hjNiBOeBwRCnKuGj0Fpuqp/dh52tZgxeWtvJpNrNNfquqQVWWgfpyiUWZ8PSUbO/+b
         esJoRHGTDnsbchAIgHYUQlRQXT5b1TbEcnMPkHXHRpe+94h+m+PRLIm0kioARD5jwb6n
         sYeH78xP0D3cg6xOCgkzh+4pC+g+stbcivI5fXKgw7VG22fE8Q72lqLV5dDrhiA/422K
         yQDIVlDURf7tnThSt+eL8KcL60LoXQlAb8vKVXMZ+6zTdxkalONi+HekcHZ1BWJDt2CA
         OJTzyXToKpB5N9HgIXZL5xAC9PBCkJgZcmr3i5giV9UYZvhUcfz9UayXS/fM3MSlhyR3
         bk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8FadSrmlOZLyAbiub4y2c7LobVItOV31nYxQs25pTQ=;
        b=CfBcikii4ugRVHQrYJZEHXFP75nHdDMloTwlnEAvYNQNN3xl0E314N4uRlQ96152Ap
         rN5UuPMBWaNRpo3MqaeZsgLrOKEsLkRGvmX+aBIOiKp5zQgG1plcpmyr6Mr+DrtEV4xk
         ZwUiOGiYi8NAD45PL18fhzAvRMP44zCw0TtCJtZ7iZzhGmQIS/D7iqzBQhrKdCqcTrUk
         zvUFmaGyonkgWH/Q6Mnyuz6tOeEEvrBMWpj8vOWIbeSfFlrVQCHIMZBqyB/xdyFQKFFZ
         qW0AI0EMGeiiLyIhV8N3SNdzrnUdlYuEuPXrCvAtFOhitXFi8lSThhQ8jJs6mksK3yDp
         +4Zw==
X-Gm-Message-State: ACrzQf3FkZHDFDHJXSw50fWacRF6srpPMpbtIvg3BJj3pyPmfgetItOy
        dK6dof32fMRstEsQGS8EcmjbbFWmg5OTDg==
X-Google-Smtp-Source: AMsMyM7y2M53yAiOdLSNr0KE3FBQ5NTTizFUMr82blKyi2GOp5EvwrvOaZTc9UIZ1dHfnvwMMsusYQ==
X-Received: by 2002:a05:6000:2cd:b0:22e:5cef:4332 with SMTP id o13-20020a05600002cd00b0022e5cef4332mr396636wry.540.1665675590969;
        Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
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
Subject: [PATCH v5 16/34] doc txt & -h consistency: fix mismatching labels
Date:   Thu, 13 Oct 2022 17:39:10 +0200
Message-Id: <patch-v5-16.34-503bd076a6b-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various inconsistencies between command SYNOPSIS and the
corresponding -h output where our translatable labels didn't match
up.

In some cases we need to adjust the prose that follows the SYNOPSIS
accordingly, as it refers back to the changed label.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clean.txt                    | 10 +++++-----
 Documentation/git-credential-cache--daemon.txt |  4 ++--
 Documentation/git-mv.txt                       |  4 ++--
 Documentation/git-receive-pack.txt             |  4 ++--
 Documentation/git-tag.txt                      | 18 +++++++++---------
 Documentation/git-upload-archive.txt           |  4 ++--
 builtin/bugreport.c                            |  2 +-
 builtin/clean.c                                |  2 +-
 builtin/commit-graph.c                         |  4 ++--
 builtin/for-each-repo.c                        |  2 +-
 builtin/pack-redundant.c                       |  2 +-
 builtin/rerere.c                               |  2 +-
 builtin/rev-list.c                             |  2 +-
 builtin/stash.c                                |  2 +-
 builtin/unpack-file.c                          |  2 +-
 builtin/upload-archive.c                       |  2 +-
 builtin/verify-pack.c                          |  2 +-
 builtin/worktree.c                             |  2 +-
 18 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 91742633fa8..8347c6eed79 100644
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
@@ -20,16 +20,16 @@ Normally, only files unknown to Git are removed, but if the `-x`
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
-If any optional `<path>...` arguments are given, only those paths
-are affected.
+If any optional `<pathspec>...` arguments are given, only those paths
+that match the pathspec are affected.
 
 OPTIONS
 -------
 -d::
-	Normally, when no <path> is specified, git clean will not
+	Normally, when no <pathspec> is specified, git clean will not
 	recurse into untracked directories to avoid removing too much.
 	Specify -d to have it recurse into such directories as well.
-	If any paths are specified, -d is irrelevant; all untracked
+	If a <pathspec> is specified, -d is irrelevant; all untracked
 	files matching the specified paths (with exceptions for nested
 	git directories mentioned under `--force`) will be removed.
 
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
index 01e1c214dd8..650a15a7edf 100644
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
@@ -16,7 +16,7 @@ DESCRIPTION
 NOTE: You probably don't want to invoke this command yourself; it is
 started automatically when you use linkgit:git-credential-cache[1].
 
-This command listens on the Unix domain socket specified by `<socket>`
+This command listens on the Unix domain socket specified by `<socket-path>`
 for `git-credential-cache` clients. Clients may store and retrieve
 credentials. Each credential is held for a timeout specified by the
 client; once no credentials are held, the daemon exits.
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 972a055fbd8..fb0220fd18d 100644
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
@@ -30,7 +30,7 @@ OPTIONS
 -------
 -f::
 --force::
-	Force renaming or moving of a file even if the target exists
+	Force renaming or moving of a file even if the <destination> exists.
 -k::
 	Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 014a78409b9..5c297db1a4b 100644
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
@@ -38,7 +38,7 @@ its behavior, see linkgit:git-config[1].
 
 OPTIONS
 -------
-<directory>::
+<git-dir>::
 	The repository to sync into.
 
 --http-backend-info-refs::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c5..fdc72b5875a 100644
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
@@ -26,19 +26,19 @@ to delete, list or verify tags.
 
 Unless `-f` is given, the named tag must not yet exist.
 
-If one of `-a`, `-s`, or `-u <keyid>` is passed, the command
+If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
+If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
 
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
 
 A GnuPG signed tag object will be created when `-s` or `-u
-<keyid>` is used.  When `-u <keyid>` is not used, the
+<key-id>` is used.  When `-u <key-id>` is not used, the
 committer identity for the current user is used to find the
 GnuPG key for signing. 	The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
@@ -72,8 +72,8 @@ OPTIONS
 	Override `tag.gpgSign` configuration variable that is
 	set to force each and every tag to be signed.
 
--u <keyid>::
---local-user=<keyid>::
+-u <key-id>::
+--local-user=<key-id>::
 	Make a GPG-signed tag, using the given key.
 
 -f::
@@ -164,14 +164,14 @@ This option is only applicable when listing tags without annotation lines.
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
-	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
+	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
 -F <file>::
 --file=<file>::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
-	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
+	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
 -e::
@@ -220,7 +220,7 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-keyid>
+    signingKey = <gpg-key_id>
 -------------------------------------
 
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
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
2.38.0.1085.gb7e61c3016c

