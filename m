Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43DC43219
	for <git@archiver.kernel.org>; Mon, 30 May 2022 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiE3OXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiE3OSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 10:18:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA79CF36
        for <git@vger.kernel.org>; Mon, 30 May 2022 06:48:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v25so5543173eda.6
        for <git@vger.kernel.org>; Mon, 30 May 2022 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6Yd54vyyyWYTe9V4mYTnCS5kg7ZIZclqpXT8N+Xp99I=;
        b=p2RVjmZaos5I4eLsLa76YPPrVXcngdPLUEmQ0ZxFsErFj4Yj8KmfBH8m4seWa9bJ3K
         reFxdZFlQ1CEWDlIdu5OfgDtqJ3YeBr8hrEEQS7IFkz1QC8JOOwZ0wzsfsDxUpZyZOuR
         hMWunBYtzij/vHYTWXGxnfbGY4vuJ+N6/VrdsU1E4Dhkvx5MtmngW2BFJ0SugslI7e7L
         Ax89OZCWhB2bW9xQ+rq5oQmHDsBHPzroujUV8E0mE1QMiCA1cxIgzM/cij8PZgji8JCi
         VLYEqjlc4Z5XK2yxOVe6GWU5s41JBg4OxZF5cRwikJNvyrb/snuZmvPVZIs+k59GnGCF
         NbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6Yd54vyyyWYTe9V4mYTnCS5kg7ZIZclqpXT8N+Xp99I=;
        b=J/jpJpTw23+nAT5xF65f6Vy5jcxsiSZgy15U+/DxjctMAq25crzCqsxwKJOd/hAmOG
         okznCQGveqWp6gsw72+2z6hIToHoo1oBH8hgZ5gkdcSYMk1D9AORxEU3efoCB00bwi+5
         1LbI30xqIq+1Ga00+aieTUDo5c7tPHakmaSmB/DpichjcckHNH0TRZihG4xBq/fd573A
         9jFogKKhQ2H1sx93OO+2tP+ceO7Q1YggbfpwkXxjcPJAR5to50DB/S1LKdYbyEo+qPUd
         YBxgK9EtxUewINUAPHFUZdIx96OQ2uAGfapTEbUBgBVdFz/1xYi9Jrbn1Q1yuh1hbM5Z
         nhag==
X-Gm-Message-State: AOAM530EGdJCXH2H19mH4pF9PjQuN3bvME2xBC6pgjRgX89RXjnhBfMx
        Csa+x1DmNGnwcAeX9zvzxgO+T78GR2Y=
X-Google-Smtp-Source: ABdhPJwocRiCJf6EmRfZFmgqu/ycSiOdgQ5PIpuN+bghuAJRDm/62gl086zADBG3LWo/PKcpwrPFLw==
X-Received: by 2002:a05:6402:3046:b0:42b:505a:4f26 with SMTP id bs6-20020a056402304600b0042b505a4f26mr44631204edb.183.1653918520919;
        Mon, 30 May 2022 06:48:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm4084233eja.32.2022.05.30.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:48:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nvfl9-000g9W-9v;
        Mon, 30 May 2022 15:48:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
