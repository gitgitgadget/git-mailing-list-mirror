Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F3C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB72166E
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410195AbgDOQFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:05:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:54644 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2410192AbgDOQFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 12:05:37 -0400
Received: (qmail 12783 invoked by uid 109); 15 Apr 2020 16:05:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 16:05:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4652 invoked by uid 111); 15 Apr 2020 16:16:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 12:16:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 12:05:35 -0400
From:   Jeff King <peff@peff.net>
To:     luciano.rocha@booking.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [External] Re: [PATCH 1/1] freshen_file(): use NULL `times' for
 implicit current-time
Message-ID: <20200415160535.GF2464307@coredump.intra.peff.net>
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
 <20200414195535.GA1879302@coredump.intra.peff.net>
 <20200415090906.wudutxpiyw7ooas6@C02Z11TTLVDN.corpad.adbkng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415090906.wudutxpiyw7ooas6@C02Z11TTLVDN.corpad.adbkng.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 11:09:06AM +0200, luciano.rocha@booking.com wrote:

> > The old code was setting the time based on the system time from time().
> > We've occasionally hit cases where the filesystem time and the system
> > time do not match exactly (this might be true on an NFS mount, for
> > example).
> > 
> > It's not clear to me whether utime(NULL) would be using the system or
> > filesystem time in such a case. If the former, then there's no change in
> > behavior. If the latter, I'd argue that it's probably an _improvement_,
> > since we're simulating the case that we wrote a new file with a new
> > mtime.
> 
> I'm not that familiar with kernel code, so can't say for sure. From a
> cursory look, it doesn't seem like it uses the remote server's time.
> 
> But it does seem to have a higher precision, for filesystems that
> support it.

Yeah, that's another point in its favor.

It seems pretty clear to me that utime(NULL) should give either the same
or better behavior in all cases.

-Peff
