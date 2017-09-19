Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E982C2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbdISVDE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 17:03:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:44032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751623AbdISVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 17:03:03 -0400
Received: (qmail 15108 invoked by uid 109); 19 Sep 2017 21:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 21:03:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8247 invoked by uid 111); 19 Sep 2017 21:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 17:03:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 17:03:01 -0400
Date:   Tue, 19 Sep 2017 17:03:01 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
 <20170919134552.7845f021@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919134552.7845f021@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 01:45:52PM -0700, Jonathan Tan wrote:

> The following comments are assuming that we're going to standardize on
> UNLEAK(var); (with the semicolon).

Yeah, I assumed we would. We don't have to, since this really is sort-of
magical, but I think the code looks better with it.

> On Fri, 8 Sep 2017 02:38:41 -0400
> Jeff King <peff@peff.net> wrote:
> 
> > +#ifdef SUPPRESS_ANNOTATED_LEAKS
> > +extern void unleak_memory(const void *ptr, size_t len);
> > +#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
> 
> I would feel better if the semicolon was omitted. I don't think it
> matters in this particular case, though.

You end up with a double semi-colon. Some linters might complain.

> > +#else
> > +#define UNLEAK(var)
> 
> I think this should be defined to be something (for example, "do {}
> while (0)"), at least so that we have compiler errors when UNLEAK(var)
> is used incorrectly (for example, without the semicolon) when
> SUPPRESS_ANNOTATED_LEAKS is not defined.

Seems reasonable.

I think both are worth doing, but the patch is already in next so we
need to do it on top. Do you want to prepare a patch?

-Peff
