Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6041420248
	for <e@80x24.org>; Wed,  3 Apr 2019 12:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDCMGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 08:06:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36989 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCMGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 08:06:30 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so10783756itc.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t62H0gDXzrbsyNWsdv6Vq+lAPqnQ/kOGBK56qSvPdSY=;
        b=R5/3Pi4TIZ7ZxFhr1D16Ky4I14a+QwWDlhK4M+XSOG/kkSvXjf1qB0BMjknqkuWCTD
         j8BIbsTt5BIGEsr5jDrjYPatxWBa46mDrKNAdrIEdDpIGz42pOeKw+GOCm9sJRknbHT3
         nxo8Q51XjelUPUrk18VNdvmknn6AO7RSqibhsG8FmHiXqBWNVvrwMN1NKQPM5UF+XSOE
         c5OXGGZ5Sb/vJTPfPeAnpVGJV7/4IVv9eq9aOZC6aV9hTCMK3eH239vJ2L2yAJpEJtQq
         GN9pUdAJjb/KMhJBsMj0/GycARv5XKQX0g27yiHUThb6Li82MZqRoYryG+Q2pfOFD0Rd
         KStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t62H0gDXzrbsyNWsdv6Vq+lAPqnQ/kOGBK56qSvPdSY=;
        b=FTAn8Y+tAtT1sc5arwBRQIxSlf+8kDGNCKlY4viDsuAN9RAKSmZDANT0B8fTkQHeU5
         pURwW5ISq5PTiA+7Sv476krBGJlai82il9z5GSsbhfFxIkPRxRh7R5bXbOE2uovghFGg
         m2BvpfUkR6ZMm4esrr5/V7+6YHCR6BUAK7v9pJsB0hD08tTI3WLgKpoSTvacrA81mL4E
         kqPKxUKBmoocW8c0XbuBwnKLBb4BDM3Q3bIziQ6o1E5X0D2eIaegfUDMno32wjllnRyE
         J6e2WbgPt7viZZluGuFXCpjrsQWKO41ZVcCjGjEOmchSva+4Cqhm1nwq5kFGIshzkdvr
         g7EA==
X-Gm-Message-State: APjAAAXuXHvoaZt92k8VVgPden8wptfopv4vzc6oYeBLrwvR5uPf0cY6
        vZ6sRLOVwz2g7TCuTFi7U5QyaFB20llOcpuX2LY=
X-Google-Smtp-Source: APXvYqyR3OZrUbYNJ7COqi1AdmOT0LlHZZvF/BBb/K6gCDa4t0PbjDmH7HSfufl8fckHfg4b8BcfZe5Gy4e3Q4LFiT4=
X-Received: by 2002:a24:4755:: with SMTP id t82mr1460353itb.72.1554293189041;
 Wed, 03 Apr 2019 05:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115625.21427-1-dak@gnu.org> <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com> <20190403113604.GA2941@sigill.intra.peff.net>
In-Reply-To: <20190403113604.GA2941@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 Apr 2019 19:06:02 +0700
Message-ID: <CACsJy8BCGHqjO5fKG7TO5X239z_7Gzdo80jF0rx939X501yVnA@mail.gmail.com>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 3, 2019 at 6:36 PM Jeff King <peff@peff.net> wrote:
> I suspect we could do even better by storing and reusing not just the
> original blob between diffs, but the intermediate diff state (i.e., the
> hashes produced by xdl_prepare(), which should be usable between
> multiple diffs). That's quite a bit more complex, though, and I imagine
> would require some surgery to xdiff.

Amazing. xdl_prepare_ctx and xdl_hash_record (called inside
xdl_prepare_ctx) account for 36% according to 'perf report'. Please
tell me you just did not get this on your first guess.

I tracked and dumped all the hashes that are sent to xdl_prepare() and
it looks like the amount of duplicates is quite high. There are only
about 1000 one-time hashes out of 7000 (didn't really draw a histogram
to examine closer). So yeah this looks really promising, assuming
somebody is going to do something about it.
-- 
Duy
