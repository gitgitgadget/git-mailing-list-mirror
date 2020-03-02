Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B81C3F2CD
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002AE20836
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIFMlKdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCBSTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:19:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 13:19:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id u9so83224wml.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWv4D9tB0wsTzpQPoU1oJk8O91qHfgfGanOgjbpjGNw=;
        b=JIFMlKdPA30YTd6w+F5cMUKNilFp+fzbrOgQu725y3X2zdt2f/btf7qoyC89Q6H4ic
         O3Ughu8tEoBH/a3cWYrBpLkJjFDlVvSBDOXPPZNhSTn1c1nfvK2knOvnvM1XGOCwLQWu
         JS2uFQrxoDBl/QH7FI0iGYMNZ7jKeOvY4xNWifpZfcUmvQSvyykOMfzkCd5XfFTwxlnH
         RW2ig4JC/Q1V4Pw+95KypDecmZEChyIyWBsBmOOl3++dMotuqnDhqLrNSPLG3LMowwbB
         5XlQr9lv9YuIZX8gaZWYBD1i6n5VUk0bdG7uff/9xIbAu06j45Cl0/I07AQBXdsHzfkc
         xkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWv4D9tB0wsTzpQPoU1oJk8O91qHfgfGanOgjbpjGNw=;
        b=AWwUsKBvGotrRsYtvU0URrTrQOny/ntQvIZgcFJTS/PklH2ItUYjnGoxbSl1KM+pnO
         JHTdfMxqdUqYMJ7MzPpOpHu7oe6ghlPd0xgDj5+2Li2d8fq7gVK8u0zJzCmx0R+2hrgi
         JtmFUuzzYGrrL4MhkiNESmuDuFUgJe5a/tV+nRW3AyKA6RC9L5fU+3NJhkDarFCp4nV0
         XW9lsc2J4hrKIPOUgHjz3V815f5xL47oXAIQli0PtW0lGqvwQtZbE0ts4GZIEjpyrG2J
         UdKDLBmcFVwFmC8LZU+XgAgYQQ/T8I2VQ8ezr4WibLHppEhXH0lI9tf9jUMpPdlER4J7
         2+fQ==
X-Gm-Message-State: ANhLgQ0OKjFG/jS+7BUnwN9dXOPe2HS9YUSqp4bjYzCHAlSqyH6I38Z1
        Laictly+irygF05TB/qOTn4=
X-Google-Smtp-Source: ADFU+vulZ72ySPncXzkwz1xK1Gs0v8MYn5qH0c/t1KFuYW3nC0teiyMIIDX4Nnu1cmGVKdvN6NQs6w==
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr85612wme.134.1583173165802;
        Mon, 02 Mar 2020 10:19:25 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id j5sm301051wmi.33.2020.03.02.10.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 10:19:25 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:19:24 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [PATCH 2/2] stash: remove the stash.useBuiltin setting
Message-ID: <20200302181924.GB1571684@cat>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
 <20200302181832.GA1571684@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302181832.GA1571684@cat>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the stash.useBuiltin setting which was added as an escape hatch
to disable the builtin version of stash first released with Git 2.22.

Carrying the legacy version is a maintenance burden, and has in fact
become out of date failing a test since the 2.23 release, without
anyone noticing until now.  So users would be getting a hint to fall
back to a potentially buggy version of the tool.

We used to shell out to git config to get the useBuiltin configuration
to avoid changing any global state before spawning legacy-stash.
However that is no longer necessary, so just use the 'git_config'
function to get the setting instead.

Similar to what we've done in d03ebd411c ("rebase: remove the
rebase.useBuiltin setting", 2019-03-18), where we remove the
corresponding setting for rebase, we leave the documentation in place,
so people can refer back to it when searching for it online, and so we
can refer to it in the commit message.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 .gitignore                     |   1 -
 Documentation/config/stash.txt |  18 +-
 Makefile                       |   1 -
 builtin/stash.c                |  44 +-
 git-legacy-stash.sh            | 798 ---------------------------------
 t/README                       |   4 -
 t/t3903-stash.sh               |  14 +
 7 files changed, 30 insertions(+), 850 deletions(-)
 delete mode 100755 git-legacy-stash.sh

