Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C0C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445854AbiDVJZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDVJZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:25:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3533FD8A
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:22:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p18so4517354edr.7
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GD015F7sI4u7oYHU2T0u9nEY99bV/weMOHSBLxPfvYM=;
        b=GI40YvhhukQ1azfJHg/Qfl8azgjXajKHX/mB60zjXdLmz3Gj2zFXjxmsDTGem/WCHJ
         jVIC53y1xTQhvngfBHNmDf5UVx/FSePgv5V5BIErPNy+pdlhl7e+azy5f/2RKSQMSpAT
         pI1ewy6cTSOP+ZIyCq4XEj+zofWTV3XUxc+CBbe2NR+UH7OddUvii6a0sx3apU37XpcW
         fkUG65QzAH6HXdOEp4kmBuLBFZjDKAKvTCCoxd2dLPfyxUzH0AdzuCv59HTiH3hFyLjv
         pa7Dryx5BPcOQ4kd6zkHW2GFkq3I30SLuZO5eTIUqIN1mfjd08vH4QqFxkwmGU58QaW3
         /sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GD015F7sI4u7oYHU2T0u9nEY99bV/weMOHSBLxPfvYM=;
        b=lfYXu0lwcLe9pUSoD2DAmK1YoElAyNQcSz+JDCdmtmOa07gWYHg/E70FOxo5BBEzu+
         itjxm/R9s/TjQcrLVNO/rBaQhE8JxU3a9A9L0DSIrlrefvKO0pqQ3SDtrGP/yD/0rLwg
         xznqhK+t758TMh1sylCwP5JF16Y/MhJQPGFgt04DT7FLNx23gw6Qb8isRedNz8YcoRkG
         kWEIawKCYogKpRefR+A5RrrF/8tr5JBqbjTXgdJrtHrx+E6DqXIgLx5HCJx1lnkRQ5KA
         PjVESvVL/zeezdogdJxhP0Q3S0Ums0DZ5i1O+WSfydO11I+p6DS0h6XLsEgNUAPAEflc
         4n2g==
X-Gm-Message-State: AOAM530uiwnCL5GUFMaTLQJob1GjBJmf7h4cphvBgjPOCtcIAbdx5rQs
        jLF8zSV/Vr94394UQew2Pbw=
X-Google-Smtp-Source: ABdhPJyghy/i6a13xoDZGODl7Py/ulscCAhV0Y3DlbU8qFwiLiCgiu19nAC3Eup3epCA3BkQA6updg==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr3761321ede.327.1650619344131;
        Fri, 22 Apr 2022 02:22:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b006e87c7b8ffasm570785eje.32.2022.04.22.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:22:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhpUd-008dJE-2o;
        Fri, 22 Apr 2022 11:22:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
Date:   Fri, 22 Apr 2022 11:22:15 +0200
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
 <xmqqo80uf9jn.fsf@gitster.g> <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
 <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
 <xmqq7d7if76u.fsf@gitster.g>
 <CAPig+cSMJJem_1t0rVwjbU9SsQfBpmbE2Yn6wZeNsY=h-1MAkg@mail.gmail.com>
 <xmqq5yn2dppk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5yn2dppk.fsf@gitster.g>
Message-ID: <220422.86czh95v74.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Apr 21, 2022 at 5:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> > Any of
>>> > the following would likely be less confusing (in no particular order
>>> > of preference):
>>> >
>>> >     * sed -i .bak -e '...' "$path"
>>> >     * rename dance
>>> >     * perl -pi -e ...
>>>
>>> That order happens to match my preference, but if the first one
>>> comes with a comment to dissuade readers to copy-and-paste the
>>> construct to other places in our code, that would be even better.
>>
>> Bikeshedding: I think I would prefer the rename-dance over a lengthy
>> comment meant to dissuade people from copying this non-portable usage,
>> especially since people often fail to read comments. The rename-dance
>> idiom, on the other hand, can be cargo-culted without harm.
>
> Yeah, that is fine, too.

I just used the rename dance in the updated v3:
https://lore.kernel.org/git/cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com/
