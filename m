Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9726AC77B76
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjDTQb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjDTQb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 12:31:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F710DD
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:31:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63d4595d60fso8343503b3a.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682008283; x=1684600283;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wSsFnLoGivBjOgjWumiL3zmGACb5PiaeKo1533NXVw=;
        b=jIsEORASRzKoeKcYdAgFHKGe9UZXfhStdCNmUEE7k6XZZaCzygjDi+N0P81r4ublO/
         tcIsg5xN8ieQ8rTR/d+EmVJeuA0A1T0KVd2sOmWHaGj35GTSkVkKvnwqNWwbdhu0xLdb
         lRSDLuFHcoEFqf9urQhXSSk3c7LrVX6A3GGB28KvCajVjln8wvGQFM7rPcpsoy66Xg6m
         TnKipgFLO/kl3jS8LDKKTTh3F5V8wtQm/sam9IR+6FSbaz0u5YyhQbPesyI9OOO8dvFb
         3XUoPJzjsAgst1dxNvaYQcMc+yyehfeTwEYIOrBc5JujT+1gKXQ43ikT/FRmFNQvIsks
         0bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008283; x=1684600283;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5wSsFnLoGivBjOgjWumiL3zmGACb5PiaeKo1533NXVw=;
        b=A6KUXT5vYB6Z96dd3G+QQMmHJ5wqAzGyG6oXWRVvKKWTtEHQNZ2GXTXM7Gyj7AKkrn
         KR99+qFFvN0nGPOWTylCctAduCHhUt35r0a+IJvSoV+PH5aU/0JXFMYRbpGaNqzyvLWX
         sDybZ+d3+tcCFasVR9oj92O+yRc+4+qtVGEf1mpWKcdSajFw/X/1F1p1DkAWa0zNUbRy
         yQ95zfUjmcvMXJ1g38GIXvYE3xb/2AzYXDTBTctda1qPY+wlpjJqeCSc+4fHzN/h3ST8
         YponyBp3qsXEHmgZs1gQ8pTYzTs8VQOoDlrKGbzcvytsi+vYSZsKXvPve8afHOb34zY9
         qpUQ==
X-Gm-Message-State: AAQBX9dTkrI/gaepAbXVfjDShKQYhzlm0F11oXiC3m19ajUV9o8Gm2X5
        EM9WmYWesBDGWrG6Vq30DP8=
