Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C2C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A523A60F94
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhJMNpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhJMNpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:45:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE7C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:43:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n8so12106318lfk.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=58ZsRgwfaxVJIFGdi+vQSppzs7/kyhENo4CoWHANpl4=;
        b=D8S3DX0AIcCH8B9nvZFeiJNGr91fHvEQ8QjGbp0pLh9bg+z5pIuWBz0UAEQnAGF552
         bB3rblkm3jINzatkxWrRC4bNe0nspL6ldosKJl30Q1gfsPN9rwvvUEQXy8ZZl9PpBmPz
         w+7/H/d+r52bMER8Svfr8GQjotC03XLZyTJxLtdASQxfvHOv5AEPL7c49RVokOOTJXYW
         QrtJqGazPsVB6PqXYibfrLEdZC1rHsxG8DermtighVTHiEiCHxPNgfZXw8F/UpYXPA6m
         9xUy7iVclkenD8gLQtWu8g5lhAIzYLO08FGqGBt9NHurY541a5U/g7K20SzZB5P3HjdN
         E0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=58ZsRgwfaxVJIFGdi+vQSppzs7/kyhENo4CoWHANpl4=;
        b=7IB8sFBelgtonXEtvHaWU6FIFTjbJtHMZPpq+kBzof4AfZWEqT3mHk0xF1ZPyjoRhw
         UMb7v1PQdpOHKrHxMNxOUswgXFANGMmKD6QAK250s8A1Bdz7UARwaphV/apHLWY0Kcxy
         yZwVk4tMpPzoESpT8R+zKbCEMLZY6yEYki7pky8RfxbGwk32P84MCC+l7J4VDFEvW5uU
         boa6oJWjYDwFTKdlvsZzRNIjRQsfspHggabzjfD5hNt8Zu/rwdXohsAPCvb0uj7nqhOI
         X0L6ds+z+ZsQlLOUagfhimqj0qTTzbZWEUk9vyFHNGZ3Cz7aAsiuLSCCTNuluClHYaRE
         mJmg==
X-Gm-Message-State: AOAM533TPVgk5zZngbjK3wUSSy41HeT6oWe3mLtbvCdn006W/y3ZEXqh
        F/ODSI5ogKu1TnHs2Oz+qU8=
X-Google-Smtp-Source: ABdhPJwTNUnAmLRMZooYIB7iFlNPMBafcvEo1Fguxyeh67oxh2VDZBrmWuskAy4NIM8xv4xR5OdOFw==
X-Received: by 2002:a05:6512:30f:: with SMTP id t15mr37705451lfp.64.1634132596404;
        Wed, 13 Oct 2021 06:43:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y14sm88769lfk.41.2021.10.13.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:43:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g> <xmqqo87u777d.fsf@gitster.g>
        <87k0ii446g.fsf@osv.gnss.ru> <xmqqzgre40ff.fsf@gitster.g>
        <87lf2yqevj.fsf@osv.gnss.ru> <xmqqo87til8b.fsf@gitster.g>
Date:   Wed, 13 Oct 2021 16:43:15 +0300
In-Reply-To: <xmqqo87til8b.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Oct 2021 21:48:04 -0700")
Message-ID: <871r4pujkc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I didn't ask you what --staged is suitable for, sorry. I asked how do
>> you solve the problem of saving an *entirely unrelated* subset of
>> changes for future use?
>
> Ah, OK.  I do not think I would "git add" unrelated pieces in the
> first place, so "add -p && stash --staged" as a way to stash away
> such a change would be quite foreign concept in my workflow.
>
> IOW, I'd concentrate on finishing the step I am working on, leaving
> unrelated changes in the working tree, and when I came to a good
> stopping point, I'd do the "stash -k && test && commit" dance,
> followed by "stash pop".  At that point,the working tree would have
> only unrelated changes that I can stash away with "stash save".
>
> So I guess perhaps your "no such problem for me" is the closest?

Yep, looks like it is.

For me the problem with the approach you've adopted is that these
unrelated changes distract my attention every time I select what is to
be in the next clean commit, and it gets annoying over time.

Thanks,
-- Sergey Organov
