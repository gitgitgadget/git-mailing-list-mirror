Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98648C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBOWU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBOWU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 17:20:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDB360A1
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:20:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o36so215613wms.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tueHF1db1hl0RclGG+F+ToT1LvYa0rjUYtJ6g0hwzB0=;
        b=lSiewmyTo5d/WVJ1RyIM4bPF4ZCtaoHggwJ0XF02QYqP4HH9lzDKGesf1TpFY6+/0x
         LwBA0fNTmaEumscUmj6M4D2H2AshxFi6AV/okC+Txi6zjoa2/LLSYo0rEIlNt9/gywgy
         az/T8oMN6Uyx6tak57g3mMW7UaaUwmDcsKFG7WGuVwIaw+LcXH2wzsfoHP22gIEsJwa5
         8wepqbfAsHyXjJKWV7IJS8wZP748s/RzU1jGsSW1goAtNIDMQmWQIrGrKpDsqoH15khE
         MQhigYEV2j31WZc9yn8WzVXnWv9mFt2SGGmrZUyIu6TtmCgpHI7o+mSwXNAHmlg3wnl4
         xG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tueHF1db1hl0RclGG+F+ToT1LvYa0rjUYtJ6g0hwzB0=;
        b=BFhIDUeCzMA/xCcEQIWguNu30noaF2eQgfokTscqqo5HeIOB2a3z6LCTcGcuWzKfoC
         wPZ9BxgAegdJhqhNlqBpsfsFzh5KjkilTLZpJ7O5AeHANG9zcfMbQWZm7zvfn2EnLKX8
         cMOUwlrQRRQUwHvdxfcckYHm3L7pNHmFkVKLMpcuTCKLXaLPmgQh6ChOsJCypmCOw8+x
         cAWHy4PkbyKNxZ32Xy4D5eskeP9vYGE5aeabDe383zoeUAWrS84lZ3RvzzRpY1W1ttgT
         K0TYqGJCjFhW3hxB2pFJ0Lbt8bdvXlc2HDi1moXWSzaK+kBlSh3VpkzQiiLQ8LQGwOxw
         X8jA==
X-Gm-Message-State: AO0yUKX8ridjbPWXddYECNkIV2UF7j15FwIDIUc8lbJBzaEcnqAoam+Z
        nqLUNImq/UTEB8aYKyD0HQc=
X-Google-Smtp-Source: AK7set/KImrjUvvZ7dMz0nHCWnOR4Tr1ZQr8ETCyDdBVhXPRhQT8DylkXMliNrSEPr6Kjj8VIloP0w==
X-Received: by 2002:a05:600c:2b0f:b0:3dc:1054:3acd with SMTP id y15-20020a05600c2b0f00b003dc10543acdmr2954703wme.17.1676499620857;
        Wed, 15 Feb 2023 14:20:20 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003dd1bd0b915sm3557364wms.22.2023.02.15.14.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 14:20:20 -0800 (PST)
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out
 elsewhere
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
 <CAPig+cQPVMKui=AiXBHEfNWY5e4fMbxixdnzvZmXsSkW9ZMLyg@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <1008f790-d2af-3b1f-50a3-6ce27f3b3df4@gmail.com>
Date:   Wed, 15 Feb 2023 23:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQPVMKui=AiXBHEfNWY5e4fMbxixdnzvZmXsSkW9ZMLyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-feb-2023 23:52:08, Eric Sunshine wrote:
> On Sat, Feb 4, 2023 at 6:02 PM Rubén Justo <rjusto@gmail.com> wrote:
> > Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> > have a safety valve in checkout/switch to prevent the same branch from
> > being checked out simultaneously in multiple worktrees.
> >
> > If a branch is bisected in a worktree while also being checked out in
> > another worktree; when the bisection is finished, checking out the
> > branch back in the current worktree may fail.
> >
> > Let's teach bisect to use the "--ignore-other-worktrees" flag.
> >
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > @@ -122,6 +122,29 @@ test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
> > +test_expect_success 'bisect reset: back in a branch checked out also elsewhere' '
> > +       echo "shared" > branch.expect &&
> > +       test_bisect_reset() {
> > +               git -C $1 bisect start &&
> > +               git -C $1 bisect good $HASH1 &&
> > +               git -C $1 bisect bad $HASH3 &&
> > +               git -C $1 bisect reset &&
> > +               git -C $1 branch --show-current > branch.output &&
> > +               cmp branch.expect branch.output
> > +       } &&
> > +       test_when_finished "
> > +               git worktree remove wt1 &&
> > +               git worktree remove wt2 &&
> > +               git branch -d shared
> > +       " &&
> 
> As mentioned in my review[1] of one of your other patches, &&-chaining
> within the argument to test_when_finished() is probably undesirable in
> this case since failure of any cleanup command would cause
> test_when_finish() to fail, which would cause the test to fail
> overall.

As I said in my other response, if there is no argument against this
change, I'll reroll with it.

Thanks.

> 
> [1]: https://lore.kernel.org/git/CAPig+cQpizjmhmDKb=HPrcYqqRq7JpvC-NZvY7B9eBbG+NrfKw@mail.gmail.com/
> 
> > +       git worktree add wt1 -b shared &&
> > +       git worktree add wt2 -f shared &&
> > +       # we test in both worktrees to ensure that works
> > +       # as expected with "first" and "next" worktrees
> > +       test_bisect_reset wt1 &&
> > +       test_bisect_reset wt2
> > +'
