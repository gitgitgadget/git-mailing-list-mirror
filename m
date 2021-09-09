Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C222C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DA961168
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349215AbhIIBhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIBg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:36:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440BC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:35:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc21so181951ejc.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IPtpRE4twChi5hnU5UZJrxbZFIXoeVCzb6YL4dAf1bM=;
        b=M6QqE6UDwpXbQqK2h1rH7XYfYEHvnCnTUmiUKSPilocM+6p89M7ouUMkYT0eUeszA9
         sPP37cOsFjt6YTN4Fg+B64eQoK7ZtCMLFZnHJXJg0TtKgZBLMtZ1FdxQexjY7MCbQ6cT
         YcuACqUJSsZpkHnsed31/ZKTDZwOHJFtnMCLll01KCBe2fk6VpApcYtYSu1e2wk7xklG
         lu6vzxft69TBY0wsr2HWhbm3kYksRVAafWpMqyWx2P/7W93sYWmNsmopdVh5IN2hL5Qo
         /WO4yB8r+lX/yEnKZAhYqlmEmonFRCmCci5xNmjmP8quLxN2AZQ2aVOCro1ZnDcSglOc
         xtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IPtpRE4twChi5hnU5UZJrxbZFIXoeVCzb6YL4dAf1bM=;
        b=lE045UO7tiBOA5hMQwajRjwfcJ6srS0EYTydZ3BFEPYDwMHMjyYquwb7CKszjhvawo
         wkIxiUHGWR5ntu4vHTqlVqfq1EELRf62cFosA09WnILDjQmctY5rg7gNUYE4eY4t9C4K
         iRGqGc5mdZH93v8KbQM/R0aGfM2ICFNh1qWALqwYobS1AtMbKEfKwuNqMKt4RziGmAqQ
         xa47+oBKXkmpqCOza3qVKK1PTj3Zs9AEKliz5eC0GRH5Hp1g32Yzk+EIs0vMXoRiI7Fu
         1pSIDAnRgPzcRwkCoWPOZRTAp8faFRfFAS+H9ilB0pmbiu2dSR+1x1Xga0qMc/bYIhzb
         V01g==
X-Gm-Message-State: AOAM530qCYbZqbUiGZECdvcJ9mhp4evotVE/T4pdI0riOpjFvGhniqw9
        nln7IoLHmdfnA8eQ8/hsxu9u7KS2sPMSYA==
X-Google-Smtp-Source: ABdhPJwd1YlXqxIAyeFNN7Gud1F3zn61wiFxpzgssIZmxIFF7sibCoDF/8SfgqPrlyAskfAH8DMFxw==
X-Received: by 2002:a17:906:f24d:: with SMTP id gy13mr613502ejb.395.1631151349453;
        Wed, 08 Sep 2021 18:35:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lm21sm84181ejb.58.2021.09.08.18.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:35:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Date:   Thu, 09 Sep 2021 03:33:02 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
 <877dfqhb8n.fsf@evledraar.gmail.com> <8735qeh8h5.fsf@evledraar.gmail.com>
 <YTlfp/tRmNy0kt+b@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTlfp/tRmNy0kt+b@nand.local>
Message-ID: <87y286fs3v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> On Thu, Sep 09, 2021 at 02:50:59AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > On Wed, Sep 08 2021, Taylor Blau wrote:
>> >
>> >> Here is a very small reroll of a couple of patches to make sure that =
packs are
>> >> not read before all of their auxiliary files exist and are moved into=
 place, by
>> >> renaming the .idx file into place last.
>> >>
>> >> New since the original version is a patch to apply similar treatment =
to
>> >> index-pack, as noticed by Peff in [1]. This should be queued before =
=C3=86var's
>> >> series on top.
>> >
>> > I read Junio's earlier <xmqq8s063m7m.fsf@gitster.g>[1] as a suggestion
>> > that we combine the two into a singe series. I do think that yields a
>> > better end-result, in particular your 1/3 is much more readable if the
>> > refactoring in my 2/4.
>> >
>> > I'm mot of the way done with such a rewrite, which also incorporates
>> > your suggestion for how to manage memory in rename_tmp_packfile(), but
>> > I'll hold of on what you & Junio have to say about next steps before
>> > adding to the re-roll competition Junio mentioned...
>> >
>> > 1. https://lore.kernel.org/git/xmqq8s063m7m.fsf@gitster.g
>>
>> I've got that at
>> https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-race=
-3
>
> Beautiful :-).
>
> I mentioned in my response to [1] that I missed that message when
> sending v2 of my series to fix a couple of these races. And I was even
> happy to unify our two series, but you did all of the work for me while
> I was eating dinner. Thank you!
>
> I fetched your branch, reviewed, and am happy with the result. So I
> would be content to apply my s-o-b to your patches and resubmit them as
> a unified series.

Sounds good to me, also in particular any typo/grammar etc. fixes to my
changes are most welcome, I tend to sneak those in, and any code changes
you see fit of course.

> But I did wonder if you wanted to include [2] in this series as well.
> It's kind of different, but also related enough that it probably makes
> sense to just pull it in. So I'm inclined to just do that, unless you
> have any objections.

In this latest push-out of "next" Junio's merged that one down already,
see 1972c5931bb (Merge branch 'ab/reverse-midx-optim' into next,
2021-09-08).

So I think at this point it could be built on top of that, but given
that the two don't conflict in any way (textually or semantically) it's
probably better to base this larger topic on "master" and proceed with
them independently.

> [2]: https://lore.kernel.org/git/patch-1.1-366ba928bd-20210908T010743Z-av=
arab@gmail.com/

