Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C1C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4259920792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHEKER (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 06:04:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHEKDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 06:03:53 -0400
Received: (qmail 11644 invoked by uid 109); 5 Aug 2020 10:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2020 10:03:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21434 invoked by uid 111); 5 Aug 2020 10:03:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2020 06:03:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Aug 2020 06:03:51 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: racy test failure in tb/upload-pack-filters
Message-ID: <20200805100351.GA2126375@coredump.intra.peff.net>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
 <CAN0heSqsHGL2Pb37d2dWL+RCWac4z8mjpM-v6v6zsxH_8cWQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqsHGL2Pb37d2dWL+RCWac4z8mjpM-v6v6zsxH_8cWQjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 11:27:22AM +0200, Martin Ågren wrote:

> > In theory we'd see both copies of the message in the second case. But
> > now always! As soon as the client sees ERR, it exits and we run grep.
> 
> s/now/not/

Oops, thanks.

> > -       grep "filter '\''blob:none'\'' not supported" err
> > +       test_i18ngrep "filter '\''blob:none'\'' not supported" err
> 
> Right, this is the one from the intro and the commit message.
> 
> > -       grep "tree filter allows max depth 0, but got 1" err
> > +       test_i18ngrep "tree filter allows max depth 0, but got 1" err
> 
> This one isn't translated, so this hunk could be dropped. Or maybe you
> wanted to knowingly cast a slightly wider net? (And this does fit the
> subject of your patch.)

Neither message is translated in itself, but the bug can happen with
either of them (because of the translation of the "remote error"
string). The tree-depth one was actually in the first failure I saw, but
when I re-ran it to produce output for the commit message, I got one of
the other tests.

-Peff
