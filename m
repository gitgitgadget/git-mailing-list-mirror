Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEAC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21E20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbhAACRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:33 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97253C061799
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:11 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d20so19317927otl.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfH29uADgGTx/5aFuQU3d0ICem7q0ZiG+yokpPPBIGw=;
        b=Pma8ma2SMdyPT8lRoHCn0HG4zoKr1D7t/nSAvBH2Vu3hmcQM77UFSJlcIAdVEUam5x
         Dx2nejojcgXFTVafLoI3BXr6SyE6Yya1gAdqLAOkfpWLKQyYeFDfhACZzxoWGURHRpuk
         3KG8x6PqjFrBC5MB56I62sZ5RDzdj3BGTIyfgJXcZwjymrZzDmXoW+7omoJypzC1WFd3
         HhfnTPbC3EYcqUWH2hGhTipW0GaOk8NFXv3deZXKNcoxO2oGJoiYV8lkt9tp3X6kMIHH
         qjEdvcuI7bPX4yUgzV/dHV2wrPEAXHbK+hUwW3nxonUJ7SOAYm6N1HYnIEO0lOAjZgw0
         IazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfH29uADgGTx/5aFuQU3d0ICem7q0ZiG+yokpPPBIGw=;
        b=lTt4DQfrmddSK3LEGj1TnHFpvCQoeRwdQVr8qjRKa84Pyx3H/OMzi8P8+TM3T6RcNw
         L9O9px7R8YG9qYQxg1XqZMLiZ/6y85z75imaDXa66KurnXgoi+XtSs1A1tgd+R21+JLa
         VL0mXE2uKpI7CLEDLJETxBrBLiKaek7uVEmlSgpYgZqWg1ZSFOA69BnWHWq1GULYh1VW
         NJ7KrYUYLWwTn/cqQ3J5vDOfV0crCCPd42nRIwU8MnIfEvx3U3qXejCaKijB9JL8XCFl
         T/lHqGO5Yl3dBChnn+TPRaL5pz8GkLja++4CcanMKvncA/t7hAv3CA0cxWjB4LIyxs/Q
         6hKw==
X-Gm-Message-State: AOAM53373mqs4KLJ75s0/hl00nHyFJFB8mFq7iXtiIATbSsmSvRbrUvJ
        y6K6QTPDqWQuHjRAJJ14y7gAGJxvqo3/oQ==
X-Google-Smtp-Source: ABdhPJwbt9mTGJ5j4DE37l/zONyF9MTbb8V4b36DVQSnWYsC1UdSwO/1maxcNfPUEIUPvgLzEYSTCQ==
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr28403624oth.316.1609467430622;
        Thu, 31 Dec 2020 18:17:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t2sm8784892otj.47.2020.12.31.18.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:10 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 29/47] completion: add __gitcomp_opts
Date:   Thu, 31 Dec 2020 20:16:04 -0600
Message-Id: <20210101021622.798041-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new simplified version of __gitcomp for most callers, and
__gitcomp_opts for the ones that need reorganizing all the options.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 114 ++++++++++++++-----------
 contrib/completion/git-completion.zsh  |   8 ++
 t/t9902-completion.sh                  |  58 ++++++-------
 3 files changed, 100 insertions(+), 80 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e56f96bdd6..faf563b783 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -310,13 +310,25 @@ __gitcompadd ()
 	done
 }
 
-# Creates completion replies, reorganizing options and adding suffixes as needed.
+# Creates completion replies.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
 # 3: Generate possible completion matches for this word (optional).
 # 4: A suffix to be appended to each possible completion word (optional).
 __gitcomp ()
+{
+	local IFS=$' \t\n'
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
+}
+
+# Creates completion replies, reorganizing options and adding suffixes as needed.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word (optional).
+__gitcomp_opts ()
 {
 	local cur_="${3-$cur}"
 
@@ -360,7 +372,7 @@ fi
 
 # This function is equivalent to
 #
-#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#    __gitcomp_opts "$(git xxx --git-completion-helper) ..."
 #
 # except that the output is cached. Accept 1-3 arguments:
 # 1: the git command to execute, this is also the cache key
@@ -395,7 +407,7 @@ __gitcomp_builtin ()
 		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options"
+	__gitcomp_opts "$options"
 }
 
 # Generates completion reply from newline-separated possible completion words
@@ -1032,7 +1044,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	-X)
-		__gitcomp "$__git_merge_strategy_options"
+		__gitcomp_opts "$__git_merge_strategy_options"
 		return 0
 		;;
 	esac
