Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56B31F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfA2Qz0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:55:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:53450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728946AbfA2QzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:55:25 -0500
Received: (qmail 3663 invoked by uid 109); 29 Jan 2019 16:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 16:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8527 invoked by uid 111); 29 Jan 2019 16:55:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 11:55:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 11:55:23 -0500
Date:   Tue, 29 Jan 2019 11:55:23 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit
 value
Message-ID: <20190129165523.GA7349@sigill.intra.peff.net>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181208163647.19538-1-anders@0x63.nu>
 <20181208163647.19538-3-anders@0x63.nu>
 <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com>
 <87o99iwmjn.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o99iwmjn.fsf@0x63.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 10:30:04PM +0100, Anders Waldenborg wrote:

> 
> Junio C Hamano writes:
> > That way, we can handle %(trailers:only=bogo) more sensibly,
> > no?  Syntactically we can recognize that the user wanted to give
> > 'bogo' as the value to 'only', and say "'bogo' is not a boolean" if
> > we did so.
> 
> I agree that proper error reporting for the pretty formatting strings
> would be great. But that would depart from the current extremely crude
> error handling where incorrect formatting placeholders are just left
> unexpanded. How would such change in error handling be done safely, wrt
> backwards compatibility changes?

I think we'd want to move in the direction of enforcing valid
expressions for %(foo) placeholders. There's some small value in leaving
%X alone if we do not understand "X" (not to mention the backwards
%compatibility you mentioned), but I think %() is a pretty
deliberate indication that a placeholder was meant there.

We already do this for ref-filter expansions:

  $ git for-each-ref --format='%(foo)'
  fatal: unknown field name: foo

We don't for "--pretty" formats, but I do wonder if anybody would be
really mad (after all, we have declared ourselves free to add new
placeholders, so such formats are not future-proof).

-Peff
