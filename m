Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4390820357
	for <e@80x24.org>; Sun, 16 Jul 2017 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdGPKDY (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:03:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:41908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKDX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:03:23 -0400
Received: (qmail 22609 invoked by uid 109); 16 Jul 2017 10:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24348 invoked by uid 111); 16 Jul 2017 10:03:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:03:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:03:21 -0400
Date:   Sun, 16 Jul 2017 06:03:21 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170716100321.3jj4pdz7jqoa3dr4@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
 <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
 <4dbe06d0-9a65-7bf5-eb82-6371d9ad7e9b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dbe06d0-9a65-7bf5-eb82-6371d9ad7e9b@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 10:07:57AM +0200, Johannes Sixt wrote:

> Am 14.07.2017 um 22:08 schrieb Jeff King:
> > The implementation on this doesn't seem overly complex. My main concerns
> > are what we're asking from the filesystem in terms of atomicity, and
> > what possible races there are.
> 
> One of the failure modes is that on Windows a file cannot be deleted while
> it is open in any process. It can happen that a compacting updater wants to
> remove a reftable file that is still open in a reader.

Good point. I think the explicit pointers I mentioned are an improvement
there, because a compacting updater _can_ leave the file in place if the
delete fails (and later, another compaction can clean up cruft that was
left).

I assume that's more or less how pack deletion works on Windows.

-Peff
