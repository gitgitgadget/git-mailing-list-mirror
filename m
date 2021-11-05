Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B52C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9261161056
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhKEXcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 19:32:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54116 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKEXca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 19:32:30 -0400
Received: (qmail 12810 invoked by uid 109); 5 Nov 2021 23:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 23:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23741 invoked by uid 111); 5 Nov 2021 23:29:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 19:29:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 19:29:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test_bitmap_hashes(): handle repository without bitmaps
Message-ID: <YYW+baYx+M7ZhaJU@coredump.intra.peff.net>
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g>
 <YYWBz6rjF+I+JkO3@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYWBz6rjF+I+JkO3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 03:11:11PM -0400, Taylor Blau wrote:

> > I wonder how you found it.  Diagnosing a repository that did not
> > seem healthy?  What I am getting at is if we want a new option to
> > make a plumbing command, other than the test-tool, that calls this
> > function, as the latter is usually not deployed in the field.
> 
> I would not be surprised if this was discovered via Coverity, or by
> manual inspection. Peff and I have been merging a slew of releases from
> your tree into GitHub's fork and so have been reading code in the more
> recently changed areas.

It was Coverity in this case. I haven't actually used the name-hash
dumper for any real-world debugging.

> On the test-tool vs. plumbing thing: I think there are some compelling
> reasons in either direction. There's no *good* home for these in our
> current set of plumbing tools. E.g., the closest example we have is `git
> rev-list --test-bitmap <rev>`, which is kind of ugly. When we needed
> these new inspection tools for some of the newer bitmap-related tests,
> adding them via the test-helper suite was a conscious choice to not
> build on the ugliness of `--test-bitmap`.
> 
> But on occasion these test-tool things are useful to have "in the
> field", as you say. It's rare enough that I usually just clone a copy of
> our fork as needed and build it when I do find myself reaching for
> test-helpers.

Yeah, I could see arguments both ways on such tools (not just bitmaps,
but other "debug this binary format" tools like read-midx and
read-graph). I'm content to leave it as-is until I come across more
in-the-field cases where those tools would be useful. Half the time I
end up in a debugger anyway. ;)

-Peff
