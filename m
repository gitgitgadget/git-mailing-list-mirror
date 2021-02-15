Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4D0C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8650764DFD
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBOTCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOTCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 14:02:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AEC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:02:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y18so9358242edw.13
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cC4jBvWhYr2PLNKZt66um6Fi0n3THLM4jXEHexym9Gs=;
        b=tYJWJ64mkZU71roQVFNUJOxQlHrFkiYlB11IWLJZBesfHqXGHXknRrglNMZfaqQlEa
         4iYEv4l9eBvY5KUiKBvf1yjSogsvW/FxGcPlCDThYd+b2c2K+r16Vj39c0t6b85nFEA/
         N55ITpEymfmcJQg85xKevX2c6FNQrJJAD4mHjHvxHeDVarCpRzfRg02TQ4fWW3SIiXE/
         O1wZzzIqpXZF06Am+hGI/8JIyEJY0+BnozHPNDEnZ1xmgtqzQpEcB5fRAlwdbARAB89Y
         pidiDzH3F/KHRHbtxX2LyRu6/81xSFemfWQAIPMVeUJGlGdmAzNaSffbgdzXfx8wa2SW
         bhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cC4jBvWhYr2PLNKZt66um6Fi0n3THLM4jXEHexym9Gs=;
        b=JFDa4KdAy2RZkjGYqJBrhQdKBwe5vMcYVBkE1zAPSrUsjzD10O2yZHHJkpOHriNPng
         8gUuqi51UtFQiiA5thVKL/kzZrKKWGVKMd7Z8PqBxNxNgDHhChySsQcM5QezaExE7h9s
         rZYc4gPvSc/uV5mfgoX/FUw8Q/hMSsqv3skUKMvdo9wWdLaOSrj62Vh0w86ttlMS5VuG
         Uhq4wgjCmzwfAuR9sGvAkLEnQDm98s+KH648pY2uHvUYmNUbxQucKmHaS0TUskZq+VA4
         hqp4vVDIbTweec/9HlqcqCSGjUYhEjOdYHndcC2PvxMfHBC93NB679Ne5yAJpPCmLGDP
         4O7g==
X-Gm-Message-State: AOAM5303KFGtG8Stx18l/6a6P2llfKGFjH6liDpDhaCNjlR2D45Si7SN
        ZOyP6ZJa27QjDgaGmthiyXA=
X-Google-Smtp-Source: ABdhPJxS8wH+XH/gR2JlxzWO7R0wbae/cKvD82RH4ioAqJ98H4oo+750VC5dh6aX25A0Rhr1r4JUNg==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr17179415edd.365.1613415718730;
        Mon, 15 Feb 2021 11:01:58 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f6sm10997546edk.13.2021.02.15.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:01:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 19/27] gitattributes doc: document multi-line
 userdiff patterns
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-20-avarab@gmail.com>
 <7984b3d6-7c01-565e-f5fd-3104af4b3ce6@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <7984b3d6-7c01-565e-f5fd-3104af4b3ce6@kdbg.org>
Date:   Mon, 15 Feb 2021 20:01:57 +0100
Message-ID: <87lfbpb1ei.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Johannes Sixt wrote:

> Am 15.02.21 um 16:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
>> index 72d38dad68..30df13d8b2 100755
>> --- a/t/t4018/custom.sh
>> +++ b/t/t4018/custom.sh
>> @@ -111,3 +111,53 @@ ChangeMe
>>     baz
>>   EOF_TEST
>> +
>> +test_expect_success 'custom: setup negation syntax, ! is magic' '
>> +	git config diff.custom.xfuncname "!negation
>> +line"
>> +'
>> +
>> +test_diff_funcname 'custom: negation syntax, ! is magic' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +line
>> +EOF_HUNK
>> +line
>> +!negation
>> +
>> +ChangeMe
>> +
>> +baz
>> +EOF_TEST
>> +
>> +test_expect_success 'custom: setup negation syntax, use [!] to override=
 ! magic' '
>> +	git config diff.custom.xfuncname "[!]negation
>> +line"
>> +'
>> +
>> +test_diff_funcname 'custom: negation syntax, use [!] to override ! magi=
c' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +!negation
>> +EOF_HUNK
>> +line
>> +!negation
>> +
>> +ChangeMe
>> +
>> +baz
>> +EOF_TEST
>> +
>> +test_expect_success 'custom: setup captures in multiple patterns' '
>> +	git config diff.custom.xfuncname "!^=3Dhead
>> +^format ([^ ]+)
>> +^sub ([^;]+)"
>> +'
>> +
>> +test_diff_funcname 'custom: captures in multiple patterns' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +foo
>> +EOF_HUNK
>> +sub foo;
>> +=3Dhead1
>> +ChangeMe
>> +
>> +EOF_TEST
>
> This test would not catch a regression. You must leave a line between
> the candidate-that-must-not-be, =3Dhead1, and ChangeMe, otherwise,
> =3Dhead1 is never tested against the negation pattern.
>
> Or did you change the diff invocation in an earlier patch such that it
> does not emit context lines?
>
>> diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
>> index ac8fff7417..2952483a2c 100755
>> --- a/t/t4018/perl.sh
>> +++ b/t/t4018/perl.sh
>> @@ -76,3 +76,19 @@ sub RIGHT
>>   	print "ChangeMe\n";
>>   }
>>   EOF_TEST
>> +
>> +
>> +test_expect_success 'custom: setup config overrides built-in patterns' '
>> +	git config diff.perl.xfuncname "!^=3Dhead
>> +^[^ ]+.*"
>> +'
>> +
>> +test_diff_funcname 'custom: config overrides built-in patterns' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +sub foo;
>> +EOF_HUNK
>> +sub foo;
>> +=3Dhead1
>> +ChangeMe
>> +
>> +EOF_TEST
>
> Same here.

Well spotted. Both of these test work for their advertised
purpose. I.e. "we can override the perl built-in config" and "capture
count gets reset", but you're right that the =3Dhead1 negation rule is
redundant at this point in the series.

In 23/27 we start testing with -U0, at which point it starts
working. But of course a better fix is to just add an empty line here...
