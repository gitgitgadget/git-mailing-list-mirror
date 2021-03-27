Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350DAC433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE951619B1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0SgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0Sf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 14:35:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B440C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:35:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so13291429ejc.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wneLxoIGAlPLDBWpsMzpL4VQNmUfzhin696RLJPetg4=;
        b=GwoqT+3PUwh0YilGZEYVsvmQ+VA+tYXdxtR4I6DNYOl7nOA22MYfedasVVDjrm/gSp
         T+X+SA311VM3/9j+bQ5/JKuYRq+GjpLHw92hIo7u0M0qwoB9S8e4W5vIdW6kEHbx9LIF
         k7pmqZPywrGirtdq3X3dXDot4el9Gnibefb41h5MHJofGE2Tp8GUyqLFdiqWHToT3EiN
         7vZODF8V2vDZJ63w10mHmXcLrvi4ZJ8zMrsJipYb3NqgGDPFI/cMDFrKVs1wcRqvpPrl
         +Bo/vSWBFF4wkzvBN393klBnZmq1evAd0DnHoM9ENaQo4oefzRnmWlobkHMv6/dkzHXz
         CE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wneLxoIGAlPLDBWpsMzpL4VQNmUfzhin696RLJPetg4=;
        b=Eq0/zLLBqj3appzVsbPeqGcfoAQH0Q51fHs/1xZYTzkiyVZkLfoij8FAE3hNuk6C0R
         2OLqZN/mhbSNqmAd5HD1nd1sGoQo/WCHpmJEo+8bw8Sj3+o3TxXruXa3grYMvEVeHvBX
         D5mmXLOnzyQUvcESuNCVJeFTNLupHhiCTu2qAWjW/cmNhjEdGG7X6AjT4TdYWksA7vb9
         m8xV91R42YuQHjheuCtwDgHbky5iSU+qcZ1DhCBs/iRKv/IQi2x0sYmTaHWh4TMN72+w
         j533NKSJj2DH/h9tBNRYG8ERueEOWdufjKKkAfi3S850OGEoknWDWuBSluUP3yuSKQYZ
         KAww==
X-Gm-Message-State: AOAM531n74Styt8+rW/Tkukg/b02fOoSnZMYvoydP6h6LIHTEqp07zKS
        9mFYFtc4nkOhoOvbruyQCr0=
X-Google-Smtp-Source: ABdhPJwnOe5Ju0Rz5gTdzIQfyFIizfR5kxBGJyMbpPfGUUVu/D1MLESyRjf35SQBOMtZcy1cnNr02w==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr21151870ejd.533.1616870156774;
        Sat, 27 Mar 2021 11:35:56 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id r4sm5514273ejd.125.2021.03.27.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 11:35:56 -0700 (PDT)
Date:   Sat, 27 Mar 2021 19:35:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-completion.bash: pass $__git_subcommand_idx
 from __git_main()
Message-ID: <20210327183554.GD2271@szeder.dev>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616574955.git.liu.denton@gmail.com>
 <e4aa3e8cd7f64512ce0d72906f4d15f1f0dc0a60.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4aa3e8cd7f64512ce0d72906f4d15f1f0dc0a60.1616574955.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nit: I don't like the word "pass" in the subject line, because
you don't actually "pass" that variable as a parameter, but simly set
it, and it will be visible in all called functions, because that's how
shell variables work.

On Wed, Mar 24, 2021 at 01:36:27AM -0700, Denton Liu wrote:
> Many completion functions perform hardcoded comparisons with $cword.
> This fails in the case where the main git command is given arguments
> (e.g. `git -C . bundle<TAB>` would fail to complete its subcommands).

It's not just the hardcoded comparison with $cword, but the hardcoded
indices into the $words array that causes these problems:

> Even _git_worktree(), which uses __git_find_on_cmdline(), could still
> fail. With something like `git -C add worktree move<TAB>`, the
> subcommand would be incorrectly identified as "add" instead of "move".
> 
> Assign $__git_subcommand_idx in __git_main(), where the git subcommand

In 'git -C add worktree move this there' we invoke the 'worktree'
command's 'move' subcommand.  Therefore, this variable should be
called $__git_command_idx.  Or perhaps $__git_cmd_idx, to spare some
keystrokes without sacrificing readability?

> is actually found and the corresponding completion function is called.
> Use this variable to replace hardcoded comparisons with $cword.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

This patch leaves a couple of accesses to $words and $cword unchanged,
though they still suffer from the same issues and should be changed,
e.g.:

