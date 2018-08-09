Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB971F405
	for <e@80x24.org>; Thu,  9 Aug 2018 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeHIWZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726971AbeHIWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:25:08 -0400
Received: (qmail 1915 invoked by uid 109); 9 Aug 2018 19:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 19:58:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13033 invoked by uid 111); 9 Aug 2018 19:58:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 15:58:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 15:58:45 -0400
Date:   Thu, 9 Aug 2018 15:58:45 -0400
From:   Jeff King <peff@peff.net>
To:     Bartosz Konikiewicz <izdwuut@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's the use case for committing both the freshly created file
 and it's exclusion in .gitignore?
Message-ID: <20180809195845.GE32376@sigill.intra.peff.net>
References: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 01:04:43PM +0200, Bartosz Konikiewicz wrote:

> Hi there!
> 
> I hope that the subject of my message (i.e. the question) is
> exhaustive enough, so I'll just stick to reproducing my issue.
> 
> Steps to reproduce:
> 
> 1. Create a new file.
> 2. Stage the file.
> 3. Add the file to .gitignore.
> 4. Stage the .gitignore.
> 5. Commit changes.
> 
> I imagined that the file would now be removed from the stage (because
> it's ignored now and not yet committed) but it isn't. Where this
> behavior would be desirable? I know that a 'git add' command can be
> invoked with an '-f' flag, which would yield the same result, but I
> can't come up with an explanation where can it be applied.

As far as I know, that is not an intentionally supported workflow. It is
merely the result that .gitignore is only considered when adding new
files to the index, not when committing nor when updating the entry for
an existing file.

If you are asking as a more general case: why do we not complain about
.gitignore for files the index already knows about, then I think that is
useful. It lets you override the .gitignore _once_ when adding the file
initially, and then you don't have to deal with it again (and keep in
mind that the pattern excluding it may be broad, like "*.o", or even
just "*", so simply deleting it from the .gitignore is not an option).

You could probably accomplish this these days by using a negative
pattern in your .gitignore file. But I think the behavior in question
may predate negative patterns (but I didn't dig). It's also a bit
simpler to use in practice, IMHO.

-Peff
