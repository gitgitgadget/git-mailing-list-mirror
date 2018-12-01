Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2460211B4
	for <e@80x24.org>; Sat,  1 Dec 2018 20:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725736AbeLBHP2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 02:15:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:56280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725732AbeLBHP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 02:15:28 -0500
Received: (qmail 22066 invoked by uid 109); 1 Dec 2018 20:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 20:02:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1648 invoked by uid 111); 1 Dec 2018 20:01:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 15:01:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 15:02:09 -0500
Date:   Sat, 1 Dec 2018 15:02:09 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181201200209.GC29120@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:

> > > Would it not make more sense to add a command-line option (and a config
> > > setting) to re-schedule failed `exec` commands? Like so:
> > 
> > Your proposition would do in most cases, however it is not possible to
> > make a distinction between reschedulable and non-reschedulable commands.
> 
> True. But I don't think that's so terrible.
> 
> What I think is something to avoid is two commands that do something very,
> very similar, but with two very, very different names.
> 
> In reality, I think that it would even make sense to change the default to
> reschedule failed `exec` commands. Which is why I suggested to also add a
> config option.

I sometimes add "x false" to the top of the todo list to stop and create
new commits before the first one. That would be awkward if I could never
get past that line. However, I think elsewhere a "pause" line has been
discussed, which would serve the same purpose.

I wonder how often this kind of "yes, I know it fails, but keep going
anyway" situation would come up. And what the interface is like for
getting past it. E.g., what if you fixed a bunch of stuff but your tests
still fail? You may not want to abandon the changes you've made, but you
need to "rebase --continue" to move forward. I encounter this often when
the correct fix is actually in an earlier commit than the one that
yields the test failure. You can't rewind an interactive rebase, so I
complete and restart it, adding an "e"dit at the earlier commit.

How would I move past the test that fails to continue? I guess "git
rebase --edit-todo" and then manually remove it (and any other remaining
test lines)?

That's not too bad, but I wonder if people would find it more awkward
than the current way (which is to just "rebase --continue" until you get
to the end).

I dunno. I am not sure if I am for or against changing the default, so
these are just some musings. :)

-Peff
