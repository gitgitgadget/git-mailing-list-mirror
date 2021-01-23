Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA8C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E0422A84
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbhAWQAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbhAWQAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 11:00:08 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC9C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:59:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c128so6966793wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o224S2jjf2+cnPJcpcqVSGjfAr1pX8DPsmm4EwA0Lyo=;
        b=UkCcy0gB0bcKUIjrm9WX+21I9vdK1QlRCf0w/SnhPA26ORmDN8+5Zs9+7NoUmT2fMt
         uClhnY0J6kAtZG5ppZUXHA7R0Zsl2KoCu+BAWSRfaa1GV86Egv+fjjV4vAqWw8pMrUcm
         m2TM6m4wXfuIjxaMzma8qgN13Y68QSFNjbIDv2coA/8uQkDl4iWmYXi+tMNVJcHZlfsc
         3QJF3zT/gypwKZ7cnMMTAOkKkfpsp25iN6hP4Ywh1ctq7oxWvxAiNvzjb2pVkOOqU3a/
         p0mJo/F2uFves2wI4rWsZR3Uh+o9Sa1TneUBMhchpGCOgyWjkXPiAhCGGCbQTHk6kVnb
         fRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o224S2jjf2+cnPJcpcqVSGjfAr1pX8DPsmm4EwA0Lyo=;
        b=eltrX6ObsmswH2ELDPEovHFoidbQBp12hKWJoiTXERGpzvORDrIFoJjJskT5EADqeJ
         muEKTpRDAWyyPThtuvdV46+ko8fCahQImlYin/oHoGezxskPfnZKntBpps9G+NlyDtsG
         PHMpJ01ZgsXZLtSZBc+T2r3MRaHycvUdYk/DtfcZqX9iMxuiZQKmyXfr23lpvyPL+xvJ
         u4nl71FThRnqnysbeKPs8iy/FTP4L/O76juS4m/1vnuBnfGOzFuLQrIjR68FM+bkFrSh
         j1Y5RbR8lcgkHeDERFKcOcnMnDi/Zfko+yTrGBzpJlooLRaE6U/IupSDyd8o+PtwQXuA
         1MDg==
X-Gm-Message-State: AOAM532vqvaM+Wu09PlFyxXFk4kZLuGVeDtL3cv3Hby41NoEu9uEsPcR
        wyWHh5R6efqgPVkiJexKjJo=
X-Google-Smtp-Source: ABdhPJxbTcZuEHXPAh2MoWzbyeh6DockDhbEBs1mCCBUXAPF+rF5Lv6KBsdAAv71ewRHhhWkjQ4r2g==
X-Received: by 2002:a1c:9e86:: with SMTP id h128mr8889058wme.171.1611417566630;
        Sat, 23 Jan 2021 07:59:26 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id u142sm7891153wmu.3.2021.01.23.07.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:59:25 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] range-diff: refactor check for commit range
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
 <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
 <0ce0953a-92b2-2ce6-1e13-6f6240933ce1@gmail.com>
 <xmqqbldg7hvb.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a0b100e7-57b8-df46-de2b-d54fdbe6a255@gmail.com>
Date:   Sat, 23 Jan 2021 15:59:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqbldg7hvb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 22/01/2021 21:59, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>    +static int is_range(const char *range)
>>> +{
>>> +	return !!strstr(range, "..");
>>> +}
>>
>> If the user wrongly passes two arguments referring to single commits
>> with `:/<text>` or `@{/<text>}` where text contains ".." this will
>> give a false positive.
> 
> True.  I do not think this aims to be complete revision parser in
> the first place, though.

Yes but it affects the error message given to the user. If I run

git range-diff $(git rev-parse HEAD^{/..q}) $(git rev-parse HEAD^{/..x})

It fails immediately with

fatal: no .. in range: 'b60863619cf47b2e1e891c2376bd4f6da8111ab1'

This patch improves the error message to say it is not a range

but

git range-diff HEAD^{/..q} HEAD^{/..x}

runs for several minutes without producing any output and eventually 
fails with

fatal: Out of memory, malloc failed (tried to allocate 33846432676 bytes)

So I think it would be helpful to be more careful here.

Best Wishes

Phillip


> It is tempting to at least idly speculate if an approach to run
> setup_revisions() on argument is_range() takes and checking the
> result would yield a more practical solution.  I would imagine that
> we would want to see in the resulting revs.pending has at least one
> positive and one negative, and none of them have SYMMETRIC_LEFT set
> in their .flags word.
> 
>      Side note: Strictly speaking, people could wish "rev" to mean
>                 "everything reachable from the rev, down to root", so
>                 requiring one negative may technically be a wrong
>                 thing, but in the context of "range-diff", I am not
>                 sure how useful such a behaviour would be.
> 
