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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85272C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E53664DE0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCITMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCITMe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 14:12:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1623C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 11:12:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w7so3347385wmb.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nU7AA/defsCE71J30pnNgqdJLthQXLEPLWTIK5dcUm4=;
        b=qDWbc7i/9ABNv1yKqR04uZMPjGGj1l+7nnBrBR/hcgDs6q+qdXoj2XX9roE/fpiw2u
         TuHseQzKW0q9haCQvdhtYPpEoGgEZdkbqbXO7UVsO/5Kg31T+WXaMhstiRBK8scf2lpo
         FL1cNA/eB3bpf3xmZaJVF+UJsWc2JDjqJMOaoxWm835rX30MJjHeEgpmk+tIQpn78OKz
         lq6YhAhYWS6mDLUUdCF/N4mwspkdPHdieUrQge2DPQhYg2ZrevCrv0c6KGYq0ixPzGt+
         1uR0YHEwfard67whOlG6gK/pv1QnOPhC9eRqFNe+lC9bZOND+BhbGeWkJGvmvKlES7sO
         bNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nU7AA/defsCE71J30pnNgqdJLthQXLEPLWTIK5dcUm4=;
        b=jzMskBRmmkjxXYbaRuKZeBTSn9aqO4upec9YwIw5Tx3MxquJkntVPxY2R9e/wEffPp
         oon1P/wSVe18qQDsWxQWiAni80QtCNFS6ZAeCKo2RFQjj8QdQ+kJK7AnNRiGv9UqLUy/
         W13EOGe8k4MyoY4RWyjfq+KsPaI+B2fX2IWG7AozWgehpLzwi/LgQd16bVcHGQ6TCVm5
         5DF1QE3lT7FUh0ltdpkq44bg9OH9LdibqE089fW+bvFA+YNj0H0pgiYyfPdmzhe7bH/d
         W7Y69lK3BugovnWsCL70YiwjLXNuNl1QI7CxJD4RA4+ZeEgG2lFmHUj0+axkaL9+oLNc
         dGrw==
X-Gm-Message-State: AOAM532TwrrUVQYFDWIjruN90/y1Oa3+TPRa5kSpZfQRIcGkmcgZHY4J
        Qnf9atIhWbNdShoLfVmAqms=
X-Google-Smtp-Source: ABdhPJx5pZfBqYIkqwn2SbNgclZlRBUHFiZh6oQ7vnRsWiLSNehubNhRNkOktHyX3lJpo+xemM3JXg==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr5564591wme.63.1615317152492;
        Tue, 09 Mar 2021 11:12:32 -0800 (PST)
Received: from szeder.dev (94-21-29-148.pool.digikabel.hu. [94.21.29.148])
        by smtp.gmail.com with ESMTPSA id h6sm5571292wmi.6.2021.03.09.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:12:32 -0800 (PST)
Date:   Tue, 9 Mar 2021 20:12:30 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
Message-ID: <20210309191230.GG3590451@szeder.dev>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309160219.13779-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 05:02:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Make the --verbose output be valid TAP, making it machine-readable for
> TAP parsers again.
> 
> Both the verbose and non-verbose test outputs were valid TAP back when
> I added support for TAP in 5099b99d25f (test-lib: Adjust output to be
> valid TAP format, 2010-06-24).
> 
> Sometime after that the --verbose output broke due to some tests
> emitting their own lines starting "ok" (or otherwise invalidate the
> TAP). That was noticed and fixed in 452320f1f5 (test-lib: add
> --verbose-log option, 2016-10-21) and "fixed" by simply turning off
> the verbose mode when we were running under TAP::Harness (e.g. under
> "prove").
> 
> That solution worked for running under Travis CI. After that fix it
> was made to use the --verbose-log option in 041c72de109 (travis: use
> --verbose-log test option, 2016-10-21), see 522354d70f4 (Add Travis CI
> support, 2015-11-27) for the "cat t/test-results/*.out" code that was
> aimed at.
> 
> But that solution and others discussed in 452320f1f5 closed the door
> on us having reliable machine-readable TAP output.
> 
> Let's instead revert the work done in 452320f1f5 and, as well as the
> follow-up commits 88c6e9d31c (test-lib: --valgrind should not override
> --verbose-log, 2017-09-05) and f5ba2de6bc (test-lib: make "-x" work
> with "--verbose-log", 2017-12-08), which were only needed to work
> around bugs in the the previous --verbose-log implementation.
> 
> Replace it with a simple method for ensuring that we have valid TAP
> both on stdout, and in any verbose output we write. When we detect
> that we're running under "prove" we prefix all legitimate TAP
> directives with "GIT_TEST_TEE_STARTED":
> 
>     $ GIT_TEST_TEE_STARTED=1 ./t5547-push-quarantine.sh
>     GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
>     GIT_TEST_TEE_STARTED ok 2 - accepted objects work
>     [...]
>     GIT_TEST_TEE_STARTED 1..6
> 
> Then, instead of piping the output to "tee -a" we pipe it to a helper
> which first converts "ok" and other TAP syntax to e.g. "\ok", and then
> strips that "GIT_TEST_TEE_STARTED " prefix from the start of the line.
> 
> The end result is that we're guaranteed to have valid TAP syntax on
> stdout.
> 
> We can thus get rid of the --verbose-log special-case. Since that
> option was meant to get around the TAP issue let's simply make it an
> alias for "--verbose --tee".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/README         |  9 ++++++---
>  t/t0000-basic.sh |  8 ++++++++
>  t/test-lib.sh    | 43 +++++++++++++++++++++----------------------
>  3 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/t/README b/t/README
> index 2cc8cbc7185..f09d94e754e 100644
> --- a/t/README
> +++ b/t/README
> @@ -157,10 +157,13 @@ appropriately before running "make". Short options can be bundled, i.e.
>  
>  -V::
>  --verbose-log::
> -	Write verbose output to the same logfile as `--tee`, but do
> -	_not_ write it to stdout. Unlike `--tee --verbose`, this option
> +	An alias for `--verbose --tee`. This option
>  	is safe to use when stdout is being consumed by a TAP parser
> -	like `prove`. Implies `--tee` and `--verbose`.
> +	like `prove`.
> +	Historically this option was different from `--verbose --tee`
> +	and would not write any verbose output to stdout to ensure the
> +	TAP-correctness of the output. The TAP-correctness of the
> +	output is now sanity checked by the test library,

Not everyone is using a TAP harness to run the tests, and, therefore,
'--verbose-log' should not spew out verbose output to the terminal.

