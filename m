Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CDC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 02:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE3A64F80
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 02:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhCJCWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 21:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhCJCWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 21:22:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8DC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 18:22:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dx17so34285279ejb.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 18:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a8f/w3stqx8Ten41YyXrBgKlKXkXlTy4wxYZ6Qm1u2A=;
        b=PhrMbxQq8Odzz+yILvSpStyvIjyZ1UqdFrbE4SgEn3SOBtbd7bNCkWJfxamuDnuN8d
         pD5M+CiAJ8BD0lGxMb5WpUvHXNEiwoVnbGqyaFsioqFUv/mHglUsxsIvYp/II/HOIJti
         UWLigNyJxfPfPKJ4KN9sDBeraFwrTPPwKsI9/j8tLn4cutwxKJJ4xKZpLIQaN6/+gXle
         XoP0V206w1yONU+BRDd7nfxDGQNwW9ZtkmJa2n8m7SFewqp1DYSBqne8/6EeWzbY55tc
         hTJ0F4ENH/uCPOkSKGFTKH9xNR8Cg+tkLdj6nfPvWARDb4RicFUlM0aYXxD2uThtrsfM
         GQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=a8f/w3stqx8Ten41YyXrBgKlKXkXlTy4wxYZ6Qm1u2A=;
        b=uE5a8yDRMlLpqij8mvnIfSBrsulMi+C6hE086fki64NFLPJ1PI9rWUhUuFdwU1HOH9
         QPfqOK5twHgwCymSyYb2Gx5sMQ9+temPvkADj4DkZnV/vvP4qh0hxY6J3J3Rg3AY6LxM
         NtlFHXECwwBjyDyp2soFJXvW5JxFWyorUb1C1mDoee9mFehruzAaL2bqd2uyPKd+Dxo6
         h18CU2/6LMMVDtUhya1YhR0mW9BesZdb46YtQVlsURP43Bd4lZCc2DOzO+RYNEKm4bC5
         ItabGDYvIui7jcaUGKJkWCUgp+2sgf5CKQGZU3nF9YBjxQZhJFhsfiQTFzckO901SeGi
         iaWA==
X-Gm-Message-State: AOAM5310hc1GwpDY5NKEsbqmu0WZb94FqjTt+B4Z5cwndPRvdCjdsn7J
        qN8kju+bvgUZ3F6Jt6N8jPqQmrTEMDjdAw==
X-Google-Smtp-Source: ABdhPJyLgQUsa1PJCq0uCu12Y8TPOT0BF6p4aMi1b0gYe1NS6/Jzq7D7qimXt5PBF0hY7pG1OgSFWQ==
X-Received: by 2002:a17:906:5012:: with SMTP id s18mr1061904ejj.100.1615342930014;
        Tue, 09 Mar 2021 18:22:10 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x21sm9851921eds.53.2021.03.09.18.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:22:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] test-lib: remove test_external
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-2-avarab@gmail.com>
 <xmqqsg53yg28.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqsg53yg28.fsf@gitster.c.googlers.com>
Date:   Wed, 10 Mar 2021 03:22:09 +0100
Message-ID: <878s6viw8e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Remove the test_external function(s) in favor of running the Perl
>> tests with a test_expect_success.
>> ...
>> My motivation for this is to eliminate a special case where things
>> that aren't test-lib.sh are going to produce TAP, for reasons that'll
>> be clear in subsequent commits.
>
> Puzzled.
>
>>  .../netrc/t-git-credential-netrc.sh           |  7 +-
>>  t/README                                      | 26 ------
>>  t/t0202-gettext-perl.sh                       | 10 +--
>>  t/t9700-perl-git.sh                           | 10 +--
>>  t/test-lib-functions.sh                       | 89 +------------------
>>  t/test-lib.sh                                 | 42 ++++-----
>>  6 files changed, 28 insertions(+), 156 deletions(-)
>
> Reducing the number of lines is always good, but is this essentially
> losing what the commit that added test_external wanted to add?

Yes, I don't think streaming TAP from external sources is a problem
worth solving in the first place.

>> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contri=
b/credential/netrc/t-git-credential-netrc.sh
>> index 07227d02287..28118a9e194 100755
>> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
>> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
>> @@ -20,13 +20,10 @@
>>  		'set up test repository' \
>>  		'git config --add gpg.program test.git-config-gpg'
>>=20=20
>> -	# The external test will outputs its own plan
>> -	test_external_has_tap=3D1
>> -
>>  	export PERL5LIB=3D"$GITPERLLIB"
>> -	test_external \
>> -		'git-credential-netrc' \
>> +	test_expect_success 'git-credential-netrc' '
>>  		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
>> +	'
>>=20=20
>>  	test_done
>>  )
>
> This is valid because we expect nobody runs this under tap?

