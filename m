Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1E820373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdCMVA2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:00:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:43577 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbdCMVA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:00:27 -0400
Received: (qmail 4993 invoked by uid 109); 13 Mar 2017 21:00:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 21:00:26 +0000
Received: (qmail 23513 invoked by uid 111); 13 Mar 2017 21:00:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 17:00:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 17:00:23 -0400
Date:   Mon, 13 Mar 2017 17:00:23 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Stevens <Marc.Stevens@cwi.nl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net>
 <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
 <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
 <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
 <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 09:47:54PM +0100, Marc Stevens wrote:

> Linus:
> I would be surprised, the dependencies should be automatically determined.
> 
> BTW Did you make local changes to this perf branch?

I can reproduce it with:

  cd sha1collisiondetection
  git clean -dqfx ;# make sure we are starting from scratch

  git checkout 9c8e73cadb35776d3310e3f8ceda7183fa75a39f
  make
  bin/sha1dcsum $file

  git checkout 55d1db0980501e582f6cd103a04f493995b1df78
  make
  bin/sha1dcsum $file

The final call to sha1dcsum will report a collision, even though the
first one did not.

It also reproduces with the original snippet I posted. I didn't notice
because I was just collecting the timings then (and I originally noticed
the problem on the versions I had pulled into Git, where it works as
expected; but then I am just pulling in the two source files, without
all of the libtool magic).

-Peff
