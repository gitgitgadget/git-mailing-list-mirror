Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96DC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08CA207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIRUM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Dec 2019 12:20:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 12:20:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so17049259wrj.12
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 09:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JW5kgw1u4V2sgNP8BENBKJyEd4CMkm8xNjkOuOx+OQQ=;
        b=dvJK+bIxnCGCWZEgB1m9BV7l9fzG9dhCd+kUJtNe/fDnyfx0FlsktmOgeN/QP9OPbo
         eDiaYyAO1I/spWs1kqjdDLj1Clyxcp/XOkSdmJtCT4ilqqtWWKF6FYpe1AFKWUjT+xyS
         7rtjriyn/7uRNvrFwm32Xpr5BB97sHYHn/+BvEnb7avTBIiVQVsV6fkHUxz91e9cREJG
         y+f6tFttwSYmjJF+e7JBa/mu88GY/hBbdTZ4V/+VyerAMB9TqoUYagEUWUDkpp2phqvj
         jTqqWoJRru0QJv6fPA03Bij8sWjs/qrpb+r3OYwk+AYdix5EO53xqhBVvARGA4rlSVIL
         Bl6A==
X-Gm-Message-State: APjAAAX1MB82bpwkjlw0oECviQ4kyYK3D2F3KF3dGFOWbFOZp8kGYlcm
        sJys9Hty/C+9VThojvEWZfvbvI+GSd5M+wheUEo=
X-Google-Smtp-Source: APXvYqzq6366OfWALHhS/AN8nkAX7rG3nEidk36kugthuyuGXwnqsXJlXZzxRUnvuhvVU2aDY0yure08EktQErydRxY=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr3471248wrv.308.1575912010307;
 Mon, 09 Dec 2019 09:20:10 -0800 (PST)
MIME-Version: 1.0
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com> <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
In-Reply-To: <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Dec 2019 12:19:59 -0500
Message-ID: <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 12:11 PM René Scharfe <l.s.r@web.de> wrote:
> Am 09.12.19 um 16:36 schrieb Derrick Stolee:
> > René Scharfe  0bb313a5 xdiff: unignore changes in function context
> > xdiff/xemit.c
> > 0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
> > 0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
> > 0bb313a5 225) xchp = xchp->next;
>
> Hmm, line 223 *is* exercised by t4015.85.

This, along with Dscho's[1] review of an earlier coverage report,
makes one wonder if there is some off-by-one error in the reporting
logic, such that it is reporting the wrong lines as not covered.

Footnotes:

[1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet/
which, among other seeming anomalies pointed out by Dscho, showed a
closing brace '}' not covered by a test:

    > Johannes Schindelin 867bc1d2 rebase-merges: ...
    > sequencer.c
    > 867bc1d2 4539) }

    Not sure why this closing parenthesis isn't covered :-D
