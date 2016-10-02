Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC9B1F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbcJBNCX (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 09:02:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbcJBNCT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 09:02:19 -0400
Received: (qmail 24307 invoked by uid 109); 2 Oct 2016 13:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 13:02:18 +0000
Received: (qmail 22748 invoked by uid 111); 2 Oct 2016 13:02:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 09:02:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2016 09:02:16 -0400
Date:   Sun, 2 Oct 2016 09:02:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 0/6] receive-pack: quarantine pushed objects
Message-ID: <20161002130216.bburwjkx4dkzxiig@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <CAP8UFD3Y1du+L9DRgz01wgbsCYiebu2DgyePH41MaDhjV24oHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Y1du+L9DRgz01wgbsCYiebu2DgyePH41MaDhjV24oHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 02, 2016 at 11:20:59AM +0200, Christian Couder wrote:

> On Fri, Sep 30, 2016 at 9:35 PM, Jeff King <peff@peff.net> wrote:
> > I've mentioned before on the list that GitHub "quarantines" objects
> > while the pre-receive hook runs. Here are the patches to implement
> > that.
> 
> Great! Thanks for upstreaming these patches!
> 
> I wonder if the patch you sent in:
> 
> https://public-inbox.org/git/20160816144642.5ikkta4l5hyx6act@sigill.intra.peff.net/
> 
> is still useful or not.

It is potentially still useful for other code paths besides
receive-pack. But if the main concern is pushes, then yeah, I think it
is not really doing anything.

> I guess if we fail the receive-pack because the pack is bigger than
> receive.maxInputSize, then the "quarantine" directory will also be
> removed, so the part of the pack that we received before failing the
> receive-pack will be deleted.

Correct. _Any_ failure up to the tmp_objdir_migrate() call will drop the
objects. So that includes index-pack failing for any reason.

> >     These two patches set that up by letting index-pack and pre-receive
> >     know that quarantine path and use it to store arbitrary files that
> >     _don't_ get migrated to the main object database (i.e., the log file
> >     mentioned above).
> 
> It would be nice to have a diffstat for the whole series.

You mean in the cover letter? I do not mind including it if people find
them useful, but I personally have always just found them to be clutter
at that level.

-Peff
