Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C75A20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdK3UMU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:12:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:44720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750761AbdK3UMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:12:19 -0500
Received: (qmail 20947 invoked by uid 109); 30 Nov 2017 20:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 20:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31641 invoked by uid 111); 30 Nov 2017 20:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 15:12:38 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 15:12:17 -0500
Date:   Thu, 30 Nov 2017 15:12:17 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171130201217.GA3578@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129183514.wze5trxjfgqxqs7z@laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129183514.wze5trxjfgqxqs7z@laptop.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 06:35:16PM +0000, Thomas Adam wrote:

> On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
> > +		if (print_waiting_for_editor) {
> > +			fprintf(stderr, _("hint: Waiting for your editor input..."));
> >  			fflush(stderr);
> 
> Just FYI, stderr is typically unbuffered on most systems I've used, and
> although the call to fflush() is harmless, I suspect it's not having any
> effect.  That said, there's plenty of other places in Git which seems to think
> fflush()ing stderr actually does something.

I'd prefer to keep them (including this one), even if they are noops on
most platforms, because:

  1. They serve as a note for readers of the code that it's important
     for the output to have been printed immediately.

  2. We build on some funny and antique platforms. I wouldn't be
     surprised if there's one that line buffers by default. Or even a
     modern system with funny settings (e.g., using the GNU stdbuf
     tool).

(I know you said later you don't think this case needs to be removed,
but I want to make it clear I think it's a reasonable project-wide
policy to not assume we we know how stderr is buffered).

-Peff
