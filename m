Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663291F45F
	for <e@80x24.org>; Thu,  9 May 2019 18:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEISi6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 14:38:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726632AbfEISi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:38:57 -0400
Received: (qmail 7765 invoked by uid 109); 9 May 2019 18:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 18:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5247 invoked by uid 111); 9 May 2019 18:39:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 14:39:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 14:38:55 -0400
Date:   Thu, 9 May 2019 14:38:55 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as unsigned
Message-ID: <20190509183855.GA28107@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
 <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
 <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
 <20190508230420.GC19990@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905091605070.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905091605070.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 09, 2019 at 04:06:22PM +0200, Johannes Schindelin wrote:

> > I don't this this has anything to do with gcc. The point is that we
> > already have this line:
> >
> >   write_or_die(fd, buf, BLOCKSIZE);
> >
> > which does not cast and nobody has complained,
> 
> I mistook this part of your reply in
> https://public-inbox.org/git/20190413013451.GB2040@sigill.intra.peff.net/
> as precisely such a complaint:
> 
> 	BLOCKSIZE is a constant. Should we be defining it with a "U" in
> 	the first place?

Ah, sorry to introduce confusion. I mostly meant "if we need to cast,
why not just define as unsigned in the first place?". But I think René
was pointing out that we do not even need to cast, and I am fine with
that approach.

I do dream of a world where we do not have a bunch of implicit
conversions (both signedness but also truncation) in our code base, and
can compile cleanly with -Wconversion We know that this case is
perfectly fine, but I am sure there are many that are not. However, I'm
not sure if we'll ever get there, and in the meantime I don't think it's
worth worrying too much about individual cases like this.

-Peff
