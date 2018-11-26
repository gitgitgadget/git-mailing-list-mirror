Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092BC1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 16:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeK0DkT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 22:40:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:51160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726672AbeK0DkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:18 -0500
Received: (qmail 9188 invoked by uid 109); 26 Nov 2018 16:45:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Nov 2018 16:45:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13705 invoked by uid 111); 26 Nov 2018 16:45:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Nov 2018 11:45:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Nov 2018 11:45:38 -0500
Date:   Mon, 26 Nov 2018 11:45:38 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t5570 shaky for anyone ?
Message-ID: <20181126164537.GB27711@sigill.intra.peff.net>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125222247.GD30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181125222247.GD30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 11:22:47PM +0100, SZEDER Gábor wrote:

> > The following fixes it, but I am not sure if this is the ideal
> > solution.
> 
> Currently this is the only test that looks at 'daemon.log', but if we
> ever going to add another one, then that will be prone to the same
> issue.
> 
> I wonder whether it's really that useful to have the daemon log in the
> test script's output...  if the log was sent directly to daemon log,
> then the window for this race would be smaller, but still not
> completely closed.
> 
> Anyway, I added Peff to Cc, since he added that whole fifo-shell-loop
> thing.

Yeah, see my comments on the other part of the thread. If we did write
directly to a file, I think that would be enough here because git-daemon
writes this entry before running the sub-process. So by the time
ls-remote finishes, we know that it talked to upload-pack, and we know
that before upload-pack was run, git-daemon wrote the log entry. That
assumes git-daemon doesn't buffer its logs (but if it does, we should
probably fix that).

-Peff
