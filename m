Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D27A1F45C
	for <e@80x24.org>; Mon, 12 Aug 2019 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfHLQfT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:35:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725822AbfHLQfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:35:18 -0400
Received: (qmail 26234 invoked by uid 109); 12 Aug 2019 16:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 16:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24055 invoked by uid 111); 12 Aug 2019 16:38:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 12:38:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 12:35:17 -0400
From:   Jeff King <peff@peff.net>
To:     geoffsimons@aim.com
Cc:     git@vger.kernel.org
Subject: Re: Git add claims path is ignored, but git check-ignore returns no
 results
Message-ID: <20190812163517.GA26231@sigill.intra.peff.net>
References: <1229468090.3098018.1565627099656.ref@mail.yahoo.com>
 <1229468090.3098018.1565627099656@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1229468090.3098018.1565627099656@mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 04:24:59PM +0000, geoffsimons@aim.com wrote:

> I can’t find anything relevant in .git/info/exclude either, or any of
> the .gitignore files I could find.
> 
> git check-ignore .\Source\UI\Website\LiveFeeds\Releases\IO\ReleasesSerializer.cs
> git add .\Source\ui\Website\LiveFeeds\Releases\io\ReleasesSerializer.cs
> The following paths are ignored by one of your .gitignore files:
> Source/ui/Website/LiveFeeds/Releases/io/ReleasesSerializer.cs
> Use -f if you really want to add them.
> 
> I get a similar result for adding files in that directory, or the
> parent directory (releases), but the grandparent directory (livefeeds)
> works fine.  Any ideas what might be causing this?

I notice that your "add" and "check-ignore" commands differ in the case
of "UI". I think both commands should work correctly when on a
case-insensitive filesystem (and a few checks I did after setting
core.ignorecase manually seem to confirm this).

But maybe try it with "ui" in the check-ignore command and see if that
changes anything?

Another thing I notice is that you're using Windows-style back-slashes
for the path separators (whereas internally in Git, everything is
front-slashes). AFAIK that's supposed to work everywhere on Windows, but
I wouldn't be surprised if there are corner cases where it doesn't. Does
switching to:

  git check-ignore ./Source/ui/Website/LiveFeeds/Releases/IO/ReleasesSerializer.cs

help?

-Peff
