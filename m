Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8879C6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBZJ3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 04:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZJ3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 04:29:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9666E06C
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 01:29:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f41so4710122lfv.13
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHON4Y8/nReLJIecSw981J2NQDJhnf6U0KK8H872g5I=;
        b=ZN+rz5jOlwZ1WuMOsT2pmk/79Y/xlugUsHa0nk8HPxKyu1uDjyN/hM/lbWVO9IGK+4
         mINfJBDaUfwHiyDfWJg0S4icy+Wyx59JNFgPkMBwiXItFsFJYRK3RSp2g72IDZSHKFu3
         SQ/n66KUWpgjN0svIT5SbXLT70Mtd7kZ5m9kWQQB4S5PTdSZC7BzNpMBYYnFRCKybKs0
         uIhFqpIoOcmHETXxmcMZnoedgV05M0v214ejp1qKmCUaXw13BjTXMoA7qICMKaPrPVXa
         8ADLGZVKCUQj8VImxmnMO/pt16ZjfW6N/68D4Gz4nte3y1z5db5aci4BhIhRWAMYjl1G
         G7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHON4Y8/nReLJIecSw981J2NQDJhnf6U0KK8H872g5I=;
        b=es3jlzObDWMauwNyPeYhfUBqnu6v+qxM6p/Esv8ik3AwVAVW8vxp7aAmocm1A06iJa
         RNkWOT8txWS6ydG3UFXNMpeS6JGO1vJEEWdCSjYUsfZnC33FLW/x1cWlTXARzVSvL2CW
         PJZ34Q2UkHpO/lZZ6LonyTiqvXpRyyWtPyeZgVrUYGMAOkQr7wpL0AFpiZLGC7wR2+dy
         +B3GUrVSpYvRSesD6zUZQhIq0uxg2QhTJebInU7YFjEJMLhyoYp1ZbHt937fWkFrbjI7
         8ALVp61fqGuA7Nvs9cMuymVEjaPSkl0xewSr6I66co8XHCM3umtwiS3vRpB2FTsEOiDA
         q0zA==
X-Gm-Message-State: AO0yUKXz8HgwY8lBdjUbx5BKAbrLW+/hmNotOCybQy8qBJCZndCfnk7U
        O4s65NCWpy4wN20to/FitPE=
X-Google-Smtp-Source: AK7set/1hSZv37rTshU0wpHp6cIH3yGte7MrSD/hiISMAJLvfF2kKKzDrQ+o4FmiYyhgGbUNxnzokQ==
X-Received: by 2002:a05:6512:403:b0:4db:3a92:2c74 with SMTP id u3-20020a056512040300b004db3a922c74mr6809710lfk.9.1677403787403;
        Sun, 26 Feb 2023 01:29:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o5-20020a056512050500b004dc807b904bsm503717lfb.120.2023.02.26.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 01:29:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
        <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
        <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
        <87a615vkqk.fsf@osv.gnss.ru>
        <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
        <87bklilnvp.fsf@osv.gnss.ru>
        <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
        <87fsatixnn.fsf@osv.gnss.ru>
        <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
Date:   Sun, 26 Feb 2023 12:29:45 +0300
In-Reply-To: <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 25 Feb 2023 08:28:49 -0800")
Message-ID: <87lekklqpi.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sat, Feb 25, 2023 at 7:15 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>>
>> [...]
>>
>> > Please, go read at least [1] to see Johannes comments about how the
>> > prior proposals don't work beyond simple cases.
>>
>> It's exactly handling of simple cases that we need most. We can get
>> fancy afterwards, if feasible.
>
> If we can handle just the simple cases without making common cases
> significantly worse, that'd be a potential path forward.  Any proposal
> involving the diff between a merge commit and either of its parents
> (or an equivalent such as a three-way merge involving the merge commit
> and one of its parents) doesn't achieve that, IMO.

Except the method discussed does achieve exactly that according to the
evidence gathered at the time of debates, and here is confirmation (from
Johannes himself) from the reference you provided:

"This strategy, while it performed well in my initial tests (and in
Buga's initial tests, too), *does* involve more than one 3-way merge,
and therefore it risks something very, very nasty: *nested* merge
conflicts."

So, overall, the method performs well in general, and we just need to
avoid driving ourselves into nested merge conflicts, as resolving them
is beyond capabilities of most human beings.

Setting this back into perspective, in comparison to blind re-merge,
that fails to keep user changes even when no conflicts at all exist, and
even when it's applied at the same place in the history, the discussed
method is a *huge* step forward, especially if re-merge is kept as a
fallback strategy.

P.S. BTW, where this hate for using of diffs with respect to parents
come from, I wonder, provided we do use them all the time anyway?

Thanks,
-- Sergey Organov
