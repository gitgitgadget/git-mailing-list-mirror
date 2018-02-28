Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9451F404
	for <e@80x24.org>; Wed, 28 Feb 2018 13:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeB1NVT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 08:21:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:40578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752325AbeB1NVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 08:21:19 -0500
Received: (qmail 445 invoked by uid 109); 28 Feb 2018 13:21:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 13:21:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1708 invoked by uid 111); 28 Feb 2018 13:22:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 08:22:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 08:21:16 -0500
Date:   Wed, 28 Feb 2018 08:21:16 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180228132116.GA32272@sigill.intra.peff.net>
References: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
 <20180227212537.GA6899@sigill.intra.peff.net>
 <20180228082005.GA16857@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228082005.GA16857@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 09:20:05AM +0100, Torsten Bögershausen wrote:

> >   2. auto-detect utf-16 (your patch)
> >      - Just Works for existing repositories storing utf-16
> > 
> >      - carries some risk of kicking in when people would like it not to
> >        (e.g., when they really do want a binary patch that can be
> >        applied).
> 
> The binary patch is still supported, but that detail may need some more explanation
> in the commit message. Please see  t4066-diff-encoding.sh

Yeah, but if you don't have binary-patches enabled we'd generate a bogus
patch. Which, granted, without that you wouldn't be able to apply the
patch either. But somehow it feels funny to me to generate something
that _looks_ like a patch but you can't actually apply.

I also think we'd want a plan for this to be used consistently in other
diff-like tools. E.g., "git blame" uses textconv for the starting file
content, and it would be nice for this to kick in then, too. Ditto for
things like grep, pickaxe, etc.

I have some patches that reuse some of the textconv infrastructure for
this, which should mostly make it "just work" everywhere. They need a
little more polishing before I post them, but you can take a look at:

  https://github.com/peff/git.git jk/textconv-utf16

if you want.

-Peff
