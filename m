Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4CC33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8AB2077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNp98dZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgAPQJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40011 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPQJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so4381784wmi.5
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NcVSestg0cCMFI0FGLqke4lkaZeF7nP01/+19yZgfHA=;
        b=jNp98dZUyGgCCM4ZgJbvJuC4AcUQ9bskFS8+jPslZQQRnh3BT4trVSZa0al3ifYYkv
         KMQ6Hg6oqhV27RjDuCuGNDD4MnhDwef+72sMP71/s4Fe/OJEQLR1TMemT3yjzHdxtr3t
         FQlLsPnkUAoARRQV/1haH2d1DfxSkCphDXk6wGXsLYkKgPm1rEcrbJ84T6HT+JiYms59
         AWJku5B6kvJ5fOxxGBIk/iKPYN7LDLuup1jYATvZO4OUYzGJUkhOauapzEq6vV4P8dQX
         vG2wNuRye4k6AYIYlheBG1UtSJcOJL4cQp1LBSHd/euy8A/W4a1Cn+I2cHHxZAG8PcJE
         NGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NcVSestg0cCMFI0FGLqke4lkaZeF7nP01/+19yZgfHA=;
        b=iHML82XbwHaQ/QwWIJfd7cR4t8jG/FCbjKhPx/VvpH7qryrWFLVtPoUwwTXQRZfnix
         oeZI8sBsFM/GqzsoFnpkv6EYrL0LyA5FNr5hoWByh4Uqc53lyQT204m6wdxm8wLFprcV
         Ca3okoXv07LAsMthTaJei919zpwBj9ZrwVM1i//iJ/BL20LeHM+PGm/CL1VJNysv08K0
         +Fv6LoXFhZpjSHbnG1OXMSaPmJbTJ/DFFVahwxW1fMDOUwUpQkaTT9hPWCBKsP0FoGco
         U4I3Y1y3l4xWaYXtzMxE8wlFkcnTaQDdkXSQ1PUwTqx2Vq+Qf77vpMqrSJ7uUMgl28Bl
         k3iA==
X-Gm-Message-State: APjAAAW9U9KKr56D9e/X34Kw8PT8zBmaTtnhNRUUFvSJ8J+1DKuQr838
        hfPFV/O7zKZJcqn0lYyJ4A3vSKgJ
X-Google-Smtp-Source: APXvYqzzICz/75PYfTt2eibbzslp3HGQSV+ncnworWZIlLSKYwomVk6LG5EGexr6rO+WN5R+Fsgwjw==
X-Received: by 2002:a05:600c:2c0b:: with SMTP id q11mr132777wmg.2.1579190970106;
        Thu, 16 Jan 2020 08:09:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm769511wmk.23.2020.01.16.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:27 -0800 (PST)
Message-Id: <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:19 +0000
Subject: [PATCH 2/8] rm: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) It is not allowed to pass pathspec in both args and file.

`if (!argc)` block was adapted to work with --pathspec-from-file. For
that, I also had to parse pathspec earlier. Now it happens before
`read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
sounds fine to me.

In case of empty pathspec, there is now a clear error message instead
of showing usage. As a consequence, exit code has also changed. Judging
from [1] it doesn't seem that showing usage in this case was important
(according to commit message, it was to avoid segfault), and it doesn't
fit into how other commands react to empty pathspec. Finally, the new
error message is easier to understand.

[1] Commit 7612a1ef ("git-rm: honor -n flag" 2006-06-09)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-rm.txt    | 17 +++++++-
 builtin/rm.c                | 28 ++++++++++---
 t/t3601-rm-pathspec-file.sh | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 7 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index e02a08e5ef..ab750367fd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,9 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
+'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	  [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -73,6 +75,19 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
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
 
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
 --------------------------------------------------------
diff --git a/builtin/rm.c b/builtin/rm.c
index 19ce95a901..8e40795751 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -235,7 +235,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 }
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, pathspec_file_nul = 0;
+static char *pathspec_from_file = NULL;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -245,6 +246,8 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
 };
 
@@ -259,8 +262,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
-	if (!argc)
-		usage_with_options(builtin_rm_usage, builtin_rm_options);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv);
+
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_CWD,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (!pathspec.nr)
+		die(_("Nothing specified, nothing removed"));
 
 	if (!index_only)
 		setup_work_tree();
@@ -270,9 +289,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
-		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
new file mode 100755
index 0000000000..0f69ae8478
--- /dev/null
+++ b/t/t3601-rm-pathspec-file.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='rm --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files" &&
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
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	EOF
+
+	echo fileA.t | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success '--pathspec-file-nul' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	D  fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" | git rm --pathspec-from-file=- --pathspec-file-nul &&
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileB.t
+	D  fileC.t
+	EOF
+
+	printf "fileB.t\nfileC.t\n" | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git rm --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git rm --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	
+	>empty_list &&
+	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
+	test_i18ngrep -e "Nothing specified, nothing removed" err
+'
+
+test_done
-- 
gitgitgadget

