Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D208C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162DB64EC7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSAy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSAy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 19:54:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A8C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:54:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so6651150edd.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FKous77h5W6BeR+KGgvfqqfyeIlidqdQlz4KbDucLs8=;
        b=q8v+pbvbvQBuTX2x5scb6Oe+IOlHxhfUSllbP2fsekL8UbwJRK9n59VVq2cnNB/H2d
         1rzo+xNiAYsPAgYfI+fkdh6ICuqYlSjA2Kn924FzspoHvmupbrYQ6Wny14EtzMxegpdB
         3OjWA6XSpONJWYaheCE+flrokqcggt2P1AVBWqhH0MawWPLdyOqLmn6GkmuokygLaP2b
         8hFOI7ol2l/LaRKq94ZLreUDiK+FUjguL/eKFN/SAYT4GOTyn8DkiSFIRm3VsoFVKcSI
         Y11ihbmpEYB6EtihRSpP0fORZYTVMP3xhEbvFUQpEhMl+0hTKvANdfMOyAQKjtbdUOg7
         FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FKous77h5W6BeR+KGgvfqqfyeIlidqdQlz4KbDucLs8=;
        b=CqHl0kLwmVxx35H4IHdIo9fvwF46ktLYBIOoNoMfQ13fYiVRsL5RAjQmDBwwyXj6/R
         21NW01RM5GqXQoxqyIDZzaGcoikaTyo63AQU8iE09AFE/GCHAa3H+yXtBxOZzKRHIkYF
         ReGmKe+WVoo0WxxM+Ov5Y8JC4m1pklA3CP7HJe03fxRuLLPAnvBIoaWi8ShYJ7K9wPCH
         8o6KPoS4JFDi+NA+KL29hP8O9fjTRrkCnTfstdA0XE5xqNb7lv4GKgSvgeqJSkAEiUEt
         93aseOujCANcR6fpTgCPgPqLJUy90rEV+rCZ3pgqCQH7oj44hIRLSWsOl5CQY/tnhGHh
         1qhQ==
X-Gm-Message-State: AOAM530ObzdFbeVX36aZp8G+O3YlOG1xn7ZC66Ng2hAEKerjcAVA1orv
        r0fCYUoEzcjfhrob/HyqGXz//LThMDZI/Q==
X-Google-Smtp-Source: ABdhPJx4+Z35S6T9yXzSU21Qh5oKFTjm3ZRxFPQMAth5uLDz4MfxhM0N+qu2LeR53oGKZ7q5Uw417Q==
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr6849670edv.210.1613696054731;
        Thu, 18 Feb 2021 16:54:14 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hc13sm3276461ejc.5.2021.02.18.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 16:54:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
 <20210217194246.25342-1-avarab@gmail.com> <xmqqo8gijtl7.fsf@gitster.g>
 <87zh028ctp.fsf@evledraar.gmail.com> <xmqqtuq9faw5.fsf@gitster.g>
 <YC7GupBLb4IoDLj6@coredump.intra.peff.net> <xmqqtuq9dsu3.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtuq9dsu3.fsf@gitster.g>
Date:   Fri, 19 Feb 2021 01:54:13 +0100
Message-ID: <87lfbk98sq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 18 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Feb 18, 2021 at 11:12:26AM -0800, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>=20
>>> >> Let's get this reviewed now, but with expectation that it will be
>>> >> rebased after the dust settles.
>>> >
>>> > Makes sense. Pending a review of this would you be interested in queu=
ing
>>> > a v2 of this that doesn't conflict with in-flight topics?
>>>=20
>>> Not really.  I am not sure your recent patches are getting
>>> sufficient review bandwidth they deserve.
>>
>> FWIW, I just read through v2 (without having looked at all at v1 yet!),
>> and they all seemed like quite reasonable cleanups. I left a few small
>> comments that might be worth a quick re-roll, but I would also be OK
>> with the patches being picked up as-is.
>
> That's good to hear.  I shouldn't even have bothered to answer the
> question, if the v2 were to have sent to the list without waiting
> for my reply ;-)

FWIW it's not that I didn't care about the reply, but I'm somewhat
intermittently available time/network wise in the coming days. And
there's the TZ difference between us.

I sent v1 thinking you might be willing to pick it up & resolve the
conflict, but since you expressed an interest in deferring it until
conflicting work landed figured I'd ask (and then just sent the patches)
if you'd be interested in a conflict-free version to queue alongside
those changes.

If it was still "nah" fair enough, I'd just wait. But if not those
patches would be there to pickup.

Thanks a lot to you & Jeff for the review on v2. I won't have time to
address all that today, and in any case I got the message that maybe I
should stop firehosing the list with patch series's for a bit :)