@@ -1042,7 +1054,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	--strategy-option=*)
-		__gitcomp "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
+		__gitcomp_opts "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
 		return 0
 		;;
 	esac
@@ -1283,7 +1295,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "$__git_am_inprogress_options"
+		__gitcomp_opts "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1537,7 +1549,7 @@ _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp_opts "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 
@@ -1695,7 +1707,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_diff_difftool_options"
+		__gitcomp_opts "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -1989,7 +2001,7 @@ _git_log ()
 		return
 		;;
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
@@ -2052,7 +2064,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp_opts "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
@@ -2200,7 +2212,7 @@ _git_range_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
@@ -2217,11 +2229,11 @@ _git_rebase ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
-		__gitcomp "$__git_rebase_interactive_inprogress_options"
+		__gitcomp_opts "$__git_rebase_interactive_inprogress_options"
 		return
 	elif [ -d "$__git_repo_path"/rebase-apply ] || \
 	     [ -d "$__git_repo_path"/rebase-merge ]; then
-		__gitcomp "$__git_rebase_inprogress_options"
+		__gitcomp_opts "$__git_rebase_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2663,7 +2675,7 @@ __git_complete_config_variable_name ()
 					for (s in sections)
 						print s "."
 				}
-				')" "" "$cur_"
+				')" "" "$cur_" ""
 		;;
 	esac
 }
@@ -2841,7 +2853,7 @@ _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "$__git_revert_inprogress_options"
+		__gitcomp_opts "$__git_revert_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2873,7 +2885,7 @@ _git_shortlog ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			--numbered --summary --email
@@ -2911,7 +2923,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
+		__gitcomp_opts "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
@@ -2944,10 +2956,10 @@ _git_sparse_checkout ()
 
 	case "$subcommand,$cur" in
 	init,--*)
-		__gitcomp "--cone"
+		__gitcomp_opts "--cone"
 		;;
 	set,--*)
-		__gitcomp "--stdin"
+		__gitcomp_opts "--stdin"
 		;;
 	*)
 		;;
@@ -2965,7 +2977,7 @@ _git_stash ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "$save_opts"
+			__gitcomp_opts "$save_opts"
 			;;
 		sa*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
@@ -2981,22 +2993,22 @@ _git_stash ()
 	else
 		case "$subcommand,$cur" in
 		push,--*)
-			__gitcomp "$save_opts --message"
+			__gitcomp_opts "$save_opts --message"
 			;;
 		save,--*)
-			__gitcomp "$save_opts"
+			__gitcomp_opts "$save_opts"
 			;;
 		apply,--*|pop,--*)
-			__gitcomp "--index --quiet"
+			__gitcomp_opts "--index --quiet"
 			;;
 		drop,--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		list,--*)
-			__gitcomp "--name-status --oneline --patch-with-stat"
+			__gitcomp_opts "--name-status --oneline --patch-with-stat"
 			;;
 		show,--*)
-			__gitcomp "$__git_diff_common_options"
+			__gitcomp_opts "$__git_diff_common_options"
 			;;
 		branch,--*)
 			;;
@@ -3027,7 +3039,7 @@ _git_submodule ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -3038,29 +3050,29 @@ _git_submodule ()
 
 	case "$subcommand,$cur" in
 	add,--*)
-		__gitcomp "--branch --force --name --reference --depth"
+		__gitcomp_opts "--branch --force --name --reference --depth"
 		;;
 	status,--*)
-		__gitcomp "--cached --recursive"
+		__gitcomp_opts "--cached --recursive"
 		;;
 	deinit,--*)
-		__gitcomp "--force --all"
+		__gitcomp_opts "--force --all"
 		;;
 	update,--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--init --remote --no-fetch
 			--recommend-shallow --no-recommend-shallow
 			--force --rebase --merge --reference --depth --recursive --jobs
 		"
 		;;
 	set-branch,--*)
-		__gitcomp "--default --branch"
+		__gitcomp_opts "--default --branch"
 		;;
 	summary,--*)
-		__gitcomp "--cached --files --summary-limit"
+		__gitcomp_opts "--cached --files --summary-limit"
 		;;
 	foreach,--*|sync,--*)
-		__gitcomp "--recursive"
+		__gitcomp_opts "--recursive"
 		;;
 	*)
 		;;