diff --git a/.gitignore b/.gitignore
index aebe7c0908..188bd1c3de 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,7 +83,6 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
-/git-legacy-stash
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index abc7ef4a3a..0f3db821f6 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,17 +1,9 @@
 stash.useBuiltin::
-       Set to `false` to use the legacy shell script implementation of
-       linkgit:git-stash[1]. Is `true` by default, which means use
-       the built-in rewrite of it in C.
-+
-The C rewrite is first included with Git version 2.22 (and Git for Windows
-version 2.19). This option serves as an escape hatch to re-enable the
-legacy version in case any bugs are found in the rewrite. This option and
-the shell script version of linkgit:git-stash[1] will be removed in some
-future release.
-+
-If you find some reason to set this option to `false`, other than
-one-off testing, you should report the behavior difference as a bug in
-Git (see https://git-scm.com/community for details).
+	Unused configuration Variable.  Used in Git versions 2.22 to
+	2.26 as an escape hatch to enable the legacy shellscript
+	implementation of rebase. Now the built-in rewrite of it in C
+	is always used. Setting this will emit a warning, to alert any
+	remaining users that setting this now does nothing.
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
diff --git a/Makefile b/Makefile
index 9804a0758b..096c6d1fbb 100644
--- a/Makefile
+++ b/Makefile
@@ -609,7 +609,6 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/builtin/stash.c b/builtin/stash.c
index f371db270c..5f4bd693df 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -701,6 +701,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 static int show_stat = 1;
 static int show_patch;
+static int use_legacy_stash;
 
 static int git_stash_config(const char *var, const char *value, void *cb)
 {
@@ -712,6 +713,10 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_patch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.usebuiltin")) {
+		use_legacy_stash = !git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_basic_config(var, value, cb);
 }
 
@@ -1524,29 +1529,6 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int use_builtin_stash(void)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
-	int ret, env = git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1);
-
-	if (env != -1)
-		return env;
-
-	argv_array_pushl(&cp.args,
-			 "config", "--bool", "stash.usebuiltin", NULL);
-	cp.git_cmd = 1;
-	if (capture_command(&cp, &out, 6)) {
-		strbuf_release(&out);
-		return 1;
-	}
-
-	strbuf_trim(&out);
-	ret = !strcmp("true", out.buf);
-	strbuf_release(&out);
-	return ret;
-}
-
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	int i = -1;
@@ -1558,22 +1540,18 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (!use_builtin_stash()) {
-		const char *path = mkpath("%s/git-legacy-stash",
-					  git_exec_path());
-
-		if (sane_execvp(path, (char **)argv) < 0)
-			die_errno(_("could not exec %s"), path);
-		else
-			BUG("sane_execvp() returned???");
-	}
-
 	prefix = setup_git_directory();
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
 	git_config(git_stash_config, NULL);
 
