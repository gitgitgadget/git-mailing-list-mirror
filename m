Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A13C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 11:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833F061949
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 11:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC1LEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1LEc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 07:04:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D9C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 04:04:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ap14so1928941ejc.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7w5cayql9OBMpU/M6otDq1tSMgmqy8buMhr+7QOwGA=;
        b=SmJ6oEakF3xc+ARM62ksZ1uYBF7RHe9/+8DJ5kaDdTtdD9vioWkuOHPwTRQ4B5gQfz
         qEfauMjcNLzOFRJbIwF2VpT7Vvg2MRIXXlP+3Zu8iypicuuyE7Hp+9KNwkPIRf1a2rgO
         GKZQz+SsjaLGDat2yVakBz0EGmK+fytRguQDfUNBoVouyB05Swe3MBxqt3JHBhwTUWVQ
         Rlk61UPCPBBdyJZPcSRNFSl+8VdPajpzTTQMUn04JDpyG5QLzz32k7LoyVjgRh9q5Arr
         7fULGiLNqWl8mWfMUmGK2Ral2Pnmu/hL7Xw7rdq9aiIowXFYPzbAGs3gsrgQFcwNChTY
         CCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7w5cayql9OBMpU/M6otDq1tSMgmqy8buMhr+7QOwGA=;
        b=oLX+vI/QkDA0xt1NB/dtrmXWPBEZrQ27qsi5zW00yM5V6Nv+5eoMBPPLNr7Ib9oC1J
         9lvgRS+UobsilF6iTCmh9/HH6tCwIrhxcpXObnBkOyxS6kp/ySBx6wGnlgJ/pVz1WQdI
         Gm7QxjBAKfyEG3rZ6SnUtNx/D9Y2gY4EVTxpb3PdeVipIneSj0QAfX5ZOu5FKpKxC7Ww
         eO+G3yRBdmYLsV1WqRfQ2R6StjnwN4qXBFZ8BkXhwVKPjdLWee6YvrGENAFzob6buGxa
         ScHmQ+kiv9P5gtwArRV3fKYlpjiMuWwD/lkjwQ150D8KxTQaJfXoUOKiO9RxB4I44YP9
         nXXA==
X-Gm-Message-State: AOAM533Xrk839+FUObVTck/6N+b4UoXfr1MCHQRb+0lKRpWvMABBZc9k
        VMxjo+BWk0hkPfkLknHuJfM=
X-Google-Smtp-Source: ABdhPJwbr2wt3XrYquwGrNOpoC1WOAr4m+/dcwZpK+fU49NLBrom/WOfrNcCuXoxv+E+qkqSiMg4fA==
X-Received: by 2002:a17:907:2661:: with SMTP id ci1mr23601820ejc.403.1616929470050;
        Sun, 28 Mar 2021 04:04:30 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id cw14sm7268779edb.8.2021.03.28.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 04:04:29 -0700 (PDT)
Date:   Sun, 28 Mar 2021 13:04:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-completion.bash: use __gitcomp_builtin() in
 _git_stash()
Message-ID: <20210328110427.GG2271@szeder.dev>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616574955.git.liu.denton@gmail.com>
 <680f3a3146355e6b09aa2e0f59471c7695954a1b.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <680f3a3146355e6b09aa2e0f59471c7695954a1b.1616574955.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:36:29AM -0700, Denton Liu wrote:
> The completion for 'git stash' has not changed in a major way since it
> was converted from shell script to builtin. Now that it's a builtin, we
> can take advantage of the groundwork laid out by parse-options and use
> the generated options.
> 
> Rewrite _git_stash() to take use __gitcomp_builtin() to generate
> completions for subcommands.
> 
> The main `git stash` command does not take any arguments directly. If no
> subcommand is given, it automatically defaults to `git stash push`. This
> means that we can simplify the logic for when no subcommands have been
> given yet. We only have to offer subcommand completions when we're
> completing a non-option after "stash".
> 
> One area that this patch could improve upon is that the `git stash list`
> command accepts log-options. It would be nice if the completion for this
> were unified with that of _git_log() and _git_show() which would allow
> completions to be provided for options such as `--pretty` but that is
> outside the scope of this patch.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 42 ++++++++++++--------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8d4d8cc0fe..c926ca26c6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3013,26 +3013,19 @@ _git_sparse_checkout ()
>  
>  _git_stash ()
>  {
> -	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
>  	local subcommands='push list show apply clear drop pop create branch'
>  	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
> -	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
> -		subcommand="push"
> -	fi

I think it would be better to keep this condition ...

> +
>  	if [ -z "$subcommand" ]; then
> -		case "$cur" in
> -		--*)
> -			__gitcomp "$save_opts"
> +		case "$((cword - __git_subcommand_idx)),$cur" in

... and not bring in such magic with the indices here and ...

> +		*,--*)
> +			__gitcomp_builtin stash_push
>  			;;
> -		sa*)
> -			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
> -				__gitcomp "save"
> -			fi
> +		1,sa*)
> +			__gitcomp "save"
>  			;;
> -		*)
> -			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
> -				__gitcomp "$subcommands"
> -			fi
> +		1,*)
> +			__gitcomp "$subcommands"

... here in these two case arms, but instead handle the cases both
with and without a subcommand in a unified case statement as I
suggested in reply to the previous patch.

>  			;;
>  		esac
>  		return
> @@ -3040,24 +3033,29 @@ _git_stash ()
>  
>  	case "$subcommand,$cur" in
>  	push,--*)
> -		__gitcomp "$save_opts --message"
> +		__gitcomp_builtin stash_push
>  		;;
>  	save,--*)
> -		__gitcomp "$save_opts"
> +		__gitcomp_builtin stash_save
>  		;;
> -	apply,--*|pop,--*)
> -		__gitcomp "--index --quiet"
> +	pop,--*)
> +		__gitcomp_builtin stash_pop
> +		;;
> +	apply,--*)
> +		__gitcomp_builtin stash_apply
>  		;;
>  	drop,--*)
> -		__gitcomp "--quiet"
> +		__gitcomp_builtin stash_drop
>  		;;

These case arms are still quite repetitive, and could be handled by a
single arm like this:

        *,--*)
                __gitcomp_builtin stash_$subcommand
                ;;

Of course the more specific 'list,--*' and 'show,--*' cases should be
handled before.

The end result would look something like this (taken from a WIP patch
series of mine, which has been in a WIP state for about a year and a
half now...):

  https://github.com/szeder/git/commit/83a0e138767040280750062c5c0d43886796fcb1


>  	list,--*)
> -		__gitcomp "--name-status --oneline --patch-with-stat"
> +		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
> +		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
>  		;;
>  	show,--*)
> -		__gitcomp "$__git_diff_common_options"
> +		__gitcomp_builtin stash_show "$__git_diff_common_options"
>  		;;
>  	branch,--*)
> +		__gitcomp_builtin stash_branch
>  		;;
>  	branch,*)
>  		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> -- 
> 2.31.0.rc2.261.g7f71774620
> 
