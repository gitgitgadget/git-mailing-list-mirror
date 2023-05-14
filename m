Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12CC77B7D
	for <git@archiver.kernel.org>; Sun, 14 May 2023 20:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjENUYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUYj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 16:24:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5F10FC
        for <git@vger.kernel.org>; Sun, 14 May 2023 13:24:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42b984405so42327985e9.3
        for <git@vger.kernel.org>; Sun, 14 May 2023 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684095876; x=1686687876;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqp4SdgIjbzYNwcimJatWTOVuAHk7ya4KmceLbq/qdI=;
        b=nZkV7gDaBtDEKB6J9jPPTtvUmxCJnYcJ2AMbP6zgLfW7BS6uIHDTYtmQUEJsPhyEHM
         DuS95mW3AaiI5TAkVQ4lePw7znpuccwZH/5hi305XOFc6f/eIIGBZEQJeiPPXiC05mkw
         Al9tiocv/1lzTIrsmNTRwjQkvP+A4gK6ZFWpVXf0q8dlA9ncj2XUv1Pw2gD8mljhAbMA
         syobPoiE9S9dRQVSXKYLoIfQpz3xsIUrtxN7/XUocX7kVdi6u5RvAZS0xSYM2HPYLCNq
         3X5MC+GQfKwFov5BtmD7NcLxh55MV/WzgX5hrNJ4SBUEYK6xP5GeUisxOjo79tm6HM9R
         Etnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095876; x=1686687876;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqp4SdgIjbzYNwcimJatWTOVuAHk7ya4KmceLbq/qdI=;
        b=EzMivkOuKD11+Qbxiuy2W9ePXsbL2eOu9pR6BEsXwM/JBFHN6Udguol4nO8rmEujbT
         P/sxcudefUwgHUKu5XqYocODe+m924W4EUA/pTqqnj1gQO3KHsBfwwO6/BluH9GkF/y3
         eeE2TE37PmI6n570NO8Y4P9aIlKp6TuRceg7KOPD0lGDiTpcPlmkvl8MEfv3FAilwFTO
         7dEDug1L9JXEpvQp32bnuDjeKfP8LJqvEPlh0+W2i9T/IrvyILVx+8Mwuu2jYvidhRno
         5qP1HkvlShR+jOPK3dILZF3AXQ/Laa7Zya7YEana+Xg501maIkm9pjbD4kMiS8x+G4+x
         jfIw==
X-Gm-Message-State: AC+VfDz98Wk0NGOUzdbASwBzsRKFhDTmW1o1RdDHrT+53LvPJkrWsI9F
        HYBvJQ7vUT3UfsDZvYAc8Yc=
X-Google-Smtp-Source: ACHHUZ7V/Ljs2TYPf/3cIKEyhDnDxDWkmIxYo3ManIk0VqRHD8GcIBwT5gnXXBqD1eINqTI/g+6y9g==
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id k20-20020a7bc314000000b003ef6b97f0c3mr22332076wmj.15.1684095875463;
        Sun, 14 May 2023 13:24:35 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c22c200b003f42328b5d9sm22962065wmg.39.2023.05.14.13.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 13:24:34 -0700 (PDT)
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20230119055325.1013-1-carenas@gmail.com>
 <20230120113553.24655-1-carenas@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <6dfbdc94-6a5c-c99a-3435-08f86f0e1fef@gmail.com>
