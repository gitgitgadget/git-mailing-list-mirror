Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39070C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FCA61287
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbhDLXEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:04:55 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:42798 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242462AbhDLXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:04:53 -0400
Received: by mail-ej1-f53.google.com with SMTP id w23so7098359ejb.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 16:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ntwNZokUW1axC2/1LCr2ZmD6KXAvih50x7ocEh4GAA=;
        b=JQawbwZCr2HGDaYpjQ8YG1iL54fTbMzVn0qgtLdcDntc8Ci/7rJ6rzyH+0JDrReYZx
         CJNmAxltnG+spFjnkyBT3K0dHTt1Ppjq3gCNtuk09gzCz56kTsZG57gDWzcLIeRn0M38
         QrFs3HD2//IJVQPwq1jmy1aBP7PUgRAqPbn7hfFLd2JaNfiR0+ETz4hmgRnujWrtcC2i
         SZLH/F5yBYv6OWLmQxhCcpn9mAK2OLZ97J97/FJ4EUJG4ki3XxguLYXTo58Z4wMbYYzA
         eUKi1lPbupSwX0mycG09ZJasp4sc3QauFZ+/5J706gIPagEm4G3KHGP9Vtca2l1jKw72
         b8fQ==
X-Gm-Message-State: AOAM53343vj0/DV3z+uVzVXLn/fJ7MzZPmheDCJ2Mi12hCvremXKLcYL
        6685vWGEI4vBIvBlnX9HK44WgUJyNNPGCvzjaNE=
X-Google-Smtp-Source: ABdhPJwiwX3PfFHU0Yayl9EApxTJvGttwU0RcWO1es2v2+PgkmpB8vVU8UE8vR1op+oiKMukH6i6+tqm3kdJNMlKm0g=
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr28585173ejc.202.1618268673476;
 Mon, 12 Apr 2021 16:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
 <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com> <xmqqk0p7b3d5.fsf@gitster.g>
In-Reply-To: <xmqqk0p7b3d5.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Apr 2021 19:04:22 -0400
Message-ID: <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to test_commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The name "printf" has such strong association in programmer's minds
> > with "%" and argument consumption that the name of this option alone
> > almost begs people to take advantage of argument interpolation even
> > though it's documented here as not allowing it. Taking into
> > consideration that people often do not read documentation, `--printf`
> > as the name of the option may be an unfortunate one. Perhaps it could
> > be called `--raw` or something less likely to suggest argument
> > interpolation.
>
> The reason we want to use 'printf' instead of 'echo' is because only
> some implementations of 'echo' honors '\t\n\r' etc., and 'echo' by
> others show these literally.  Using printf(1) allows us to write
> these backslashed special characters universally.
>
> So, I find 'raw' equally confusing, if not more.

I don't care for `--raw` either but couldn't think of anything better
at the time. But perhaps a name such as `--allow-escapes` would be
clearer, or perhaps not. `--c-style-escapes`?

Anyhow, it's pure bikeshedding as I mentioned in my original email, so
not a big deal. I brought it up only because the very first thought
that popped into my head when reading the commit message saying it was
adding `--printf` was "oh, interesting; how do I specify the arguments
to interpolate into the `printf` format string?".
