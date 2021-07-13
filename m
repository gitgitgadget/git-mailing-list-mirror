Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F58C07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 02:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E160611F1
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 02:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhGMCZZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Jul 2021 22:25:25 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:43812 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhGMCZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 22:25:24 -0400
Received: by mail-ej1-f42.google.com with SMTP id v20so38517349eji.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 19:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4826MJDXNiglg8mNARzTDolDbX4648o+WCwvfORvFcA=;
        b=Ko4oEa8psXRA3U8HfVqEDPAQ86IqYHHliQk19EWQm1zsluwQpZ6YyRl70yUp6Tswtw
         W6HhCsSZchRJwJx65PSeqm8wJZ2hRLXH2Kv3xPpsa99rgjPMA1A8j+NSurLPyV8MfWMq
         HD/Q2MZuQdjPaHaxzvlwXOoa2HQxzDQlNKeTjrdn273NFnNGUjBxMS3qCyEul/WNEbHS
         mBQaBr1yCcyAedDnlmjnTUIBn+CPCrmd0uW3ld/UBlrPgKdHtDk8vK9l7TxMKId8areW
         ar5hCGIr0G2/0DbnB9RKevacWViMMSW0X/lktQP9k9Rkh/u3FayLdZdyUvA6kX0zOQyT
         uOYw==
X-Gm-Message-State: AOAM530NZWhJ3AkeBXsjNHRQRz2+WWM40kyfJCupzGnvZ0WeBzv5dq/7
        oPswhNCoYq9sqJeWBtOEO89rU55Xcl4Q996YGww=
X-Google-Smtp-Source: ABdhPJyW5rFOshH0bc9PqlBqa2XaHwD8bc9gvoLRvexxQemXTxwGsTfYMuFKSPYhT6fOKaiZE4Yo/YunDSUw/mmzG2w=
X-Received: by 2002:a17:907:33cc:: with SMTP id zk12mr1581682ejb.168.1626142953127;
 Mon, 12 Jul 2021 19:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210612165043.165579-1-lenaic@lhuard.fr> <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr> <87h7h75hzz.fsf@evledraar.gmail.com>
 <xmqq5yxni2rn.fsf@gitster.g> <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
In-Reply-To: <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Jul 2021 22:22:22 -0400
Message-ID: <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 8:16 PM Jeff King <peff@peff.net> wrote:
> On Tue, Jul 06, 2021 at 01:52:12PM -0700, Junio C Hamano wrote:
> > A helper function that takes a string and returns a strvec would be
> > a good fit, though.
>
> I was going to second that, but I see we already have one. :) Dscho
> introduced it in c5aa6db64f (argv_array: offer to split a string by
> whitespace, 2018-04-25), and then it later became strvec_split().
>
> And indeed, Lénaïc's patches use it elsewhere. I think it doesn't work
> in this instance because it can't take an arbitrary delimiter. But I
> wouldn't at all mind seeing it grow that feature (and I suspect it could
> even share some code with string_list_split(), but didn't look).

Since Lénaïc is a relative newcomer to the project, can we, as
reviewers, be clear that we don't expect him to perform the task of
generalizing strvec_split() just to get this series -- which is
already at v7 -- landed? I gave the previous round a pretty thorough
going-over and -- aside from one minor test-time bug -- didn't find
any show-stoppers which should prevent it from landing. While it may
be the case that the series has a superficial wart here and there
(such as #ifdef's in function bodies, and non-ASCII fancy comment
boxes), the review comments on the latest round have pretty much all
been subjective; I haven't seen any outright actionable observations.
Extra polishing based upon the subjective review comments can always
be done later atop Lénaïc's series (if someone -- not necessarily
Lénaïc -- wants to do so) without asking him for endless re-rolls.