@@ -3101,64 +3113,64 @@ _git_svn ()
 
 		case "$subcommand,$cur" in
 		fetch,--*)
-			__gitcomp "--revision= --fetch-all $fc_opts"
+			__gitcomp_opts "--revision= --fetch-all $fc_opts"
 			;;
 		clone,--*)
-			__gitcomp "--revision= $fc_opts $init_opts"
+			__gitcomp_opts "--revision= $fc_opts $init_opts"
 			;;
 		init,--*)
-			__gitcomp "$init_opts"
+			__gitcomp_opts "$init_opts"
 			;;
 		dcommit,--*)
-			__gitcomp "
+			__gitcomp_opts "
 				--merge --strategy= --verbose --dry-run
 				--fetch-all --no-rebase --commit-url
 				--revision --interactive $cmt_opts $fc_opts
 				"
 			;;
 		set-tree,--*)
-			__gitcomp "--stdin $cmt_opts $fc_opts"
+			__gitcomp_opts "--stdin $cmt_opts $fc_opts"
 			;;
 		create-ignore,--*|propget,--*|proplist,--*|show-ignore,--*|\
 		show-externals,--*|mkdirs,--*)
-			__gitcomp "--revision="
+			__gitcomp_opts "--revision="
 			;;
 		log,--*)
-			__gitcomp "
+			__gitcomp_opts "
 				--limit= --revision= --verbose --incremental
 				--oneline --show-commit --non-recursive
 				--authors-file= --color
 				"
 			;;
 		rebase,--*)
-			__gitcomp "
+			__gitcomp_opts "
 				--merge --verbose --strategy= --local
 				--fetch-all --dry-run $fc_opts
 				"
 			;;
 		commit-diff,--*)
-			__gitcomp "--message= --file= --revision= $cmt_opts"
+			__gitcomp_opts "--message= --file= --revision= $cmt_opts"
 			;;
 		info,--*)
-			__gitcomp "--url"
+			__gitcomp_opts "--url"
 			;;
 		branch,--*)
-			__gitcomp "--dry-run --message --tag"
+			__gitcomp_opts "--dry-run --message --tag"
 			;;
 		tag,--*)
-			__gitcomp "--dry-run --message"
+			__gitcomp_opts "--dry-run --message"
 			;;
 		blame,--*)
-			__gitcomp "--git-format"
+			__gitcomp_opts "--git-format"
 			;;
 		migrate,--*)
-			__gitcomp "
+			__gitcomp_opts "
 				--config-dir= --ignore-paths= --minimize
 				--no-auth-cache --username=
 				"
 			;;
 		reset,--*)
-			__gitcomp "--revision= --parent"
+			__gitcomp_opts "--revision= --parent"
 			;;
 		*)
 			;;
@@ -3373,7 +3385,7 @@ __git_main ()
 			;;
 		esac
 		case "$cur" in
-		--*)   __gitcomp "
+		--*)   __gitcomp_opts "
 			--paginate
 			--no-pager
 			--git-dir=
@@ -3424,7 +3436,7 @@ __gitk_main ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_gitk_options
 			$merge
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0ef15ff643..d5ec8a1417 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -53,6 +53,14 @@ __gitcomp ()
 {
 	emulate -L zsh
 
+	local IFS=$' \t\n'
+	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+}
+
+__gitcomp_opts ()
+{
+	emulate -L zsh
+
 	local cur_="${3-$cur}"
 
 	[[ "$cur_" == *= ]] && return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e1a9e9483c..50b7b04021 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -98,17 +98,17 @@ test_completion ()
 	test_cmp expected out_sorted
 }
 
-# Test __gitcomp.
+# Test __gitcomp_opts.
 # The first argument is the typed text so far (cur); the rest are
-# passed to __gitcomp.  Expected output comes is read from the
+# passed to __gitcomp_opts.  Expected output comes is read from the
 # standard input, like test_completion().
-test_gitcomp ()
+test_gitcomp_opts ()
 {
 	local -a COMPREPLY &&
 	sed -e 's/Z$//' >expected &&
 	local cur="$1" &&
 	shift &&
-	__gitcomp "$@" &&
+	__gitcomp_opts "$@" &&
 	print_comp &&
 	test_cmp expected out
 }
@@ -463,8 +463,8 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	test_cmp expected out
 '
 
-test_expect_success '__gitcomp - trailing space - options' '
-	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
+test_expect_success '__gitcomp_opts - trailing space - options' '
+	test_gitcomp_opts "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
 	--reuse-message=Z
 	--reedit-message=Z
