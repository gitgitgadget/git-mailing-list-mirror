Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C44C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F8A2071E
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M6O2/hHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgKWVjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:39:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50746 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKWVjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:39:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16F25937C8;
        Mon, 23 Nov 2020 16:39:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hjxY9ijlnG9nBetAS/Sh8ZmdvM4=; b=M6O2/h
        HRFz0SfPlKdwStPLJ0ZgMzTUvq0qAPr+vcFvCcGQ5WSrHFqjMgRjWM2zDrC0oJ34
        5w/ru7xVFX/Jb5JmP06c1NBUt5sXsBORc4Cinz7S9e+m0ibP+RUH15M34QXfogdT
        Kt01HFxXdUjM189BloIMu+Sxa+pd3F/B+mBKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AYTIE0CCxttklxXHtklsShPosg3EN7Nq
        ayXXI0vyuOGO2Q1M5BdyLjNbNLacEvdDrlnbeKBio0ucZv7sxrFXaaObx4qr087R
        PltP1K/itvltNCK/kKAewWbrjzoQxNkSWcgNFKSTIzN98NHbU5q++WirWfcYGpid
        0oXnPgCJ2HM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D76E937C7;
        Mon, 23 Nov 2020 16:39:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C9E3937C6;
        Mon, 23 Nov 2020 16:39:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 7/7] maintenance: use 'git config --fixed-value'
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 13:39:20 -0800
In-Reply-To: <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 23 Nov 2020
        16:05:07 +0000")
Message-ID: <xmqqo8jnn46v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5903EFB0-2DD4-11EB-9DBD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For the test, require that we are not running on Windows since the '+'
> character is not allowed on that filesystem.

Not a huge deal, but we do not have to rely on '+', though.  Using
"a*b*c" instead of "a+b*c" would perfectly be fine.  It would only
match "a*b*c" literally and not as ERE.


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
> +	git config --get-all --global --fixed-value \
> +		maintenance.repo "$(pwd)/$GLOB" &&
> +	git -C "$GLOB" maintenance unregister &&
> +	test_must_fail git config --get-all --global --fixed-value \
> +		maintenance.repo "$(pwd)/$GLOB"
> +'
> +
>  test_expect_success 'start from empty cron table' '
>  	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
