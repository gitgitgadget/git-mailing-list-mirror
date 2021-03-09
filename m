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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55745C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCB6522E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhCIU5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhCIU5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:57:06 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F24C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:57:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h10so23168740edl.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vLWDUH7MhBs5V20jhZmyuAE++wegtOLCdL4fIcpT1/M=;
        b=bIN18QZZgZsJxX13TVORpwXwF2jUmHy91U/bSgJ5WLakDbkUOMYwXYfXnDw7WFF4f+
         wa0BJKyAd+b+jCzcWT7XEsqaPBc2p+OPIkiGXHZ66ZNoujjrtIzf/JhSrrqPHmwm39zR
         hBNFEA6j7+MoPCridLa6XjOANNVLCHP91kXrmJpxwNadoamF4bhAsXgeK2pd5I2o4cSB
         GhGJPCCW1xcD1EmXORkn31FOQH+6EY30GLh9B3MukDd4prOFXsFQOjvy9IdXbCI4tCli
         ONUTfI4+3tetOLQ3DqratsHJ9Lh/fXnh/H1VMOJz9VGM4c07Y4TlC4xN8lzEP/MN8Ckc
         84dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vLWDUH7MhBs5V20jhZmyuAE++wegtOLCdL4fIcpT1/M=;
        b=sqZ8wujfJBBavnvaGMTK3mSc+GBP0PhogdDXlDdOo1DTE9xjeu972bOQ1XxDoeRKrh
         E/Flf7NTCLdEdaapAwcBvEYtoKcwufc7Lu6nj91csG66aVc4gYN9iQXP92aIrtnJy8YM
         9FUJf2jFYMnT19klzzBifio4XNRgO4fDtQOeXG1wifraWVeMU9pFTqhVBTejzLGhi+di
         zjCMg8IgREHPl0MiNVuEEEeL+IeKEeNh3XU5NOUmTiZ3aueHZnRh0PsB9q9G8Z/fpKTM
         hitP1Ic/sKRzEkI18i4BUtYwo4hdNmIVhVUeF6zTDVFP2UbNcFRdBARKQQUgjiIKv39+
         z6YQ==
X-Gm-Message-State: AOAM531jjwR4yHz/t+aI75gEXm1UMaYDIBE6mdfazFPwciv4Vw8kGYX5
        RNMxu5IED6XeUB0D8M7ZcNU=
X-Google-Smtp-Source: ABdhPJwzRDensX/mElD3fHQmB6lYNb1ZJhA11zzVaJyATOppPyBJGwUb4UtPvXdfW/fs+z6DCJoztQ==
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr6375735edb.128.1615323424758;
        Tue, 09 Mar 2021 12:57:04 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b12sm9537945eds.94.2021.03.09.12.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:57:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
 <20210309185911.GF3590451@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210309185911.GF3590451@szeder.dev>
Date:   Tue, 09 Mar 2021 21:57:03 +0100
Message-ID: <87k0qghwps.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 09, 2021 at 05:02:18PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Make the --verbose output be valid TAP, making it machine-readable for
>> TAP parsers again.
>>=20
>> Both the verbose and non-verbose test outputs were valid TAP back when
>> I added support for TAP in 5099b99d25f (test-lib: Adjust output to be
>> valid TAP format, 2010-06-24).
>>=20
>> Sometime after that the --verbose output broke due to some tests
>> emitting their own lines starting "ok" (or otherwise invalidate the
>> TAP). That was noticed and fixed in 452320f1f5 (test-lib: add
>> --verbose-log option, 2016-10-21) and "fixed" by simply turning off
>> the verbose mode when we were running under TAP::Harness (e.g. under
>> "prove").
>>=20
>> That solution worked for running under Travis CI. After that fix it
>> was made to use the --verbose-log option in 041c72de109 (travis: use
>> --verbose-log test option, 2016-10-21), see 522354d70f4 (Add Travis CI
>> support, 2015-11-27) for the "cat t/test-results/*.out" code that was
>> aimed at.
>>=20
>> But that solution and others discussed in 452320f1f5 closed the door
>> on us having reliable machine-readable TAP output.
>>=20
>> Let's instead revert the work done in 452320f1f5 and, as well as the
>> follow-up commits 88c6e9d31c (test-lib: --valgrind should not override
>> --verbose-log, 2017-09-05) and f5ba2de6bc (test-lib: make "-x" work
>> with "--verbose-log", 2017-12-08), which were only needed to work
>> around bugs in the the previous --verbose-log implementation.
>>=20
>> Replace it with a simple method for ensuring that we have valid TAP
>> both on stdout, and in any verbose output we write. When we detect
>> that we're running under "prove" we prefix all legitimate TAP
>> directives with "GIT_TEST_TEE_STARTED":
>>=20
>>     $ GIT_TEST_TEE_STARTED=3D1 ./t5547-push-quarantine.sh
>>     GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
>>     GIT_TEST_TEE_STARTED ok 2 - accepted objects work
>>     [...]
>>     GIT_TEST_TEE_STARTED 1..6
>>=20
>> Then, instead of piping the output to "tee -a" we pipe it to a helper
>> which first converts "ok" and other TAP syntax to e.g. "\ok", and then
>> strips that "GIT_TEST_TEE_STARTED " prefix from the start of the line.
>>=20
>> The end result is that we're guaranteed to have valid TAP syntax on
>> stdout.
>>=20
>> We can thus get rid of the --verbose-log special-case. Since that
>> option was meant to get around the TAP issue let's simply make it an
>> alias for "--verbose --tee".
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

