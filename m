Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB77D1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbcFUU6F (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:58:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:58137 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbcFUU6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:58:03 -0400
Received: (qmail 5889 invoked by uid 102); 21 Jun 2016 20:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 16:57:22 -0400
Received: (qmail 28596 invoked by uid 107); 21 Jun 2016 20:57:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 16:57:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 16:57:20 -0400
Date:	Tue, 21 Jun 2016 16:57:20 -0400
From:	Jeff King <peff@peff.net>
To:	"Robin H. Johnson" <robbat2@gentoo.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160621205720.GA4747@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <robbat2-20160621T185126-722667990Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <robbat2-20160621T185126-722667990Z@orbis-terrarum.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 07:44:55PM +0000, Robin H. Johnson wrote:

> On Thu, Jun 16, 2016 at 12:37:33AM -0400,  Jeff King wrote:
> > We could ship just the resulting compressed object data as a
> > loose object, but even that takes 64MB. So sadly, this code
> > path remains untested in the test suite.
> Additionally compress the object data, and insert it for the purpose of
> testing? It's still an expensive test time-wise, but repeated
> gzip compression on zeros does still help; to that end, here's the
> pieces to add a testcase while only being <9KiB.

Interesting idea. With bzip2 it actually drops to about 600 bytes (I
suspect we could get it even smaller by writing a custom program to
generate it, but it's diminishing returns).

I think there are some other portability issues, though (like does the
receiving tar actually support 64GB sizes).

-Peff
