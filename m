Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C6C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 02:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8AC64F4B
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhCJCfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 21:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhCJCfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 21:35:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49FC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 18:35:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id dm26so24898675edb.12
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 18:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7jVQ0fD6sOSSNIRArYiYjHEsgvvCDEUcSjF0TH2AI1E=;
        b=dLknXe6Zv22y2qrMOKvRVSMIDMT08/zpdYKtHxwVNd2pSO8G/5O3mTw7JKEnVDNYmO
         RGtxS937e5dMimBd48tk24gpCC5Gcs4U9DqRzLTMC6rZ2BYVljFLWXQWpZ/p/bJ7+c/l
         7YnPcJu6+RwSF5w/KHKNDfWNsQLRSx5aaSo8FHKPHsQHPCRiCF3dX8Ua++XfR7cY52R2
         0euBE9M13wrWk2CMIvp6IJm9ByU3+cxFq9sycCqMYSd+liFu/yra/k5zNjCxdoeeUOpJ
         VzDVqDtGXhC34/P4N5XOucCY01D4RdCGnAqirWBXuMEV32B5MDqD0C4rtG/sT1wPvvTj
         5gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7jVQ0fD6sOSSNIRArYiYjHEsgvvCDEUcSjF0TH2AI1E=;
        b=XyRm66oikDA6qI648/WxtCS8NWHuzwkv2/aqkjJEEZKVGhwOtcQLxAATxbqTUPGvZy
         +LToeoiDCF7ouTUn0MZVEaN7aMG6rMx17WDh4EiD79o7MPVyfz/ZHPa+C8KjO6nTNSIy
         7apmHDABW57lY5CA5aqS0JRDTW/thYm2pPJb+6srTj+sV6KN8qKfec8o3esspfxuDxXY
         g0pBXcd42iBPOCzL0jgw61dD5IHVDDdQGjmN81yO8AbR+4aIofXA+8BulfWvOMeafUc9
         5hFVEJNdvQV7boL30hznslbSHdTlJznHZ3j4VsHUlqiSV19bPU2EBSPoN0T/13aNK34m
         8vwA==
X-Gm-Message-State: AOAM533TTIDjCQjvxyXvjA4TI1/liRanVKXaCI7+eOotY+txANp9MjC0
        aR5L8XvjDvvDAq13NeI6ZUw=
X-Google-Smtp-Source: ABdhPJz6yG1L5z/JtNHK76KZ1vJ3f39RsJcoNFeBY+uLzQcI4Nxtm5McI/fzuIVH/55t2dKvR5w4cg==
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr666354edr.213.1615343741843;
        Tue, 09 Mar 2021 18:35:41 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id da17sm9862656edb.83.2021.03.09.18.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:35:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
 <20210309185911.GF3590451@szeder.dev> <87k0qghwps.fsf@evledraar.gmail.com>
 <20210309213117.GB1016223@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210309213117.GB1016223@szeder.dev>
Date:   Wed, 10 Mar 2021 03:35:40 +0100
Message-ID: <875z1zivlv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 09, 2021 at 09:57:03PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> diff --git a/t/README b/t/README
>> >> index 2cc8cbc7185..f09d94e754e 100644
>> >> --- a/t/README
>> >> +++ b/t/README
>> >> @@ -157,10 +157,13 @@ appropriately before running "make". Short opti=
ons can be bundled, i.e.
>> >>=20=20
>> >>  -V::
>> >>  --verbose-log::
>> >> -	Write verbose output to the same logfile as `--tee`, but do
>> >> -	_not_ write it to stdout. Unlike `--tee --verbose`, this option
>> >> +	An alias for `--verbose --tee`. This option
>> >>  	is safe to use when stdout is being consumed by a TAP parser
>> >> -	like `prove`. Implies `--tee` and `--verbose`.
>> >> +	like `prove`.
>> >> +	Historically this option was different from `--verbose --tee`
>> >> +	and would not write any verbose output to stdout to ensure the
>> >> +	TAP-correctness of the output. The TAP-correctness of the
>> >> +	output is now sanity checked by the test library,
>> >
>> > Not everyone is using a TAP harness to run the tests, and, therefore,
>> > '--verbose-log' should not spew out verbose output to the terminal.
>>=20
>> IOW even though --verbose-log was meant as a hack to make prove happy,
>> you've since come to like the "verbose in log, but not stdout" mode and
>> want that kept?
>
> Yes, '--verbose-log' proved to be really convenient, even if it was
> meant to solve a different issue.

Sure, let's keep it then.

>> Yes, this patch takes that mode away.
>>=20
>> Yes, I can change it.
>>=20
>> Would your use-case for this be satisfied by having prove(1) just emit
>> different output for you in this scenario, so you'd need to invoke this
>> as something like:
>>=20
>>     prove <test> :: --verbose --tee # or --verbose-log
>
> I use prove to run the test suite, but I don't and won't use prove to
> run a single test.
>
> The behavior of './t1234-foo.sh -V' with or without '-x' should not
> change without _very_ convincing reasons.

