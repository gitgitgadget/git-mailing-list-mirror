Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EEE82022D
	for <e@80x24.org>; Sat,  5 Nov 2016 01:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbcKEBsV (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 21:48:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38978 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbcKEBsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 21:48:20 -0400
Received: (qmail 31169 invoked by uid 109); 5 Nov 2016 01:48:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Nov 2016 01:48:20 +0000
Received: (qmail 28220 invoked by uid 111); 5 Nov 2016 01:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 21:48:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 21:48:17 -0400
Date:   Fri, 4 Nov 2016 21:48:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161105014817.vm4ush2wfbblzsc7@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
 <CA+P7+xpwUZscpgzLJYf5vkKKsT6SFkC3TrsyBJXJjGo9cF94nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpwUZscpgzLJYf5vkKKsT6SFkC3TrsyBJXJjGo9cF94nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 04:34:34PM -0700, Jacob Keller wrote:

> > You might also want fallback rules for storing gitrefs on "old" servers
> > (e.g., backfilling gitrefs you need if the server didn't them in the
> > initial fetch). But I guess storing any gitrefs on such a server is
> > inherently dangerous, because the server might prune them at any time.
> 
> Is it possible currently for a protocol extension to result in "oh the
> server doesn't support this so I'm going to stop pushing"?

Yes, it would be easy for the client to abort if the server fails to
advertise a particular extension.

What I would worry about more is that "somehow" an older client gets
hold of history with a gitref, and then pushes it. It would be nice if
even an old server said "nope, I don't understand this and I won't take
it" rather than propagating the data to a server that will throw it
away.

> Right. I'm assuming tree objects don't get checked for invalid mode
> already? If they do, we could just change the mode to something
> unsupported currently. But... that seems like it might not be the case
> because it requires checking every tree object coming in?
> 
> I'm not familiar with what sort of checking already exists... Thoughts?

If the server sets receive.fsckObjects, then fsck_tree() runs and will
reject any non-standard mode. That option is not the default, though
some big hosters set it (GitHub does, but I am actually not that worried
about GitHub; if gitrefs support materialized I would probably ship it
there fairly promptly).

-Peff
