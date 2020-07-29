Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBDCC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4072D2075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG2Smk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:42:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:41366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Smk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:42:40 -0400
Received: (qmail 8264 invoked by uid 109); 29 Jul 2020 18:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 18:42:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7179 invoked by uid 111); 29 Jul 2020 18:42:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 14:42:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 14:42:39 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract
 "-m"
Message-ID: <20200729184239.GB2339835@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200728163853.GB2650252@coredump.intra.peff.net>
 <CAPx1Gvf7d5kdPqYVvruStZuXTySBFZEWMx_1O2MtWJatUM3j+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1Gvf7d5kdPqYVvruStZuXTySBFZEWMx_1O2MtWJatUM3j+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 10:52:14AM -0700, Chris Torek wrote:

> On Tue, Jul 28, 2020 at 9:40 AM Jeff King <peff@peff.net> wrote:
> > I pulled the option name from the rev_info field name. It might be too
> > broad (we are not ignoring merges during the traversal, only for the
> > diff). It could be "--no-diff-merges" or something, but that would
> > involve flipping the sense of the boolean (but that would just be in the
> > code, not user-visible, so not that big a deal).
> 
> Perhaps a bit bikesheddy, but I would suggest some clarifying
> notes in the documentation.  The fact that `git log` *follows*
> merges by default is pretty obvious, but the fact that it doesn't
> *diff them at all* by default appears to be surprising to most Git
> newcomers.  (It was to me, so many years ago, and I see this all
> the time on stackoverflow.)

Yeah, I agree this is a point of confusion. My hope is that the code
change makes some of the confusion go away without people having to read
the documentation.

But I think "git log -p" (or "git log -Sfoo") still remains as a point
of confusion. Possibly we should be using "--cc" by default there, too.
It's obviously more expensive, but I wonder how much that really matters
in practice. I'd rather not tie it in to this series, though, which I
think is more unambiguously helpful. :)

>   Note that --ignore-merges / --no-ignore-merges affect
>   only diff generation, not commit traversal.

Yeah, that would definitely reduce confusion, but I'm switching it to
--diff-merges (and flipping the boolean nature), which I think is even
better.

>   Note
>   also that by default, "git log -p" does not generate
>   diffs for merges except when using --first-parent.
>   See also the -c and --cc options and note that the
>   default for "git show" is "--cc".

I think this would be useful to have in the manpage, but not under this
option. It looks like we can expand on this under the "Diff Formatting"
section. That's still kind of buried, but is the first place that makes
any sense to me. I'll see if I can do a patch on top of my series.

-Peff
