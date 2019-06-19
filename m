Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E40E1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSRsC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 13:48:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:44254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726322AbfFSRsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 13:48:02 -0400
Received: (qmail 11115 invoked by uid 109); 19 Jun 2019 17:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 17:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7703 invoked by uid 111); 19 Jun 2019 17:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 13:48:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 13:47:52 -0400
Date:   Wed, 19 Jun 2019 13:47:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        git <git@vger.kernel.org>, masahiroy@kernel.org
Subject: Re: [PATCH] interpret-trailers: load default config
Message-ID: <20190619174752.GA27834@sigill.intra.peff.net>
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net>
 <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
 <20190619033728.GA29027@sigill.intra.peff.net>
 <xmqqwohhr6ut.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwohhr6ut.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 07:24:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] interpret-trailers: load default config
> >
> > The interpret-trailers program does not do the usual loading of config
> > via git_default_config(), and thus does not respect many of the usual
> > options. In particular, we will not load core.commentChar, even though
> > the underlying trailer code tries to do so.
> 
> "tries to use it"?  Eh, it does use it, so, "the underlying trailer code
> uses its value", would be the correct version of the last sentence.

Heh. Well, it does use the C variable, just not the one from the config.
:) But yeah, if you want to clarify the text while you apply, I'm fine
with that.

> The underlying trailer.c has two calls to git_config() to lazy-load
> its own set of config variables (which is justified, as its caller
> is not necessarily the "interpret-trailers" subcommand), but their
> callbacks are not good places to call git_default_config() from for
> obvious reasons.  It has to be done in "interpret-trailers" (and
> other callers of the machinery should already have learned what
> core.commentChar is with their own configuration calls) like the
> patch I am reviewing does.

Yeah, I didn't look too carefully into the loading that the trailer code
does for the reasons you gave. Thanks for laying it out clearly (and I
wouldn't mind if you stuck that in the commit message either).

-Peff