Date:   Sun, 14 May 2023 22:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230120113553.24655-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/1/23 12:35, Carlo Marcelo Arenas Belón wrote:
> Commands `git switch -C` and `git checkout -B` neglect to check whether
> the provided branch is already checked out in some other worktree, as
> shown by the following:
>
>   $ git worktree list
>   .../foo    beefb00f [main]
>   $ git worktree add ../other
>   Preparing worktree (new branch 'other')
>   HEAD is now at beefb00f first
>   $ cd ../other
>   $ git switch -C main
>   Switched to and reset branch 'main'
>   $ git worktree list
>   .../foo    beefb00f [main]
>   .../other  beefb00f [main]
>
> Fix this problem by teaching `git switch -C` and `git checkout -B` to
> check whether the branch in question is already checked out elsewhere.
>
> Unlike what it is done for `git switch` and `git checkout`, that have
> an historical exception to ignore other worktrees if the branch to
> check is the current one (as required when called as part of other
> tools), the logic implemented is more strict and will require the user
> to invoke the command with `--ignore-other-worktrees` to explicitly
> indicate they want the risky behaviour.
>
> This matches the current behaviour of `git branch -f` and is safer; for
> more details see the tests in t2400.
>
> Reported-by: Jinwook Jeong <vustthat@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Rubén Justo <rjusto@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Changes since v3
> * Code and Tests improvements as suggested by Phillip
> * Disable unreliable test that triggers a known bug
>
> Changes since v2
> * A leak free implementation
> * More details in commit as suggested by Junio
>
> Changes since v1
> * A much better commit message
> * Changes to the tests as suggested by Eric
> * Changes to the logic as suggested by Rubén
>
>
>  builtin/checkout.c      | 32 ++++++++++++++++++++++++--------
>  t/t2400-worktree-add.sh | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3fa29a08ee..0688652f99 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1474,7 +1474,8 @@ static void die_if_some_operation_in_progress(void)
>  }
>  
>  static int checkout_branch(struct checkout_opts *opts,
> -			   struct branch_info *new_branch_info)
> +			   struct branch_info *new_branch_info,
> +			   char *check_branch_path)
>  {
>  	if (opts->pathspec.nr)
>  		die(_("paths cannot be used with switching branches"));
> @@ -1533,13 +1534,13 @@ static int checkout_branch(struct checkout_opts *opts,
>  	if (!opts->can_switch_when_in_progress)
>  		die_if_some_operation_in_progress();
>  
> -	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
> -	    !opts->ignore_other_worktrees) {
> +	if (!opts->ignore_other_worktrees && !opts->force_detach &&
> +	    check_branch_path && ref_exists(check_branch_path)) {
>  		int flag;
>  		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
> -		if (head_ref &&
> -		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
> -			die_if_checked_out(new_branch_info->path, 1);
> +		if (opts->new_branch_force || (head_ref &&
> +		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_path))))
> +			die_if_checked_out(check_branch_path, 1);
>  		free(head_ref);
>  	}
>  
> @@ -1627,7 +1628,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  			 const char * const usagestr[],
>  			 struct branch_info *new_branch_info)
>  {
> +	int ret;
>  	int parseopt_flags = 0;
> +	char *check_branch_path = NULL;
>  
>  	opts->overwrite_ignore = 1;
>  	opts->prefix = prefix;
> @@ -1717,6 +1720,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		opts->new_branch = argv0 + 1;
>  	}
>  
> +	if (opts->new_branch && !opts->ignore_other_worktrees) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		strbuf_branchname(&buf, opts->new_branch, INTERPRET_BRANCH_LOCAL);
> +		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
> +		check_branch_path = strbuf_detach(&buf, NULL);
> +	}
>  	/*
>  	 * Extract branch name from command line arguments, so
>  	 * all that is left is pathspecs.
> @@ -1741,6 +1751,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  					     new_branch_info, opts, &rev);
>  		argv += n;
>  		argc -= n;
> +
> +		if (!opts->ignore_other_worktrees && !check_branch_path && new_branch_info->path)
> +			check_branch_path = xstrdup(new_branch_info->path);
>  	} else if (!opts->accept_ref && opts->from_treeish) {
>  		struct object_id rev;
>  
> @@ -1817,9 +1830,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	if (opts->patch_mode || opts->pathspec.nr)
> -		return checkout_paths(opts, new_branch_info);
> +		ret = checkout_paths(opts, new_branch_info);
>  	else
> -		return checkout_branch(opts, new_branch_info);
> +		ret = checkout_branch(opts, new_branch_info, check_branch_path);
> +
> +	free(check_branch_path);
> +	return ret;
>  }
>  
>  int cmd_checkout(int argc, const char **argv, const char *prefix)
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index d587e0b20d..7ab7e87440 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -118,14 +118,17 @@ test_expect_success '"add" worktree creating new branch' '
>  	)
>  '
>  
> -test_expect_success 'die the same branch is already checked out' '
> +test_expect_success 'die if the same branch is already checked out' '
>  	(
>  		cd here &&
> -		test_must_fail git checkout newmain
> +		test_must_fail git checkout newmain &&
> +		test_must_fail git checkout -B newmain &&
> +		test_must_fail git switch newmain &&
> +		test_must_fail git switch -C newmain
>  	)
>  '
>  
> -test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
> +test_expect_success SYMLINKS 'die if the same branch is already checked out (symlink)' '
>  	head=$(git -C there rev-parse --git-path HEAD) &&
>  	ref=$(git -C there symbolic-ref HEAD) &&
>  	rm "$head" &&
> @@ -133,17 +136,34 @@ test_expect_success SYMLINKS 'die the same branch is already checked out (symlin
>  	test_must_fail git -C here checkout newmain
>  '
>  
> -test_expect_success 'not die the same branch is already checked out' '
> +test_expect_success 'allow creating multiple worktrees for same branch with force' '
> +	git worktree add --force anothernewmain newmain
> +'
> +
> +test_expect_success 'allow checkout/reset from the conflicted branch' '
>  	(
>  		cd here &&
> -		git worktree add --force anothernewmain newmain
> +		git checkout -b conflictedmain newmain &&
> +		git checkout -B conflictedmain newmain &&
> +		git switch -C conflictedmain newmain
> +	)
> +'
> +
> +test_expect_success 'and not die on re-checking out current branch even if conflicted' '
> +	(
> +		cd there &&
> +		git checkout newmain &&
> +		git switch newmain
>  	)
>  '
>  
> -test_expect_success 'not die on re-checking out current branch' '
> +test_expect_failure 'unless using force without --ignore-other-worktrees' '

The fix to what caused this test to occasionally fail is already in
'master'.  This test should now succeed consistently.

>  	(
>  		cd there &&
> -		git checkout newmain
> +		test_must_fail git checkout -B newmain &&
> +		test_must_fail git switch -C newmain &&
> +		git checkout --ignore-other-worktrees -B newmain &&
> +		git switch --ignore-other-worktrees -C newmain
>  	)
>  '
>  
>

Thanks for continuing to work on this.
