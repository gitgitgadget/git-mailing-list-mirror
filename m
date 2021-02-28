Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CDC433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEC964E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhB1Pwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 10:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhB1Pwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 10:52:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFFC06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 07:52:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mj10so3468713ejb.5
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qdinP52G+zmhgR5jGVoKz0aOf10p1TKrpX05FmDbNic=;
        b=G90HiWqaSozsLNdumJtrCspkjhzWaCYeNez6KVaTE1IfHpyobONNBji747RrDoZUWm
         866R29+yLfkD66whp2M70WBLsYSJ6/BSxMqq62IrFapzFcn8S9uImUoyNU8DfslUQ9n2
         vDIvPvRaz9yb45Ha30WZfbi6hB5kiZkWvst2G2GOMkAFv4ph+KLd+ROYA7jL+OiJMKp7
         dR1lJNT4TdlDWk6br+fRg7c6TUmfxIQgoBhJmynaY/RWj2npT8qZDjyuf/tt5EcaCW3e
         01Xi5LPa8X4vVWuXs4EjgWaGH/31iWu4yOidisAGZzv+Yr5y7vHlgKwqAYSfnljgPM6d
         bSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qdinP52G+zmhgR5jGVoKz0aOf10p1TKrpX05FmDbNic=;
        b=QiSMyv5oEKOexXuCjJp8jS0Cy+e6K0SQPjNBazYdnPv9yYp0eBTWeYiNeGBCZGklo+
         mHex7kKy16f4F9X2ofhTf//ST5Dibew7M0HWFUy7rfhr+ha5lTKOU1vpbkD9mq3+xsRv
         5Q/cTeu8nygLOgLHi8PVf7LvD7oeNyc36zOANPwsZ3TWExJO7hzT6BjEDtMhnclVkDEY
         3Vbu9X9AfAW9MdCmSvJzIYOtdTPkEGbCtjhYetzYD9EbwkinM8CMlmBm9lZbU8IwtcMW
         cEQVxUjscURxN1JRRa0eZSsGLMU2ZS/myUWfEg49I+7Bpaab50BZhHQB12lK4NDUP/Gx
         FlHA==
X-Gm-Message-State: AOAM5314IjAa7+IcZedGAVRxj0DaPLPsMeRcOk10QY58k0fCOZqZ2L3r
        UBXMClCiXMlrECDNbI9rA/g=
X-Google-Smtp-Source: ABdhPJz2ly8YKBKGEKFu8hTr+PLTN/nAYbIIpTPBLk2rxEjKomrqFohFDKX9gysqzYcMSOP3ZuKt3Q==
X-Received: by 2002:a17:906:4c8b:: with SMTP id q11mr12152523eju.270.1614527521001;
        Sun, 28 Feb 2021 07:52:01 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c17sm9612677edw.32.2021.02.28.07.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:52:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 20/35] userdiff tests: assert that new built-in
 drivers have tests
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-21-avarab@gmail.com>
 <377d555c-6bd0-4206-3f71-d4d51aaca692@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <377d555c-6bd0-4206-3f71-d4d51aaca692@kdbg.org>
Date:   Sun, 28 Feb 2021 16:51:59 +0100
Message-ID: <878s78kx5s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 28 2021, Johannes Sixt wrote:

> Am 24.02.21 um 20:51 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Add an assertion to the userdiff test framework to check that
>> everything except a narrow whitelist of existing built-in patterns has
>> tests.
>>=20
>> Since this test framework was added we've added new patterns without
>> any tests. Let's make it obvious in the future in the diff for such
>> patches that they should have those tests.
>>=20
>> For anything with tests we can skip the "does the pattern compile?"
>> test, as the actual tests will check that for us.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t4018-diff-funcname.sh | 30 +++++++++++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
>> index b80546b4d7f..a3058fda130 100755
>> --- a/t/t4018-diff-funcname.sh
>> +++ b/t/t4018-diff-funcname.sh
>> @@ -15,6 +15,19 @@ test_expect_success 'setup' '
>>  	sort <builtin-drivers >builtin-drivers.sorted &&
>>  	test_cmp builtin-drivers.sorted builtin-drivers &&
>>=20=20
>> +	# Do not add anything to this list. New built-in drivers should have
>> +	# tests
>> +	cat >drivers-no-tests <<-\EOF &&
>> +	ada
>> +	bibtex
>> +	csharp
>> +	html
>> +	objc
>> +	pascal
>> +	ruby
>> +	tex
>> +	EOF
>> +
>>  	# for regexp compilation tests
>>  	echo A >A.java &&
>>  	echo B >B.java
>> @@ -22,7 +35,12 @@ test_expect_success 'setup' '
>>=20=20
>>  for p in $(cat builtin-drivers)
>>  do
>> -	test_expect_success "builtin $p pattern compiles" '
>> +	P=3D$(echo $p | tr 'a-z' 'A-Z')
>> +	if grep -q $p drivers-no-tests
>> +	then
>> +		test_set_prereq NO_TEST_FOR_DRIVER_$P
>> +	fi
>> +	test_expect_success NO_TEST_FOR_DRIVER_$P "builtin $p pattern compiles=
" '
>>  		echo "*.java diff=3D$p" >.gitattributes &&
>>  		test_expect_code 1 git diff --no-index \
>>  			A.java B.java 2>msg &&
>
> Please drop this hunk. It is extremly distracting to see, e.g.,
>
> ok 8 # skip builtin cpp pattern compiles (missing NO_TEST_FOR_DRIVER_CPP)
> ok 9 - builtin cpp wordRegex pattern compiles
>
> It says "NO_TEST_FOR_DRIVER_CPP", but I know we have tests. I have to
> waste time to check that something not related to "we have tests for the
> driver" is meant here. It may be just a matter of naming the
> prerequisite, but I think we do not need this optimization.

Perhaps some other way to do this is better. I did the prerequisite just
to avoid indenting that whole part and I figured it was more readable,
but apparently not on the "more readable".

I do think it makes sense to keep this in some form, i.e. not test the
compilation if we know we have later tests to compile the regex. It's
providing self-documenting code to show that once we add tests for the
few missing drivers we can delete that test entirely.

And if a later change does the same check on the t4034/* files the
--word-diff check can also go.

>> @@ -119,11 +137,17 @@ test_diff_funcname () {
>>  	'
>>  }
>>=20=20
>> +>drivers-had-no-tests
>>  for what in $diffpatterns
>>  do
>>  	test=3D"$TEST_DIRECTORY/t4018/$what.sh"
>>  	if ! test -e "$test"
>>  	then
>> +		git -C t4018 ls-files ':!*.sh' "$what*" >other-tests &&
>> +		if ! test -s other-tests
>> +		then
>> +			echo $what >>drivers-had-no-tests
>> +		fi
>>  		continue
>>  	fi &&
>>=20=20
>> @@ -135,4 +159,8 @@ do
>>  	. "$test"
>>  done
>>=20=20
>> +test_expect_success 'we should not have new built-in drivers without te=
sts' '
>> +	test_cmp drivers-no-tests drivers-had-no-tests
>> +'
>> +
>>  test_done
>>=20

