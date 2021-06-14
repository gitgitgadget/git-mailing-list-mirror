Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB00C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1C261246
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhFNRCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:02:48 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36424 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhFNRCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:02:47 -0400
Received: by mail-ej1-f42.google.com with SMTP id nd37so10070226ejc.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ffqo4UCdqVhx3wPNixLzw5SndvY6/XVxx+HULuZuu8M=;
        b=CU+EfQOAHm9vpJP5beQnqdhAU1tUbLzvLp5j2r+iZHRXkgM9oLKoFc9/I458EU9x00
         Vb51+CLanf1zye2GMN7eKp/BXRx3ZD/juC1Ae2fkZYZxnnqxkzenDShepCNIkpRusuWC
         y1ILHCvEthT1gsmfopK7DSDvDkuDgQbIHaiCo7Fv/kVQQrrIXVqdIVdqo4Ce3hRy2xWh
         lniYSRwWb5KnX7wmDwvDLW4y5Kje8uv9RqkYjsfHAhajAE5KOkIbUJ8TKwT3FsPZGofT
         YTADtT5295NhDkA+rJ1hmObhuN/n/jgDVDapImIKkBQavTOKHRKopKLKPhn07xYWEbWb
         jWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ffqo4UCdqVhx3wPNixLzw5SndvY6/XVxx+HULuZuu8M=;
        b=I8vm7tZUBcZ6WucjJVAolj4blBgw9uL8yoHLQxEENzawsyEW1/UgqqLmVCWWPG35DE
         Bz/I6qXsylX8RrOQvJwQNMweOZcMN13GPSaivloxSPqeiV0m38B90gr2uhdxEBlM97Vl
         1HfCiL16NL82QRcbbcy+NACP33xiyHn+L/Ra0Fa3sGnoFUV/HsEv26c+XF0uNAGlsUYP
         qkJ12YEdabOwFzxOnCtEcHNkm7YT0UTlgOM7t2OVzYOEu1z9MYwKP11n+q4eGd/0H5nT
         pOcY81tfgzYfzoPqUxpnBAjWu6ewhk8limK3JtWs4dlaAtcW0/dyZtXMRkQNP6E3t4oD
         FyPw==
X-Gm-Message-State: AOAM532IuKwQ8uY+F/8ehdRikLeelYLEq/kfFgkM3RyafyGvaeIqqvuq
        IU9mKeu7sK0pNL6pNr46LPY=
X-Google-Smtp-Source: ABdhPJzflsJWDOJuimLvpw2g1/aLykjNlBOQlnBXqs8r9frjSK2pXzcvxvIcsdzPMU5eRDvW+Wc7fA==
X-Received: by 2002:a17:906:1f90:: with SMTP id t16mr16198701ejr.297.1623689968888;
        Mon, 14 Jun 2021 09:59:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id oz11sm7828785ejb.16.2021.06.14.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:59:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel?= =?utf-8?Q?=C3=B3n?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Mon, 14 Jun 2021 18:55:03 +0200
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
 <8735tk22if.fsf@evledraar.gmail.com>
 <YMdm5XayUfp4/atY@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMdm5XayUfp4/atY@coredump.intra.peff.net>
Message-ID: <87r1h4z8k0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, Jeff King wrote:

> On Mon, Jun 14, 2021 at 11:33:12AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I think breaking the test suite is objectively worse than having a few
>> > extra files in the output directory, but to each his own.
>>=20
>> We've got both in-tree and out-tree things that rely on e.g. the
>> *.counts in that directory to have a 1=3D1 mapping with "real"
>> tests. E.g. "make aggregate-results".
>
> Indeed. With Felipe's original patch, the "test" target (but not
> "prove") in t/Makefile will report, whether you set
> TEST_OUTPUT_DIRECTORY or not:
>
>   failed test(s): t1234 t2345
>
>   fixed   0
>   success 23243
>   failed  2
>   broken  221
>   total   23647
>
> though curiously it doesn't exit non-zero back to make (usually we'd
> also see the failures from the individual make targets, and barf there).

Odd.

