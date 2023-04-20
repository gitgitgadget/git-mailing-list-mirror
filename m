Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078BC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjDTHqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjDTHqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 03:46:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F940F5
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:46:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso978375b3a.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681976805; x=1684568805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uu7vr0WXf/XuZlIfA3ykXLLbGewD5Jmv9BGHOV1ckk=;
        b=HJf83zAYD8CGm0c0R+Yu9bYsxTl7AbBAyNPowI5y6L+JgyDTR6L7QFdllbtytnxUMK
         FVSBQDiwQpdpb5J5OBvcW5+1uHgfqZLs+uCvBFmf/TwAi9PFVTQ4LNZOnCMT2HJDpCKA
         /x9xnbQby930c0vSm8jv+uM3fVuLrXsyWJDs4xSj/fFFkjNZw0hTvVbi9l3jL/63a1n0
         7lJohIfn6rrskPQzYFHtQJpMQcqces0euIpBqztFjLDlYQhK23f6i1E7yFIPOVOHd4UO
         m7I7yy7mFMBeLgmGZE9RB7gd2j4K7H9i+GBTb/XI48mm+lpcvsVaA7S4p5SGPx9gnVdl
         eChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681976805; x=1684568805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Uu7vr0WXf/XuZlIfA3ykXLLbGewD5Jmv9BGHOV1ckk=;
        b=XJFgRogX5xV8S59kKPH7Z3dfB0fOLFjtWM7Pdi/KA1zHrw10YKxsUuGe2qmsnFakbR
         bs0V48NEmyT49iKKeJwvijRRFLG2+T6rx/CiKp93Mh/kCPITIJQHxj77FM2ywkC5hRSd
         meRt6OQC6Hdg2cH7yDZaxY8jqyt5SusVrKgaXr6GSFm4U2F0kNTwc4mVa+zxqCkvVCFW
         r2ukyHmIhCbmzpOxbOUzCLVDWTTYACdAdkd+Pn6feV1xlrnSsRuNOEkhhlGYF9El94eG
         CRqRso17e3SYKbFXooxO/tuflC4mLl97mWjURU/HzxLG5EXyXcLdE2n0oVv4+8iHBu5e
         wwRw==
X-Gm-Message-State: AAQBX9dKkG602vtMtjA41QLBuQ9+HYRp/EjVKTBGDoVO/43nZptZntuo
        zfXNpuDuJekDuvATR+PEzXMbmVwj4po/2Q==
X-Google-Smtp-Source: AKy350aCUEBM6Nva5w0ohmKOxfN8Bcrwpi5ce7lhNUH41e4bMXhrfxsov3lZyC6i3YMZAqy7PoWuZw==
X-Received: by 2002:a05:6a20:d906:b0:f0:7b8:c788 with SMTP id jd6-20020a056a20d90600b000f007b8c788mr833115pzb.50.1681976805159;
        Thu, 20 Apr 2023 00:46:45 -0700 (PDT)
Received: from chatoyancy.. (fpa0565fa6.aicf508.ap.nuro.jp. [160.86.95.166])
        by smtp.gmail.com with ESMTPSA id h133-20020a62838b000000b0063b8a30b571sm642353pfe.9.2023.04.20.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:46:44 -0700 (PDT)
