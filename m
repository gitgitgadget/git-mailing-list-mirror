Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E221F424
	for <e@80x24.org>; Mon, 18 Dec 2017 12:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759496AbdLRM7L (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 07:59:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:42064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1759394AbdLRM7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 07:59:10 -0500
Received: (qmail 1226 invoked by uid 109); 18 Dec 2017 12:59:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Dec 2017 12:59:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25667 invoked by uid 111); 18 Dec 2017 12:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 18 Dec 2017 07:59:34 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec 2017 07:59:08 -0500
Date:   Mon, 18 Dec 2017 07:59:08 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171218125907.GA4665@sigill.intra.peff.net>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <20171215095838.GA3567@sigill.intra.peff.net>
 <D1E22F0E-EC10-4133-9177-AE20F398A8AC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1E22F0E-EC10-4133-9177-AE20F398A8AC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 11:54:32AM +0100, Lars Schneider wrote:

> >  warning: failed to encode 'file' from utf-8 to utf16
> > 
> > At least it figured out that it couldn't convert the content. It's
> > slightly troubling that it would try in the first place, though; are
> > there encoding pairs where we might accidentally generate nonsense?
> 
> At this point we interpret utf-16 content as utf-8 and try to convert
> it to utf-16. That of course fails because utf-16 content is no valid
> utf-8. How could we stop trying that? How could Git possibly know what
> kind of encoding is used (apart from our new hint in gitattributes)?

Yeah, sorry if I wasn't clear: I don't really have an answer to those
questions either. So this is probably the best we can do. I was mostly
just trying to think through the worst case, and what could go wrong.

> > It may make sense to die() during "git add ." (since we're actually
> > changing the index entry, and we don't want to put nonsense into a
> > tree). But I'm not sure it's the best thing for operations which just
> > want to read the content. For them, perhaps it would be more appropriate
> > to issue a warning and return the untouched content.
> 
> Absolutely! Thanks for spotting this. I will try to run die() only on
> "git add" in v2.

Great, thanks!

-Peff
