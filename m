Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457A8202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbdKAVjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:39:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:43236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934423AbdKAVjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:39:14 -0400
Received: (qmail 28484 invoked by uid 109); 1 Nov 2017 21:39:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 21:39:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15720 invoked by uid 111); 1 Nov 2017 21:39:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 17:39:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 17:39:11 -0400
Date:   Wed, 1 Nov 2017 17:39:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
Message-ID: <20171101213911.aokzrnchr6s2r2uq@sigill.intra.peff.net>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-3-sbeller@google.com>
 <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
 <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012235070.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711012235070.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 10:36:02PM +0100, Johannes Schindelin wrote:

> Hi Junio,
> 
> On Wed, 1 Nov 2017, Junio C Hamano wrote:
> 
> > On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > >         ...
> > >         (
> > >                 for x in four three
> > >                 do
> > >                         git rm $x &&
> > >                         git commit -m "remote $x" ||
> > >                         exit
> > >                 done
> > >         ) &&
> > >         test 0 -eq $? &&
> > >         ...
> > >
> > > Ugly? Yes. Correct? Also yes.
> > 
> > I think returning non-zero with "return" is how other tests avoid an
> > extra level of subshell.
> > Ugly? Yes. Correct? Questionable but it seems to work for those who
> > wrote them ;-)
> 
> Given that the test_expect_* functions evaluate the code, it makes me
> wonder whether those `return` statements really return appropriately, or
> one call level too low.

The test_expect functions eval the actual snippets inside a dummy
function. This is intentional exactly to allow them to call "return" at
will.

-Peff
