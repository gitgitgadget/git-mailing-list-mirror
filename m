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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB16CC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592516115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhDZQTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhDZQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:53 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A7C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z7so4740419oix.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsU/sfVQdC5LbwT4bDtnySSwnTLILy3H1e4tFtPQ6Qw=;
        b=qSLx2+Gio4h+wiFgocghGfM9NZUZLdBWKSPCn3KKqhrTcSn1KSbEH8cN//sCoaM298
         qCGAcXGRHI++sc3Y8GkZc/1dHvvfaplhe1BeDUSar8KoYZ5QmiqOwPRBVhMH7WnMfrme
         YDyvDX/1SbKYk75lJkp/kDLblrNSS1fOIbSiVqs+rwa64EES1yspBelOEUAiYlnmBgge
         TCs6WWha0w3YulKN1w0PiVwhmBSwveSus0duDuoRfmofmay7TTzy+LGfoXvEtPsraqUI
         8xfhvJMNm3l9b2ecTR426adSGbR1Jm6eYFftxcNECpJV11lm6a6xuHAG5VMk6HSYKC+P
         uhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsU/sfVQdC5LbwT4bDtnySSwnTLILy3H1e4tFtPQ6Qw=;
        b=mhz8R1nPHF7lw147nbjeFkKuKcF/spvRUY+iQTPqNmWh3YzcKYNBnPa4APEF188jiL
         /2V0925oAbpkS0qUeGlLBQPquZFMeOzOolxAShjBbMzpyTHoci4OIBp4KU9Kuj68CEYp
         JNnui+oqPt7DnEnSQtv7KzDCCQoPC7q/LzjRgmvTegqFOCd3nmSsY5LtsXeSIl45kNAM
         muUZpyADC/5FR8OWPxObBGwNDqM3D1/muWidJVIc9MGzYER91gMiGGDDAZfqu84pnUGm
         iH5epGQnGhLIQQlmXb7FYFf9K0PFDIX5Mfa3Ai2zPlGmzIo0ko/u+VBpan6Y4yflj/KI
         B1MA==
X-Gm-Message-State: AOAM530pZezWoTAsh6oSb8GiHD6/ngaO4wauK0GhTC9D4hILMrF0sHBZ
        SVfgKsnp7fi/OEQa7H4yElKF/IPRyuChvQ==
X-Google-Smtp-Source: ABdhPJxItSRN9cQZwrK56sK48QUmHX4sEQQU5P0oRJ5VfmXxg/8QPYptCKb/6VHXFYxGzQOAjPFEXg==
X-Received: by 2002:aca:db05:: with SMTP id s5mr13498246oig.134.1619453951056;
        Mon, 26 Apr 2021 09:19:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q10sm62575ooo.34.2021.04.26.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 29/43] completion: add __gitcomp_opts
Date:   Mon, 26 Apr 2021 11:14:44 -0500
Message-Id: <20210426161458.49860-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index b2a04a6b8c..00fd782e57 100644
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
@@ -1292,7 +1304,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "$__git_am_inprogress_options"
+		__gitcomp_opts "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1548,7 +1560,7 @@ _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp_opts "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 
@@ -1706,7 +1718,7 @@ _git_diff ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_diff_difftool_options"
+		__gitcomp_opts "$__git_diff_difftool_options"
 		return
 		;;
 	esac
@@ -2000,7 +2012,7 @@ _git_log ()
 		return
 		;;
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
@@ -2063,7 +2075,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp_opts "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
@@ -2211,7 +2223,7 @@ _git_range_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			--creation-factor= --no-dual-color
 			$__git_diff_common_options
 		"
@@ -2228,11 +2240,11 @@ _git_rebase ()
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
@@ -2674,7 +2686,7 @@ __git_complete_config_variable_name ()
 					for (s in sections)
 						print s "."
 				}
-				')" "" "$cur_"
+				')" "" "$cur_" ""
 		;;
 	esac
 }
@@ -2852,7 +2864,7 @@ _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "$__git_revert_inprogress_options"
+		__gitcomp_opts "$__git_revert_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2884,7 +2896,7 @@ _git_shortlog ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
+		__gitcomp_opts "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			--numbered --summary --email
@@ -2922,7 +2934,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
+		__gitcomp_opts "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
@@ -2955,10 +2967,10 @@ _git_sparse_checkout ()
 
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
@@ -2976,7 +2988,7 @@ _git_stash ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "$save_opts"
+			__gitcomp_opts "$save_opts"
 			;;
 		sa*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
@@ -2992,22 +3004,22 @@ _git_stash ()
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
@@ -3038,7 +3050,7 @@ _git_submodule ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet"
+			__gitcomp_opts "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -3049,29 +3061,29 @@ _git_submodule ()
 
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
@@ -3112,64 +3124,64 @@ _git_svn ()
 
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
@@ -3388,7 +3400,7 @@ __git_main ()
 			;;
 		esac
 		case "$cur" in
-		--*)   __gitcomp "
+		--*)   __gitcomp_opts "
 			--paginate
 			--no-pager
 			--git-dir=
@@ -3439,7 +3451,7 @@ __gitk_main ()
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
index bbea339a45..205083184a 100755
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
2.31.0

