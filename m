Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29875C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0623206D8
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6ZE3h3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgKWWs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbgKWWsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:48:20 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A0C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:48:20 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so16393244pfm.13
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O34ZPWxCXzwaKqmjYdwWE/fmDkE983TdR4/u4lwnj4E=;
        b=H6ZE3h3VtNLpy47Qan4mCynX/YMWRjxh/vLIqiYhwHRkyfTseD42jUDm0ctRZs26Zb
         OFV6IIbAgIZqIIMA9UnO25XNeC4gpda29dlopnpzUOQCND6XWs5Zvkwye4DaiLHtx1b3
         X/YqM3p+WFkpiqIoK3XwtsCY9x0GSJwBmFXe9hBfIQCgEjLy7rksj6I8mnn8xQnxYD9+
         x+hKoBfcjptKJPNjCVUhXzAPNtHyLrMzfLkQE0b+sJ4u/0BF2+rwfK8DY3pd9Dbjl8cC
         pDHbnLXHHMQJoNBsj/8VVUxO3f4oqgZJD5KclaOHNj0jkYSoje4I3wWMrrvTRnO9PMkL
         B2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O34ZPWxCXzwaKqmjYdwWE/fmDkE983TdR4/u4lwnj4E=;
        b=NgIZHtNN3akNNaRsMV/LZPwQDa4KpK6HROueH9+C5vz6gMguETe1uB5KqXPV8Nk2w4
         0qFLljGm7c367BVaahspoHG5glefeJoNNL7KhKvQf2e7CKF2VzzIvkwcop5Ddg8Gi6lq
         lRe34VlgxovFLNPFTx/g7mL9rVRR131JN94bv36wuv57npeIfq5+5BMhabDTQVrVfbxf
         xOYpOFGHwG7yaccFKxOXZ/TUzA0+hW7kQygn4KsJT9gtQgicjNb8evGRPLgLmivcUnSH
         xlaFE7tbw1sUooLloVTPS4pOxbmM3xL8HFw5GeHDa4cq8Apz2mhQ6FFfumxULllG0CLB
         S42Q==
X-Gm-Message-State: AOAM532n9FcEkzWyXM2SAnzYfw0luW8ukwWKmNtBf1zqHDkkbQpmxKo3
        W5V6piOytUi4riKdkQz3SyCUYg==
X-Google-Smtp-Source: ABdhPJxRkGrN3XtsHwgLh9HondA84WGaBZNNOKYOMeBConqTYPXdzAIS2bBmnMi//y/R1675FbFAgA==
X-Received: by 2002:a62:8006:0:b029:196:33f2:4dd7 with SMTP id j6-20020a6280060000b029019633f24dd7mr1531610pfd.38.1606171700104;
        Mon, 23 Nov 2020 14:48:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id s26sm11837996pgv.93.2020.11.23.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:48:19 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:48:14 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 7/7] maintenance: use 'git config --fixed-value'
Message-ID: <20201123224814.GG499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:07PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> When a repository's leading directories contain regex glob characters,
Minor "well, actually" - I'm not sure 'glob' is the right word to use
here.

> the config calls for 'git maintenance register' and 'git maintenance
> unregister' are not careful enough. Use the new --fixed-value option
> to direct the config machinery to use exact string matches. This is a
> more robust option than excaping these arguments in a piecemeal fashion.
Typo on 'escaping'.

> 
> For the test, require that we are not running on Windows since the '+'
> character is not allowed on that filesystem.
> 
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Reported-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/gc.c           |  5 +++--
>  t/t7900-maintenance.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e3098ef6a1..6dde3ce1bb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1452,7 +1452,8 @@ static int maintenance_register(void)
>  		git_config_set("maintenance.strategy", "incremental");
>  
>  	config_get.git_cmd = 1;
> -	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
> +	strvec_pushl(&config_get.args, "config", "--global", "--get",
> +		     "--fixed-value", "maintenance.repo",
>  		     the_repository->worktree ? the_repository->worktree
>  					      : the_repository->gitdir,
>  			 NULL);
> @@ -1483,7 +1484,7 @@ static int maintenance_unregister(void)
>  
>  	config_unset.git_cmd = 1;
>  	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> -		     "maintenance.repo",
> +		     "--fixed-value", "maintenance.repo",
>  		     the_repository->worktree ? the_repository->worktree
>  					      : the_repository->gitdir,
>  		     NULL);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 20184e96e1..c4e5564c31 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -367,6 +367,18 @@ test_expect_success 'register and unregister' '
>  	test_cmp before actual
>  '
>  
> +test_expect_success !MINGW 'register and unregister with glob characters' '
> +	GLOB="a+b*c" &&
> +	git init "$GLOB" &&
> +	git -C "$GLOB" maintenance register &&
> +	git config --get-all --show-origin maintenance.repo &&
Hm, what's the reason for --show-origin when the output isn't captured
or checked? Is this leftover?

> +	git config --get-all --global --fixed-value \
> +		maintenance.repo "$(pwd)/$GLOB" &&
> +	git -C "$GLOB" maintenance unregister &&
> +	test_must_fail git config --get-all --global --fixed-value \
> +		maintenance.repo "$(pwd)/$GLOB"
> +'
> +
>  test_expect_success 'start from empty cron table' '
>  	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
>  

And after all that buildup, this patch is a very straightforward test
fix: explain the problem, add the arg in question, add a regression
test. Thanks.

Other than the one extraneous(?) line,
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
