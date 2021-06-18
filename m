Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C4C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F5F613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhFRS2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhFRS2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:33 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386FC061224
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:21 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso2345027ooa.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5fMuLSySkB2Tfqy24UjCGYy2iCrTsJPheQtcjVpzbU=;
        b=LF0t5PFe+2Desf2CsFYFXTSy3mPvE51pky3mRWH9j83OkjGWvh0FhlGCXYp6qa0DVG
         HwGHL5fkG+SJJ2HzY3A+JJbfRTK1YMwXL040QC0v1+8bUhRv/yFZ7juv3yIq/pSF2to8
         4B4CgPWI1qf/Wb+xJYwGizikBPi0Y3p6HQWcvFvXoRpBS+nEn75hRaapjozJ24HuwVjo
         s9RCzxx6wsDQcOb9dfzfXKDQTLwce6/ctDBtDJ8y2JTo9B5E1W2Ea9b7ZN4FrwjI9LFB
         mkJ5aaUrfELjNslQ5Pz/sytYX5+CC/J/wbUOICFg80ZxPscXviECZNPuyHfbpcQiP5et
         FMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5fMuLSySkB2Tfqy24UjCGYy2iCrTsJPheQtcjVpzbU=;
        b=aA4QcKgExAyWOgCOC8zyEaQdD+p7Nt8kbSkJyJZ1PcVatAJFIJl/7C3X2aAAn1N5HC
         0RVmAmos9R/h1StNfy3LDMGi+uA91vOPSF/HsOtmvJwBiePwCaHVeKEAiZmE8tPJUsm0
         dPpg2kX/6bdm4Zvo1gz8mgJVXBPewJfKNTIGpSQp/hVCafRcQ7plDxtd7QnCXVQOE2z9
         7oZ1AClEAOuYKYKWIfltwbH1ddCIx+Kz7C6RtCfvZTtI/sNOUhx10clZUOMPpeG4d4rm
         QGRG2kLNTc7NItJsP0O1C0vxupo0UXKdL3CXENGLcHkh/5Tz3k+dHYzpHlY7Jph1qY2u
         SLtA==
X-Gm-Message-State: AOAM530VilTfcP45RWrE4I8PGyDBb2Anf2u4K825YUx5eH7L2AuwS+8E
        +IXvrEGN3Ree8HjF5eMS+M2bJvMob9irog==
X-Google-Smtp-Source: ABdhPJzIhyOVJ39qemz8wRPyS5Q9EIfHh0DFNirm2k8VmsFvc1HzOUcEbipxYvZNjsfVwfFSod6Hww==
X-Received: by 2002:a4a:315a:: with SMTP id v26mr10077841oog.75.1624040780637;
        Fri, 18 Jun 2021 11:26:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p9sm2105653otl.64.2021.06.18.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 32/45] completion: add __gitcomp_opts
Date:   Fri, 18 Jun 2021 13:25:05 -0500
Message-Id: <20210618182518.697912-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new simplified version of __gitcomp for most callers, and
__gitcomp_opts for the ones that need reorganizing all the options.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 100 ++++++++++++++-----------
 contrib/completion/git-completion.zsh  |   8 ++
 t/t9902-completion.sh                  |  58 +++++++-------
 3 files changed, 93 insertions(+), 73 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0218ae7eb6..8836eab884 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -319,13 +319,25 @@ __gitcompadd ()
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
 
@@ -369,7 +381,7 @@ fi
 
 # This function is equivalent to
 #
-#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#    __gitcomp_opts "$(git xxx --git-completion-helper) ..."
 #
 # except that the output is cached. Accept 1-3 arguments:
 # 1: the git command to execute, this is also the cache key
@@ -404,7 +416,7 @@ __gitcomp_builtin ()
 		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options"
+	__gitcomp_opts "$options"
 }
 
 # Generates completion reply from newline-separated possible completion words
@@ -1041,7 +1053,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	-X)
-		__gitcomp "$__git_merge_strategy_options"
+		__gitcomp_opts "$__git_merge_strategy_options"
 		return 0
 		;;
 	esac
@@ -1051,7 +1063,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	--strategy-option=*)
-		__gitcomp "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
+		__gitcomp_opts "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
 		return 0
 		;;
 	esac
@@ -1293,7 +1305,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "$__git_am_inprogress_options"
+		__gitcomp_opts "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1553,7 +1565,7 @@ _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp_opts "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 
@@ -1711,7 +1723,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_diff_difftool_options"
+		__gitcomp_opts "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -2005,7 +2017,7 @@ _git_log ()
 		return
 		;;
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
@@ -2068,7 +2080,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp_opts "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
@@ -2216,7 +2228,7 @@ _git_range_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
@@ -2233,11 +2245,11 @@ _git_rebase ()
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
@@ -2679,7 +2691,7 @@ __git_complete_config_variable_name ()
 					for (s in sections)
 						print s "."
 				}
-				')" "" "$cur_"
+				')" "" "$cur_" ""
 		;;
 	esac
 }
@@ -2857,7 +2869,7 @@ _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "$__git_revert_inprogress_options"
+		__gitcomp_opts "$__git_revert_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2889,7 +2901,7 @@ _git_shortlog ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			--numbered --summary --email
@@ -2927,7 +2939,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
+		__gitcomp_opts "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
@@ -2960,10 +2972,10 @@ _git_sparse_checkout ()
 
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
@@ -3025,7 +3037,7 @@ _git_submodule ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -3036,29 +3048,29 @@ _git_submodule ()
 
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
@@ -3099,64 +3111,64 @@ _git_svn ()
 
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
@@ -3396,7 +3408,7 @@ __git_main ()
 		esac
 		case "$cur" in
 		--*)
-			__gitcomp "
+			__gitcomp_opts "
 			--paginate
 			--no-pager
 			--git-dir=
@@ -3447,7 +3459,7 @@ __gitk_main ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_gitk_options
 			$merge
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b81479c814..e515f464ab 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -54,6 +54,14 @@ __gitcomp ()
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
index 9803878480..3dbb5eb121 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -101,17 +101,17 @@ test_completion ()
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
@@ -466,8 +466,8 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	test_cmp expected out
 '
 
-test_expect_success '__gitcomp - trailing space - options' '
-	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
+test_expect_success '__gitcomp_opts - trailing space - options' '
+	test_gitcomp_opts "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
 	--reuse-message=Z
 	--reedit-message=Z
@@ -475,8 +475,8 @@ test_expect_success '__gitcomp - trailing space - options' '
 	EOF
 '
 
-test_expect_success '__gitcomp - trailing space - config keys' '
-	test_gitcomp "br" "branch. branch.autosetupmerge
+test_expect_success '__gitcomp_opts - trailing space - config keys' '
+	test_gitcomp_opts "br" "branch. branch.autosetupmerge
 		branch.autosetuprebase browser." <<-\EOF
 	branch.Z
 	branch.autosetupmerge Z
@@ -485,32 +485,32 @@ test_expect_success '__gitcomp - trailing space - config keys' '
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
@@ -518,44 +518,44 @@ test_expect_success '__gitcomp - ignore optional negative options' '
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
2.32.0