+	if (use_legacy_stash ||
+	    !git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1))
+		warning(_("the stash.useBuiltin support has been removed!\n"
+			  "See its entry in 'git help config' for details."));
+
+
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
deleted file mode 100755
index 4d4ebb4f2b..0000000000
--- a/git-legacy-stash.sh
+++ /dev/null
@@ -1,798 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2007, Nanako Shiraishi
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
-   or: $dashless show [<stash>]
-   or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-   or: $dashless branch <branchname> [<stash>]
-   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [<message>]
-   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [-m <message>]
-		       [-- <pathspec>...]]
-   or: $dashless clear"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-START_DIR=$(pwd)
-. git-sh-setup
-require_work_tree
-prefix=$(git rev-parse --show-prefix) || exit 1
-cd_to_toplevel
-
-TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
-trap 'rm -f "$TMP-"* "$TMPindex"' 0
-
-ref_stash=refs/stash
-
-if git config --get-colorbool color.interactive; then
-       help_color="$(git config --get-color color.interactive.help 'red bold')"
-       reset_color="$(git config --get-color '' reset)"
-else
-       help_color=
-       reset_color=
-fi
-
-no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
-	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files "$@")")
-}
-
-untracked_files () {
-	if test "$1" = "-z"
-	then
-		shift
-		z=-z
-	else
-		z=
-	fi
-	excl_opt=--exclude-standard
-	test "$untracked" = "all" && excl_opt=
-	git ls-files -o $z $excl_opt -- "$@"
-}
-
-prepare_fallback_ident () {
-	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
-	then
-		GIT_AUTHOR_NAME="git stash"
-		GIT_AUTHOR_EMAIL=git@stash
-		GIT_COMMITTER_NAME="git stash"
-		GIT_COMMITTER_EMAIL=git@stash
-		export GIT_AUTHOR_NAME
-		export GIT_AUTHOR_EMAIL
-		export GIT_COMMITTER_NAME
-		export GIT_COMMITTER_EMAIL
-	fi
-}
-
-clear_stash () {
-	if test $# != 0
-	then
-		die "$(gettext "git stash clear with parameters is unimplemented")"
-	fi
-	if current=$(git rev-parse --verify --quiet $ref_stash)
-	then
-		git update-ref -d $ref_stash $current
-	fi
-}
-
-maybe_quiet () {
-	case "$1" in
-	--keep-stdout)
-		shift
-		if test -n "$GIT_QUIET"
-		then
-			"$@" 2>/dev/null
-		else
-			"$@"
-		fi
-		;;
-	*)
-		if test -n "$GIT_QUIET"
-		then
-			"$@" >/dev/null 2>&1
-		else
-			"$@"
-		fi
-		;;
-	esac
-}
-
-create_stash () {
-
-	prepare_fallback_ident
-
-	stash_msg=
-	untracked=
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-u|--include-untracked)
-			shift
-			untracked=${1?"BUG: create_stash () -u requires an argument"}
-			;;
-		--)
-			shift
-			break
-			;;
-		esac
-		shift
-	done
-
-	git update-index -q --refresh
-	if maybe_quiet no_changes "$@"
-	then
-		exit 0
-	fi
-
-	# state of the base commit
-	if b_commit=$(maybe_quiet --keep-stdout git rev-parse --verify HEAD)
-	then
-		head=$(git rev-list --oneline -n 1 HEAD --)
-	elif test -n "$GIT_QUIET"
-	then
-		exit 1
-	else
-		die "$(gettext "You do not have the initial commit yet")"
-	fi
-
-	if branch=$(git symbolic-ref -q HEAD)
-	then
-		branch=${branch#refs/heads/}
-	else
-		branch='(no branch)'
-	fi
-	msg=$(printf '%s: %s' "$branch" "$head")
-
-	# state of the index
-	i_tree=$(git write-tree) &&
-	i_commit=$(printf 'index on %s\n' "$msg" |
-		git commit-tree $i_tree -p $b_commit) ||
-		die "$(gettext "Cannot save the current index state")"
-
-	if test -n "$untracked"
-	then
-		# Untracked files are stored by themselves in a parentless commit, for
-		# ease of unpacking later.
-		u_commit=$(
-			untracked_files -z "$@" | (
-				GIT_INDEX_FILE="$TMPindex" &&
-				export GIT_INDEX_FILE &&
-				rm -f "$TMPindex" &&
-				git update-index -z --add --remove --stdin &&
-				u_tree=$(git write-tree) &&
-				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
-				rm -f "$TMPindex"
-		) ) || die "$(gettext "Cannot save the untracked files")"
-
-		untracked_commit_option="-p $u_commit";
-	else
-		untracked_commit_option=
-	fi
-
-	if test -z "$patch_mode"
-	then
-
-		# state of the working tree
-		w_tree=$( (
-			git read-tree --index-output="$TMPindex" -m $i_tree &&
-			GIT_INDEX_FILE="$TMPindex" &&
-			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
-			git update-index --ignore-skip-worktree-entries \
-				-z --add --remove --stdin <"$TMP-stagenames" &&
-			git write-tree &&
-			rm -f "$TMPindex"
-		) ) ||
-			die "$(gettext "Cannot save the current worktree state")"
-
-	else
-
-		rm -f "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" git read-tree HEAD &&
-
-		# find out what the user wants
-		GIT_INDEX_FILE="$TMP-index" \
-			git add --legacy-stash-p -- "$@" &&
-
-		# state of the working tree
-		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
-		die "$(gettext "Cannot save the current worktree state")"
-
-		git diff-tree -p HEAD $w_tree -- >"$TMP-patch" &&
-		test -s "$TMP-patch" ||
-		die "$(gettext "No changes selected")"
-
-		rm -f "$TMP-index" ||
-		die "$(gettext "Cannot remove temporary index (can't happen)")"
-
-	fi
-
-	# create the stash
-	if test -z "$stash_msg"
-	then
-		stash_msg=$(printf 'WIP on %s' "$msg")
-	else
-		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
-	fi
-	w_commit=$(printf '%s\n' "$stash_msg" |
-	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
-	die "$(gettext "Cannot record working tree state")"
-}
-
-store_stash () {
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg="$1"
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-q|--quiet)
-			quiet=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-	test $# = 1 ||
-	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
-
-	w_commit="$1"
-	if test -z "$stash_msg"
-	then
-		stash_msg="Created via \"git stash store\"."
-	fi
-
-	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
-	ret=$?
-	test $ret != 0 && test -z "$quiet" &&
-	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
-	return $ret
-}
-
-push_stash () {
-	keep_index=
-	patch_mode=
-	untracked=
-	stash_msg=
-	while test $# != 0
-	do
-		case "$1" in
-		-k|--keep-index)
-			keep_index=t
-			;;
-		--no-keep-index)
-			keep_index=n
-			;;
-		-p|--patch)
-			patch_mode=t
-			# only default to keep if we don't already have an override
-			test -z "$keep_index" && keep_index=t
-			;;
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		-u|--include-untracked)
-			untracked=untracked
-			;;
-		-a|--all)
-			untracked=all
-			;;
-		-m|--message)
-			shift
-			test -z ${1+x} && usage
-			stash_msg=$1
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		--help)
-			show_help
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			option="$1"
-			eval_gettextln "error: unknown option for 'stash push': \$option"
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
-
-	if test -n "$patch_mode" && test -n "$untracked"
-	then
-		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
-	fi
-
-	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
-
-	git update-index -q --refresh
-	if maybe_quiet no_changes "$@"
-	then
-		say "$(gettext "No local changes to save")"
-		exit 0
-	fi
-
-	git reflog exists $ref_stash ||
-		clear_stash || die "$(gettext "Cannot initialize stash")"
-
-	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
-	die "$(gettext "Cannot save the current status")"
-	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
-
-	if test -z "$patch_mode"
-	then
-		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked" && test $# = 0
-		then
-			git clean --force --quiet -d $CLEAN_X_OPTION
-		fi
-
-		if test $# != 0
-		then
-			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
-			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
-			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
-			git diff-index -p --cached --binary HEAD -- "$@" |
-			git apply --index -R
-		else
-			git reset --hard -q --no-recurse-submodules
-		fi
-
-		if test "$keep_index" = "t" && test -n "$i_tree"
-		then
-			git read-tree --reset $i_tree
-			git ls-files -z --modified -- "$@" |
-			git checkout-index -z --force --stdin
-		fi
-	else
-		git apply -R < "$TMP-patch" ||
-		die "$(gettext "Cannot remove worktree changes")"
-
-		if test "$keep_index" != "t"
-		then
-			git reset -q -- "$@"
-		fi
-	fi
-}
-
-save_stash () {
-	push_options=
-	while test $# != 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			# pass all options through to push_stash
-			push_options="$push_options $1"
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	stash_msg="$*"
-
-	if test -z "$stash_msg"
-	then
-		push_stash $push_options
-	else
-		push_stash $push_options -m "$stash_msg"
-	fi
-}
-
-have_stash () {
-	git rev-parse --verify --quiet $ref_stash >/dev/null
-}
-
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
-show_stash () {
-	ALLOW_UNKNOWN_FLAGS=t
-	assert_stash_like "$@"
-
-	if test -z "$FLAGS"
-	then
-		if test "$(git config --bool stash.showStat || echo true)" = "true"
-		then
-			FLAGS=--stat
-		fi
-
-		if test "$(git config --bool stash.showPatch || echo false)" = "true"
-		then
-			FLAGS=${FLAGS}${FLAGS:+ }-p
-		fi
-
-		if test -z "$FLAGS"
-		then
-			return 0
-		fi
-	fi
-
-	git diff ${FLAGS} $b_commit $w_commit
-}
-
-show_help () {
-	exec git help stash
-	exit 1
-}
-
-#
-# Parses the remaining options looking for flags and
-# at most one revision defaulting to ${ref_stash}@{0}
-# if none found.
-#
-# Derives related tree and commit objects from the
-# revision, if one is found.
-#
-# stash records the work tree, and is a merge between the
-# base commit (first parent) and the index tree (second parent).
-#
-#   REV is set to the symbolic version of the specified stash-like commit
-#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
-#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
-#   s is set to the SHA1 of the stash commit
-#   w_commit is set to the commit containing the working tree
-#   b_commit is set to the base commit
-#   i_commit is set to the commit containing the index tree
-#   u_commit is set to the commit containing the untracked files tree
-#   w_tree is set to the working tree
-#   b_tree is set to the base tree
-#   i_tree is set to the index tree
-#   u_tree is set to the untracked files tree
-#
-#   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags (if allowed)
-#
-# dies if:
-#   * too many revisions specified
-#   * no revision is specified and there is no stash stack
-#   * a revision is specified which cannot be resolve to a SHA1
-#   * a non-existent stash reference is specified
-#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
-#
-
-parse_flags_and_rev()
-{
-	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
-	PARSE_CACHE="$*"
-
-	IS_STASH_LIKE=
-	IS_STASH_REF=
-	INDEX_OPTION=
-	s=
-	w_commit=
-	b_commit=
-	i_commit=
-	u_commit=
-	w_tree=
-	b_tree=
-	i_tree=
-	u_tree=
-
-	FLAGS=
-	REV=
-	for opt
-	do
-		case "$opt" in
-			-q|--quiet)
-				GIT_QUIET=-t
-			;;
-			--index)
-				INDEX_OPTION=--index
-			;;
-			--help)
-				show_help
-			;;
-			-*)
-				test "$ALLOW_UNKNOWN_FLAGS" = t ||
-					die "$(eval_gettext "unknown option: \$opt")"
-				FLAGS="${FLAGS}${FLAGS:+ }$opt"
-			;;
-			*)
-				REV="${REV}${REV:+ }'$opt'"
-			;;
-		esac
-	done
-
-	eval set -- $REV
-
-	case $# in
-		0)
-			have_stash || die "$(gettext "No stash entries found.")"
-			set -- ${ref_stash}@{0}
-		;;
-		1)
-			:
-		;;
-		*)
-			die "$(eval_gettext "Too many revisions specified: \$REV")"
-		;;
-	esac
-
-	case "$1" in
-		*[!0-9]*)
-			:
-		;;
-		*)
-			set -- "${ref_stash}@{$1}"
-		;;
-	esac
-
-	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
-		reference="$1"
-		die "$(eval_gettext "\$reference is not a valid reference")"
-	}
-
-	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
-	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
-	s=$1 &&
-	w_commit=$1 &&
-	b_commit=$2 &&
-	w_tree=$3 &&
-	b_tree=$4 &&
-	i_tree=$5 &&
-	IS_STASH_LIKE=t &&
-	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
-	IS_STASH_REF=t
-
-	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
-	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
-}
-
-is_stash_like()
-{
-	parse_flags_and_rev "$@"
-	test -n "$IS_STASH_LIKE"
-}
-
-assert_stash_like() {
-	is_stash_like "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash-like commit")"
-	}
-}
-
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-
-	assert_stash_like "$@"
-
-	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
-
-	# current index state
-	c_tree=$(git write-tree) ||
-		die "$(gettext "Cannot apply a stash in the middle of a merge")"
-
-	unstashed_index_tree=
-	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
-			test "$c_tree" != "$i_tree"
-	then
-		git diff-tree --binary $s^2^..$s^2 | git apply --cached
-		test $? -ne 0 &&
-			die "$(gettext "Conflicts in index. Try without --index.")"
-		unstashed_index_tree=$(git write-tree) ||
-			die "$(gettext "Could not save index tree")"
-		git reset
-	fi
-
-	if test -n "$u_tree"
-	then
-		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
-		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
-		rm -f "$TMPindex" ||
-		die "$(gettext "Could not restore untracked files from stash entry")"
-	fi
-
-	eval "
-		GITHEAD_$w_tree='Stashed changes' &&
-		GITHEAD_$c_tree='Updated upstream' &&
-		GITHEAD_$b_tree='Version stash was based on' &&
-		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
-	"
-
-	if test -n "$GIT_QUIET"
-	then
-		GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
-	fi
-	if git merge-recursive $b_tree -- $c_tree $w_tree
-	then
-		# No conflict
-		if test -n "$unstashed_index_tree"
-		then
-			git read-tree "$unstashed_index_tree"
-		else
-			a="$TMP-added" &&
-			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
-			git read-tree --reset $c_tree &&
-			git update-index --add --stdin <"$a" ||
-				die "$(gettext "Cannot unstage modified files")"
-			rm -f "$a"
-		fi
-		squelch=
-		if test -n "$GIT_QUIET"
-		then
-			squelch='>/dev/null 2>&1'
-		fi
-		(cd "$START_DIR" && eval "git status $squelch") || :
-	else
-		# Merge conflict; keep the exit status from merge-recursive
-		status=$?
-		git rerere
-		if test -n "$INDEX_OPTION"
-		then
-			gettextln "Index was not unstashed." >&2
-		fi
-		exit $status
-	fi
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
-test "$1" = "-p" && set "push" "$@"
-
-PARSE_CACHE='--not-parsed'
-# The default command is "push" if nothing but options are given
-seen_non_option=
-for opt
-do
-	case "$opt" in
-	--) break ;;
-	-*) ;;
-	*) seen_non_option=t; break ;;
-	esac
-done
-
-test -n "$seen_non_option" || set "push" "$@"
-
-# Main command set
-case "$1" in
-list)
-	shift
-	list_stash "$@"
-	;;
-show)
-	shift
-	show_stash "$@"
-	;;
-save)
-	shift
-	save_stash "$@"
-	;;
-push)
-	shift
-	push_stash "$@"
-	;;
-apply)
-	shift
-	apply_stash "$@"
-	;;
-clear)
-	shift
-	clear_stash "$@"
-	;;
-create)
-	shift
-	create_stash -m "$*" && echo "$w_commit"
-	;;
-store)
-	shift
-	store_stash "$@"
-	;;
-drop)
-	shift
-	drop_stash "$@"
-	;;
-pop)
-	shift
-	pop_stash "$@"
-	;;
-branch)
-	shift
-	apply_to_branch "$@"
-	;;
-*)
-	case $# in
-	0)
-		push_stash &&
-		say "$(gettext "(To restore them type \"git stash apply\")")"
-		;;
-	*)
-		usage
-	esac
-	;;
-esac
diff --git a/t/README b/t/README
index 9afd61e3ca..369e3a9ded 100644
--- a/t/README
+++ b/t/README
@@ -393,10 +393,6 @@ the --no-sparse command-line argument.
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
-GIT_TEST_STASH_USE_BUILTIN=<boolean>, when false, disables the
-built-in version of git-stash. See 'stash.useBuiltin' in
-git-config(1).
-
 GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
 built-in version of git add -i. See 'add.interactive.useBuiltin' in
 git-config(1).
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea56e85e70..b84d55a832 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1285,4 +1285,18 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+test_expect_success 'stash -c stash.useBuiltin=false warning ' '
+	expected="stash.useBuiltin support has been removed" &&
+
+	git -c stash.useBuiltin=false stash 2>err &&
+	test_i18ngrep "$expected" err &&
+	env GIT_TEST_STASH_USE_BUILTIN=false git stash 2>err &&
+	test_i18ngrep "$expected" err &&
+
+	git -c stash.useBuiltin=true stash 2>err &&
+	test_must_be_empty err &&
+	env GIT_TEST_STASH_USE_BUILTIN=true git stash 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.25.1.377.g2d2118b814

