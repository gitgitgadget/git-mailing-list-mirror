Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A0C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97C0214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/et5Qtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfLLOgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38828 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfLLOgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2991264wrh.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6h89B3EMB3xcDYibcrxXqOJAO7RKzFw1xiGUxFfgXt8=;
        b=D/et5QtujQrW5LafkT+ainvdDCUQJQeXyBQzjro+bNL05Uz3K06dPg1bpwGeTEX0tK
         m8K54xLIiQm4wTnB7Xtr3ZYafjf/ViVQaiR6+l+haQc3TSPZLI4Fhe55B/VlNKl/1rZY
         KCDQwASVVUSOaFAJ7E050QaK0t+PwmGresVBl5JDJiJhNGu4TKKUalsxWbTY6pv2qtpT
         JSrft9uHDjWTjDnKowLmEh4GWOR2L9B2LgL3ZL/l5P0OTB4DEkHtFRH9u7iBpmnb8wPF
         dVMpo6N/G12e4f0f6k02TLYX8xrRWUBVDwDTm1PXu+AY5uuMVvlNwl1694bfiOYmkYJN
         JImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6h89B3EMB3xcDYibcrxXqOJAO7RKzFw1xiGUxFfgXt8=;
        b=T51mQ56oObHUlnzGnq6jg9SYFA35c4ZgyzlbfQm8XA1ABhCIH7ycYbiHjC94oF2p4k
         Grn0IgM4WPV2jDBj3gDFiJPR16TxE6XmC1tgJVVx/i5iIb2ZgKjx/TF7x3zQpkaD4YqA
         +KAT6jsGogE9xUmv3DzOtnwzqL1fCf4oWqHVp1e1p5kVcImOikPq4f3YbuqzToGzCGRi
         r5NQ9VvAvM+WQSHG/i3dEcAGgBXXy7VK78tXkGshiLEYAJAEAh/Unu3tz+YgfA+VEmO5
         nTupKaUuIkIs5r6QvF7H9r3KI6XmAqbOm42UAr98zb6J1YyTSaupTspnmao8tkQg4ihx
         R6Qw==
X-Gm-Message-State: APjAAAVaQnIizp6zpPfz+Qx1CQlKF9LvLCjevkQ3BM1dLfIMj/IapJJR
        2cF/DDSckpFHKwT075gjhzvQrT38
X-Google-Smtp-Source: APXvYqxwpMhnhuwX+rFIKQAZS1VY1Hc5Ot0IOvG9UI9JWXUC1RqIcUO22TW5xXMonptFy8T8jSjqCQ==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr6769356wrm.248.1576161398257;
        Thu, 12 Dec 2019 06:36:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21sm7141110wmj.39.2019.12.12.06.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:37 -0800 (PST)
Message-Id: <9af2de98dec456f9314121fc964df037be7f5b36.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:25 +0000
Subject: [PATCH 16/16] checkout, restore: support the --pathspec-from-file
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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
   `--patch`, even when <file> is not `stdin`. Such use case it not
   really expected.
2) It is not allowed to pass pathspec in both args and file.

`you must specify path(s) to restore` block was moved down to be able to
test for `pathspec.nr` instead, because testing for `argc` is no longer
correct.

`git switch` does not support the new options because it doesn't expect
`<pathspec>` arguments.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt    |  15 ++++
 Documentation/git-restore.txt     |  14 +++
 builtin/checkout.c                |  33 +++++--
 t/t2026-checkout-pathspec-file.sh |  61 +++++++++++++
 t/t2072-restore-pathspec-file.sh  | 139 ++++++++++++++++++++++++++++++
 t/t9902-completion.sh             |   2 +
 6 files changed, 259 insertions(+), 5 deletions(-)
 create mode 100755 t/t2026-checkout-pathspec-file.sh
 create mode 100755 t/t2072-restore-pathspec-file.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 93124f3ad9..ffe3c1bff2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
@@ -79,6 +80,7 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
 
 	Overwrite the contents of the files that match the pathspec.
 	When the `<tree-ish>` (most often a commit) is not given, 
