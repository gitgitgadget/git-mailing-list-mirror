Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006BC0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiH3JeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiH3JdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:05 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92136E1AAD
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:42 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11ee4649dfcso8940871fac.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4LggF5ZXBnEm2SPdHNSdF/O3Bocbl/f1xI78pOSnbdo=;
        b=K0xK+KqI0FnNbeOO95mfYGutjkGYmCtGR9oQGKMMMIRuK+ciQg6ebYCEwMo7Z0XchC
         3Y4aIGQx0r/Nc6AT9cZ3A7N7IB9zvvtLloFoLGa2lrkBp7HMChBknDDfnlulQQ0SXmdO
         A1ZIdkz24ZQ+Nk0pcsHDd6mWFsMm13VtfK+W2hk14yJwWRd9jPKl3t0luZ2nWtsvthfD
         dpUwd9A9MFc+/eYqoa7F0D90JEF3g9IApeHEA0JokRjSLxbFRZnCGkPL52x8+4mKh/iP
         vIAbJnTWdPvSYJUbSCAjYZvH5aFjeuc/wSwwLu/dUmdiICEsqV78w+xmZ4BKkkMFEXRa
         DW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4LggF5ZXBnEm2SPdHNSdF/O3Bocbl/f1xI78pOSnbdo=;
        b=7ViX2eXjaoHFUSKcWAvp4ZJZ0UGu/e431xhfF7CW3mfQFyBMeZxR/kHs8HVLhws/OK
         ckgaQ+9HcjAURFEIPsZeThhJSRp4lTLnGWpM8EWcfRIjsWBK1tW1RSIhs3q/oaMrLt7v
         VG6qu3zpmJJrV2oPJ6+8X0kt1up6MjigCWNzE8LDJT6sCGGGN5rvprNAq5cTWP9oase6
         3qNR0etnlI7JYiog7425uRwznP5JCt+FOEjfo8EQcRXxHbaPEDDQFSlif9VaWZkQgz5/
         gAoqgHBFtc9vRw91WtTHYFOyqV0FEtf9C8YG9aXG7yeEecOs3r0TjmVZoV7YywFKA7bL
         MEhA==
X-Gm-Message-State: ACgBeo3eScHtCr7CTpxJPXxVe2uuK8GO/UZi7l8W69VXCd2ajNsOvyzf
        LlUA+9UdMkcxev8q6xz7OY/fmnJdP30=
X-Google-Smtp-Source: AA6agR6Z+IvG2u8dH4ANNEOCNu9M8a7/2m4kgYco9awOuoOSJpbbJUHErm2sGnHjOFSuR+wKTSXtMg==
X-Received: by 2002:a05:6870:5702:b0:11e:dd17:d4b6 with SMTP id k2-20020a056870570200b0011edd17d4b6mr5030901oap.112.1661851961729;
        Tue, 30 Aug 2022 02:32:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s8-20020a056830148800b0063911de9fd8sm7068596otq.24.2022.08.30.02.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 36/51] completion: add __gitcomp_opts
Date:   Tue, 30 Aug 2022 04:31:23 -0500
Message-Id: <20220830093138.1581538-37-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new simplified version of __gitcomp for most callers, and
__gitcomp_opts for the ones that need reorganizing all the options.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 94 +++++++++++++++-----------
 contrib/completion/git-completion.zsh  |  8 +++
 t/t9902-completion.sh                  | 58 ++++++++--------
 t/t9904-zsh-completion.sh              | 54 +++++++--------
 4 files changed, 117 insertions(+), 97 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6610054e0e..2cedbd6cc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -324,13 +324,25 @@ __gitcompadd ()
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
 
@@ -374,7 +386,7 @@ fi
 
 # This function is equivalent to
 #
-#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#    __gitcomp_opts "$(git xxx --git-completion-helper) ..."
 #
 # except that the output is cached. Accept 1-3 arguments:
 # 1: the git command to execute, this is also the cache key
@@ -409,7 +421,7 @@ __gitcomp_builtin ()
 		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options"
+	__gitcomp_opts "$options"
 }
 
 # Generates completion reply from newline-separated possible completion words
@@ -1046,7 +1058,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	-X)
-		__gitcomp "$__git_merge_strategy_options"
+		__gitcomp_opts "$__git_merge_strategy_options"
 		return 0
 		;;
 	esac
@@ -1056,7 +1068,7 @@ __git_complete_strategy ()
 		return 0
 		;;
 	--strategy-option=*)
-		__gitcomp "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
+		__gitcomp_opts "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
 		return 0
 		;;
 	esac
@@ -1298,7 +1310,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "$__git_am_inprogress_options"
+		__gitcomp_opts "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1558,7 +1570,7 @@ _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp_opts "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 
@@ -1717,7 +1729,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_diff_difftool_options"
+		__gitcomp_opts "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -2011,7 +2023,7 @@ _git_log ()
 		return
 		;;
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
@@ -2074,7 +2086,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp_opts "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
@@ -2222,7 +2234,7 @@ _git_range_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
@@ -2239,11 +2251,11 @@ _git_rebase ()
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
@@ -3053,7 +3065,7 @@ _git_submodule ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -3064,29 +3076,29 @@ _git_submodule ()
 
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
@@ -3127,64 +3139,64 @@ _git_svn ()
 
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
@@ -3424,7 +3436,7 @@ __git_main ()
 		esac
 		case "$cur" in
 		--*)
-			__gitcomp "
+			__gitcomp_opts "
 			--paginate
 			--no-pager
 			--git-dir=
@@ -3481,7 +3493,7 @@ __gitk_main ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_gitk_options
 			$merge
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 41aae0f454..2ad24f1510 100644
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
index e1e9c6e365..eb8e173e6b 100755
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
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 42917833e8..894f3287f4 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -37,16 +37,16 @@ test_completion ()
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
 	sed -e 's/Z$//' >expected &&
 	local cur="$1" &&
 	shift &&
-	run_completion "git func __gitcomp $(printf "%q " "$@") $cur" &&
+	run_completion "git func __gitcomp_opts $(printf "%q " "$@") $cur" &&
 	test_cmp expected out
 }
 
@@ -78,8 +78,8 @@ test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	git init -b main otherrepo
 '
 
-test_expect_success '__gitcomp - trailing space - options' '
-	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
+test_expect_success '__gitcomp_opts - trailing space - options' '
+	test_gitcomp_opts "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
 	--reuse-message=Z
 	--reedit-message=Z
@@ -87,8 +87,8 @@ test_expect_success '__gitcomp - trailing space - options' '
 	EOF
 '
 
-test_expect_success '__gitcomp - trailing space - config keys' '
-	test_gitcomp "br" "branch. branch.autosetupmerge
+test_expect_success '__gitcomp_opts - trailing space - config keys' '
+	test_gitcomp_opts "br" "branch. branch.autosetupmerge
 		branch.autosetuprebase browser." <<-\EOF
 	branch.Z
 	branch.autosetupmerge Z
@@ -97,32 +97,32 @@ test_expect_success '__gitcomp - trailing space - config keys' '
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
 
-test_expect_failure '__gitcomp - prefix' '
-	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
+test_expect_failure '__gitcomp_opts - prefix' '
+	test_gitcomp_opts "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
 	EOF
 '
 
-test_expect_failure '__gitcomp - suffix' '
-	test_gitcomp "branch.ma" "master maint next seen" "branch." \
+test_expect_failure '__gitcomp_opts - suffix' '
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
@@ -130,38 +130,38 @@ test_expect_success '__gitcomp - ignore optional negative options' '
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
-- 
2.37.2.351.g9bf691b78c.dirty

