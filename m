Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE4C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiFFKBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiFFKBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 06:01:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD427A
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 03:01:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so9723989wme.5
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Yu2rzj9l/IKZLLnOHhlEvISTNML/MYjSd4YmhLQZMuw=;
        b=n5klchWNFdS+DK6kBl9z+ULUXQkhjT/ChJI9TEmmMV69/gJ7t3paraREb5kMfd/O/n
         fqZPDFXZ/XcDSEZutshFXrIPvFMCgd8bBdr6rPU0+ormmu4w80I9k6wW3G8PPeqespI+
         aHCIzjHVq3+yrr0R74ldhGb23IJvehgH+eazv+HUc43P/y4WbJc+9kL6dwMmaQO4ljiC
         XjX6HDHfsjMyTxq8Eh7fadz6TQd/PSOZTufDIOD3kM3XXFz7c7b28x13fC28Bgh8w/25
         4ScPDdaDUtIBZHnIdGqegjTrKGwQPf5MJtzHvk91cgFCKiNRlhCR8J7WNFWvd/dBiMW2
         C7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yu2rzj9l/IKZLLnOHhlEvISTNML/MYjSd4YmhLQZMuw=;
        b=a9QkW+iSwEsjQsSp75weFkpXr/YbXuXyru7BdgBfTO+g0EzKbeLmg4TvLy8pCpsi3X
         W+NAMl8h8kk44o2M6D6bd6IIwKJ5Elg4qKMd74BPcnjJO1SKufp21HiJUbY0D28wU7+h
         JUL7kCHpL+IQWBM4vx0l1lmw0Bx8o4rBt5V1tMVuHNzRdCV9QhMXvGLby4aEbyPgr8Gw
         cEgdq6GmVT2778vGFYXDFlJQwETeFhENPmLb5+9OQFpFXUse6/Ks1Gom7EuBd0Xtav6Z
         WX+8y+AFPyVHLWZUmSFD4r7CjADE1AunSrQrzDOmaOoCTrFL+E1VExA5I9XPC/Jm/4qu
         aIUQ==
X-Gm-Message-State: AOAM531RqUgKxKbm2l0EBNAEOUEI3qzrwTPl03FtmPlvH+MuIR1JZ5Lx
        kaGKI7cNlhgIJOqSzfctEnBeruXDbdeKMNQ/
X-Google-Smtp-Source: ABdhPJxEgiQrG3oe5pq8ZtBrgozCbOmV3+sPnREmUKIfV4mWMffMrxZXOFOKeGukdWfLM/0leTEkCA==
X-Received: by 2002:a7b:c403:0:b0:38e:7c57:9af7 with SMTP id k3-20020a7bc403000000b0038e7c579af7mr21445703wmi.144.1654509680607;
        Mon, 06 Jun 2022 03:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003942a244ed7sm16477911wmi.28.2022.06.06.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:01:19 -0700 (PDT)
