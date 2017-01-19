Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4D020A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdASV1b (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:27:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:41788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdASV13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:27:29 -0500
Received: (qmail 14826 invoked by uid 109); 19 Jan 2017 21:20:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 21:20:42 +0000
Received: (qmail 9273 invoked by uid 111); 19 Jan 2017 21:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:21:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 16:20:40 -0500
Date:   Thu, 19 Jan 2017 16:20:40 -0500
From:   Jeff King <peff@peff.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
Message-ID: <20170119212039.3gixsrk7qco45wjo@sigill.intra.peff.net>
References: <20170115183051.3565-1-wsa@the-dreams.de>
 <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
 <20170119204343.xtotmjddhbum2mvr@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170119204343.xtotmjddhbum2mvr@ninjato>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 09:43:45PM +0100, Wolfram Sang wrote:

> > As to the implementation, I am wondering if we can make this somehow
> > work well with the "trailers" code we already have, instead of
> > inventing yet another parser of trailers.  
> > 
> > In its current shape, "interpret-trailers" focuses on "editing" an
> > existing commit log message to tweak the trailer lines.  That mode
> > of operation would help amending and rebasing, and to do that it
> > needs to parse the commit log message, identify trailer blocks,
> > parse out each trailer lines, etc.  
> > 
> > There is no fundamental reason why its output must be an edited
> > original commit log message---it should be usable as a filter that
> > picks trailer lines of the selected trailer type, like "Tested-By",
> > etc.
> 
> I didn't know about trailers before. As I undestand it, I could use
> "Tested-by" as the key, and the commit subject as the value. This list
> then could be parsed and brought into proper output shape. It would
> simplify the subject parsing, but most things my AWK script currently
> does would still need to stay or to be reimplemented (extracting names
> from tags, creating arrays of tags given by $name). Am I correct?
> 
> All under the assumption that trailers work on a range of commits. I
> have to admit that adding this to git is beyond my scope.

This sounds a lot like the shortlog-trailers work I did about a year
ago:

  http://public-inbox.org/git/20151229073832.GN8842@sigill.intra.peff.net/

  http://public-inbox.org/git/20151229075013.GA9191@sigill.intra.peff.net/

Nobody seemed to really find it useful, so I didn't pursue it.

Some of the preparatory patches in that series bit-rotted in the
meantime, but you can play with a version based on v2.7.0 by fetching
the "shortlog-trailers-historical" branch from
https://github.com/peff/git.git.

And then things like:

  git shortlog --ident=tested-by --format='...tested a patch by %an'

work (and you can put whatever commit items you want into the --format,
including just dumping the hash if you want to do more analysis).

-Peff
