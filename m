Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED991F403
	for <e@80x24.org>; Thu,  7 Jun 2018 02:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeFGCiH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 22:38:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753064AbeFGCiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 22:38:06 -0400
Received: (qmail 14204 invoked by uid 109); 7 Jun 2018 02:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Jun 2018 02:38:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11860 invoked by uid 111); 7 Jun 2018 02:38:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 22:38:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 22:38:04 -0400
Date:   Wed, 6 Jun 2018 22:38:04 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180607023804.GB3898@sigill.intra.peff.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
 <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
 <20180607014909.GL3094@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607014909.GL3094@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06, 2018 at 09:49:09PM -0400, Todd Zullinger wrote:

> Ramsay Jones wrote:
> [...]
> > I don't run the p4 or svn tests, so ... :-D
> 
> Heh, lucky you. :)
> 
> I try to run them all as part of the fedora builds since
> they cover much more than I'd ever use.  That's the main
> reason I noticed the bare python.  That would trip me up
> when it came time to build on a near-future fedora where
> python isn't installed by default and I only wanted to
> require python3 for the build/runtime scripts.

I'm not actually sure those svn bits involving python are usable by real
users. The main tool that people us for svn interop is git-svn, which is
written in perl.

There was an effort to have a real "git-remote-svn" helper (so that you
could just seamlessly "git clone svn://..." instead of using the "git
svn" wrapper.

So we have the work in vcs-svn, which gets built as part of a regular
compile. But AFAICT it is only used for git-remote-testsvn,
t/helper/test-svn-fe, and contrib/svn-fe. None of which have seen any
substantive work since 2012[1].

I suppose it's possible somebody could be using "git clone testsvn://"
in the wild, but the name would hopefully warn them off. I have no idea
how usable that work is in practice.

-Peff

[1] Browsing "git log", most of the commits are just tree-wide
    cleanups, or fixing some compilation or dependency error. The last
    "real" commit seems to be around 8e43a1d010 (remote-svn: add
    incremental import, 2012-09-19).

    I wonder if it is worth dropping this experiment as incomplete and
    unmaintained. People have obviously spent time dealing with the code
    for various fixups, but I think the whole thing may essentially just
    be dead code. Or maybe people really are using contrib/svn-fe. Like
    I said, I have no clue if this stuff is even usable, but we
    certainly haven't packaged it to be seen by most users.
