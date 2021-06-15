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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95670C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD046109D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFOTWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOTWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:22:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96021C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:20:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k7so24322393ejv.12
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VoF7I2jCH97mjit6IQe7890qNIcZt4rTxVhQLWVrCLM=;
        b=oxxQgmyH//g0DBL+bH13boXnbLH4v2RzhpsmeDNqjnxBdQ9szyWIWZxawDiwLXGzzw
         ykhpYCKS9DkP2heAOOi9Har+CVMztamjuCB3q1qlmUuKTrwtuypJj8yK4M1Iik5v/Ttn
         xNXj+3pr4uN1Ed1dJ3jagfH4PBV+sejrF5DCehXs4J9UprIRwAc2Ds8xzftgZKdpTp7y
         0byc8t71EUpJ5rwPnLITD9JIQWbpp1yDZu8dih+QFI13RncSqG7+xlSJSt8vcl+JJae2
         TjRHbXWAii80QZwqjLWuWXUtDTIh18RZcCu/zNNk4LDH5vstXyRazXSkv733dRyDwH1l
         wyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VoF7I2jCH97mjit6IQe7890qNIcZt4rTxVhQLWVrCLM=;
        b=a91V/zeDtITXhlj9a+XLePNqqllLBxSgrMZQiKH6ZCy2FObDXoxxPfwfxa2fTaM854
         wdJ5RzdgcfSPK815qhTa1iZS81W5h3lf4ouqJiLq/atC47RjlCvZA3lIGVdJVX9TSgtC
         d5Fj9S5lyTaOAHdWRHPGLuCkMAx+/C12rQmSslXeVh2lrf81WIfJCaR5CRyOjR5IHaOC
         58bsZvTVLArPn9LdHVuj4bMOSU1/NH4opeGsYSx/O8oLESQYKkmzmeR/xL7Y1nhNR5Ao
         /FiBYmefEkEfkx5TF/Drk5dJO6uGMWpuO/fdbaqC5BjJ3ts3aHq25WO1pOGuot7HkYOQ
         MbgA==
X-Gm-Message-State: AOAM533WDMn1iMGbgKLH0Zh8nOztlllf/NJI7TsRIxH4aWStpH42SaoP
        9HC7TEUmTsGVIlBFhA2571aLhoATa8k+jg==
X-Google-Smtp-Source: ABdhPJx4KaJtuS5QqMzBzCSLuQVILmug110MsQPZ8kh9WGqzus3GJoJgcwPCt8vEPcuLVoDM8KTr1Q==
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr1238543ejb.218.1623784843919;
        Tue, 15 Jun 2021 12:20:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m17sm1853669ejg.96.2021.06.15.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:20:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Tue, 15 Jun 2021 21:16:34 +0200
References: <20210615183157.104999-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210615183157.104999-1-felipe.contreras@gmail.com>
Message-ID: <87y2bbx7cq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Felipe Contreras wrote:

> The test_atexit unit test relies on the specific location of the
> generated files.
>
> When TEST_OUTPUT_DIRECTORY is unset, _run_sub_test_lib_test_common sets
> it to pwd, which is two levels under the pwd of the parent unit test,
> and the parent can find the generated files just fine.
>
> But when TEST_OUTPUT_DIRECTORY is set, it's stored in GIT-BUILD-OPTIONS,
> and even though _run_sub_test_lib_test_common correctly overrides it,
> when the child script is run it sources GIT-BUILD-OPTIONS and
> TEST_OUTPUT_DIRECTORY is overridden.
>
> Effectively both the parent and child scripts output to the same
> directory.
>
>   make TEST_OUTPUT_DIRECTORY=/tmp/foobar GIT-BUILD-OPTIONS &&
>   make -C t t0000-basic.sh
>
> We could try to specify --root, as 6883047071 (t0000: set
> TEST_OUTPUT_DIRECTORY for sub-tests, 2013-12-28) suggested, but then the
> results of subtests would leak out because TEST_RESULTS_DIR would not
> be changed from the parent.
>
> Instead, let's revert part of 2d14e13c56 (test output: respect
> $TEST_OUTPUT_DIRECTORY, 2013-04-29) by removing TEST_OUTPUT_DIRECTORY
> from GIT-BUILD-OPTIONS.
>
> It's unclear how much value t/valgrind/analyze.sh provides today, but
> users of that script that use TEST_OUTPUT_DIRECTORY as well can simply
> call the script with that variable in the environment.

I've only skimmed this & the patch, but this approach sounds good to me.

> It doesn't make much sense to break t0000-basic.sh for users of
> TEST_OUTPUT_DIRECTORY, just to provide a little convenience for the
> users of t/valgrind/analyze.sh.

I would also think that if anyone really cares about this
valgrind/analyze.sh script the thing to do is to make a Makefile target
for it, similar to the aggregate target(s).

We could then make that target go through some light wrapper in
test-lib.sh so it would e.g. pick up GIT_TEST_OPTS (which can have
--root=*), and otherwise find things in the same location that
test-lib.sh put them / thinks the are in.

> Presumably this was broken since 900721e15c (test-lib: introduce
> 'test_atexit', 2019-03-13).
>
> Cc: John Keeping <john@keeping.me.uk>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> Since v1 I completely changed the approach and instead of using --root
> which leaks test results, I remove TEST_OUTPUT_DIRECTORY from
> GIT-BUILD-OPTIONS.
>
> Apparently only people who would care are the users of
> t/valgrind/analyze.sh which now would need to specify that variable
> themselves.
>
> Marginal convenience for the users of an obscure script is not a good
> reason to break t0000-basic.sh.
>
> Range-diff against v1:
> 1:  04047359b9 < -:  ---------- test: fix for TEST_OUTPUT_DIRECTORY
> -:  ---------- > 1:  d8430aee08 test: fix for TEST_OUTPUT_DIRECTORY
>
>  Makefile              | 3 ---
>  t/valgrind/analyze.sh | 3 ---
>  2 files changed, 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..2e25489569 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2790,9 +2790,6 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>  	@echo X=\'$(X)\' >>$@+
> -ifdef TEST_OUTPUT_DIRECTORY
> -	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> -endif
>  ifdef GIT_TEST_OPTS
>  	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@+
>  endif
> diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
> index 2ffc80f721..378d0a8daa 100755
> --- a/t/valgrind/analyze.sh
> +++ b/t/valgrind/analyze.sh
> @@ -1,8 +1,5 @@
>  #!/bin/sh
>  
> -# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
> -. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
> -# ... otherwise set it to the default value.
>  : ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
>  
>  output=

