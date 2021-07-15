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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61415C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484EA613D3
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhGOQcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhGOQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:32:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA7C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:29:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec55so9007899edb.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CP+Hzyk0Io+iLL4PXS8y419iBQZQJI/XhkP9WhHm8IY=;
        b=B8tJgP38Esx2aUQ0gtE4nSvtvzCPM6W81wo6lnI9dUUuD9UsVF6h9jia0GLXdopHEG
         VCnEbk3b7Cy//FBVHArdaO+BD2hcKFq3rTKdMh8Y2yegln2wPcll5JJJHLH8j4q9yKUO
         xpK7T74HZJrhqMeGRWckxAWreNLmOg6vyNESeQXFyB/ZKyDJjed6xrNOw7eGGS+7WKv9
         SwODHTg62vO3PLBJd2ATuZi+SAvytlcUxZeZzQyXW6KrwfPlCgMmfkBh5EtdM7NYHKGW
         APH4O904jZ23OmMWJkmfcxFDvfMqetVbUDCwJquc2tVi+bsRvthwiTt0BM23r3nBM1FR
         4ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CP+Hzyk0Io+iLL4PXS8y419iBQZQJI/XhkP9WhHm8IY=;
        b=Bj/+D45iBu56tNNXy6l1YO3v3/VgMpR1hAMV+enjo26yc/VniiSunSnH8KDZyniUch
         UZ9aAzPH31HM6BXx82Esdk4w0CQi6jbs0Q+q6LIC9ShPjQv0GbVGf4cGUSVdUQrADWz5
         Z7QjN5r98WYIazvKtEiVkeXoCIwruq3Rcns6/8FHh6p7upghTtSLpdqZlNazFBqBOYRY
         +FvyaGRVYDssEWVT0NqMjjiiaoR1gXXnpBsqex1vJD6CwjgpZEDfL2yuyjdePQEDsEGW
         Z26LvJ8Vg8fMHtuU5TgijjCHXwPy9IS7+12mEDUfTtkax9Puqv4PUOThnrMrMoMsVKup
         k+Xw==
X-Gm-Message-State: AOAM530FEHnxFk5eXL/f2T4dp3v2VjQpylUoNLjeI5fK0R0H+JE+kHWM
        kN48ZP7u24cOjSQZvdc372Mo4ZKUqGN94hGX
X-Google-Smtp-Source: ABdhPJxw7lnCleX1eIvw5flUL7M0ycj8ovOZ/d7nIFEbRZIdRCV0vkD26D26Hs9rWWdtYYHUjnLRsA==
X-Received: by 2002:a05:6402:c9:: with SMTP id i9mr8313195edu.48.1626366554708;
        Thu, 15 Jul 2021 09:29:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t15sm2008477ejf.119.2021.07.15.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:29:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
Date:   Thu, 15 Jul 2021 18:16:26 +0200
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
Message-ID: <8735sfzgkg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 'OPT_ALIAS' was created in 5c387428f1 (parse-options: don't emit
> "ambiguous option" for aliases, 2019-04-29), 'git clone
> --git-completion-helper', which is used by the Bash completion script to
> list options accepted by clone (via '__gitcomp_builtin'), lists both
> '--recurse-submodules' and its alias '--recursive', which was not the
> case before since '--recursive' had the PARSE_OPT_HIDDEN flag set, and
> options with this flag are skipped by 'parse-options.c::show_gitcomp',
> which implements 'git <cmd> --git-completion-helper'.
>
> At the point where 'show_gitcomp' is called in 'parse_options_step',
> 'preprocess_options' was already called in 'parse_options', so any
> aliases are now copies of the original options with a modified help text
> indicating they are aliases.
>
> Helpfully, since 64cc539fd2 (parse-options: don't leak alias help
> messages, 2021-03-21) these copies have the PARSE_OPT_FROM_ALIAS flag
> set, so check that flag early in 'show_gitcomp' and do not print them,
> unless the user explicitely requested that *all* completion be shown (by
> setting 'GIT_COMPLETION_SHOW_ALL'). After all, if we want to encourage
> the use of '--recurse-submodules' over '--recursive', we'd better just
> suggest the former.
>
> The only other options alias is 'log' and friends' '--mailmap', which is
> an alias for '--use-mailmap', but the Bash completion helpers for these
> commands do not use '__gitcomp_builtin', and thus are unnaffected by
> this change.
>
> Test the new behaviour in t9902-completion.sh. As a side effect, this
> also tests the correct behaviour of GIT_COMPLETION_SHOW_ALL, which was
> not tested before. Note that since '__gitcomp_builtin' caches the
> options it shows, we need to re-source the completion script to clear
> that cache for the second test.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     parse-options: don't complete option aliases by default
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-996%2Fphil-blain%2Fclone-recurse-completion-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-996/phil-blain/clone-recurse-completion-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/996
>
>  parse-options.c       |  2 +-
>  t/t9902-completion.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index e6f56768ca5..2abff136a17 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -585,7 +585,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
>  		if (!opts->long_name)
>  			continue;
>  		if (!show_all &&
> -			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)))
> +			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE | PARSE_OPT_FROM_ALIAS)))
>  			continue;
>  
>  		switch (opts->type) {
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index cb057ef1613..11573936d58 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2404,6 +2404,19 @@ test_expect_success 'sourcing the completion script clears cached --options' '
>  	verbose test -z "$__gitcomp_builtin_notes_edit"
>  '
>  
> +test_expect_success 'option aliases are not shown by default' '
> +	test_completion "git clone --recurs" "--recurse-submodules "
> +'

I'm a bit biased here since I like --recursive better, but let's not
drag that whole argument up again. I don't find the argument in
bb62e0a99fc (clone: teach --recurse-submodules to optionally take a
pathspec, 2017-03-17) convincing enough to have moved such a prominent
use-case to a longer option name.

But, water under the bridge. Aside from that:

For me a Google search for "git clone --recursive" is ~40k results, but
"git clone --recurse-submodules". The former links to various
discussions/docs/stackoverflow answers, often --recurse-submodules isn't
mentioned at all or as an aside.

I think it's unfortunate that we:

 1. Conflate whether something shows up in completion v.s. the
    help. Given its prominence and that "git clone -h" is ~50 lines why
    not note --recursive there.

 2. Don't have the completion aware of these aliases, i.e. "git clone
    --rec<TAB>" before your chance offers a completion of both, that sucks,
    we should fully complete the non-alias instead.

 3. Making it PARSE_OPT_HIDDEN "solves" #2 at the cost of hiding it in
    "git help -h", and now this won't work, but did before:

        git clone --recursi<TAB>

    I.e. even if we didn't want to do #2 *and* wanted to hide it in the
    usage output surely completing an unmbigous prefix is better, even
    if it's a hidden option?

Per-se none of this is a blocker or "we must fix this first" for this
particular change, we have this in many existing cases.

I daresay there's no other alias that's in as wide a use in the wild, so
we should think about this one particularly carefully though.

It's not fully clear from your commit message which of 1-3 you're aiming
for, I think it's more of the "discourage its use". 

Sure, fair enough, but PARSE_OPT_HIDDEN is not a 1=1 mapping to that,
and can often lead to more user confusion.

E.g. the user has used --recursive for years, but can't even find it in
-h (I also think it's a mistake to have entirely removed it from the
docs, even if one agrees with its "deprecation" I'd say we should keep
some "used to be called --recursive" note there).