From:   Koichi Murase <myoga.murase@gmail.com>
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Koichi Murase <myoga.murase@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Subject: [PATCH 1/2] completion: quote arguments of test and [
Date:   Thu, 20 Apr 2023 16:46:15 +0900
Message-Id: <20230420074616.1642742-1-myoga.murase@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The raw command substitutions $v in the arguments of the test command
and the [ command are subject to word splitting and pathname
expansions. Even when it is ensured that the variable is not empty and
does not contain whitespaces and glob characters, it can fail when IFS
is set to non-trivial values containing letters and digits.

To prevent them from being unexpectedly processed by word splitting
and pathname expansions, properly quote the unquoted command
substituations in the arguments of the `test` and `[` builtins.

Co-authored-by: Edwin Kofler <edwin@kofler.dev>
Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
Signed-off-by: Edwin Kofler <edwin@kofler.dev>
---
 contrib/completion/git-completion.bash | 62 +++++++++++++-------------
 contrib/completion/git-prompt.sh       |  8 ++--
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc8..6c110c223b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -253,19 +253,19 @@ __git_reassemble_comp_words_by_ref()
 		# word separator characters to the current word.
 		first=t
 		while
-			[ $i -gt 0 ] &&
+			[ "$i" -gt 0 ] &&
 			[ -n "${COMP_WORDS[$i]}" ] &&
 			# word consists of excluded word separators
 			[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
 		do
 			# Attach to the previous token,
 			# unless the previous token is the command name.
-			if [ $j -ge 2 ] && [ -n "$first" ]; then
+			if [ "$j" -ge 2 ] && [ -n "$first" ]; then
 				((j--))
 			fi
 			first=
 			words_[$j]=${words_[j]}${COMP_WORDS[i]}
-			if [ $i = $COMP_CWORD ]; then
+			if [ "$i" = "$COMP_CWORD" ]; then
 				cword_=$j
 			fi
 			if (($i < ${#COMP_WORDS[@]} - 1)); then
@@ -276,7 +276,7 @@ __git_reassemble_comp_words_by_ref()
 			fi
 		done
 		words_[$j]=${words_[j]}${COMP_WORDS[i]}
-		if [ $i = $COMP_CWORD ]; then
+		if [ "$i" = "$COMP_CWORD" ]; then
 			cword_=$j
 		fi
 	done
@@ -292,7 +292,7 @@ _get_comp_words_by_ref ()
 	fi
 	__git_reassemble_comp_words_by_ref "$exclude"
 	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
+	while [ "$#" -gt 0 ]; do
 		case "$1" in
 		cur)
 			cur=$cur_
@@ -848,7 +848,7 @@ __git_complete_refs ()
 {
 	local remote= dwim= pfx= cur_="$cur" sfx=" " mode="refs"
 
-	while test $# != 0; do
+	while test "$#" != 0; do
 		case "$1" in
 		--remote=*)	remote="${1##--remote=}" ;;
 		--dwim)		dwim="yes" ;;
@@ -1036,7 +1036,7 @@ __git_complete_remote_or_refspec ()
 	if [ "$cmd" = "remote" ]; then
 		((c++))
 	fi
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		i="${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
@@ -1060,7 +1060,7 @@ __git_complete_remote_or_refspec ()
 		__gitcomp_nl "$(__git_remotes)"
 		return
 	fi
-	if [ $no_complete_refspec = 1 ]; then
+	if [ "$no_complete_refspec" = 1 ]; then
 		return
 	fi
 	[ "$remote" = "." ] && remote=
@@ -1080,21 +1080,21 @@ __git_complete_remote_or_refspec ()
 	esac
 	case "$cmd" in
 	fetch)
-		if [ $lhs = 1 ]; then
+		if [ "$lhs" = 1 ]; then
 			__git_complete_fetch_refspecs "$remote" "$pfx" "$cur_"
 		else
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
 		;;
 	pull|remote)
-		if [ $lhs = 1 ]; then
+		if [ "$lhs" = 1 ]; then
 			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
 		else
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
 		;;
 	push)
-		if [ $lhs = 1 ]; then
+		if [ "$lhs" = 1 ]; then
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		else
 			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
@@ -1203,7 +1203,7 @@ __git_find_on_cmdline ()
 {
 	local word c="$__git_cmd_idx" show_idx
 
-	while test $# -gt 1; do
+	while test "$#" -gt 1; do
 		case "$1" in
 		--show-idx)	show_idx=y ;;
 		*)		return 1 ;;
@@ -1212,7 +1212,7 @@ __git_find_on_cmdline ()
 	done
 	local wordlist="$1"
 
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		for word in $wordlist; do
 			if [ "$word" = "${words[c]}" ]; then
 				if [ -n "${show_idx-}" ]; then
@@ -1237,7 +1237,7 @@ __git_find_last_on_cmdline ()
 {
 	local word c=$cword show_idx
 
-	while test $# -gt 1; do
+	while test "$#" -gt 1; do
 		case "$1" in
 		--show-idx)	show_idx=y ;;
 		*)		return 1 ;;
@@ -1246,7 +1246,7 @@ __git_find_last_on_cmdline ()
 	done
 	local wordlist="$1"
 
-	while [ $c -gt "$__git_cmd_idx" ]; do
+	while [ "$c" -gt "$__git_cmd_idx" ]; do
 		((c--))
 		for word in $wordlist; do
 			if [ "$word" = "${words[c]}" ]; then
@@ -1286,7 +1286,7 @@ __git_get_option_value ()
 	config_key="$4"
 
 	((c = $cword - 1))
-	while [ $c -ge 0 ]; do
+	while [ "$c" -ge 0 ]; do
 		word="${words[c]}"
 		for val in $values; do
 			if [ "$short_opt$val" = "$word" ] ||
@@ -1308,7 +1308,7 @@ __git_get_option_value ()
 __git_has_doubledash ()
 {
 	local c=1
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		if [ "--" = "${words[c]}" ]; then
 			return 0
 		fi
@@ -1474,7 +1474,7 @@ _git_branch ()
 {
 	local i c="$__git_cmd_idx" only_local_ref="n" has_r="n"
 
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		i="${words[c]}"
 		case "$i" in
 		-d|-D|--delete|-m|-M|--move|-c|-C|--copy)
@@ -1493,7 +1493,7 @@ _git_branch ()
 		__gitcomp_builtin branch
 		;;
 	*)
-		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
+		if [ "$only_local_ref" = "y" -a "$has_r" = "n" ]; then
 			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
 		else
 			__git_complete_refs