I think I can make it the same, except for emulating the sheared write
issue 452320f1f5 mentions. I.e. moving to this method inherently
requires us to squash together stdout/stderr into one, which isn't what
we're doing now.

> "We now output valid TAP even with --verbose, so we don't need it for
> the TAP harness" is definitely not convincing.

It's more like "we produce one machine-readable output format, so if you
need junit, or an abbreviated format (--verbose-log) or a nyancat
progress bar or whatever, it makes more sense to pipe it to another
process that'll munge that for you... :)

>> Becuse the advantage of this series is that that sort of thing becomes
>> really trivial without everything needing to be hardcoded in
>> test-lib.sh, observe (this is with my series):
>>=20
>>=20=20=20=20=20
>>     0 $ PERL5LIB=3D. prove -v --formatter=3DSZEDERVerboseLog ./t0201-get=
text-fallbacks.sh :: --verbose-log
>
> Well, this doesn't look trivial at all, does it?  In fact, I consider
> this unusably convoluted.

... I meant to say something closer to "does that output look
ok?". Obviously we'd then make the --verbose-log run something like that
under the hood.

But in any case, I found it easier to just add this feature to my "tee"
program than doing it with Perl's TAP libraries, i.e. something like
this on top (will integrate it in an eventual re-roll):

    diff --git a/t/helper/test-tee.c b/t/helper/test-tee.c
    index 4ed34e9db9..063b9277e0 100644
    --- a/t/helper/test-tee.c
    +++ b/t/helper/test-tee.c
    @@ -29,2 +29,3 @@ int cmd__tee(int argc, const char **argv)
     {
    +       int only_tap_on_stdout =3D 0;
            int tap =3D 0;
    @@ -38,2 +39,4 @@ int cmd__tee(int argc, const char **argv)
            struct option options[] =3D {
    +               OPT_BOOL(0, "only-tap-on-stdout", &only_tap_on_stdout,
    +                        "only emit TAP on stdout, not 'unknown' etc."),
                    OPT_BOOL(0, "escape-stdout", &escape_stdout,
    @@ -75,3 +78,7 @@ int cmd__tee(int argc, const char **argv)
=20=20=20=20=20
    -               fprintf(stdout, "%s\n", line.buf + offs);
    +               if (!only_tap_on_stdout)
    +                       fprintf(stdout, "%s\n", line.buf + offs);
    +               else if (offs)
    +                       fprintf(stdout, "%s\n", line.buf + offs);
    +
                    if (logfp)
    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index 479ad4fb38..731ecc36bb 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -153,2 +153,3 @@ parse_option () {
                    verbose=3Dt
    +               verbose_log=3Dt
                    tee=3Dt
    @@ -371,2 +372,3 @@ then
                    --escape-stdout ${HARNESS_ACTIVE+--escape-file} \
    +               ${verbose_log+--only-tap-on-stdout} \
                    "$GIT_TEST_TEE_OUTPUT_FILE"


>>     # lib-gettext: No is_IS UTF-8 locale available
>>     # lib-gettext: No is_IS ISO-8859-1 locale available
>>     ok 1 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to fallthroug=
h)
>>     ok 2 - sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is set
>>     ok 3 - sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough
>>     ok 4 - gettext: our gettext() fallback has pass-through semantics
>>     ok 5 - eval_gettext: our eval_gettext() fallback has pass-through se=
mantics
>>     ok 6 - eval_gettext: our eval_gettext() fallback can interpolate var=
iables
>>     ok 7 - eval_gettext: our eval_gettext() fallback can interpolate var=
iables with spaces
>>     ok 8 - eval_gettext: our eval_gettext() fallback can interpolate var=
iables with spaces and quotes
>>     # passed all 8 test(s)
>>     1..8
>>     ok
>>     All tests successful.
>>     Files=3D1, Tests=3D8,  1 wallclock secs ( 0.01 usr  0.01 sys +  0.07=
 cusr  0.01 csys =3D  0.10 CPU)
>>     Result: PASS
>>     $ wc -l test-results/t0201-gettext-fallbacks.out=20
>>     75 test-results/t0201-gettext-fallbacks.out
>>=20
>> All without any patching on top to the test-lib.sh, just:
>>=20=20=20=20=20
>>     $ cat SZEDERVerboseLog.pm=20
>>     package SZEDERVerboseLog::Session;
>>     use base 'TAP::Formatter::Console::Session';
>>=20=20=20=20=20
>>     sub result {
>>         my ($self, $result) =3D @_;
>>         return if $result->is_unknown;
>>         return $self->SUPER::result($result);
>>     }
>>=20=20=20=20=20
>>     package SZEDERVerboseLog;
>>     use strict;
>>     use warnings;
>>     use base 'TAP::Formatter::Console';
>>=20=20=20=20=20
>>     sub open_test {
>>         my ($self, $test, $parser) =3D @_;
>>         my $session =3D SZEDERVerboseLog::Session->new( {
>>             name            =3D> $test,
>>             formatter       =3D> $self,
>>             parser          =3D> $parser,
>>         } );
>>         return $session;
>>     }
>>=20=20=20=20=20
>>     1;
>>=20
>> The "is_unknown" is everything that's not TAP syntax.
>>=20