@@ -306,6 +308,19 @@ Note that this option uses the no overlay mode by default (see also
 	working tree, but not in `<tree-ish>` are removed, to make them
 	match `<tree-ish>` exactly.
 
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
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index d7bf016bba..5bf60d4943 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
 'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
@@ -113,6 +114,19 @@ in linkgit:git-checkout[1] for details.
 	appear in the `--source` tree are removed, to make them match
 	`<tree>` exactly. The default is no-overlay mode.
 
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
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index aa4ff14ec2..b02425f49b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -70,6 +70,8 @@ struct checkout_opts {
 	int checkout_worktree;
 	const char *ignore_unmerged_opt;
 	int ignore_unmerged;
+	int pathspec_file_nul;
+	const char *pathspec_from_file;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1202,7 +1204,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * Absence of '--' leaves <pathspec>/<commit> ambiguity.
 		 * Try to resolve it with additional knowledge about pathspec args.
 		 */
-		expect_commit_only = !opts->accept_pathspec;
+		expect_commit_only = !opts->accept_pathspec || opts->pathspec_from_file;
 	} else if (dash_dash_pos == 0) {
 		/* 'git checkout/switch/restore -- [...]' */
 		return 1;  /* Eat '--' */
@@ -1476,6 +1478,8 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
+		OPT_PATHSPEC_FROM_FILE(&opts->pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&opts->pathspec_file_nul),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
@@ -1612,10 +1616,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
-	if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc &&
-	    !opts->patch_mode)	/* patch mode is special */
-		die(_("you must specify path(s) to restore"));
-
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -1635,10 +1635,33 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (opts->force_detach)
 			die(_("git checkout: --detach does not take a path argument '%s'"),
 			    argv[0]);
+	}
+
+	if (opts->pathspec_from_file) {
+		if (opts->pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		if (opts->force_detach)
+			die(_("--pathspec-from-file is incompatible with --detach"));
 
+		if (opts->patch_mode)
+			die(_("--pathspec-from-file is incompatible with --patch"));
+
+		parse_pathspec_file(&opts->pathspec, 0,
+				    0,
+				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
+	} else if (opts->pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (opts->pathspec.nr) {
 		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
 			      "checking out of the index."));
+	} else {
+		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
+		    !opts->patch_mode)	/* patch mode is special */
+			die(_("you must specify path(s) to restore"));
 	}
 
 	if (opts->new_branch) {
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
new file mode 100755
index 0000000000..379f1afd8e
--- /dev/null
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='checkout --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	test_commit file0 &&
+
+	echo 1 >fileA.t &&
+	echo 1 >fileB.t &&
+	echo 1 >fileC.t &&
+	echo 1 >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files 1" &&
+
+	echo 2 >fileA.t &&
+	echo 2 >fileB.t &&
+	echo 2 >fileC.t &&
+	echo 2 >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files 2" &&
+
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain --untracked-files=no -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'simplest' '
+	restore_checkpoint &&
+
+	echo fileA.t | git checkout --pathspec-from-file=- HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	M  fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t\n" | git checkout --pathspec-from-file=- HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	M  fileB.t
+	M  fileC.t
+	EOF
+	verify_expect
+'
+
+test_done
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
new file mode 100755
index 0000000000..db58e83735
--- /dev/null
+++ b/t/t2072-restore-pathspec-file.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+
+test_description='restore --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	test_commit file0 &&
+
+	echo 1 >fileA.t &&
+	echo 1 >fileB.t &&
+	echo 1 >fileC.t &&
+	echo 1 >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files 1" &&
+
+	echo 2 >fileA.t &&
+	echo 2 >fileB.t &&
+	echo 2 >fileC.t &&
+	echo 2 >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files 2" &&
+
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain --untracked-files=no -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	echo fileA.t | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	echo fileA.t >list &&
+	git restore --pathspec-from-file=list --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\0fileB.t\0" | git restore --pathspec-from-file=- --pathspec-file-nul --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	 M fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	 M fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	 M fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\r\nfileB.t\r\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	 M fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" >list &&
+	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+
+	cat >expect <<-\EOF &&
+	 M fileB.t
+	 M fileC.t
+	EOF
+	verify_expect
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ec3eccfd3d..93877ba9cd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1438,6 +1438,8 @@ test_expect_success 'double dash "git checkout"' '
 	--no-guess Z
 	--no-... Z
 	--overlay Z
+	--pathspec-file-nul Z
+	--pathspec-from-file=Z
 	EOF
 '
 
-- 
gitgitgadget
