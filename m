Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7966EC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbiFCXI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiFCXIz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 19:08:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708343B2A6
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 16:08:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n28so11961373edb.9
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uqPQ67ZRVDnlyWcgW5a3yJh5Gj9Z6Zf/gWU5/YfG1ok=;
        b=Kdw+eAcv2dwW/gJuhxlu1YBy/BQwVZvQ+VjXUKr2PyDYD4GnMKKpiCEouCNthJpy65
         5cukDyLRTavOGy+v+d1qpH5VFdXua5CaTBwGp1orzhIOe5abeQDWjRBpBaxqic+PvFB4
         7aZPzB10dEluUFM8gDgUVX/rw4D2BoNHcHg3qlMvRk+eg1uJhwMHYVxT+aKPOHCUfidH
         32V6EJu8zfAfVQinHQam7dp5mO3aeVrezAeC9CHDVdaY7isFsMH6SiR2CXl9oEV7/0Qe
         uCvuhL9KuQcWDF7XdzqpDj23hEJZklcwQMY1ubaJxBmCFK42EagtG4hp8iX3WZQKI9DM
         CHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uqPQ67ZRVDnlyWcgW5a3yJh5Gj9Z6Zf/gWU5/YfG1ok=;
        b=lDl/5S3T2PHsbj95bR7QmzsoucEYZ74P1NvMTUOKUaLPo2Ji08gvoAouZzktIJdTor
         xy5+1XSU9e7VdzsYVN6Yqob+Ml40Wnf+Nf/65P7Gba/4tYkAdR0zFiI3Mf0RlGECxcxf
         WEavagv7T6dXajVbX+GwZyiYUnEed2ek+LCAA620mz4zvPZ7AnJz+rvw3T6Fcrr//Hw2
         8AbaylE3E/5x1uz02OZgXIl7ddfbe+1X8frGcmhq65xill5+qr45TPBLONAmFfvYaNNo
         lR8wiJgEP+oEiDhSauJvKuOSBXQ3SbNEbNViHpLbf++mREbwoRmr77K300tSRdHj24ol
         2yHQ==
X-Gm-Message-State: AOAM5334nPP01tXw5of9J9vhxofATNDG2Py80v6Ivk09mtiX/hH7x6Ax
        GYq/7bJWVBUBx7EKcD6kqyM=
X-Google-Smtp-Source: ABdhPJw1YyalsIKoFoCNByObj1p36wn/7S5xwGcKs/ADhaasYV82wwssQSfFl0qcefvi/u3g2e8m8Q==
X-Received: by 2002:a05:6402:42c1:b0:42d:fba6:d5c5 with SMTP id i1-20020a05640242c100b0042dfba6d5c5mr13554930edc.295.1654297733010;
        Fri, 03 Jun 2022 16:08:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b006f3ef214e13sm3310061ejb.121.2022.06.03.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:08:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxGPT-001uTd-CO;
        Sat, 04 Jun 2022 01:08:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Date:   Sat, 04 Jun 2022 01:05:34 +0200
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
 <xmqqv8theehf.fsf@gitster.g> <xmqqczfpe9ua.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqczfpe9ua.fsf@gitster.g>
Message-ID: <220604.8635glxs3g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> However, in doing so we've been fooling ourselves when it comes to
>>> what trace2 events we log. The events tested for in
>>> 0a9dde4a04c (usage: trace2 BUG() invocations, 2021-02-05) are not the
>>> real ones, but those that we emit only from the "test-tool".
>>
>> I can fully agree with the above reasoning, i.e. let's test what we
>> do use in production, instead of something nobody uses for real, if
>> we were adding a test for BUG() in vacuum, but why did we have to
>> "fake" it in the first place?
>> ...
>> Are we sure that the reason no longer applies?  How do we know?  We
>> would want to explain that to future developers in the proposed log
>> message, I would think.
>
> We can flip it the other way around.  
>
> I do not think I ever saw anybody asked anybody on this list who got
> a BUG() message to use the coredump to do something useful.  Don't
> modern distros ship with "ulimit -c 0" these days?

I think that part of it was just a side-effect of SIGABRT.

> It might be possible that a better direction is to introduce
> GIT_ABORT_ON_BUG environment or core.abortOnBUG configuration that
> chooses between abort() and exit(99), or something like that, and
> then we switch to use the latter by default over time?

I think the reason for abort() was what's covered in raise(3), i.e. it's
a one-stop-shop to getting "stop it" behavior both under threading and
non-threading, which as e.g. exit(3) discusses wouldn't be thread-safe
with it.

But perhaps that was all premature worrying, we're mostly running
non-threaded, and to the extent that we ever BUG() running into exit(3)
threading issues is probably the least of our worries.

So perhaps we should drop abort() entirely, I don't know. These proposed
patches tried not to do that, but just to log things when we did so.
