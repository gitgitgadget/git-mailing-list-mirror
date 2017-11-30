Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89BDC20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 17:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbdK3RpC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 12:45:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:44516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753296AbdK3RpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 12:45:01 -0500
Received: (qmail 14636 invoked by uid 109); 30 Nov 2017 17:45:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 17:45:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28847 invoked by uid 111); 30 Nov 2017 17:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 12:45:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 12:45:00 -0500
Date:   Thu, 30 Nov 2017 12:45:00 -0500
From:   Jeff King <peff@peff.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, hsed@unimetic.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH V4] config: add --expiry-date
Message-ID: <20171130174500.GA16245@sigill.intra.peff.net>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
 <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
 <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
 <CAGZ79ka+5o07cz4A8=Gu_VqO1hYqqO=8Ju1uAaDY23s7xjCWvw@mail.gmail.com>
 <20171120203702.mdd3hkwezxyf7vtg@sigill.intra.peff.net>
 <20171130111849.GA98794@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130111849.GA98794@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 12:18:49PM +0100, Heiko Voigt wrote:

> > Fine by me. While I think the original intent was to be more lenient to
> > malformed .gitmodules, it's not like we're seeing bug reports about it.
> 
> My original intent was not about being more lenient about malformed
> .gitmodules but having a way to deal with repository history that might
> have a malformed .gitmodules in its history. Since depending on the
> branch it is on it might be quite carved in stone.
> On an active project it would not be that easy to rewrite history to get
> out of that situation.
> 
> When a .gitmodules file in the worktree is malformed it is easy to fix.
> That is not the case when we are reading configurations from blobs.
> 
> My guess why there are no reports is that maybe not too many users are
> using this infrastructure yet, plus it is probably seldom that someone
> edits the .gitmodules file by hand which could lead to such a situation.
> But if such an error occurs it will be very annoying if we die while
> parsing submodule configurations. The only solution I see currently is
> to turn submodule recursion off completely.
> 
> But maybe I am being overly cautious here.

Ah, OK, that makes a lot of sense to me. Thanks for explaining.

I agree that is a good goal to shoot for in the long term. It's not the
end of the world if there are a few code paths that may die() for now,
but we should try not to add more, and eventually weed out the ones that
do.

-Peff
