Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B3D60FC3
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhJHD52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:57:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhJHD50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 23:57:26 -0400
Received: (qmail 2702 invoked by uid 109); 8 Oct 2021 03:55:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 03:55:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30451 invoked by uid 111); 8 Oct 2021 03:55:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 23:55:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 23:55:30 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <YV5yi+AejPGO9qOi@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV5yi+AejPGO9qOi@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:39AM -0400, Taylor Blau wrote:

> On Wed, Oct 06, 2021 at 10:38:18PM -0400, Jeff King wrote:
> > The reason for that is that I didn't find it by inspection; I've started
> > running my personal builds through coverity. It wasn't too bad to set up
> > with a GitHub Action, like so:
> >
> > [...]
> 
> It looks like this would never cause the build to fail, but is merely
> responsible for sending any warnings off to Coverity's UI?

Sort of. They basically wrap the "make" invocation to intercept "cc". My
understanding is that their faux-compiler is mostly about gathering data
about the code. That gets stuffed into a tarball and uploaded to their
servers, where the real analysis happens.

It's very black-box, which I don't love. But in my experience it
produces by far the most useful static-analysis output of any tool I've
seen.

> > There are tons of existing warnings, many of which are false positives.
> > But it keeps track of which problems are new, and emails out a summary
> > of only the new ones (which is how I saw the leak here, which just hit
> > next). I don't care all that much about leaks here (we have other
> > techniques for finding them), but when Stefan used to do regular
> > coverity builds in the past, it routinely found useful errors.
> 
> I'm generally pessimistic about tools like Coverity, but I share your
> experience that Coverity warnings are actually pretty high quality. Or
> at least they have a high enough signal-to-noise ratio that it makes
> them worth looking through.
> 
> So I would be happy to have forks of GitHub have fewer barriers to use
> this tool.

OK. I'll see if I can clean up the patch a bit.

-Peff
