Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B00FC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE9920723
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhA0G7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317581AbhA0BFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:05:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF6C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:04:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kg20so325821ejc.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0pUL2RGNAxiz2rholqCa4joivMOrVK21vuRmOrS0o3s=;
        b=XMPVZTp4aWIyoi2bP9QZWnXUPhCE6Wmw6PwBcfKBG3VtGzMiw0YCoH9D3zj47cXk7f
         4AQjqW01SCHLIcNvxojYp67KSDkK6pUccsF0yGIIJ4RBuvO2oW1++va5GYPAF9nzvGYU
         ePQjW3IHQ+LgEsSwvFhvEASGEAkB2EOYgqYP1xaC5JrmOoUimCsl83+YWE8F5xUje9wm
         cEUkRU+MKt+mWinF+X6OwBcr0KzAJHUAzgG15nFyWJkPYVFnATN24wpusvUkXhTOPA8y
         a54SWFk0klcoEisKhe/LFROa3ALFdUgsYYiZo7kmea7VG91OVmjpEX/oCLGFgMs49Qbe
         zw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0pUL2RGNAxiz2rholqCa4joivMOrVK21vuRmOrS0o3s=;
        b=csZUt3syNmth5jNJYIyxYaivvV+AltvfqevUDPYFtSn6+ZC2hSOtISePigppv4xfUP
         BVXqClbloo//ZhhFGyNK2BF4FU9IPo5F6cAJULFPNTuDZotGLRxHl9TLH3hyhlhv86jo
         RF3qlDOTl75wKrFR6Yns6FI8INb2UbX149a6iyMkZ/5UASef8J8qB5Xoq47UGDv/PkEJ
         SQV1srOjyBxj14jDHOVZY22zHrXhzgM9d14rUy1OoZDkuGUSMjfBSmIZSyJwBki7MX1j
         9VLWevI7p8wB6Q8Ovu+2jA3YXeTOf/M7Qd5rjMWnRmiQKLAR6NiYGojzTv/zE+35kiDc
         p90g==
X-Gm-Message-State: AOAM531UUpHA9Nq+lX2ejPWLmGJzNlvqEckdny6/9gV9Zxj7FlNyDO3R
        VZGSOiPAsxacWndJHYkkNA8=
X-Google-Smtp-Source: ABdhPJwdBSOLol9M633cx/+8Obf1mwgS+XT6P3hSo3dBnJ7kkyqt7AF6lEvsgs4ap9V3W3LY6o58vQ==
X-Received: by 2002:a17:906:2c0e:: with SMTP id e14mr4922042ejh.299.1611709467327;
        Tue, 26 Jan 2021 17:04:27 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i6sm108507ejd.110.2021.01.26.17.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 17:04:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2021, #05; Mon, 25)
References: <xmqq1re8wja2.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <xmqq1re8wja2.fsf@gitster.c.googlers.com>
Date:   Wed, 27 Jan 2021 02:04:26 +0100
Message-ID: <87mtwvp4v9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 26 2021, Junio C Hamano wrote:

> * ab/grep-pcre-invalid-utf8 (2021-01-24) 2 commits
>  - grep/pcre2: better support invalid UTF-8 haystacks
>  - grep/pcre2 tests: don't rely on invalid UTF-8 data test
>
> * ab/retire-pcre1 (2021-01-23) 2 commits
>  - Remove support for v1 of the PCRE library
>  - config.mak.uname: remove redundant NO_LIBPCRE1_JIT flag

I have a few follow-up patches this grep/pcre2 area to fix some
longstanding bugs, but am holding them off because they'll conflict
badly with both of these, and I thought maybe I shouldn't submit some
giant "fix misc stuff related to xyz" topic again if I could help it :)

So if you/reviewers are taking requests getting some eyes on these to
get it down into next/master sooner than later would be great. 

In particular the PCREv1 removal topic is rather trivially reviewable in
the sense of whether we're removing the right code. But the real
question is if anyone's still depending on PCREv1 badly enough to want
to not have this, which we're more likely to see as it's merged down
sooner than later in the cycle.

> * ab/detox-gettext-tests (2021-01-21) 3 commits
>  - tests: remove uses of GIT_TEST_GETTEXT_POISON=false
>  - tests: remove support for GIT_TEST_GETTEXT_POISON
>  - ci: remove GETTEXT_POISON jobs
>
>  Get rid of "GETTEXT_POISON" support altogether, which may or may
>  not be controversial.

I just sent a reply to the one minor outstanding technical issue in the
series, i.e. figuring out what to do about the GETTEXT_POISON ci job
(drop or rename?).

But the main question is the "do we keep GETTEXT_POISON at all, and if
so is anyone's interested in not doing this and doing Johannes's rot13
proposal instead?".

As noted in the thread I honestly don't care much either way where we go
with this, I'd just like to either drop the patch or get it off my plate
sooner than later, so if you love/hate/meh the GETTEXT_POISON mode,
chime in.
