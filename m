Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652751F576
	for <e@80x24.org>; Fri, 26 Jan 2018 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeAZLM1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 06:12:27 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:62276 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeAZLMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 06:12:25 -0500
Received: from [192.168.2.201] ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id f1vjeqHZENSVVf1vje4nqE; Fri, 26 Jan 2018 11:12:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516965143;
        bh=BcpPSQfMf+sRRpPFHDxdXGLdZ5EWWCLHklYk1BMDzXw=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=IQXkS8+t8B4oGvrFpEkCKhEZfvvjUzQHhzCsor+LwuX5wGbEB6jUeyqo9ueYny+Ti
         f9+HmMPfkJL/410SvTKKRqMwTMcJIMxdnzSH/X7Pz9Jez0a3GiIaFDlVqIH102pzww
         48rZCNPhFkpM7N6E0iZ1vXPqVz7Y2r21MifAXk/0=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=wpn1FvXkZpQtFJ2W3DEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: add --show-patch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180126095520.919-3-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4d7eb4c8-8d48-7c8d-259a-ba6b2f64def0@talktalk.net>
Date:   Fri, 26 Jan 2018 11:12:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126095520.919-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJDHvUQQa80cIojmqRlNe49dFAdhhJ3AScbj/WkC8y9kw8e+8sQ66NLUyUcf+Hr+8xsB4GSBTVcQiVnurz8pAFo268hRToIDSyuc6Ik/SqKB3hae7Lua
 thg/KGqtLkxRW7ClUJES7BfXPL1fHC0l2OHiLomeiMGtsgtvrvgeTTcmb4ZV5vKmgCb7Sr5b32pxRxbhlntH4XUA4ylqMbyTXpc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/18 09:55, Nguyễn Thái Ngọc Duy wrote:
> 
> It is useful to see the full patch while resolving conflicts in a
> rebase. The only way to do it now is
> 
>     less .git/rebase-*/patch
> 
> which could turn out to be a lot longer to type [1] if you are in a
> linked worktree, or not at top-dir. On top of that, an ordinary user
> should not need to peek into .git directory. The new option is
> provided to examine the patch.
> 
> [1] A conflict caused by git-rebase--am.sh does show the path to this
>     patch file so you could copy/paste. But then after some time and
>     lots of commands to resolve the conflict, that path is likely
>     scrolled out of your terminal.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-rebase.txt           |  5 +++-
>  contrib/completion/git-completion.bash |  4 +--
>  git-rebase--am.sh                      |  3 +++
>  git-rebase--interactive.sh             |  4 +++
>  git-rebase--merge.sh                   |  4 +++
>  git-rebase.sh                          |  7 +++++-
>  t/t3400-rebase.sh                      | 34 ++++++++++++++++++++++++++
>  t/t3404-rebase-interactive.sh          |  6 +++++
>  8 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 8a861c1e0d..4fd571d393 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  	[<upstream> [<branch>]]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>  	--root [<branch>]
> -'git rebase' --continue | --skip | --abort | --quit | --edit-todo
> +'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-patch
>  
>  DESCRIPTION
>  -----------
> @@ -250,6 +250,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  --edit-todo::
>  	Edit the todo list during an interactive rebase.
>  
> +--show-patch::
> +	Show the current patch in an interactive rebase.
> +
>  -m::
>  --merge::
>  	Use merging strategies to rebase.  When the recursive (default) merge
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1e9105f6d5..b70da4990f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1992,11 +1992,11 @@ _git_rebase ()
>  {
>  	__git_find_repo_path
>  	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
> -		__gitcomp "--continue --skip --abort --quit --edit-todo"
> +		__gitcomp "--continue --skip --abort --quit --edit-todo --show-patch"
>  		return
>  	elif [ -d "$__git_repo_path"/rebase-apply ] || \
>  	     [ -d "$__git_repo_path"/rebase-merge ]; then
> -		__gitcomp "--continue --skip --abort --quit"
> +		__gitcomp "--continue --skip --abort --quit --show-patch"
>  		return
>  	fi
>  	__git_complete_strategy && return
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 14c50782e0..564a4a5830 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -27,6 +27,9 @@ skip)
>  	move_to_original_branch
>  	return
>  	;;
> +show-patch)
> +	exec git am --show-patch
> +	;;
>  esac
>  
>  if test -z "$rebase_root"
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index d47bd29593..01cc002efd 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -840,6 +840,10 @@ To continue rebase after editing, run:
>  
>  	exit
>  	;;
> +show-patch)
> +	cmt="$(cat "$state_dir/stopped-sha")"
> +	exec git format-patch --subject-prefix= --stdout "${cmt}^!"
> +	;;
>  esac
>  
>  comment_for_reflog start
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 06a4723d4d..5c513a9736 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -137,6 +137,10 @@ skip)
>  	finish_rb_merge
>  	return
>  	;;
> +show-patch)
> +	cmt="$(cat "$state_dir/current")"
> +	exec git format-patch --subject-prefix= --stdout "${cmt}^!"
> +	;;
>  esac

Here and in the git-rebase--interactive you have access to the SHA of
the failed pick so you could run git log --patch and git colored output
and it would use the pager in the same way as 'git am --show-patch' does

Best Wishes

Phillip
