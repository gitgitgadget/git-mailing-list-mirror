Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2371F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbeGKMie (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:38:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732808AbeGKMie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:38:34 -0400
Received: (qmail 5910 invoked by uid 109); 11 Jul 2018 12:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 12:34:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6633 invoked by uid 111); 11 Jul 2018 12:34:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 08:34:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 08:34:25 -0400
Date:   Wed, 11 Jul 2018 08:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/9] gpg-interface: do not hardcode the key string len
 anymore
Message-ID: <20180711123425.GB23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
 <20180710154931.GA23624@sigill.intra.peff.net>
 <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 10:54:59AM +0200, Henning Schild wrote:

> > In the general case you need:
> > 
> >   found = *next ? next + 1 : next;
> > 
> > or similar. In this case, you can actually do:
> > 
> >   found = next;
> > 
> > because we know that it's OK to search over the literal space again.
> > But that's pretty subtle, so we're probably better off just doing the
> > conditional above.
> > 
> > (And yes, looking at the existing code, I think it's even worse, as
> > there does not seem to be a guarantee that we even have 16 characters
> > in the string).
> 
> The existing code works only on expected output and the same is true
> for the version after this patch. Making the parser robust against
> random input would imho be a sort of cleanup patch on top of my
> series. .. or before, in which case i would become responsible for
> making sure that still works after my modification.
> This argument is twofold. I do not really want to fix that as well and
> it might be a good idea to separate concerns anyways.

I think it's worth addressing in the near term, if only because this
kind of off-by-one is quite subtle, and I don't want to forget to deal
with it. Whether that happens as part of this patch, or as a cleanup
before or after, I'm not picky. :)

-Peff