Date:   Mon, 30 May 2022 15:46:22 +0200
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
Message-ID: <220530.867d632kso.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 30 2022, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> After generating diffs for each range to be compared using a 'git log'
> invocation, range-diff.c::read_patches looks for the "diff --git" header
> in those diffs to recognize the beginning of a new change.
>
> In a project with submodules, and with 'diff.submodule=log' set in the
> config, this header is missing for the diff of a changed submodule, so
> any submodule changes are quietly ignored in the range-diff.
>
> When 'diff.submodule=diff' is set in the config, the "diff --git" header
> is also missing for the submodule itself, but is shown for submodule
> content changes, which can easily confuse 'git range-diff' and lead to
> errors such as:
>
>     error: git apply: bad git-diff - inconsistent old filename on line 1
>     error: could not parse git header 'diff --git path/to/submodule/and/some/file/within
>     '
>     error: could not parse log for '@{u}..@{1}'
>
> Force the submodule diff format to its default ("short") when invoking
> 'git log' to generate the patches for each range, such that submodule
> changes are always shown.
>
> Note that the test must use '--creation-factor=100' to force the second
> commit in the range not to be considered a complete rewrite.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     range-diff: show submodule changes irrespective of diff.submodule
>     
>     This fixes a bug that I reported last summer [1].
>     
>     [1]
>     https://lore.kernel.org/git/e469038c-d78c-cd4b-0214-7094746b9281@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1244%2Fphil-blain%2Frange-diff-submodule-diff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1244/phil-blain/range-diff-submodule-diff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1244
>
>  range-diff.c          |  2 +-
>  t/t3206-range-diff.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)

Thanks for picking this up again, and nice to have a test on this
iteration!

> diff --git a/range-diff.c b/range-diff.c
> index b72eb9fdbee..068bf214544 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -44,7 +44,7 @@ static int read_patches(const char *range, struct string_list *list,
>  
>  	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>  		     "--reverse", "--date-order", "--decorate=no",
> -		     "--no-prefix",
> +		     "--no-prefix", "--submodule=short",
>  		     /*
>  		      * Choose indicators that are not used anywhere
>  		      * else in diffs, but still look reasonable
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e30bc48a290..ac848c42536 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -772,4 +772,48 @@ test_expect_success '--left-only/--right-only' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
> +	git init sub-repo &&
> +	test_commit -C sub-repo sub-first &&
> +	sub_oid1=$(git -C sub-repo rev-parse HEAD) &&
> +	test_commit -C sub-repo sub-second &&
> +	sub_oid2=$(git -C sub-repo rev-parse HEAD) &&
> +	test_commit -C sub-repo sub-third &&
> +	sub_oid3=$(git -C sub-repo rev-parse HEAD) &&
> +
> +	git checkout -b main-sub topic &&
> +	git submodule add ./sub-repo sub &&
> +	git -C sub checkout --detach sub-first &&
> +	git add sub &&
> +	git commit -m "add sub" &&
> +	sup_oid1=$(git rev-parse --short HEAD) &&
> +	git checkout -b topic-sub &&
> +	git -C sub checkout sub-second &&
> +	git add sub &&
> +	git commit -m "change sub" &&
> +	sup_oid2=$(git rev-parse --short HEAD) &&
> +	git checkout -b modified-sub main-sub &&
> +	git -C sub checkout sub-third &&
> +	git add sub &&
> +	git commit -m "change sub" &&
> +	sup_oid3=$(git rev-parse --short HEAD) &&
> +
> +	test_config diff.submodule log &&
> +	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
> +	cat >expect <<-EOF &&
> +	1:  $sup_oid1 = 1:  $sup_oid1 add sub
> +	2:  $sup_oid2 ! 2:  $sup_oid3 change sub
> +	    @@ Commit message
> +	      ## sub ##
> +	     @@
> +	     -Subproject commit $sub_oid1
> +	    -+Subproject commit $sub_oid2
> +	    ++Subproject commit $sub_oid3
> +	EOF
> +	test_cmp expect actual &&
> +	test_config diff.submodule diff &&
> +	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
> +	test_cmp expect actual
> +'
> +

I'd find this much easier to follow if this were a two-part where we do
most of this test code in the 1st commit, and assert the current
(failing) behavior with a test_expect_failure.

Then this commit would narrowly be the bugfix itself.

I also see that the --creation-factor=100 isn't necessary and seems
somewhat orthagonal, i.e. we'd like to test this *without* that option
and see how we behave, i.e. we'll emit the "full replacement".

Why not compare the output without --creation-factor=100, and then just
have another --creation-factor=100 test to show what we emit if we "look
into" those commits and diff their contents?
