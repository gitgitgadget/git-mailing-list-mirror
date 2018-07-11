Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB4F1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbeGKQoC (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:44:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388231AbeGKQoC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:44:02 -0400
Received: (qmail 15820 invoked by uid 109); 11 Jul 2018 16:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 16:38:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9428 invoked by uid 111); 11 Jul 2018 16:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 12:38:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 12:38:51 -0400
Date:   Wed, 11 Jul 2018 12:38:51 -0400
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
Message-ID: <20180711163851.GA20988@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
 <20180710154931.GA23624@sigill.intra.peff.net>
 <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
 <20180711123425.GB23835@sigill.intra.peff.net>
 <20180711154619.7b574dff@md1pvb1c.ad001.siemens.net>
 <20180711142751.GF23835@sigill.intra.peff.net>
 <20180711181505.31ea530b@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711181505.31ea530b@md1pvb1c.ad001.siemens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 06:15:05PM +0200, Henning Schild wrote:

> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index bf8d567a4c..139b0f561e 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -97,7 +97,7 @@ static void parse_gpg_output(struct signature_check
> > *sigc) sigc->key = xmemdupz(found, next - found);
> >  			/* The ERRSIG message is not followed by
> > signer information */ if (sigc-> result != 'E') {
> > -				found = next + 1;
> > +				found = *next ? next + 1 : next;
> 
> This would keep us in bounds of the unexpected string. But ignore the
> line instead of "complaining" or crashing.
> 
> But you are right, it is easy enough and ignoring the line is probably
> the best way of dealing with it.
> 
> i will change the condition to
> > if (*next && sigc-> result != 'E')
> 
> also skipping the following strchrnul and xmemdupz

That sounds good to me. Thanks.

-Peff
