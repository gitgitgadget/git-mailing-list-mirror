Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E4C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA520771
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHLQj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:39:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50494 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHLQj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:39:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id c80so2353759wme.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 09:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTrrSrSiWhzkth2qPFTgSkt0TBnILq7IFTR8RUQ7Otw=;
        b=eG7JrgRu9ULrpWEeBfTwQLTZnQzWmG4H+SZFF+jDwSN8CTRq8JOdwiN2ItnNksrESe
         0eERgZ86JrCVaLFUt/mOpzml7fPeqESkfAONlPkIYO3qvUK1zfmasa2NgpMdayNFjKyl
         ysdftlpPekHUQgKCxnIQIPrd4Epx4cBm8yAEHzV1r65fahGoFoY7PsKFDiYUo5lQOKPt
         xmd55DNDS7e6c2xLe1gLPUiz0mkRcrS1+iZOBMSKg1Ky2TcmwEuARB1MNCBsqAEzCOYS
         m1yS1cB2LJkD/aa0Mzep96yYorrfyIA41fdincxSmp4DAw0BvYKr2qgvAnm+8gh56uNC
         D4pg==
X-Gm-Message-State: AOAM533xUcxH45qNTGzYHpfBvLIZELTjjIdhl7gnxc/wD69XFsjsv7vW
        qYbZnyMcX1SJO3ICso5pECGxTww5FFQG+ligynI=
X-Google-Smtp-Source: ABdhPJzl+Gxb20K3h9ULsEmLMFVL2NUzUo2uL6UL5zk4zphsb2UHLtxhGdRX9RO6+4sb8S57Mh3T/A9XsQMVLqAFWzo=
X-Received: by 2002:a1c:39d4:: with SMTP id g203mr512347wma.107.1597250365105;
 Wed, 12 Aug 2020 09:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <20200811183258.GB33865@syl.lan>
 <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
 <20200812153705.GC33189@coredump.intra.peff.net> <CAPig+cQNvJ02fm82oBtyyxHUqfNk3oAZJW__Lu2Kn0Qt3VaDWw@mail.gmail.com>
In-Reply-To: <CAPig+cQNvJ02fm82oBtyyxHUqfNk3oAZJW__Lu2Kn0Qt3VaDWw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Aug 2020 12:39:14 -0400
Message-ID: <CAPig+cSzLcVdzjoacm6=7mDAhUn8j06Z0LXo7r1LMC7Dx_2JZA@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 12:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Aug 12, 2020 at 11:37 AM Jeff King <peff@peff.net> wrote:
> > I don't think this is an error. The program can tell which you meant by
> > the number of arguments. POSIX lays out some rules here (from "man
> > 1posix test" on my system, but I'm sure you can find it online):
>
> I intentionally didn't focus on or mention POSIX in my response
> because I wanted to represent the Real World reason why "x$var" is
> such a common idiom. [...]

I probably should have done a better job in my original response to
Taylor to make it clear that I was talking about Real World (even if
old) rather than POSIX.
