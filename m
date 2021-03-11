Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6296FC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1990864FC0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 10:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhCKK3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhCKK3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 05:29:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4AAC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 02:29:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id c10so45055484ejx.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cWPwkyA34wHoQAyL9Q7gUhoKuVzQUjv1ZvrPEIMT5L0=;
        b=U/nGJYi7hyyQxc8m7WtvYxtG07JFWbSEG7FW/LSotL1KglH+WLUtsjBJgcT1Fm5AGO
         FB8mJzoNJhnTezZQLMGTB0QVsCDNiJSD37veHGl7WvbuqTwFOu8ymC4++l8bLBYsqs1T
         goJMIQzBnJ+8PBeQG2y3BMcgzjDEU2sUnK7s9mmR6Oa69kHlsb2mjrTl9NdwdhrBPjk3
         kekBw8P2C+99JC39tox7iJkW8h7bP7qA7V/pUXEnuAVCdG4XQqctYWNXrroSCvDkiies
         EASjIaWf4ajRbMjo5cXgtvCwCEB4AyfJDAxQr/XaOEvHMlKehuHqK/W8Z1EGfXVZ5XlL
         ufrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cWPwkyA34wHoQAyL9Q7gUhoKuVzQUjv1ZvrPEIMT5L0=;
        b=B4otjuOIaoBuJariw8CbS0hMUpOcRyM9Pfy/hjrOB2E9AYf5rm5cuPB+nyQ0TEaR3t
         D8mUMmXMgwpW3/mi8ahlNJBux/jDNbfom726SGXv+0ah6sAByjZWAwVDSVLyqfl1CDG/
         2R5urbQc6pUHv+GJal6GsPhoC/MOxhCnozh/YDR6Hzpd7dHawxPG1a+xbG0Ze6EjVOBH
         sd9ORmxPuJkib3Z1D5ax76Ujycvo3s9IH2oYO/CSEQwpaM5sfLp2YG5KpvjizPAmKuQz
         cOUAhyERbE20s6J2/8vXk7Ek4aJy+hRtH9T+b2R8EiJMqig68L8KKj/kylrDsuWE5LHH
         y0Fw==
X-Gm-Message-State: AOAM532TWx8yrWicDkdfDdjrWr6sr9aY18Ir54WjvTSVJj+OVdKEu73I
        FZ6XOfyE+X4YMWXM//FFe9KxdfCK2JeAjg==
X-Google-Smtp-Source: ABdhPJyW0NfAt+wQW/X3KZQGDGDHaOoibOttyYI+CzaMYykkr/bLr2ocBfL1xwmI2pz8s7+7QXWKng==
X-Received: by 2002:a17:906:bc81:: with SMTP id lv1mr2392132ejb.135.1615458574829;
        Thu, 11 Mar 2021 02:29:34 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b17sm1057031ejj.9.2021.03.11.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 02:29:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 4/4] tests: get rid of $_x05 from the test suite
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
 <20210311001447.28254-5-avarab@gmail.com> <xmqq8s6uh4a2.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq8s6uh4a2.fsf@gitster.g>
Date:   Thu, 11 Mar 2021 11:29:33 +0100
Message-ID: <87tupigf02.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Remove the last users of the $_x05 variable from the tests. It turns
>> out that all of these tests can be rewritten unambiguously to simply
>> use [0-9a-f]* instead.
>
> I am unsure about the "unambiguously" part, e.g.
>
>> -	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
>> +	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&
>
> does't the preimage say "we expect at least 5 hexdigits to be shown
> here"?  The postimage lets even an empty string to pass.=20
>
>> In the case of the tree matching we're relying on there being a <TAB>
>> after the SHA (but a space between the modes and type), then in some
>> of the other tests here that an abbreviated SHA is at the start of the
>> line, etc.
>
> Sure, but these being tests, I am not sure we should be assuming the
> correct input to these transformations.
>
>>  test_expect_success 'ls-tree --abbrev=3D5' '
>>  	git ls-tree --abbrev=3D5 $tree >current &&
>> -	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
>> +	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&
>>  	cat >expected <<\EOF &&
>>  100644 blob X	1.txt
>>  100644 blob X	2.txt
>
> This one is particularly iffy.  The --abbrev=3D5 test is designed to
> ensure that the resulting abbreviated object names are at least 5
> hexdigits long, even when the repository is so small that only 4
> hexdigits are sufficient to avoid ambiguity, while allowing the
> output to be longer than specified 5 (when 5 turns out to be
> insufficient for disambiguation).
>
> So, I dunno.

Yes, I think this patch should be dropped. Do you mind just dropping the
4/4 and having it be a 3-patch series? I can also re-submit a v2 like
that if it's easier...

I saw the feedback on 3/4, yeah I also think that "cut" is a bit nasty,
but probably not worth spending more time on it...

My assumption in writing this patch was that it was fine because we test
the details of abbrev behavior somewhere else, surely...

But is it turns out we don't, I was misrecalling that some version of my
testing for abbreviations in [1] had landed.

But alas it didn't. From rebasing it now (it's far from submission
quality yet) I see that the lack of testing on abbreviations in the
interim has silently caused some regressions on master.

E.g. we seemingly unintentionally started accepting "-c core.abbrev=3D"
(empty string) in a9ecaa06a7 (core.abbrev=3Dno disables abbreviations,
2020-09-01) is a side-effect of starting to accept boolean values. Also
"git branch --abbrev=3D-12345" became a non-error in the interim (haven't
dug, but some of the refactoring to parse_options() I assume..).

So yeah, I think this patch is a bad idea now, our test coverage for
abbreviations is really hanging on by a thread.

1. https://lore.kernel.org/git/20180608224136.20220-1-avarab@gmail.com/
