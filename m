Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF36C7EE2F
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 00:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFMADX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFMADV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 20:03:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE41713
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 17:03:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3be39e35dso19421225ad.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686614600; x=1689206600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoD09TbUzwI6m0rnYVN6IbOLHngaeTHH3QO/r75y8nQ=;
        b=hcvaIMT6S9Q6LtlyAg48z4/0/Bwe5u2u3tfbq1IjP+qImo+U8nHHZ5RZ5ju1mE6e9e
         oW7HXCGI12WW2SOeY01KdlESTCDqhsFHym2xRor+O4eHwpEVEen0GfMiOYzAm1EN6c+N
         cXOTiRthZnmSc1wgfUkL+1JAc4Uz7w4JtvJzCzle8+b9auFYUQ4F206RWBhB/HBFLICa
         wcbaD/ypamDGhspJ/rMGea+rc85tZmc/Vb5Xfo7Fp+/QWHDfWRcsQlBQyGhmcqlNwber
         E0DtyWPLi1WIZw826EVgvA2g18/6vrdfwvoAC3gjfOnHO4cj/Jop4OJPvjHh/rT3WOqQ
         Fg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614600; x=1689206600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoD09TbUzwI6m0rnYVN6IbOLHngaeTHH3QO/r75y8nQ=;
        b=PBMbiiA2XPUFXSTrj9VBWddUtnp7w8tMGZGNasPcn44tgY4fUtJltpUkxUvaNh80QU
         QYJgFTk2og7Ueq/MJmYsDe727bsIfRwF5m9MyZgsUAsCU2HcYYtLpOecAhtxlcyMZC/R
         ITV6mgg46FKx7Co2KkoT5OwcDHU8H/gD/FMPzxCZvtIXb2O+4ESN9ONc//MyYKD55IkM
         P9cWt2AE8PeLNAhQHktwla1rOIiijsuoVm6bzVEUgs6xlL7GKEwjdqI6KtyXno/7D6co
         /LxM+s8IEqrgjCBuo17jrQkkkv3Eb6haDv8bRM/oZM+b6TlX1XTsJezheUHUNhstXdr7
         Culg==
X-Gm-Message-State: AC+VfDwEQRyJzjTDooHEBKMbWBZWyFtmYwL8IC9Jd1Ff/Wa1VUaDVovk
        rbWTD67T6AlONTGj5iAoXlmI3W2/X+hCsFA6XA==
X-Google-Smtp-Source: ACHHUZ4bajH0Laj1FeV43algnRTrxRPpcIOJXzqViWoTbOn1x5FCTjL5jk6JBUZw4JypXEMa57J/pQ==
X-Received: by 2002:a17:902:e54a:b0:1b2:6387:a30d with SMTP id n10-20020a170902e54a00b001b26387a30dmr8540873plf.35.1686614599763;
        Mon, 12 Jun 2023 17:03:19 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b001ac8218ddb7sm8792630plt.84.2023.06.12.17.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 17:03:19 -0700 (PDT)
Message-ID: <9fb6d7b1-00b6-93ee-efec-9dd0ab91a66d@github.com>
Date:   Mon, 12 Jun 2023 17:03:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] setup: copy repository_format using helper
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com, gitster@pobox.com
References: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230612230453.70864-1-chooglen@google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230612230453.70864-1-chooglen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> In several parts of the setup machinery, we set up a repository_format
> and then use it to set up the_repository in nearly the exact same way,
> suggesting that we might be able to use a helper function to standardize
> the behavior and make future modifications easier. Create this helper
> function, setup_repository_from_format(), thus standardizing this
> behavior.
> 
> To determine what the 'standardized behavior' should be, we can compare
> the candidate call sites in repo_init(), setup_git_directory_gently(),
> check_repository_format() and discover_git_directory(),
> 
> - All of them copy .worktree_config.
> 
> - All of them 'copy' .partial_clone. Most perform a shallow copy of the
>   pointer, then set the .partial_clone = NULL so that it doesn't get
>   cleared by clear_repository_format(). However,
>   check_repository_format() copies the string deeply because the
>   repository_format is sometimes read back (it is an "out" parameter).
>   To accomodate both shallow copying and deep copying, toggle this
>   behavior using the "modify_fmt_ok" parameter.

Do you have a specific example of this happening? I see two uses of
'check_repository_format()' in the codebase:

1. in 'enter_repo()' ('path.c')
2. in 'init_db()' ('init-db.c')

The first one calls 'check_repository_format()' with 'NULL', which causes
the function to create a temporary 'struct repository_format' that is then
discarded at the end of the function - no need to worry about the value
being cleared there.

