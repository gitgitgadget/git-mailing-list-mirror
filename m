Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783B81FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbcLPV1g (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:27:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:57772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753187AbcLPV1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:27:35 -0500
Received: (qmail 9985 invoked by uid 109); 16 Dec 2016 21:27:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 21:27:34 +0000
Received: (qmail 14708 invoked by uid 111); 16 Dec 2016 21:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 16:28:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 16:27:31 -0500
Date:   Fri, 16 Dec 2016 16:27:31 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20161216212731.eac2q4caitlh3rjw@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481922331.28176.11.camel@frank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 04:05:31PM -0500, David Turner wrote:

> 1. Its presence in the gc.log file prevents future automatic garbage
> collection.  This seems bad.  I understand the desire to avoid making
> things worse if a past gc has run into issues.  But this warning is
> non-fatal; the only consequence is that many operations get slower.  But
> a lack of gc when there are too many packs causes that consequence too
> (often a much worse slowdown than would be caused by the missing
> bitmap).
> 
> So I wonder if it would be better for auto gc to grep gc.log for fatal
> errors (as opposed to warnings) and only skip running if any are found.
> Alternately, we could simply put warnings into gc.log.warning and
> reserve gc.log for fatal errors. I'm not sure which would be simpler.  

Without thinking too hard on it, that seems like the appropriate
solution to me, too.

> 2. I don't understand what would cause that message.  That is, what bad
> thing am I doing that I should stop doing?  I've briefly skimmed the
> code and commit message, but the answer isn't leaping out at me.

Do you have alternates and are using --local? Do you have .keep packs
and have set repack.packKeptObjects to false?

There are other ways (e.g., an incremental repack), but I think those
are the likely ones to get via "git gc".

-Peff