__git_complete_remote_or_refspec() assumes that ${words[1]} is the
command and starts looking for options starting at index 2, so e.g.
'git fetch <TAB>' lists configured remotes, but 'git -C . fetch <TAB>'
doesn't.

_git_branch() is curious, because, just like the "main" 'git' command,
'git branch' has '-c' and '-C' options, and as a result 'git branch
o<TAB>' lists branches from 'origin', but 'git -c foo.bar=baz -C .
branch o<TAB>' doesn't.

It's debatable whether __git_find_on_cmdline() and its friends should
be changed.  If we only look at the function's name, then no, because
it implicitly implies that it searches through the whole command line.
However, if we look at how we actually use it, then we'll find that we
only use it to check for the presence of subcommands or certain
options of a command or subcommand.  This means that we only want to
search the words following the command, but since it starts its scan
at ${words[1]}, it leads to that issue with 'git worktree' that you
described in the commit message, but it affects all other commands
with subcommands as well.

I haven't looked closely at the other cases, but I'm inclinened to
think that all _git_cmd() functions and any helper functions invoked
by them should only concern themselves with words after the git
command.


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7dc6cd8eb8..a2f1b5e916 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1474,12 +1474,12 @@ _git_branch ()
>  
>  _git_bundle ()
>  {
> -	local cmd="${words[2]}"
> +	local cmd="${words[__git_subcommand_idx+1]}"
>  	case "$cword" in
> -	2)
> +	$((__git_subcommand_idx+1)))
>  		__gitcomp "create list-heads verify unbundle"
>  		;;
> -	3)
> +	$((__git_subcommand_idx+2)))
>  		# looking for a file
>  		;;
>  	*)
> @@ -1894,7 +1894,7 @@ _git_grep ()
>  	esac
>  
>  	case "$cword,$prev" in
> -	2,*|*,-*)
> +	$((__git_subcommand_idx+1)),*|*,-*)
>  		__git_complete_symbol && return
>  		;;
>  	esac
> @@ -3058,7 +3058,7 @@ _git_stash ()
>  		branch,--*)
>  			;;
>  		branch,*)
> -			if [ $cword -eq 3 ]; then
> +			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
>  				__git_complete_refs
>  			else
>  				__gitcomp_nl "$(__git stash list \
> @@ -3277,11 +3277,9 @@ __git_complete_worktree_paths ()
>  _git_worktree ()
>  {
>  	local subcommands="add list lock move prune remove unlock"
> -	local subcommand subcommand_idx
> +	local subcommand
>  
> -	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
> -	subcommand_idx="${subcommand% *}"
> -	subcommand="${subcommand#* }"
> +	subcommand="$(__git_find_on_cmdline "$subcommands")"
>  
>  	case "$subcommand,$cur" in
>  	,*)
> @@ -3306,7 +3304,7 @@ _git_worktree ()
>  			# be either the 'add' subcommand, the unstuck
>  			# argument of an option (e.g. branch for -b|-B), or
>  			# the path for the new worktree.
> -			if [ $cword -eq $((subcommand_idx+1)) ]; then
> +			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
>  				# Right after the 'add' subcommand: have to
>  				# complete the path, so fall back to Bash
>  				# filename completion.
> @@ -3330,7 +3328,7 @@ _git_worktree ()
>  		__git_complete_worktree_paths
>  		;;
>  	move,*)
> -		if [ $cword -eq $((subcommand_idx+1)) ]; then
> +		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
>  			# The first parameter must be an existing working
>  			# tree to be moved.
>  			__git_complete_worktree_paths

I don't like these changes to _git_worktree(), because they implicitly
assume that 'git worktree' doesn't have any --options, and it would
then start to misbehave if we added one.

And these changes wouldn't be necessary if __git_find_on_cmdline()
started its search at $__git_cmd_idx instead of at ${words[1]}.

> @@ -3398,6 +3396,7 @@ __git_main ()
>  {
>  	local i c=1 command __git_dir __git_repo_path
>  	local __git_C_args C_args_count=0
> +	local __git_subcommand_idx
>  
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
> @@ -3412,7 +3411,7 @@ __git_main ()
>  			__git_C_args[C_args_count++]="${words[c]}"
>  			;;
>  		-*) ;;
> -		*) command="$i"; break ;;
> +		*) command="$i"; __git_subcommand_idx="$c"; break ;;

See what variable is $i assigned to?  $command, not $subcommand.

>  		esac
>  		((c++))
>  	done
> -- 
> 2.31.0.rc2.261.g7f71774620
> 
