Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD3BC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7558A2065C
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgI0IUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:20:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:42340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0IUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:20:53 -0400
Received: (qmail 29039 invoked by uid 109); 27 Sep 2020 08:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:20:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3890 invoked by uid 111); 27 Sep 2020 08:20:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:20:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:20:51 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/8] trailer: add interface for iterating over commit
 trailers
Message-ID: <20200927082051.GA1292450@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070249.GC62741@coredump.intra.peff.net>
 <CAN0heSrhmf9-Ep+SWe7Wy-7c3M9-1NFBybSA=6aJ1vDYGTdciA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrhmf9-Ep+SWe7Wy-7c3M9-1NFBybSA=6aJ1vDYGTdciA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 26, 2020 at 02:39:32PM +0200, Martin Ågren wrote:

> > +/*
> > + * Initialize "iter" in preparation for walking over the trailers in the commit
> > + * message "msg". The "msg" pointer must remain valid until the iterator is
> > + * released.
> > + *
> > + * After initializing, we are not yet pointing
> > + */
> 
> Truncated sentence. "... not yet pointing at any trailer"?

Oops. Yes, though I expanded it to:

  * After initializing, note that key/val will not yet point to any trailer.
  * Call advance() to parse the first one (if any).

Obviously another convention would be:

  for (trailer_iterator_init(&iter, msg);
       !trailer_iterator_done();
       trailer_iterator_advance()) {
  }

but I don't think it matters much either way as long as it's clearly
documented.

-Peff
