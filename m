Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87661C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2176120781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAOp46ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgKJVWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbgKJVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AEC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id j7so16095659oie.12
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7zN0nSLgY/3/vY0Ap3P6GJRm+kYhdpu8VQeX/X9xOs=;
        b=iAOp46ysmrGzQ5khV0pdX7flxQYyPR1NoR4zpBSlmnrpAq/0WhORlaImPLQw7NMo1k
         qanQFp3iMiCXdZb1KHOtQPFHcU15Qwk5yfrj/ADJOc9wILnDMSelkEMzcPF/FplZS7r4
         hS42a1gqVTU5y/4kQRBShbcz3A/BPCU+YuFRETQI9ZE2Mk6nlbVyalGrsso+Z1Z2fdOz
         JcIE7HMFGXPHw+pR6iT4CrWC9xPY99u4fY5R1XOKGXSjxaNHpp3x+dM/BiVQFlohZSW6
         EiXQFQ9MOPmOG15zVtFwMSnxdFIl18RCtMcg6LDJ0ho02aBMzD0DtDLHWQ2Q0gjUt9NJ
         li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7zN0nSLgY/3/vY0Ap3P6GJRm+kYhdpu8VQeX/X9xOs=;
        b=hzqi7B2h9zWM00d3VItuUuQqE6BhP81d1VLcp8aDwniyoe2uEpMoDIHLhrbN4ZS/ar
         vVesSEBwkJ/FeYyKj/t9h1iYUHEYBcG1t0CIMRp2bXAdzy/n38RNuB4glrHDVQOX8P5f
         0khvqYBLSYVBUKAFUL/mden3srwFnPBxAgPhBHBlbCDmAfAQemPa7edtUskCD6gsV6gr
         QXFi/usuzIX7/SgG4EMfrVsDSzNZu4byvIpBSrpiX6fwcMksYK80Meef03gp5+jBHphG
         l8T5XY9Oim0IrDUM/Fb/4UdsJIh57TqLDJWkdGy68scKay/5uE9T/uxGs5k4oeIenzHe
         96Gw==
X-Gm-Message-State: AOAM531PVlCC50tFEKzQltrj01Vxvo0Me9an/ypMIBGUuEKRodtm36QZ
        bQthSSqu1lC30OTLZp+XVd1JqUuapL6Nag==
X-Google-Smtp-Source: ABdhPJwgOe9gmbpLP+d8Qj3qnWvsseiRJcXdyBBgrzZK69iDiLh8BxQkvyQEyIM5S0tWeqFX4xuTCA==
X-Received: by 2002:aca:5c82:: with SMTP id q124mr51167oib.33.1605043345439;
        Tue, 10 Nov 2020 13:22:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b13sm27360otp.28.2020.11.10.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 24/26] completion: bash: add __gitcomp_opts
Date:   Tue, 10 Nov 2020 15:21:34 -0600
Message-Id: <20201110212136.870769-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh  |   9 ++
 t/t9902-completion.sh                  |  58 ++++++-------
 3 files changed, 101 insertions(+), 80 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8e6723874e..324793368d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -182,13 +182,25 @@ __gitcompadd ()
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
 
@@ -228,7 +240,7 @@ fi
 
 # This function is equivalent to
 #
-#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#    __gitcomp_opts "$(git xxx --git-completion-helper) ..."
 #
 # except that the output is cached. Accept 1-3 arguments:
 # 1: the git command to execute, this is also the cache key
@@ -263,7 +275,7 @@ __gitcomp_builtin ()
 		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options"
+	__gitcomp_opts "$options"
 }
 
 # Generates completion reply from newline-separated possible completion words
@@ -900,7 +912,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	-X)
-		__gitcomp "$__git_merge_strategy_options"
+		__gitcomp_opts "$__git_merge_strategy_options"
 		return 0
 		;;
 	esac
@@ -910,7 +922,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	--strategy-option=*)
-		__gitcomp "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
+		__gitcomp_opts "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
 		return 0
 		;;
 	esac
@@ -1133,7 +1145,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "$__git_am_inprogress_options"
+		__gitcomp_opts "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1387,7 +1399,7 @@ _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp_opts "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 
@@ -1545,7 +1557,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_diff_difftool_options"
+		__gitcomp_opts "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -1839,7 +1851,7 @@ _git_log ()
 		return
 		;;
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
@@ -1902,7 +1914,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp_opts "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
@@ -2050,7 +2062,7 @@ _git_range_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
@@ -2067,11 +2079,11 @@ _git_rebase ()
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
@@ -2513,7 +2525,7 @@ __git_complete_config_variable_name ()
 					for (s in sections)
 						print s "."
 				}
-				')" "" "$cur_"
+				')" "" "$cur_" ""
 		;;
 	esac
 }
@@ -2691,7 +2703,7 @@ _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "$__git_revert_inprogress_options"
+		__gitcomp_opts "$__git_revert_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2723,7 +2735,7 @@ _git_shortlog ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			--numbered --summary --email
@@ -2761,7 +2773,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
+		__gitcomp_opts "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
@@ -2794,10 +2806,10 @@ _git_sparse_checkout ()
 
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
@@ -2815,7 +2827,7 @@ _git_stash ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "$save_opts"
+			__gitcomp_opts "$save_opts"
 			;;
 		sa*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
@@ -2831,22 +2843,22 @@ _git_stash ()
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
@@ -2877,7 +2889,7 @@ _git_submodule ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -2888,29 +2900,29 @@ _git_submodule ()
 
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
@@ -2951,64 +2963,64 @@ _git_svn ()
 
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
@@ -3223,7 +3235,7 @@ __git_main ()
 			;;
 		esac
 		case "$cur" in
-		--*)   __gitcomp "
+		--*)   __gitcomp_opts "
 			--paginate
 			--no-pager
 			--git-dir=
@@ -3274,7 +3286,7 @@ __gitk_main ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_gitk_options
 			$merge
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1781401f5d..fc6d44bce0 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -53,6 +53,15 @@ __gitcomp ()
 {
 	emulate -L zsh
 
+	local IFS=$' \t\n'
+	compset -P '*[=:]'
+	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+}
+
+__gitcomp_opts ()
+{
+	emulate -L zsh
+
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index efb98cc96c..ea572960de 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -85,17 +85,17 @@ test_completion ()
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
@@ -450,8 +450,8 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	test_cmp expected out
 '
 
-test_expect_success '__gitcomp - trailing space - options' '
-	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
+test_expect_success '__gitcomp_opts - trailing space - options' '
+	test_gitcomp_opts "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
 	--reuse-message=Z
 	--reedit-message=Z
@@ -459,8 +459,8 @@ test_expect_success '__gitcomp - trailing space - options' '
 	EOF
 '
 
-test_expect_success '__gitcomp - trailing space - config keys' '
-	test_gitcomp "br" "branch. branch.autosetupmerge
+test_expect_success '__gitcomp_opts - trailing space - config keys' '
+	test_gitcomp_opts "br" "branch. branch.autosetupmerge
 		branch.autosetuprebase browser." <<-\EOF
 	branch.Z
 	branch.autosetupmerge Z
@@ -469,32 +469,32 @@ test_expect_success '__gitcomp - trailing space - config keys' '
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
@@ -502,44 +502,44 @@ test_expect_success '__gitcomp - ignore optional negative options' '
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
2.29.2

