Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D421F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeFZVmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:42:47 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34624 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeFZVmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:42:46 -0400
Received: by mail-yw0-f195.google.com with SMTP id n187-v6so3166335ywd.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NshcWC8+5Gbvd6AUMhfRCHSz5NX8Z3van6r4zTJ2HZU=;
        b=bztsuVOgQ6Wk3e9AQTPrk4k23Cbx+GX90zip1IdTdU+SabY15Qjns2bOKSuAaJsE8/
         ASZdSF1cQLWy3AeYhDUnmCdSenkyewc4+Ousb0pjLigLHuAyoyp3PvuhH80Im6l3Rhlu
         J7hX8Rj6422YMFWkDX6RKdhUnIqqxcGPlugV3JReZdX51i0KmLu3Fb2h48ZtOw0h1CHU
         LXnz/Ea0npNm3WWb2Z9Bm1ehwDo5TwtRBdHISMiP3I8RJwO5IhWrkoi+cvAZ7cBvmsFh
         +0eYDaWZ39yD331D4gjqW4zi1ln+SY17LYzth9AaLrJPI4CUYekTvdqBMRnxZrJzE5Ba
         lukw==
X-Gm-Message-State: APt69E3fPNN/AuDv0zMsoWPQrx384mwtjTo3ojPM5TD16YXkQKrbS1az
        pKM8LqjWVMk4sbvURsSAqsejl/HFwHZbfKXh8ak=
X-Google-Smtp-Source: AAOMgpeqiFY6EBaQYK/DsaFBwalsZH0H9Rg1p1Og8wi34ZlbPJvCBzmRYUWala3HMPha4Co4k2z0b8TxQRmK8jx442k=
X-Received: by 2002:a81:7b42:: with SMTP id w63-v6mr1678589ywc.70.1530049366305;
 Tue, 26 Jun 2018 14:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <20180626202244.GB2341@sigill.intra.peff.net>
 <CABPp-BGP2OFYgP5Xm0PMj_NPH2f_UmtMpoHYzcgo544V0e-_Zg@mail.gmail.com>
In-Reply-To: <CABPp-BGP2OFYgP5Xm0PMj_NPH2f_UmtMpoHYzcgo544V0e-_Zg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 17:42:35 -0400
Message-ID: <CAPig+cTc2XVX18ocv6ALOSA2CwM8aQLWW+mRWL6Pj1Wu_QHDHw@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 5:33 PM Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jun 26, 2018 at 1:22 PM, Jeff King <peff@peff.net> wrote:
> > Another option is to not enable this slightly-more-dangerous linting by
> > default. But that would probably rob it of its usefulness, since it
> > would just fall to some brave soul to later crank up the linting and fix
> > everybody else's mistakes.
>
> This may be a dumb question, but why can't we run under errexit?  If
> we could do that, we wouldn't need the &&-chaining, and bash would
> parse the shell for us and exit whenever one command failed.  (Is the
> reason for this documented somewhere?  I couldn't find it...)

I'm not sure if it's documented anywhere, but it has been discussed.
In particular, see [1], especially [2], and [3]. Peff summed up by
saying:

    So I dunno. I think "set -e" is kind of a dangerous lure. It works
    so well _most_ of the time that you start to rely on it, but it
    really does have some funny corner cases (even on modern shells,
    and for all I know, the behavior above is mandated by POSIX).

[1]: https://public-inbox.org/git/xmqq384zha6s.fsf@gitster.dls.corp.google.com/
[2]: https://public-inbox.org/git/20150320172406.GA15172@peff.net/
[3]: https://public-inbox.org/git/xmqqoannfu84.fsf@gitster.dls.corp.google.com/