The second one does call 'check_repository_format()' with a 'struct
repository_format' instance, but the 'partial_clone' field field is not
accessed again after that. The only subsequent usages of the 'repo_fmt'
variable in 'init_db()' are:

- in 'validate_hash_algorithm()', where only the 'version' and 'hash_algo'
  fields are accessed.
- in 'create_default_files()', where only 'hash_algo' is accessed.

So, shouldn't it be safe to shallow-copy-and-NULL? But as I noted earlier
[1], if you do that it'll make the name 'check_repository_format()' a bit
misleading (since it's actually modifying its arg in place). So, if you
update to always shallow copy, 'check_repository_format()' should be renamed
to reflect its side effects.

[1] https://lore.kernel.org/git/49509708-c0a1-2439-a551-cab05d944b66@github.com/

> 
> - Most of them set up repository.hash_algo, except
>   discover_git_directory(). Our helper function unconditionally sets up
>   .hash_algo because it turns out that discover_git_directory() probably
>   doesn't need to set up "struct repository" at all!

If that's the case, shouldn't the 'repository_format' assignments in
'discover_git_directory()' be removed altogether? 

>   discover_git_directory() isn't actually used in the setup process - its
>   only caller in the Git binary is read_early_config(). As explained by
>   16ac8b8db6 (setup: introduce the discover_git_directory() function,
>   2017-03-13), it is supposed to be an entrypoint into setup.c machinery
>   that allows the Git directory to be discovered without side effects,
>   in other words, we shouldn't have introduced side effects in
>   ebaf3bcf1ae (repository: move global r_f_p_c to repo struct,
>   2021-06-17). Fortunately, we didn't start to rely on this unintended
>   behavior between then and now, so we can just drop it.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> Here's the helper function I had in mind. I was initially mistaken and
> it turns out that we need to support deep copying, but fortunately,
> t0001 is extremely thorough and will catch virtually any mistake in the
> setup process. CI seems to pass, though it appears to be a little flaky
> today and sometimes cancels jobs
> (https://github.com/chooglen/git/actions/runs/5249029150).
> 
> If you're comfortable with it, I would prefer for you to squash this
> into your patches so that we don't just end up changing the same few
> lines. If not, I'll Reviewed-by your patches (if I don't find any other
> concerns on a re-read) and send this as a 1-patch on top.

Reading through the commit message & patch, I'm still not convinced this
refactor is a good idea - to me, it doesn't leave the code in a clearly
better state. If you feel strongly that it does, though, I'm happy to leave
it to others to review/decide but I would prefer that you keep it a separate
patch submission on top.

Thanks!

> diff --git a/repository.c b/repository.c
> index 104960f8f5..50f0b26a6c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -181,12 +181,7 @@ int repo_init(struct repository *repo,
>  	if (read_and_verify_repository_format(&format, repo->commondir))
>  		goto error;
>  
> -	repo_set_hash_algo(repo, format.hash_algo);
> -	repo->repository_format_worktree_config = format.worktree_config;
> -
> -	/* take ownership of format.partial_clone */
> -	repo->repository_format_partial_clone = format.partial_clone;
> -	format.partial_clone = NULL;
> +	setup_repository_from_format(repo, &format, 1);
>  
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);
> diff --git a/setup.c b/setup.c
> index d866395435..33ce58676f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1561,13 +1561,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			setup_git_env(gitdir);
>  		}
>  		if (startup_info->have_repository) {
> -			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> -			the_repository->repository_format_worktree_config =
> -				repo_fmt.worktree_config;
> -			/* take ownership of repo_fmt.partial_clone */
> -			the_repository->repository_format_partial_clone =
> -				repo_fmt.partial_clone;
> -			repo_fmt.partial_clone = NULL;
> +			setup_repository_from_format(the_repository,
> +						     &repo_fmt, 1);
>  		}
>  	}
>  	/*
> @@ -1654,14 +1649,26 @@ void check_repository_format(struct repository_format *fmt)
>  		fmt = &repo_fmt;
>  	check_repository_format_gently(get_git_dir(), fmt, NULL);
>  	startup_info->have_repository = 1;
> -	repo_set_hash_algo(the_repository, fmt->hash_algo);
> -	the_repository->repository_format_worktree_config =
> -		fmt->worktree_config;
> -	the_repository->repository_format_partial_clone =
> -		xstrdup_or_null(fmt->partial_clone);
> +	setup_repository_from_format(the_repository, fmt, 0);
>  	clear_repository_format(&repo_fmt);
>  }
>  

I think you may be missing changes to 'discover_git_directory()'? Like I
mentioned above, though, if you don't think 'discover_git_directory()' needs
to set up 'the_repository', then those assignments should just be removed
(not replaced with 'setup_repository_from_format()').

