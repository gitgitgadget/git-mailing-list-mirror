Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B8220954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdLAS31 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:29:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:45792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750872AbdLAS30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:29:26 -0500
Received: (qmail 18996 invoked by uid 109); 1 Dec 2017 18:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Dec 2017 18:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8328 invoked by uid 111); 1 Dec 2017 18:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 01 Dec 2017 13:29:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Dec 2017 13:29:24 -0500
Date:   Fri, 1 Dec 2017 13:29:24 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171201182924.GB27688@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 01, 2017 at 01:52:14PM +0100, Lars Schneider wrote:

> > These are obviously the result of devils-advocate poking at the feature.
> > I doubt any editor would end its output with a CR. But the first case is
> > probably going to be common, especially for actual graphical editors. We
> > know that emacsclient prints its own line, and I wouldn't be surprised
> > if other graphical editors spew some telemetry to stderr (certainly
> > anything built against GTK tends to do so).
> 
> True! However, if a Git user is not bothered by a graphical editor that
> spews telemetry to stderr, then I think the same user wouldn't be
> bothered by one additional line printed by Git either, right?

Yeah, if there's a lot of spew, I agree it probably doesn't matter.

The "emacsclient" one is probably the worst case, because it would print
a single line of its own, which would get tacked onto the "Waiting..."
message printed by Git, since it doesn't end with a newline.

> > The patch itself looks fine, as far as correctly implementing the
> > design.
> 
> Thanks for the review :-)

Actually, I meant to bikeshed one part but forgot. ;)

> +                       fprintf(stderr, _("hint: Waiting for your editor input..."));

I found "waiting for editor input" to be a funny way of saying this. I
input to the editor, the editor does not input to Git. :)

Maybe "waiting for your editor finish" or something would make more
sense?

Or given that the goal is really just making it clear that we've spawned
an editor, something like "starting editor %s..." would work. I think
the "waiting for..." pattern is perfectly fine, though.

-Peff
