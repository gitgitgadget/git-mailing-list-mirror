Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF335C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E8E22CBB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 06:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgLUGQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 01:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgLUGQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 01:16:40 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E8C061282
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 22:16:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b26so11421674lff.9
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 22:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nOXzD/DXomYSsulpqQS+y8X1G6PqmlQqXgxj5VKPEcY=;
        b=J1BR9rC9xSOOS/BIBNghPTt9tM3z2AZqKUAKukN5m2keLJs4EghkpX869B1BiKEVyo
         ZQVOeDo/UkSerLO4lz0Ozf08jc09TDWYq02GfqCGrXlXzABKER5h4O94ZmALjUabchCr
         OZ4a24DeksdsbwNpxSiLdH/WLSnemXlDpD0PIf5vV8wMH7y6000p1ozbbGsV/eys7D0U
         Pq3ssr/FgOLmp5FJTiKnKCTsinQOIhiBt1zXQUUFsUc6TuU9ov/r3pWyY7jFL6Mo9yP6
         rDDH8O9NtINQ7cqLOtsRN/NednAuN2yXWbeMA3K0d+wq+iKIT2Wg835teYuTou6meEbo
         r4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nOXzD/DXomYSsulpqQS+y8X1G6PqmlQqXgxj5VKPEcY=;
        b=f8HWSjjQ9IHrnaaAwWfCNGBRUiCi8A5IxnYSzkMOzkFtTOV9UjSUCd51yBc1Z7EnIe
         TOxt08nXfrBkr/RQghg++e88KZ5SJEz+ejuMIjWN9i3qFffTPHPGNfqbt//NLMia6EFD
         soqF4Z89Iktp+ADyPjopPN5NpNQ0rovsv+xARnslrMT0J95K2euTZ1vWkkrMOMCeZAma
         H+TZW2yP4IxnL9AexqVmRQJqDxID9hPd2PwRtyeO+4Ppqh8GiiwytOahXq2fvYVJ055c
         ey/hFM3JYnkZ3Oh6H8wUGhs/nbCKz+Dd6Z5byMGtYK+TrjtgoHiREI9/dPvxhKTGnEki
         xcpw==
X-Gm-Message-State: AOAM531ClqRya7ylvoGrgbqWcBicwsSIfXtRxktW0xf4jmDDnI5aUavM
        4orTRAeOlOP2je3cMPpzeHoxvLcZIz0=
X-Google-Smtp-Source: ABdhPJyt//b/YXy/nGLBiVvxS2dzZY6RhyzYZsSFt26EGqqDhtywqADGHeqqf+l7avElIQ0iP/OSLA==
X-Received: by 2002:a19:8c15:: with SMTP id o21mr5540443lfd.101.1608491740883;
        Sun, 20 Dec 2020 11:15:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c16sm1363821lft.264.2020.12.20.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 11:15:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-24-sorganov@gmail.com>
        <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
        <87blercju2.fsf@osv.gnss.ru>
        <CABPp-BGPZiwjSzZw5PLwkctW7hnG2S6UGHmkTGCh1BqgXJ+vEQ@mail.gmail.com>
        <871rfm95b9.fsf@osv.gnss.ru>
        <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
        <87sg82m2f6.fsf@osv.gnss.ru>
Date:   Sun, 20 Dec 2020 22:15:39 +0300
In-Reply-To: <87sg82m2f6.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        19 Dec 2020 14:59:57 +0300")
Message-ID: <87czz4thk4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> [...]
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Elijah Newren wrote:
>>> Personally, I think that a really important point to keep in mind when
>>> submitting patch series is trying to figure out the easiest way to
>>> move the code from point A to point B, not the route you took to get
>>> from point A to point B.  This is especially true for longer patch
>>> series.  It's common after you've finished a series to discover there
>>> was an easier or cleaner route to follow that would have arrived at
>>> the same end-point.  It's not uncommon for me to spend a significant
>>> chunk of time rebasing and restructuring a patch series to try to
>>> highlight such a better path.  This includes not just style fixups,
>>> but different patch orderings, alternate ways to break up functions,
>>> using different data structures, etc.
>>
>> Me as well.
>>
>> It's extra work for one person, but everyone else benefits, including
>> that one person in the future (who usually forgets why he/she did things
>> in that particular way).
>>
>> Cheers.
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> When Junio noticed and pointed to this deficiency, I asked him if I
>>> should fix all the series from the start, or it'd be OK to use fixup
>>> commit. As he didn't answer and nobody else commented either, I opted
>>> for the latter.
>>
>> Sorry if it slipped through the cracks---I get too many discussion
>> threads to pay attention to.
>>
>> Yes, we strongly prefer *not* to keep the honest history that
>> records all the mistakes we made along the way.  Rather, we take the
>> time a topic is still in flight and not yet cast in stone by merged
>> to 'next' as an opportunity to pretend that the topic came to
>> existence in the perfect shape, thanks to collective brain effort.
>>
>> It is our basic courtesy to future developers who has to read our
>> code (i.e. "log -p") to understand what we've been thinking, when
>> they want to fix some stupid bugs we will inevitably leave in our
>> codebase.  It is distracting to read from the beginning of a topic,
>> notice something funny going on and keep moveing to later patches,
>> while harboring puzzlement in our minds, then later discover that
>> the funny thing we noticed earlier was a simple mistake that gets
>> fixed, not some clever trick the reader needs to think deeply to
>> understand.
>
> OK, so I'll do it.
>

While we are at it, Linux kernel developers care enough about style to
provide script that checks patch series for issues and to insist it is
run before submitting.

I've used this script to cleanup these series for the next re-roll and I
think that having semi-automated test makes a lot of sense, so you may
wish to consider to adopt it for Git as well (it seems to have some
requirements that are not enforced for Git sources, but not many).

The script is called scripts/checkpatch.pl in the Linux kernel sources.

Thanks,
-- Sergey
