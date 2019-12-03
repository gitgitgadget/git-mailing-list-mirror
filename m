Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C62C43215
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD012073C
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFAPDzJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLCOC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCOC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so3757073wra.10
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LkXgE6w6UaVkpKoJy9Y/Z1HKYzIncm2cE3/WP1eADks=;
        b=SFAPDzJ5d0jPU5k/NTeZ3a8UfAwNInlE0BDHKZ6TsSz7E1DKJWkJOVJ2UTifcZQtNv
         nnWoyTqcjkZ2E3w3DNvfA2xuQk49mmlMWzXGEV+MqQ/gKliCOhKBZw+ncfh8qioQ6ZRr
         lQVOQxsWcs1ac87NwLwLcCCi7BZs+0dMaQk9u4LznprGYA8B0GlXZWzqdCJERyqDPe5P
         SUb/ub/BLW7QSAcquqDOIHEc+2D+zpbjyDf+RD6mV2T45GAhkFDo88l0xTyVtaT5flcd
         rN0cDcjWWhtqhH/NNT8KlUckEMWZ7B11lgFpfocENyZjkfWUElOHcah4UDKEKfWiWb27
         h7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LkXgE6w6UaVkpKoJy9Y/Z1HKYzIncm2cE3/WP1eADks=;
        b=XODikZqfeWu3A/5kkM81KiOuTL354jRD/6ef7dzngoEF7FO/Ox0HFG4kVBQ5jDdT0u
         B2j9RvekYJz4a6wJ6GhbwC730xg65F7Xz+lGfmOfasGYNsVCQevlQRMgJGhMUexEYTRQ
         BEWXvWlU8/JYCJn0Bv79hbl/9bzzrTFuc6KkQ++Hsk8dw55/nCPIwfHUNKW44Su1SCih
         ysL5fgOHWmKxHr5LWvyaSOx/H1wB8TF/wIwyJ/cSlAt92GTkNq/4d/mGVDQ7AY7SexWc
         9cO4JqmUtztEmoi/Cv2MvSTjfp6Qggr96DSNBpRXTOLMxzx6URude8RmOmRmP8xd2aZH
         Bo/w==
X-Gm-Message-State: APjAAAUMgASa4dlORDDiB4OLw8EkhVJTmArzyeImSt70iwLv8FL3ZeN3
        aXiBjT2D7XR68yF3arNcru+BEwRJ
X-Google-Smtp-Source: APXvYqx6falddIt44gT/GRGoEJap9Vinua3Y1OrnuHym6cWQ4egnbFhgBXzq0DHWFdKvk1+bt2ZOsA==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr5178355wrr.252.1575381745303;
        Tue, 03 Dec 2019 06:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm3081632wmh.12.2019.12.03.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:24 -0800 (PST)
Message-Id: <c877866c1323f4562564fa28cd355e413ca4d6b5.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:11 +0000
Subject: [PATCH v4 06/13] commit: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) For now, `--pathspec-from-file` is declared incompatible with
   `--interactive/--patch`, even when <file> is not `stdin`. Such use
   case it not really expected. Also, it would require changes to
   `interactive_add()`.
2) It is not allowed to pass pathspec in both args and file.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt    |  16 +++-
 builtin/commit.c                |  25 +++++-
 t/t7526-commit-pathspec-file.sh | 130 ++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 5 deletions(-)
 create mode 100755 t/t7526-commit-pathspec-file.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a0c44978ee..ced5a9beab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
+	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	   [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -278,6 +279,19 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
 
+--pathspec-from-file=<file>::
+	Pathspec is passed in `<file>` instead of commandline args. If
+	`<file>` is exactly `-` then standard input is used. Pathspec
+	elements are separated by LF or CR/LF. Pathspec elements can be
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
+	global `--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index 294dc574cd..2db2ad0de4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,9 +107,9 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
-static int no_post_rewrite, allow_empty_message;
+static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
-static char *sign_commit;
+static char *sign_commit, *pathspec_from_file;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -343,6 +343,23 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
+	if (pathspec_from_file) {
+		if (interactive)
+			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
+		die(_("No paths with --include/--only does not make sense."));
+
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
 
@@ -1198,8 +1215,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-	if (argc == 0 && (also || (only && !amend && !allow_empty)))
-		die(_("No paths with --include/--only does not make sense."));
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1513,6 +1528,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
new file mode 100755
index 0000000000..a06b683534
--- /dev/null
+++ b/t/t7526-commit-pathspec-file.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='commit --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	test_commit file0 &&
+	git tag checkpoint &&
+
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t
+'
+
+restore_checkpoint () {
+	git reset --soft checkpoint
+}
+
+verify_expect () {
+	git diff-tree --no-commit-id --name-status -r HEAD >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	echo fileA.t >list &&
+	git commit --pathspec-from-file=list -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\r\nfileB.t\r\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	A	fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileA.t
+	EOF
+	verify_expect expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" >list &&
+	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
+
+	cat >expect <<-\EOF &&
+	A	fileB.t
+	A	fileC.t
+	EOF
+	verify_expect
+'
+
+test_done
-- 
gitgitgadget