X-Google-Smtp-Source: AKy350YPDPxVew22felotdehfybJf4QWqy2hHABkjPBJN0qV4ZEUCmGpI+Mc4y7U452jE9pmJ15WcA==
X-Received: by 2002:a05:6a20:54a4:b0:f0:50c4:4c43 with SMTP id i36-20020a056a2054a400b000f050c44c43mr2410440pzk.5.1682008283117;
        Thu, 20 Apr 2023 09:31:23 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id e21-20020a656895000000b004facdf070d6sm1340730pgt.39.2023.04.20.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:31:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Koichi Murase <myoga.murase@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Subject: Re: [PATCH 1/2] completion: quote arguments of test and [
References: <20230420074616.1642742-1-myoga.murase@gmail.com>
Date:   Thu, 20 Apr 2023 09:31:22 -0700
In-Reply-To: <20230420074616.1642742-1-myoga.murase@gmail.com> (Koichi
        Murase's message of "Thu, 20 Apr 2023 16:46:15 +0900")
Message-ID: <xmqqh6ta3485.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Koichi Murase <myoga.murase@gmail.com> writes:

> The raw command substitutions $v in the arguments of the test command
> and the [ command are subject to word splitting and pathname
> expansions. Even when it is ensured that the variable is not empty and
> does not contain whitespaces and glob characters, it can fail when IFS
> is set to non-trivial values containing letters and digits.

The above sounded good before I looked at the patch, and it still is
good in theory, but it start to look mostly academic especially with
enclosing $# inside a pair of double-quotes, and the variable would
have only digits.  The same for $i and $j that appear in the loop
control "for ((i=0, j=0; ...)); do".  The story is pretty much the
same for local variables we set outselves to signal our findings,
like $pcmode that is only set to either 'yes' or 'no'.

Is there a practical use case for an IFS that is set to split a run
of digits somewhere in between (e.g. "IFS=5")?  Is there any
realistic setting of IFS that breaks the command line completion
without this patch, but the IFS is usable without breaking all other
things people wrote as shell scripts and you use everyday?

If there is no such realistic setting of IFS, most, if not all, of
the changes presented here, while they may not be incorrect per-se,
look purely academic.

It's not like this patch was produced by enclosing each and every
variable reference machanically inside a pair of double-quotes,
right?  If there were variable references that ought to be split at
IFS whitespace, the patch would have left them alone.  The readers
also need to assume the opposite for those variable references that
are touched by this patch while reviewing it.

Is there any change in this patch that do fix a real problem with
some more realistic IFS setting?  Setting IFS to a digit does not
count.  If there is, then mixing such a real fix in many academic
changes is even worse, as the latter clutters the patch and makes it
harder to assess the former.  It is like hiding a gem in a lot of
cobblestones.

In other words, this patch looks way too noisy to be reviewed to
discover its real worth.

Thanks.

> To prevent them from being unexpectedly processed by word splitting
> and pathname expansions, properly quote the unquoted command
> substituations in the arguments of the `test` and `[` builtins.
>
> Co-authored-by: Edwin Kofler <edwin@kofler.dev>
> Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
> Signed-off-by: Edwin Kofler <edwin@kofler.dev>
> ---
>  contrib/completion/git-completion.bash | 62 +++++++++++++-------------
>  contrib/completion/git-prompt.sh       |  8 ++--
>  2 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index dc95c34cc8..6c110c223b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -253,19 +253,19 @@ __git_reassemble_comp_words_by_ref()
>  		# word separator characters to the current word.
>  		first=t
>  		while
> -			[ $i -gt 0 ] &&
> +			[ "$i" -gt 0 ] &&
>  			[ -n "${COMP_WORDS[$i]}" ] &&
>  			# word consists of excluded word separators
>  			[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
>  		do
>  			# Attach to the previous token,
>  			# unless the previous token is the command name.
> -			if [ $j -ge 2 ] && [ -n "$first" ]; then
> +			if [ "$j" -ge 2 ] && [ -n "$first" ]; then
>  				((j--))
>  			fi
>  			first=
>  			words_[$j]=${words_[j]}${COMP_WORDS[i]}
> -			if [ $i = $COMP_CWORD ]; then
> +			if [ "$i" = "$COMP_CWORD" ]; then
>  				cword_=$j
>  			fi
>  			if (($i < ${#COMP_WORDS[@]} - 1)); then
> @@ -276,7 +276,7 @@ __git_reassemble_comp_words_by_ref()
>  			fi
>  		done
>  		words_[$j]=${words_[j]}${COMP_WORDS[i]}
> -		if [ $i = $COMP_CWORD ]; then
> +		if [ "$i" = "$COMP_CWORD" ]; then
>  			cword_=$j
>  		fi
>  	done
> @@ -292,7 +292,7 @@ _get_comp_words_by_ref ()
>  	fi
>  	__git_reassemble_comp_words_by_ref "$exclude"
>  	cur_=${words_[cword_]}
> -	while [ $# -gt 0 ]; do
> +	while [ "$#" -gt 0 ]; do
>  		case "$1" in
>  		cur)
>  			cur=$cur_
> @@ -848,7 +848,7 @@ __git_complete_refs ()
>  {
>  	local remote= dwim= pfx= cur_="$cur" sfx=" " mode="refs"
>  
> -	while test $# != 0; do
> +	while test "$#" != 0; do
>  		case "$1" in
>  		--remote=*)	remote="${1##--remote=}" ;;
>  		--dwim)		dwim="yes" ;;
> @@ -1036,7 +1036,7 @@ __git_complete_remote_or_refspec ()
>  	if [ "$cmd" = "remote" ]; then
>  		((c++))
>  	fi
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		i="${words[c]}"
>  		case "$i" in
>  		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
> @@ -1060,7 +1060,7 @@ __git_complete_remote_or_refspec ()
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
>  	fi
> -	if [ $no_complete_refspec = 1 ]; then
> +	if [ "$no_complete_refspec" = 1 ]; then
>  		return
>  	fi
>  	[ "$remote" = "." ] && remote=
> @@ -1080,21 +1080,21 @@ __git_complete_remote_or_refspec ()
>  	esac
>  	case "$cmd" in
>  	fetch)
> -		if [ $lhs = 1 ]; then
> +		if [ "$lhs" = 1 ]; then
>  			__git_complete_fetch_refspecs "$remote" "$pfx" "$cur_"
>  		else
>  			__git_complete_refs --pfx="$pfx" --cur="$cur_"
>  		fi
>  		;;
>  	pull|remote)
> -		if [ $lhs = 1 ]; then
> +		if [ "$lhs" = 1 ]; then
>  			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
>  		else
>  			__git_complete_refs --pfx="$pfx" --cur="$cur_"
>  		fi
>  		;;
>  	push)
> -		if [ $lhs = 1 ]; then
> +		if [ "$lhs" = 1 ]; then
>  			__git_complete_refs --pfx="$pfx" --cur="$cur_"
>  		else
>  			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
> @@ -1203,7 +1203,7 @@ __git_find_on_cmdline ()
>  {
>  	local word c="$__git_cmd_idx" show_idx
>  
> -	while test $# -gt 1; do
> +	while test "$#" -gt 1; do
>  		case "$1" in
>  		--show-idx)	show_idx=y ;;
>  		*)		return 1 ;;
> @@ -1212,7 +1212,7 @@ __git_find_on_cmdline ()
>  	done
>  	local wordlist="$1"
>  
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		for word in $wordlist; do
>  			if [ "$word" = "${words[c]}" ]; then
>  				if [ -n "${show_idx-}" ]; then
> @@ -1237,7 +1237,7 @@ __git_find_last_on_cmdline ()
>  {
>  	local word c=$cword show_idx
>  
> -	while test $# -gt 1; do
> +	while test "$#" -gt 1; do
>  		case "$1" in
>  		--show-idx)	show_idx=y ;;
>  		*)		return 1 ;;
> @@ -1246,7 +1246,7 @@ __git_find_last_on_cmdline ()
>  	done
>  	local wordlist="$1"
>  
> -	while [ $c -gt "$__git_cmd_idx" ]; do
> +	while [ "$c" -gt "$__git_cmd_idx" ]; do
>  		((c--))
>  		for word in $wordlist; do
>  			if [ "$word" = "${words[c]}" ]; then
> @@ -1286,7 +1286,7 @@ __git_get_option_value ()
>  	config_key="$4"
>  
>  	((c = $cword - 1))
> -	while [ $c -ge 0 ]; do
> +	while [ "$c" -ge 0 ]; do
>  		word="${words[c]}"
>  		for val in $values; do
>  			if [ "$short_opt$val" = "$word" ] ||
> @@ -1308,7 +1308,7 @@ __git_get_option_value ()
>  __git_has_doubledash ()
>  {
>  	local c=1
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		if [ "--" = "${words[c]}" ]; then
>  			return 0
>  		fi
> @@ -1474,7 +1474,7 @@ _git_branch ()
>  {
>  	local i c="$__git_cmd_idx" only_local_ref="n" has_r="n"
>  
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		i="${words[c]}"
>  		case "$i" in
>  		-d|-D|--delete|-m|-M|--move|-c|-C|--copy)
> @@ -1493,7 +1493,7 @@ _git_branch ()
>  		__gitcomp_builtin branch
>  		;;
>  	*)
> -		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
> +		if [ "$only_local_ref" = "y" -a "$has_r" = "n" ]; then
>  			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
>  		else
>  			__git_complete_refs
> @@ -1897,7 +1897,7 @@ __git_match_ctag () {
>  __git_complete_symbol () {
>  	local tags=tags pfx="" cur_="${cur-}" sfx=" "
>  
> -	while test $# != 0; do
> +	while test "$#" != 0; do
>  		case "$1" in
>  		--tags=*)	tags="${1##--tags=}" ;;
>  		--pfx=*)	pfx="${1##--pfx=}" ;;
> @@ -2166,7 +2166,7 @@ _git_mv ()
>  		;;
>  	esac
>  
> -	if [ $(__git_count_arguments "mv") -gt 0 ]; then
> +	if [ "$(__git_count_arguments "mv")" -gt 0 ]; then
>  		# We need to show both cached and untracked files (including
>  		# empty directories) since this may not be the last argument.
>  		__git_complete_index_file "--cached --others --directory"
> @@ -2496,7 +2496,7 @@ _git_switch ()
>  __git_config_get_set_variables ()
>  {
>  	local prevword word config_file= c=$cword
> -	while [ $c -gt "$__git_cmd_idx" ]; do
> +	while [ "$c" -gt "$__git_cmd_idx" ]; do
>  		word="${words[c]}"
>  		case "$word" in
>  		--system|--global|--local|--file=*)
> @@ -2541,7 +2541,7 @@ __git_complete_config_variable_value ()
>  {
>  	local varname="$prev" cur_="$cur"
>  
> -	while test $# != 0; do
> +	while test "$#" != 0; do
>  		case "$1" in
>  		--varname=*)	varname="${1##--varname=}" ;;
>  		--cur=*)	cur_="${1##--cur=}" ;;
> @@ -2656,7 +2656,7 @@ __git_complete_config_variable_name ()
>  {
>  	local cur_="$cur" sfx
>  
> -	while test $# != 0; do
> +	while test "$#" != 0; do
>  		case "$1" in
>  		--cur=*)	cur_="${1##--cur=}" ;;
>  		--sfx=*)	sfx="${1##--sfx=}" ;;
> @@ -2756,7 +2756,7 @@ __git_complete_config_variable_name_and_value ()
>  {
>  	local cur_="$cur"
>  
> -	while test $# != 0; do
> +	while test "$#" != 0; do
>  		case "$1" in
>  		--cur=*)	cur_="${1##--cur=}" ;;
>  		*)		return 1 ;;
> @@ -3096,7 +3096,7 @@ _git_stash ()
>  		__gitcomp_builtin "stash_$subcommand"
>  		;;
>  	branch,*)
> -		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
> +		if [ "$cword" -eq "$((__git_cmd_idx+2))" ]; then
>  			__git_complete_refs
>  		else
>  			__gitcomp_nl "$(__git stash list \
> @@ -3261,7 +3261,7 @@ _git_svn ()
>  _git_tag ()
>  {
>  	local i c="$__git_cmd_idx" f=0
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		i="${words[c]}"
>  		case "$i" in
>  		-d|--delete|-v|--verify)
> @@ -3279,7 +3279,7 @@ _git_tag ()
>  	-m|-F)
>  		;;
>  	-*|tag)
> -		if [ $f = 1 ]; then
> +		if [ "$f" = 1 ]; then
>  			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
>  		fi
>  		;;
> @@ -3342,7 +3342,7 @@ _git_worktree ()
>  			# be either the 'add' subcommand, the unstuck
>  			# argument of an option (e.g. branch for -b|-B), or
>  			# the path for the new worktree.
> -			if [ $cword -eq $((subcommand_idx+1)) ]; then
> +			if [ "$cword" -eq "$((subcommand_idx+1))" ]; then
>  				# Right after the 'add' subcommand: have to
>  				# complete the path, so fall back to Bash
>  				# filename completion.
> @@ -3366,7 +3366,7 @@ _git_worktree ()
>  		__git_complete_worktree_paths
>  		;;
>  	move,*)
> -		if [ $cword -eq $((subcommand_idx+1)) ]; then
> +		if [ "$cword" -eq "$((subcommand_idx+1))" ]; then
>  			# The first parameter must be an existing working
>  			# tree to be moved.
>  			__git_complete_worktree_paths
> @@ -3436,7 +3436,7 @@ __git_main ()
>  	local __git_C_args C_args_count=0
>  	local __git_cmd_idx
>  
> -	while [ $c -lt $cword ]; do
> +	while [ "$c" -lt "$cword" ]; do
>  		i="${words[c]}"
>  		case "$i" in
>  		--git-dir=*)
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 76ee4ab1e5..9c10690a22 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -232,7 +232,7 @@ __git_ps1_show_upstream ()
>  		if [[ -n "$count" && -n "$name" ]]; then
>  			__git_ps1_upstream_name=$(git rev-parse \
>  				--abbrev-ref "$upstream_type" 2>/dev/null)
> -			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> +			if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
>  				upstream="$upstream \${__git_ps1_upstream_name}"
>  			else
>  				upstream="$upstream ${__git_ps1_upstream_name}"
> @@ -269,7 +269,7 @@ __git_ps1_colorize_gitstring ()
>  	local flags_color="$c_lblue"
>  
>  	local branch_color=""
> -	if [ $detached = no ]; then
> +	if [ "$detached" = no ]; then
>  		branch_color="$ok_color"
>  	else
>  		branch_color="$bad_color"
> @@ -567,7 +567,7 @@ __git_ps1 ()
>  	local z="${GIT_PS1_STATESEPARATOR-" "}"
>  
>  	b=${b##refs/heads/}
> -	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> +	if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
>  		__git_ps1_branch_name=$b
>  		b="\${__git_ps1_branch_name}"
>  	fi
> @@ -579,7 +579,7 @@ __git_ps1 ()
>  	local f="$h$w$i$s$u$p"
>  	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
>  
> -	if [ $pcmode = yes ]; then
> +	if [ "$pcmode" = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
>  			gitstring=$(printf -- "$printf_format" "$gitstring")
>  		else
