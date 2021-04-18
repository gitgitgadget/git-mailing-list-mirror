Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABDC433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0081C61207
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDRFMP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 18 Apr 2021 01:12:15 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:33446 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRFMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 01:12:14 -0400
Received: by mail-ej1-f50.google.com with SMTP id g5so41254198ejx.0
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 22:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6njVm9YZbS7uazB9Kvw2nxzIWySeRRsnas5xMqr49pQ=;
        b=Ez8ALyTswLVQ2NO0dEIsGMrLRkM+YgNB6+uGTc/BPXw7ej48XiBKqqYWJxSR2DdVto
         fXaLXYi3XXKnztctDHc73yGGlkpTDbUTJyYh4/Jp+zecn/Ob0sXGkpNi8yyRvrZpFqVZ
         lIeLO9Tt8UZvS4DB42OZYoqshXIzcOqERY/iNpFkILCO8HUVfYOQ0z4OhtNyd+L9m2ea
         DWR5hVfISMOsOslfR69IzqA+WYNG2wi0YNftW4piiErpwd0BnHYOoeiYrhxUUGqrpNcq
         Nu9/1o2ZrK5hPS52BMvKrQijzZhvTjgt9U4i+Jj3awWTMmBMQmwR56Dai5OK1D5pItZu
         zZEA==
X-Gm-Message-State: AOAM532vEjkUK9xJZ9PScxgN3e7HPuf67XqvMxgllQHwQI5muCsDq2JR
        jv524gPjWwY3dHnQfxKif3ajNNIDahQ694OfWRk=
X-Google-Smtp-Source: ABdhPJxZeOP0fBcpzz6K59H/vFiB9Q1jcyX9skxHYB6AodWX8oEnS5ka5W96bjWfKyjXZwA3k01u0tJ0IopaJkgHIDk=
X-Received: by 2002:a17:906:37d7:: with SMTP id o23mr15692124ejc.202.1618722706354;
 Sat, 17 Apr 2021 22:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com> <patch-2.3-6f9e09a2017-20210417T125540Z-avarab@gmail.com>
In-Reply-To: <patch-2.3-6f9e09a2017-20210417T125540Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Apr 2021 01:11:35 -0400
Message-ID: <CAPig+cSR_y4uqPnYt+P4EFxPrhN8LHDjLX=_5uJFWYbL1skixA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert and amend "test-lib-functions: assert correct
 parameter count"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 8:58 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> The goal here is to get rid of the verbosity of having e.g. a "test 2
> -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
> to intentionally feed the "test" operator too many arguments if the
> functions are called with too many arguments, thus piggy-backing on it
> to check the number of arguments we get.

My one concern about this change is that it enters the realm of
"huh?". Although it's dead-simple to understand what this code is
doing:

    test "$#" -ne 1 && BUG "1 param"
    if ! test -f "$1"

the replacement code:

    if ! test -f "$@"

can easily lead to head-scratching, wondering why the author chose to
use "$@" rather than the more obvious "$1". This sort of unusual local
idiom might normally deserve an in-code comment explaining why the
more obvious code is not employed. However, adding a comment at each
site would be overkill, so it might be the sort of thing to explain in
documentation somewhere ("In order to make -x output less noisy,
employ "$@" rather than explicitly checking function arguments when
writing new test functions...".) Otherwise, the reader is forced to
consult the commit message.

Not a major objection; just voicing the bit of unease I feel about it.

> This does not to the "right" thing in cases like:

Channeling Dscho's inner Eric Sunshine[1]: s/to/do/

[1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103222235150.50@tvgsbejvaqbjf.bet/
