Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449CCC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1920422D02
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVv4vrB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgHGRwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgHGRwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 13:52:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A4C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 10:52:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z14so3118463ljm.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tID+ivYqYL3jG61lLMfykk4bd13lNX3Sl8Tow0MOz2M=;
        b=IVv4vrB7HL4Zug6+i/POffCtcKUb+/zQq+QLvN0A+J5KDDnVWz5rX4JWX2jgz5ppSQ
         /HycrePgdMXxQMZ3b69YF5mqwswCGARx/JNeJJbdfsjM2ixBCSRT00JsnsubEUgUqUY3
         kG/G67oWpQSGEBkP6xWDjdxMKhPA9b3Ogbsm7Kj8KMYe4v/DMBNeIjSP73Os5berpNm1
         vmyyemXlep040eUwwNUmGD4zZx82zs1hNdsaXiNx/4cUP0g2xhNuRfj/nX9tXpCv2vDw
         YZE0quyzgEW/gZmk9rvepTyxNA6qrLgJ7HcxTZDL9szjfmuX9b28ZsK8hvG8i1KtriCs
         H0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tID+ivYqYL3jG61lLMfykk4bd13lNX3Sl8Tow0MOz2M=;
        b=RuEaMiKWZVBYoVFlnQLoxvX8RHIWqvyPAGg3ZH4nvYyF6tl8U9D6d6zE1ifUrn5fdR
         c38SjOGWRaP7Qp8Rd7y6RANlWkUFGz0cLJzwpHv5YH6WS0YMmo5VXlUpGHV31L/c/PMS
         CL53WV+tOm7qWky9XMFQqa+fodiV/X+YWLF+olc1Tttipby3YlLSSqxTmM4dMlQCNHEA
         FC+h5OsurrofM2aVMiiotIacu2XSYsqJxsY68Rb/bX1mza8W85Kb3KSG0aO3h22YlpiE
         uxQF3B2seDaS0w2dh67hWcX0JgtNpNJDLox0N9rP17rVOMUumHuXQecq6kU5fsGoo+Hw
         S6qg==
X-Gm-Message-State: AOAM531cnCRmqaQRnK31Akw5MIZj82sNu8BLKYcAYqPLPMnaRHioFr1S
        2fFh15xUwyhj+HNz4WYIJLU=
X-Google-Smtp-Source: ABdhPJzDNYXvPrSWFUoZhEp5gZ4iMSikFbFFMPrU7FGXCwjmPKxmKwpgcpTJsGvjZnEzwZOZpzGJtw==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr7003485lji.48.1596822722524;
        Fri, 07 Aug 2020 10:52:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r11sm4081122lji.104.2020.08.07.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:52:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com>
Date:   Fri, 07 Aug 2020 20:52:00 +0300
In-Reply-To: <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Aug 2020 10:43:08 -0700")
Message-ID: <87364ymji7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Agreed. My only question is whether the possibility of later having
>> those other options might influence how we name the two options we add
>> now. I think it's clear to all of us in this thread how those two easy
>> options should behave, but if the intent is to eventually allow these to
>> be mutually exclusive:
>>
>>   - no diff
>>   - combined
>>   - dense combined
>>   - individual diff against each parent
>>
>> but orthogonal to the selection of the parent-set (none, all, or
>> selected ones) then e.g. "all" makes less sense for "individual diff
>> against each parent". I don't have a good succinct name suggestion,
>> though.
>>
>> TBH, I would be happy enough with any of the suggestions in the thread,
>> so I am really just finishing the thought here, and not trying to derail
>> progress. :)
>
> I agree in principle that the above is a good framework to think
> about the issue around "what to do with diff when showing a merge
> commit", but I suspect that overly spending our effort to cover the
> possibilities become mostly useless mental exercise, mostly because
> (1) comparing with second parent is mostly useful only when the
> merge was done in the wrong direction (i.e. an attempt by a leaf
> contributor to "catch up to the trunc"), (2) octopus merges are rare
> curiosity and discouraged due to bisect efficiency anyway, and (3)
> even when looking at an octopus merge, omitting some and using only
> a few selected parents to view with --cc/-c has dubious usefulness,
> as the postimage has to show contributions from all the parents
> plus "evil" adjustment anyway (iow, the primary effect of omitting
> parents while viewing --cc/-c is to make it fuzzy which part of
> apparently "evil" adjustment is what the merge did vs what the
> hidden parents did).  These are all examples that show not all the
> combinations are useful.
>
> So...

So, does

--diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)

make sense as covering all the current features?

I've put variations that came to my mind. Probably we'd better just select
one for each case.

Thanks,
-- Sergey