[Relpying to both replies in this sub-thread]

> After applying this patch series there is still one place where we
> look at $verbose_log:
>
>   $ git grep -C4 verbose_log -- test-lib.sh
>   test-lib.sh-
>   test-lib.sh-exec 5>&1
>   test-lib.sh-exec 6<&0
>   test-lib.sh-exec 7>&2
>   test-lib.sh:if test "$verbose_log" =3D "t"
>   test-lib.sh-then
>   test-lib.sh-    exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
>   test-lib.sh-elif test "$verbose" =3D "t"
>   test-lib.sh-then

Yes, well spotted. The way this patch is implemented that exec branch
should have been deleted. I just missed it.

[From your <20210309191230.GG3590451@szeder.dev>]:

>> diff --git a/t/README b/t/README
>> index 2cc8cbc7185..f09d94e754e 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -157,10 +157,13 @@ appropriately before running "make". Short options=
 can be bundled, i.e.
>>=20=20
>>  -V::
>>  --verbose-log::
>> -	Write verbose output to the same logfile as `--tee`, but do
>> -	_not_ write it to stdout. Unlike `--tee --verbose`, this option
>> +	An alias for `--verbose --tee`. This option
>>  	is safe to use when stdout is being consumed by a TAP parser
>> -	like `prove`. Implies `--tee` and `--verbose`.
>> +	like `prove`.
>> +	Historically this option was different from `--verbose --tee`
>> +	and would not write any verbose output to stdout to ensure the
>> +	TAP-correctness of the output. The TAP-correctness of the
>> +	output is now sanity checked by the test library,
>
> Not everyone is using a TAP harness to run the tests, and, therefore,
> '--verbose-log' should not spew out verbose output to the terminal.

IOW even though --verbose-log was meant as a hack to make prove happy,
you've since come to like the "verbose in log, but not stdout" mode and
want that kept?

Yes, this patch takes that mode away.

Yes, I can change it.

Would your use-case for this be satisfied by having prove(1) just emit
different output for you in this scenario, so you'd need to invoke this
as something like:

    prove <test> :: --verbose --tee # or --verbose-log

Becuse the advantage of this series is that that sort of thing becomes
really trivial without everything needing to be hardcoded in
test-lib.sh, observe (this is with my series):

=20=20=20=20
    0 $ PERL5LIB=3D. prove -v --formatter=3DSZEDERVerboseLog ./t0201-gettex=
t-fallbacks.sh :: --verbose-log
    # lib-gettext: No is_IS UTF-8 locale available
    # lib-gettext: No is_IS ISO-8859-1 locale available
    ok 1 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to fallthrough)
    ok 2 - sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is set
    ok 3 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough
    ok 4 - gettext: our gettext() fallback has pass-through semantics
    ok 5 - eval_gettext: our eval_gettext() fallback has pass-through seman=
tics
    ok 6 - eval_gettext: our eval_gettext() fallback can interpolate variab=
les
    ok 7 - eval_gettext: our eval_gettext() fallback can interpolate variab=
les with spaces
    ok 8 - eval_gettext: our eval_gettext() fallback can interpolate variab=
les with spaces and quotes
    # passed all 8 test(s)
    1..8
    ok
    All tests successful.
    Files=3D1, Tests=3D8,  1 wallclock secs ( 0.01 usr  0.01 sys +  0.07 cu=
sr  0.01 csys =3D  0.10 CPU)
    Result: PASS
    $ wc -l test-results/t0201-gettext-fallbacks.out=20
    75 test-results/t0201-gettext-fallbacks.out

All without any patching on top to the test-lib.sh, just:
=20=20=20=20
    $ cat SZEDERVerboseLog.pm=20
    package SZEDERVerboseLog::Session;
    use base 'TAP::Formatter::Console::Session';
=20=20=20=20
    sub result {
        my ($self, $result) =3D @_;
        return if $result->is_unknown;
        return $self->SUPER::result($result);
    }
=20=20=20=20
    package SZEDERVerboseLog;
    use strict;
    use warnings;
    use base 'TAP::Formatter::Console';
=20=20=20=20
    sub open_test {
        my ($self, $test, $parser) =3D @_;
        my $session =3D SZEDERVerboseLog::Session->new( {
            name            =3D> $test,
            formatter       =3D> $self,
            parser          =3D> $parser,
        } );
        return $session;
    }
=20=20=20=20
    1;

The "is_unknown" is everything that's not TAP syntax.