Message-Id: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 10:01:18 +0000
Subject: [PATCH] ls-files.c: add --only-object-name option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git ls-files --stage` default output format is:

[<tag> ]<mode> <object> <stage> <file>

sometime we want to find a path's corresponding objectname,
we will parse the output and extract objectname from it
again and again.

So introduce a new option `--only-object-name` which can only
output objectname when giving `--stage` or `--resolve-undo`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files.c: add --only-object-name option
    
    Something we want to extract objectname from git ls-files --stage, but
    git ls-file don't support something like --format=%(objectname) (which
    git ls-tree have implemented)
    
    So now add a new option --only-object-name which can only output
    objectname.
    
    (Maybe we should add something like git ls-files --format ?)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1250%2Fadlternative%2Fzh%2Fls-file-only-objectname-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1250/adlternative/zh/ls-file-only-objectname-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1250

 Documentation/git-ls-files.txt |  6 +++++-
 builtin/ls-files.c             | 18 +++++++++++++++++-
 t/t2030-unresolve-info.sh      | 33 +++++++++++++++++++++++++++++++++
 t/t3004-ls-files-basic.sh      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..0e3f4f094f3 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
 		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
 		[--directory [--no-empty-directory]] [--eol]
-		[--deduplicate]
+		[--deduplicate] [--only-object-name]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
@@ -88,6 +88,10 @@ OPTIONS
 	When any of the `-t`, `--unmerged`, or `--stage` option is
 	in use, this option has no effect.
 
+--only-object-name:
+	When giving `--stage` or `--resolve-undo` , only output `<object>`
+	instead of `[<tag> ]<mode> <object> <stage> <file>` format.
+
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..fd9c10e9f94 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -26,6 +26,7 @@ static int show_deleted;
 static int show_cached;
 static int show_others;
 static int show_stage;
+static int only_object_name;
 static int show_unmerged;
 static int show_resolve_undo;
 static int show_modified;
@@ -241,10 +242,15 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 		if (!show_stage) {
 			fputs(tag, stdout);
 		} else {
+			const char *object_name = repo_find_unique_abbrev(repo, &ce->oid, abbrev);
+			if (only_object_name) {
+				printf("%s%c", object_name, line_terminator);
+				return;
+			}
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
-			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
+			       object_name,
 			       ce_stage(ce));
 		}
 		write_eolinfo(repo->index, ce, fullname);
@@ -274,6 +280,10 @@ static void show_ru_info(struct index_state *istate)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
+			if (only_object_name) {
+				printf("%s%c", find_unique_abbrev(&ui->oid[i], abbrev), line_terminator);
+				continue;
+			}
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(&ui->oid[i], abbrev),
 			       i + 1);
@@ -635,6 +645,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
+		OPT_BOOL(0, "only-object-name", &only_object_name,
+			N_("only show staged contents' object name in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
@@ -734,6 +746,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
+	if (only_object_name && !show_stage && !show_resolve_undo)
+		die("ls-files --only-object-name only used with --stage "
+		    "or --resolve-undo");
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index f691e6d9032..d940226c5f9 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -32,6 +32,31 @@ check_resolve_undo () {
 	test_cmp "$msg.expect" "$msg.actual"
 }
 
+check_resolve_undo_only_object_name() {
+	msg=$1
+	shift
+	while case $# in
+	0)	break ;;
+	1|2|3)	die "Bug in check-resolve-undo test" ;;
+	esac
+	do
+		path=$1
+		shift
+		for stage in 1 2 3
+		do
+			sha1=$1
+			shift
+			case "$sha1" in
+			'') continue ;;
+			esac
+			sha1=$(git rev-parse --verify "$sha1")
+			printf "%s\n" $sha1
+		done
+	done >"$msg.expect" &&
+	git ls-files --resolve-undo --only-object-name >"$msg.actual" &&
+	test_cmp "$msg.expect" "$msg.actual"
+}
+
 prime_resolve_undo () {
 	git reset --hard &&
 	git checkout second^0 &&
@@ -194,4 +219,12 @@ test_expect_success 'rerere forget (add-add conflict)' '
 	test_i18ngrep "no remembered" actual
 '
 
+test_expect_success '--resolve-undo with --only-object-name' '
+	prime_resolve_undo &&
+	check_resolve_undo_only_object_name kept fi/le initial:fi/le second:fi/le third:fi/le &&
+	git checkout second^0 &&
+	echo switching clears &&
+	check_resolve_undo cleared
+'
+
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index a16e25c79bd..e42f6e7e548 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -52,4 +52,36 @@ test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --stage with --only-object-name' '
+	git init test &&
+	test_when_finished "rm -rf test" &&
+	(
+		cd test &&
+		echo a >a.txt &&
+		echo b >b.txt &&
+		git add a.txt b.txt &&
+		oid1=$(git hash-object a.txt) &&
+		oid2=$(git hash-object b.txt) &&
+		git ls-files --stage --only-object-name >actual &&
+		cat >expect <<-EOF &&
+		$oid1
+		$oid2
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git ls-files --only-object-name without --stage or --resolve-undo' '
+	git init test &&
+	test_when_finished "rm -rf test" &&
+	(
+		cd test &&
+		echo a >a.txt &&
+		echo b >b.txt &&
+		git add a.txt b.txt &&
+		test_must_fail git ls-files --only-object-name 2>stderr &&
+		test_i18ngrep "fatal: ls-files --only-object-name only used with --stage or --resolve-undo" stderr
+	)
+'
+
 test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
