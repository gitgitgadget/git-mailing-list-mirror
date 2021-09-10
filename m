Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3517C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B6060C40
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhIJPO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJPO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:14:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F545C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:13:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j13so2923223edv.13
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eNCRsLNd/5vZfziR0iw1PhTevBkx1NH9v9Ny4n5n7Go=;
        b=pGwQYbAYIgAmHbKxAXL1DXXnEtgaXm/9ya99KDrJltMOGwYlSatfN4VsLc2z/zQ6rq
         TzWNKSW6pOurL0ZzQV/V66X4kH3VCetGjw8yOSaT5UEj0CWCavwa9ezOvWyAvUzvgGHZ
         18M96XziRg/ufldF3jvrp/9RCR0WZcFuVEHOgBL/TZuy11x/aEryhekS6gcSdmKd0XAH
         yQvYXO5x3RIIQ5XbWL3WeEVVMGKryriHacQrkfOLUwnxqz1fPRDkymqYCdbaQgvYcZAo
         7y9fB54Qtl27pn0V8J6DlD0XC4jRdJr8sJQ7dG75X0uzQgbgclgoK6hcDjCehovdOBKc
         Hcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eNCRsLNd/5vZfziR0iw1PhTevBkx1NH9v9Ny4n5n7Go=;
        b=3TJubSJgytSLCA6NDOcmi0Sw+rXF4W1CGprIbgXBH8EOzbCuTiElB7Fj1u4S75P+jc
         QzwuNkX18lehZSKFbAh9Jwp59frChK2FeZhOZQrfGJtuadWoLjZB2JD8qw0ax0BipOz6
         fWbqA2/M2kgY+YI2/bBzJAlkkpgR8Va7K6kwfmMs8/SNnWGTxntpwLY1A6XkGNP0Izgp
         rGU3t8O9cYhbqHWIDRXBlUkax5kVzufOACdSl/8kYXf/mpECmY9wjqFDCeOFJaR1DIgn
         e3BHO2z0F0Up5KdnkayAbc+fX/PJhXr+yCRGE7EGZ/nXOQbCrWOpONYXmvnsIIvrHS2C
         fJeg==
X-Gm-Message-State: AOAM530oiN1Drz6iHI2jSLmfVfBIru2VrZibM8vk7wyFPMvXZVxAL5Ce
        8zrJUYVatYOOoYTg3mcIj2BFf09LL6C7ww==
X-Google-Smtp-Source: ABdhPJxcKURFkda5B/Qf/dAk26r5Sr+AlEPBot7PhBHAz8lHqK4M63Wv7hn6+/+bkgCaOSKkQ9rM4A==
X-Received: by 2002:a50:eacc:: with SMTP id u12mr9436990edp.140.1631286823650;
        Fri, 10 Sep 2021 08:13:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eg14sm3080400edb.64.2021.09.10.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:13:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Date:   Fri, 10 Sep 2021 17:08:32 +0200
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <YTtttIuur0JvcPub@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTtttIuur0JvcPub@coredump.intra.peff.net>
Message-ID: <87lf44cvkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Jeff King wrote:

> On Fri, Sep 10, 2021 at 01:04:25PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Version 1 of this had a really bad bug where we'd effectively make all
>> supported curl versions act like 7.19.4, i.e. the oldest supported
>> version except for a couple of our supported features. This is because
>> most of the things checked with the "ifdef" checks are enum fields,
>> not macros. So basically the "devil's advocate" Jeff King pointed out
>> in [2] was already the case. Oops!
>
> Oops. :)
>
> Well, I'm glad I mentioned it, then (I really was just playing devil's
> advocate). It does seem a little scary that we'd compile without all of
> these features and not even notice it.
>
> I guess it's hard to test for those features when we don't know for sure
> that our libcurl supports them. We could perhaps make the tests
> optional, but how do we set up the prereqs?
>
> Version checks based on "curl --version" or even "pkg-config
> --modversion libcurl" seems error-prone. The curl binary might not match
> the library we used, or the user might have given us a specific libcurl
> to use rather than the pkg-config version. We could teach Git to tell us
> which features it thinks curl supports, but that's depending on the very
> thing we're trying to test. We could have Git output the
> LIBCURL_VERSION_NUM it saw at build time, but then we're just
> implementing the same "if version > X, we have this feature" logic now
> in the test suite.
>
> So I dunno. I do not have any clever solution that would have caught
> this automatically without creating an even bigger maintenance headache.

Yeah, ideally we'd have tests for these optional features, and we'd then
just add them to GIT-BUILD-OPTIONS and skip dedicated tests
appropriately, then it would be more visible to see those tests
skipped. Presumably someone testing this would run "make test" against a
glob that includes *curl*.

But that's not easy to do in practice since the flags are either not
visible from the outside in terms of behavior, or if they are it's all
something that requires proxies, SSL etc, which we don't test currently.

We can and should test that, but requires e.g. extending lib-httpd.sh to
start apache with ssl support, or maybe we could do it more easily with
an optional stunnel or something...

> (Though for other reasons, it might be nice to report the curl version
> from "git version --build-options". This is a bit tricky because we
> avoid linking at libcurl at all in the main binary. Definitely
> orthogonal to your series, anyway).

We could always ship a git-version-curl and shell out to it, or embed
the version curl-config --vernum gave us at compile time via Makefile ->
-DGIT_CURL_VERSION.

That version could be changed at runtime. We could call that a
feature. It's --build-options, not --runtime-libraries :)
