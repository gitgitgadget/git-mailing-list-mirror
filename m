Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379932AbiAaVR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380406AbiAaVRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:17:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0FC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:17:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l5so29402051edv.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YCHXHPcaCA5/lSdkPIUE/zGVl+tTDbP/VWZ1F0WdcDA=;
        b=LrMkuE7CRJcWBE3YuNdXXvjbqvqFZDKN+a8fJ15HOtpd8lXH6bsT1Lf0u+1zsJsBtQ
         anHnM4rkMQDt5FxGNHimjUNSu7qhyIJNCoSl/b0AXoxB5FJLZrO6M/s1GeUqBovVfSbo
         f408jM+x9xXPdm4TCgUoU/kD9BMd4itfWOy5/YAsVnYqFH5pF0hTgVq0VHIAFQsQdWGX
         ORm+Kpebg97V9Tv0kJ1dbs56eCUJykx0jh6tbpoQtUHvAZwK7slQRrt8P1R79t2mnhuQ
         K/HIVwuontIR7KMFr6AC571NlU3ARl21v3raoPic3KA0sBUnt7T6u9Xsbljln61D0CGO
         47Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YCHXHPcaCA5/lSdkPIUE/zGVl+tTDbP/VWZ1F0WdcDA=;
        b=iNv9VCF/2OQ9gPJ8EWxeIxRrWj5w3gT5sbj9Njm+ofpEXVOQ5lUUtEtJ647Atq48Ic
         PoxpduXllCZZNQ3pnxpt/Da0LCHthhViwQDbsTEMdWVoKZG9MMXHNmNubJtUkTxLzr6K
         ALYXrReRxPprki1XdoU3Axp291AaFBMeHsMxxoNxTQTWjuEud7/wDnhfrdwdCl9WgnmE
         Q5Xp7lRTWJxwJzzXipXOpfpvlDzEbfnHtKfmwwTdcGSBcdd4lrKvymhXagc1Ec74k2iy
         mhQAd03+g0TQG9IgylWrvMzKejGFrrHFa1wx+5/ve3AhaVkNdsD1QM9aEu0lWbZeaCjT
         w9dw==
X-Gm-Message-State: AOAM530VIvHxe1JutJMp8gZn2a2xugcUnmlbigfNxG2TEKf39dweQTh3
        hffmefygoBusMAqVJfQ7a/0=
X-Google-Smtp-Source: ABdhPJxTG99Px9I6aytiKlXkIRi9BDkVpxDkrVdgJabHqODMMB/yj3LDImy6L5TNNODW67IiGflzrw==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr22375476edd.290.1643663867233;
        Mon, 31 Jan 2022 13:17:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f21sm5676598ejc.22.2022.01.31.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:17:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEe3W-003sSc-3B;
        Mon, 31 Jan 2022 22:17:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Date:   Mon, 31 Jan 2022 22:03:18 +0100
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
 <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
 <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
 <xmqqfsp3kfm0.fsf@gitster.g>
 <CABPp-BHcS3nwupJSORUuVeVhGzrL3VqPm4YQSr7G-JuyLaqBpQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHcS3nwupJSORUuVeVhGzrL3VqPm4YQSr7G-JuyLaqBpQ@mail.gmail.com>
Message-ID: <220131.864k5jbo5h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 31 2022, Elijah Newren wrote:

> On Mon, Jan 31, 2022 at 8:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> >> I.e. =default should always be equivalent to not declaring that config
>> >> at all anywhere, and not drift to being a reference to some name that
>> >> happens to be "default", as in the GNOME case.
>> >
>> > No, we have the same problem as the Gnome case.  See this part of the
>> > documentation for fetch.negotiationAlgorithm:
>> >
>> > """
>> >     The default is "default" which instructs Git to use the
>> >     default algorithm that never skips commits (unless the server has
>> >     acknowledged it or one of its descendants).
>> > """
>>
>> That looks more like one of the bugs introduced when skipping was
>> turned on for the "experimental" folks.  To fix this, without
>> turning skipping into the default too hastily, there needs two and
>> half things to happen:
>>
>>  * Give a new name for the non-skipping algorithm, and describe the
>>    algorithm like the above.
>>
>>  * Describe "default" is "non-skipping" but "feature.experimental"
>>    makes "skipping" the default.
>>
>>  * Support "non-skipping" in the configuration parser, so that even
>>    when something else becomes the default, people can choose it.
>>
>> I would think.
>
> Sounds good to me.  I'm not very creative, so I think I'd just use
> "non-skipping" as the new name.

I can't think of a better one either (aside from my already-suggested
"exhaustive"), but that's naming it in terms of the only other
negotiator.

Is it the case that the only thing anyone would want to tweak about the
default one is its skipping behavior?

E.g. if we were to make one called "smart-topology" or something (would
skip sending some OIDs by assuming things about branch/tag topology,
i.e. if you have X that probably includes Y) having negotiators "A",
"non-A", and "C" would be odd :)

We're unlikely to change the "default" negotiatior behavior at this
point, so maybe some label that communicates "the old one" without
implying deprecation? Perhaps "classic"?