@@ -472,8 +472,8 @@ test_expect_success '__gitcomp - trailing space - options' '
 	EOF
 '
 
-test_expect_success '__gitcomp - trailing space - config keys' '
-	test_gitcomp "br" "branch. branch.autosetupmerge
+test_expect_success '__gitcomp_opts - trailing space - config keys' '
+	test_gitcomp_opts "br" "branch. branch.autosetupmerge
 		branch.autosetuprebase browser." <<-\EOF
 	branch.Z
 	branch.autosetupmerge Z
@@ -482,32 +482,32 @@ test_expect_success '__gitcomp - trailing space - config keys' '
 	EOF
 '
 
-test_expect_success '__gitcomp - option parameter' '
-	test_gitcomp "--strategy=re" "octopus ours recursive resolve subtree" \
+test_expect_success '__gitcomp_opts - option parameter' '
+	test_gitcomp_opts "--strategy=re" "octopus ours recursive resolve subtree" \
 		"" "re" <<-\EOF
 	recursive Z
 	resolve Z
 	EOF
 '
 
-test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
+test_expect_success '__gitcomp_opts - prefix' '
+	test_gitcomp_opts "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
 	EOF
 '
 
-test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.ma" "master maint next seen" "branch." \
+test_expect_success '__gitcomp_opts - suffix' '
+	test_gitcomp_opts "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
 	EOF
 '
 
-test_expect_success '__gitcomp - ignore optional negative options' '
-	test_gitcomp "--" "--abc --def --no-one -- --no-two" <<-\EOF
+test_expect_success '__gitcomp_opts - ignore optional negative options' '
+	test_gitcomp_opts "--" "--abc --def --no-one -- --no-two" <<-\EOF
 	--abc Z
 	--def Z
 	--no-one Z
@@ -515,44 +515,44 @@ test_expect_success '__gitcomp - ignore optional negative options' '
 	EOF
 '
 
-test_expect_success '__gitcomp - ignore/narrow optional negative options' '
-	test_gitcomp "--a" "--abc --abcdef --no-one -- --no-two" <<-\EOF
+test_expect_success '__gitcomp_opts - ignore/narrow optional negative options' '
+	test_gitcomp_opts "--a" "--abc --abcdef --no-one -- --no-two" <<-\EOF
 	--abc Z
 	--abcdef Z
 	EOF
 '
 
-test_expect_success '__gitcomp - ignore/narrow optional negative options' '
-	test_gitcomp "--n" "--abc --def --no-one -- --no-two" <<-\EOF
+test_expect_success '__gitcomp_opts - ignore/narrow optional negative options' '
+	test_gitcomp_opts "--n" "--abc --def --no-one -- --no-two" <<-\EOF
 	--no-one Z
 	--no-... Z
 	EOF
 '
 
-test_expect_success '__gitcomp - expand all negative options' '
-	test_gitcomp "--no-" "--abc --def --no-one -- --no-two" <<-\EOF
+test_expect_success '__gitcomp_opts - expand all negative options' '
+	test_gitcomp_opts "--no-" "--abc --def --no-one -- --no-two" <<-\EOF
 	--no-one Z
 	--no-two Z
 	EOF
 '
 
-test_expect_success '__gitcomp - expand/narrow all negative options' '
-	test_gitcomp "--no-o" "--abc --def --no-one -- --no-two" <<-\EOF
+test_expect_success '__gitcomp_opts - expand/narrow all negative options' '
+	test_gitcomp_opts "--no-o" "--abc --def --no-one -- --no-two" <<-\EOF
 	--no-one Z
 	EOF
 '
 
-test_expect_success '__gitcomp - equal skip' '
-	test_gitcomp "--option=" "--option=" <<-\EOF &&
+test_expect_success '__gitcomp_opts - equal skip' '
+	test_gitcomp_opts "--option=" "--option=" <<-\EOF &&
 
 	EOF
-	test_gitcomp "option=" "option=" <<-\EOF
+	test_gitcomp_opts "option=" "option=" <<-\EOF
 
 	EOF
 '
 
-test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
-	run_func __gitcomp "$invalid_variable_name"
+test_expect_success '__gitcomp_opts - doesnt fail because of invalid variable name' '
+	run_func __gitcomp_opts "$invalid_variable_name"
 '
 
 read -r -d "" refs <<-\EOF
-- 
2.30.0

