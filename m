Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697FBC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA732075E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbhALIvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhALIvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:51:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E7C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:50:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t16so1582625wra.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JHKE1tocILIyPIZ9JqzIZk5yJN9Rt7J02t/xMjUpXEY=;
        b=qReUxWfpMoBk7rKyXGkfgwdZA3d3mWQ4dsMIGu7RZp2XvjBXUu7WysTLv+bj5DtPW/
         pGlVUHjbS1L0iV1I1CQ2ZMF1/v4yXjWJpLj9a6QbN1SXdVdxvXJz3tBYEg8UtM4NANJ7
         GGZ4maQ6OE7nU39qAF74/Zit8X45jFv8Q3Gj+rtMrvwwvA/MLW0VdCW2yF7Xt8QjMpHA
         4HJHtJecz5s3eUWV7qOzAR2yKb1zrLkQfno7BYexed3whoRf+NeAC/vrhIU5gMQbgRax
         oNUvgvDxBqhFSBicjaGbSQqXzCZF4qqAsV9QFmsgmMOCRFINEquX4Y80GvxyZYakF9Jr
         K7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JHKE1tocILIyPIZ9JqzIZk5yJN9Rt7J02t/xMjUpXEY=;
        b=AxfHBa+AKNndMRuK9wKyjN2DCu16zbA3GLeUwJwv1aJH260EWBwJ2IE0Zilv6MH4dM
         3LzAiRgTdJQwMRbmlNE2EcMI+igQEIjlq4gtFiRxqUiHQgBCVKa4DecEYguiaHErSvy0
         S6Jt6Wzvax9AxAGi5AInXzExwyYjEn4ZHjvq39zCjwFnzjRbt3areEU+gc1OkJ2klFiT
         8L0aTjia/7ROO1Gz6CQh5vz2pl76xIVUr6rvH3p6GDoGrWoirkV8r6iiqATpMnVXzjvR
         p+eIJAML2EAq3qTJm/C/apBgQRg8ehzu6r73qhEJR6UvDGtfZn7hcuW+OwBK+12nnp1n
         klSw==
X-Gm-Message-State: AOAM530AVAteTQEyr9D1XivAOEmHIeF5Dc0B+Yvjh7cXiCLQAAANK/kQ
        PP82kJbNfyf+sDzhvw3wRxA=
X-Google-Smtp-Source: ABdhPJyA7++rOfERE+ZiVIeDv4mQnIxpxYWuAu58/ckwiub5LVw4yUwktayr3pzTv6uwSkZveUZXnA==
X-Received: by 2002:adf:db51:: with SMTP id f17mr3153931wrj.83.1610441453438;
        Tue, 12 Jan 2021 00:50:53 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id n8sm3701573wrs.34.2021.01.12.00.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:50:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:50:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
Message-ID: <20210112085051.GV8396@szeder.dev>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111144740.6092-2-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 03:47:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> A subsequent commit will remove GETTEXT_POISON entirely, let's start
> by removing the CI jobs that enable the option.
> 
> We cannot just remove the job because the CI is implicitly depending
> on the "poison" job being a sort of "default" job.

I don't understand what you mean here with a "default job" that the CI
is implicitly depending on.  There is certainly no such default job on
Travis CI, and I don't think there is one on the GitHub thing.

> Let's instead add a
> "default" job.
> 
> This means we can remove the initial "make test" from the "linux-gcc"
> job (it does another one after setting a bunch of GIT_TEST_*
> variables).
> 
> I'm not doing that because it would conflict with the in-flight
> 334afbc76fb (tests: mark tests relying on the current default for
> `init.defaultBranch`, 2020-11-18) (currently on the "seen" branch, so
> the SHA-1 will almost definitely change). It's going to use that "make
> test" again for different reasons, so let's preserve it for now.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .github/workflows/main.yml | 2 +-
>  .travis.yml                | 2 +-
>  ci/install-dependencies.sh | 2 +-
>  ci/lib.sh                  | 3 +--
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index aef6643648..8b52df200f 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -286,7 +286,7 @@ jobs:
>            - jobname: osx-gcc
>              cc: gcc
>              pool: macos-latest
> -          - jobname: GETTEXT_POISON
> +          - jobname: linux-gcc-default
>              cc: gcc
>              pool: ubuntu-latest
>      env:
> diff --git a/.travis.yml b/.travis.yml
> index 05f3e3f8d7..908330a0a3 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -16,7 +16,7 @@ compiler:
>  
>  matrix:
>    include:
> -    - env: jobname=GETTEXT_POISON
> +    - env: jobname=linux-gcc-default
>        os: linux
>        compiler:
>        addons:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 0229a77f7d..79c0633a18 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -72,7 +72,7 @@ Documentation)
>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	sudo gem install --version 1.5.8 asciidoctor
>  	;;
> -linux-gcc-4.8|GETTEXT_POISON)
> +linux-gcc-default|linux-gcc-4.8)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
>  	;;
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 38c0eac351..d848c036c5 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -220,8 +220,7 @@ osx-clang|osx-gcc)
>  	# Travis CI OS X
>  	export GIT_SKIP_TESTS="t9810 t9816"
>  	;;
> -GETTEXT_POISON)
> -	export GIT_TEST_GETTEXT_POISON=true
> +linux-gcc-default)
>  	;;
>  Linux32)
>  	CC=gcc
> -- 
> 2.29.2.222.g5d2a92d10f8
> 
