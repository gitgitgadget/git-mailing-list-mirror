Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2681F403
	for <e@80x24.org>; Mon, 18 Jun 2018 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeFRERR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 00:17:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754738AbeFRERQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 00:17:16 -0400
Received: (qmail 3894 invoked by uid 109); 18 Jun 2018 04:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Jun 2018 04:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2664 invoked by uid 111); 18 Jun 2018 04:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Jun 2018 00:17:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jun 2018 00:17:14 -0400
Date:   Mon, 18 Jun 2018 00:17:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180618041713.GA31125@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
 <20180614151507.GA6933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 01:37:24PM +0200, Johannes Schindelin wrote:

> > If it's just a custom Authorization header, we should be able to support
> > it with existing curl versions without _too_ much effort.
> 
> Indeed. Because it is already implemented:
> 
> 	git -c http.extraheader="Authorization: Bearer ..." ...
> 
> To make this a *little* safer, you can use http.<URL>.extraheader.

Yeah, that will work for some cases. A few places it might not:

 - some people may want to provide this only in response to a 401

 - some tokens may need to be refreshed, which would require interacting
   with a credential helper to do the rest of the oauth conversation

 - there's no good way to hide your token in secure storage (versus
   sticking it on the command-line or in a config file).

-Peff