No, because at this point we suppress the --verbose output under
HARNESS_ACTIVE (but see 6/7 later), and under non-verbose we now emit:
=20=20=20=20
    ./t9700-perl-git.sh=20
    ok 1 - set up test repository
    ok 2 - use t9700/test.pl to test Git.pm
    # passed all 2 test(s)
    1..2

So that the stdout from t9700/test.pl doesn't screw up the test output
anymore.

>> diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
>> index a29d166e007..06a93b36790 100755
>> --- a/t/t0202-gettext-perl.sh
>> +++ b/t/t0202-gettext-perl.sh
>> @@ -17,11 +17,9 @@ perl -MTest::More -e 0 2>/dev/null || {
>>  	test_done
>>  }
>>=20=20
>> -# The external test will outputs its own plan
>> -test_external_has_tap=3D1
>> -
>> -test_external_without_stderr \
>> -    'Perl Git::I18N API' \
>> -    perl "$TEST_DIRECTORY"/t0202/test.pl
>> +test_expect_success 'run t0202/test.pl to test Git::I18N.pm' '
>> +	perl "$TEST_DIRECTORY"/t0202/test.pl 2>stderr &&
>> +	test_must_be_empty stderr
>> +'
>
> So t0202/test.pl would still produce output that would confuse
> whoever is reading our output as TAP, and it is OK?  If the
> redirection discards its standard output to /dev/null [*], I would
> sort-of understand how this may work (we would have let the perl
> script to emit 13 "ok" or "not ok" to our output, but now we discard
> that and write just one our own "ok" or "not ok", depending on what
> comes out to the standard error stream (e.g. "# Looks like you
> failed...").
>
> But that is not what is going on.  We'll let these 13 "ok" or "not ok"
> come out from the perl script and then add another on our own.

Yes, but just like we don't have stdout from any other program appear
directly in the output of ./tXXXX*.sh the TAP doesn't get to our stderr
either, i.e. our whole juggling around with FDs 1-4.

>> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
>> index 102c133112c..574c57b17f1 100755
>> --- a/t/t9700-perl-git.sh
>> +++ b/t/t9700-perl-git.sh
>> @@ -50,11 +50,9 @@ test_expect_success \
>   >       git config --add test.pathmulti bar
>>       '
>>=20=20
>> -# The external test will outputs its own plan
>> -test_external_has_tap=3D1
>> -
>> -test_external_without_stderr \
>> -    'Perl API' \
>> -    perl "$TEST_DIRECTORY"/t9700/test.pl
>> +test_expect_success 'use t9700/test.pl to test Git.pm' '
>> +	perl "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
>> +	test_must_be_empty stderr
>> +'
>
> Ditto.  It seems that we are still letting the script, i.e. one of
> the "things that aren't test-lib.sh" to produce TAP anyway.
>
>
> [Footnote]
>
> * If we are truly somehow discarding these output that would be TAP
> (13 tests in 0202 and uncounted in 9700) from being shown (by e.g.
> redirecting output to /dev/null), it would be a regression for those
> who debug breakage found by these tests.  They used to be told which
> one failed and how but now they don't.  So I do not think that is a
> useful way to go, either.

You still get the full TAP output under --verbose for debugging, we just
don't consume it as TAP anymore by "prove" etc, i.e. once we get to 6/7:
=20=20=20=20
    $ GIT_TEST_TEE_STARTED=3Dtrue HARNESS_ACTIVE=3Dt ./t9700-perl-git.sh --=
verbose --tee
    [...]
    ok 1 - set up test repository
=20=20=20=20
    ## expecting success of 9700.2 'use t9700/test.pl to test Git.pm':=20
            perl "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
            test_must_be_empty stderr
=20=20=20=20
    \ok 2 - use Git;
    \ok 3 - open repository
    \ok 4 - config scalar: string
    \ok 5 - config array: string
    \ok 6 - config scalar: nonexistent
    \ok 7 - config array: nonexistent
    [...]
    \ok 44 - cat_blob(outside): size
    \ok 45 - unquote unquoted path
    \ok 46 - unquote simple quoted path
    \ok 47 - unquote escape sequences
    \1..47
=20=20=20=20
    ok 2 - use t9700/test.pl to test Git.pm
=20=20=20=20
    # passed all 2 test(s)
    1..2

Notice how it's escaped now.

So yes, we don't get the benefit of having e.g. prove/CI say that our
6th test failed anymore in this case.

I think that's a very small price to pay for the benefit of not having
to monkeypatch Perl's TAP emitting in this case to do the back & forth
munging to safe the TAP output I'm doing in 6/7, and only need to do in
one place because I'd gotten rid of this special-case earlier.
