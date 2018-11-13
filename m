Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0231F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbeKNAgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:36:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:37108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727677AbeKNAgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:36:49 -0500
Received: (qmail 18105 invoked by uid 109); 13 Nov 2018 14:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Nov 2018 14:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19772 invoked by uid 111); 13 Nov 2018 14:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 09:37:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 09:38:22 -0500
Date:   Tue, 13 Nov 2018 09:38:22 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        larsxschneider@gmail.com, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 04/10] fast-export: avoid dying when filtering by paths
 and old tags exist
Message-ID: <20181113143822.GA17454@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-5-newren@gmail.com>
 <20181111064442.GD30850@sigill.intra.peff.net>
 <20181112225043.GJ890086@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112225043.GJ890086@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:50:43PM +0000, brian m. carlson wrote:

> On Sun, Nov 11, 2018 at 01:44:43AM -0500, Jeff King wrote:
> > > +		git fast-export --tag-of-filtered-object=rewrite --all -- bar >output &&
> > > +		grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}
> > 
> > I don't think "grep -A" is portable (and we don't seem to otherwise use
> > it). You can probably do something similar with sed.
> > 
> > Use $ZERO_OID instead of hard-coding 40, which future-proofs for the
> > hash transition (though I suppose the hash is not likely to get
> > _shorter_ ;) ).
> 
> It would indeed be nice if we used $ZERO_OID.  Also, we prefer to write
> "egrep", since some less capable systems don't have a grep with -E.

I thought that, too, but it is only "grep -F" that has been a problem
for us in the past, and we have many "grep -E" calls already. c.f.
https://public-inbox.org/git/20180910154453.GA15270@sigill.intra.peff.net/

-Peff