@@ -1897,7 +1897,7 @@ __git_match_ctag () {
 __git_complete_symbol () {
 	local tags=tags pfx="" cur_="${cur-}" sfx=" "
 
-	while test $# != 0; do
+	while test "$#" != 0; do
 		case "$1" in
 		--tags=*)	tags="${1##--tags=}" ;;
 		--pfx=*)	pfx="${1##--pfx=}" ;;
@@ -2166,7 +2166,7 @@ _git_mv ()
 		;;
 	esac
 
-	if [ $(__git_count_arguments "mv") -gt 0 ]; then
+	if [ "$(__git_count_arguments "mv")" -gt 0 ]; then
 		# We need to show both cached and untracked files (including
 		# empty directories) since this may not be the last argument.
 		__git_complete_index_file "--cached --others --directory"
@@ -2496,7 +2496,7 @@ _git_switch ()
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-	while [ $c -gt "$__git_cmd_idx" ]; do
+	while [ "$c" -gt "$__git_cmd_idx" ]; do
 		word="${words[c]}"
 		case "$word" in
 		--system|--global|--local|--file=*)
@@ -2541,7 +2541,7 @@ __git_complete_config_variable_value ()
 {
 	local varname="$prev" cur_="$cur"
 
-	while test $# != 0; do
+	while test "$#" != 0; do
 		case "$1" in
 		--varname=*)	varname="${1##--varname=}" ;;
 		--cur=*)	cur_="${1##--cur=}" ;;
@@ -2656,7 +2656,7 @@ __git_complete_config_variable_name ()
 {
 	local cur_="$cur" sfx
 
-	while test $# != 0; do
+	while test "$#" != 0; do
 		case "$1" in
 		--cur=*)	cur_="${1##--cur=}" ;;
 		--sfx=*)	sfx="${1##--sfx=}" ;;
@@ -2756,7 +2756,7 @@ __git_complete_config_variable_name_and_value ()
 {
 	local cur_="$cur"
 
-	while test $# != 0; do
+	while test "$#" != 0; do
 		case "$1" in
 		--cur=*)	cur_="${1##--cur=}" ;;
 		*)		return 1 ;;
@@ -3096,7 +3096,7 @@ _git_stash ()
 		__gitcomp_builtin "stash_$subcommand"
 		;;
 	branch,*)
-		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
+		if [ "$cword" -eq "$((__git_cmd_idx+2))" ]; then
 			__git_complete_refs
 		else
 			__gitcomp_nl "$(__git stash list \
@@ -3261,7 +3261,7 @@ _git_svn ()
 _git_tag ()
 {
 	local i c="$__git_cmd_idx" f=0
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		i="${words[c]}"
 		case "$i" in
 		-d|--delete|-v|--verify)
@@ -3279,7 +3279,7 @@ _git_tag ()
 	-m|-F)
 		;;
 	-*|tag)
-		if [ $f = 1 ]; then
+		if [ "$f" = 1 ]; then
 			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 		fi
 		;;
@@ -3342,7 +3342,7 @@ _git_worktree ()
 			# be either the 'add' subcommand, the unstuck
 			# argument of an option (e.g. branch for -b|-B), or
 			# the path for the new worktree.
-			if [ $cword -eq $((subcommand_idx+1)) ]; then
+			if [ "$cword" -eq "$((subcommand_idx+1))" ]; then
 				# Right after the 'add' subcommand: have to
 				# complete the path, so fall back to Bash
 				# filename completion.
@@ -3366,7 +3366,7 @@ _git_worktree ()
 		__git_complete_worktree_paths
 		;;
 	move,*)
-		if [ $cword -eq $((subcommand_idx+1)) ]; then
+		if [ "$cword" -eq "$((subcommand_idx+1))" ]; then
 			# The first parameter must be an existing working
 			# tree to be moved.
 			__git_complete_worktree_paths
@@ -3436,7 +3436,7 @@ __git_main ()
 	local __git_C_args C_args_count=0
 	local __git_cmd_idx
 
-	while [ $c -lt $cword ]; do
+	while [ "$c" -lt "$cword" ]; do
 		i="${words[c]}"
 		case "$i" in
 		--git-dir=*)
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 76ee4ab1e5..9c10690a22 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -232,7 +232,7 @@ __git_ps1_show_upstream ()
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
-			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+			if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
 				upstream="$upstream ${__git_ps1_upstream_name}"
@@ -269,7 +269,7 @@ __git_ps1_colorize_gitstring ()
 	local flags_color="$c_lblue"
 
 	local branch_color=""
-	if [ $detached = no ]; then
+	if [ "$detached" = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
@@ -567,7 +567,7 @@ __git_ps1 ()
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
 	b=${b##refs/heads/}
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+	if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 		__git_ps1_branch_name=$b
 		b="\${__git_ps1_branch_name}"
 	fi
@@ -579,7 +579,7 @@ __git_ps1 ()
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
-	if [ $pcmode = yes ]; then
+	if [ "$pcmode" = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 		else
-- 
2.39.0

