Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCB8C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AA523432
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404338AbhATSPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbhATSOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:14:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFEC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:13:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f1so12750458edr.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XIGs4CJIw/ngGj5UGtQ/2pM7GSSEjHVKGybgO416fko=;
        b=m28L2UGBiJQ4frdciGfIVA53T/ZFLj7fjJfEx9OhgC8OypbQ8dl1yFf3QjrBykbTL1
         mRynjNKbkpar0SuzA9hEfaOsAAcv7hfhcoH5ZUV2001C7+k1lk6kEvkWEe8Hna0Ir5/C
         KGyHINJhB4+JvR//3zgHdabirwmqLDVT02RVW+Zy/VP937Q01SxpmcxiSM+fMpc8Cuzs
         4K6JvG6g1S71pbfbKH+j8ev6rJG3gFr/GxDxuGacwDznkxoqb2nF0SfiG0d/gjzyGGl0
         0MwYk0vnU8ILwu7TaZdZL94G7A22SQL5JNPWCCEr0RM4NyE2lUQNcpT5GAc2WNBstwNA
         4nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XIGs4CJIw/ngGj5UGtQ/2pM7GSSEjHVKGybgO416fko=;
        b=s9n2h/wQJ0KKecw8vUvVWPTLvL1NFDv1KNYJ0t/KEtedi7yfyafkpUJAQLX9alzI6f
         nDqT7EbvNW0WMZWEAVtq4WpUSh1r8X+XOZXdLvREFhEQQqi2qA3HilMCPwjkhjDCMIj3
         ZWsGY1Yy+n7KcbtARtwQ9fXkBBLSQ0wO49z9DtYRtW0SySUFtUeaUGMYR1RGTvBxYK1H
         x8FQn4mGYeRQEUmU9bbHI1xPHfSEOhBBc9Q73up/KWmKUIRyvwvIMnAInYXxiyqBth5K
         yWUObl0Fl96u44xWjjnLZDB5I9pZEtx+fERNDL63d3Cjr6zLxJnu7SNqKuZpSKrjhecC
         5PoQ==
X-Gm-Message-State: AOAM530QUwlvECgb+u54JFc3Jtzv97AwMQNWI5BQkqH0q5zhNoU9K1xS
        CPXUZ2smHFn3PfZxZ3qUuMJS/yX1KWQ=
X-Google-Smtp-Source: ABdhPJxaZ/9jToCgh/8FfSs0W2l4FJBc4cnPM4hMxEbTfD4JV6gttMb6dCZfszTyZCHBFsKjewT1Fg==
X-Received: by 2002:a50:aac8:: with SMTP id r8mr8082977edc.9.1611166408570;
        Wed, 20 Jan 2021 10:13:28 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id dj25sm1474641edb.5.2021.01.20.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:13:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 0/6] Remove GIT_TEST_GETTEXT_POISON facility
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-1-avarab@gmail.com>
 <20210120153307.GD8396@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210120153307.GD8396@szeder.dev>
Date:   Wed, 20 Jan 2021 19:13:27 +0100
Message-ID: <877do78ojc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 20 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Jan 11, 2021 at 03:47:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As argued upthread and in 2/6 this test setup has outrun its
>> usefulness.
>>=20
>> This series begins to remove it in a way that's very careful about not
>> stepping on the toes of any other in-flight patches. In particular
>> "master" isn't anywhere in the diff context here to avoid conflicts
>> with the series to do that mass-replacement in t/.=20
>>=20
>> This series merges and tests cleanly in combination with the current
>> "seen" branch.
>>=20
>> At the end we're left with a bunch of tests still using
>> test_i18n{cmp,grep}, but I think that's preferable to having in-flight
>> conflicts. It'll be trivial to search-replace those at some point in
>> the future where we don't have another search-replacement series
>> amending t/ in-flight.
>>=20
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
>>   ci: remove GETTEXT_POISON jobs
>>   tests: remove support for GIT_TEST_GETTEXT_POISON
>>   tests: remove misc use of test_i18n{cmp,grep}
>>   tests: (almost) remove use of "test_i18ngrep !"
>>   tests: (almost) remove C_LOCALE_OUTPUT prerequisites
>>   tests: remove uses of GIT_TEST_GETTEXT_POISON=3Dfalse
>
> At the end of this patch series there are still a couple of remnants
> left:
>
>   - t3406: has a comment about gettext poisoning.
>
>   - Makefile still has a warning about for the GETTEXT_POISON build
>     knob referring to GIT_TEST_GETTEXT_POISON and t/README.
>
> I think both can be simply removed.

The Makefile comment was in the 20210111131451.7084-1-avarab@gmail.com
sibling series, but I'll fix the other one in this one. Thanks!
