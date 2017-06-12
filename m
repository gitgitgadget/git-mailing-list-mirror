Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126001F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdFLRgX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:36:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:38335 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752577AbdFLRgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:36:08 -0400
Received: (qmail 18465 invoked by uid 109); 12 Jun 2017 17:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:36:03 +0000
Received: (qmail 14531 invoked by uid 111); 12 Jun 2017 17:36:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 13:36:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 13:36:01 -0400
Date:   Mon, 12 Jun 2017 13:36:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
Message-ID: <20170612173601.kpdkxb23r6shssl6@sigill.intra.peff.net>
References: <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <d7e3abd9-0fac-8336-de34-dbd9aad39bd9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7e3abd9-0fac-8336-de34-dbd9aad39bd9@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 06:58:13PM +0200, René Scharfe wrote:

> > We could also simply replace "%Z" with the empty string, as the the
> > POSIX strftime() documentation allows for:
> > http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
> > ("Replaced by the timezone name or abbreviation, or by no bytes if no
> > timezone information exists.").
> 
> Yes, that's what the patch does.

Yeah, after thinking about all that was said in this thread, the empty
string is the only thing that makes sense to me.

IMHO, your patch as-is is a strict improvement. Mine on top (to handle
the "-local" cases) is optional, but I think worth doing. It makes the
rule easy to understand and explain ("-local" makes %Z behave as
expected, and the non-local variants leave it blank because the
information isn't present).

-Peff