>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 2c6e34b9478..29bf67d49bf 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -76,6 +76,12 @@ _run_sub_test_lib_test_common () {
>>  		# this variable, so we need a stable setting under which to run
>>  		# the sub-test.
>>  		sane_unset HARNESS_ACTIVE &&
>> +
>> +		# These tests should emit no metrics or output that
>> +		# would normally go in the "test-results" directory.
>> +		TEST_NO_RESULTS_OUTPUT=3D1 &&
>> +		export TEST_NO_RESULTS_OUTPUT &&
>
> I'm OK with this general approach. I do think it would be nice if we let
> the environment supersede the on-disk GIT-BUILD-OPTIONS, which IMHO is
> the real root of the problem (and possibly others), but that may be more
> challenging to get right (I posted a patch earlier, but it does rely on
> stuffing all of "set" into a variable, which makes me concerned some
> less-able shells may complain).

Yeah I don't know and haven't dug into who wants all this combination of
GIT-BUILD-OPTIONS, passing things in the env, or passing things as
paramaters to make (sometimes under the same names).

> It also means that t0000 can't test the results output (since we don't
> write it), but I assume we don't do that now (I didn't actually try
> running with your patch).

Yeah, but only in the trivial wrapper function, you can still write the
test script and check the output yourself.

That's much easier on top of a series to move that into a lib-subtest.sh
that I submitted today:
https://lore.kernel.org/git/cover-0.8-00000000000-20210614T104351Z-avarab@g=
mail.com/

>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 54938c64279..9e9696a3185 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -252,8 +252,14 @@ TEST_STRESS_JOB_SFX=3D"${GIT_TEST_STRESS_JOB_NR:+.s=
tress-$GIT_TEST_STRESS_JOB_NR}"
>>  TEST_NAME=3D"$(basename "$0" .sh)"
>>  TEST_NUMBER=3D"${TEST_NAME%%-*}"
>>  TEST_NUMBER=3D"${TEST_NUMBER#t}"
>> -TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
>> -TEST_RESULTS_BASE=3D"$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
>> +if test -n "$TEST_NO_RESULTS_OUTPUT"
>> +then
>> +	TEST_RESULTS_DIR=3D/dev/null
>> +	TEST_RESULTS_BASE=3D/dev/null
>> +else
>> +	TEST_RESULTS_DIR=3D"$TEST_OUTPUT_DIRECTORY/test-results"
>> +	TEST_RESULTS_BASE=3D"$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
>> +fi
>
> I wondered about this use of /dev/null, since we'd generally use this as
> a directory, and writing to "/dev/null/foo" is going to throw an error.
>
> But...
>
>>  TRASH_DIRECTORY=3D"trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
>>  test -n "$root" && TRASH_DIRECTORY=3D"$root/$TRASH_DIRECTORY"
>>  case "$TRASH_DIRECTORY" in
>> @@ -1124,7 +1130,7 @@ test_done () {
>>=20=20
>>  	finalize_junit_xml
>>=20=20
>> -	if test -z "$HARNESS_ACTIVE"
>> +	if test -z "$HARNESS_ACTIVE$TEST_NO_RESULTS_OUTPUT"
>>  	then
>>  		mkdir -p "$TEST_RESULTS_DIR"
>
> ...here we would never look at those variables at all, so it is just a
> sentinel that would let us know the assumption has been violated.
>
> We do look at them elsewhere, though (in --tee as you noted, and I think
> for --stress). I'd prefer to notice the "no results" flag explicitly
> there and report something sensible, rather than getting:

If we edit every single current callsite instead of setting it to
something you can't write to then we're setting ourselves up for subtle
bugss when someone uses $TEST_RESULTS_DIR for something else.

>   mkdir: cannot create directory =E2=80=98/dev/null=E2=80=99: Not a direc=
tory
>
> or similar.

Yeah that error sucks, but nobody will see it unless they're hacking on
the guts of this $TEST_NO_RESULTS_OUTPUT, and I think it beats being fragil=
e.

In any case, I'll let Felipe decide what, if anything, to do with this
:)
