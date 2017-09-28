Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406742047F
	for <e@80x24.org>; Thu, 28 Sep 2017 00:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbdI1AjR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 20:39:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:52934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752402AbdI1AjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 20:39:17 -0400
Received: (qmail 8710 invoked by uid 109); 28 Sep 2017 00:39:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 00:39:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21518 invoked by uid 111); 28 Sep 2017 00:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 20:39:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 20:39:15 -0400
Date:   Wed, 27 Sep 2017 20:39:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170928003915.rlexebnpj4e5dsk7@sigill.intra.peff.net>
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
 <20170927225126.4836-1-sbeller@google.com>
 <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
 <CAGZ79kYAzcjECZ0Pt3weyxE0V7J0WCM=M-MvM+HM9DgBDcJQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYAzcjECZ0Pt3weyxE0V7J0WCM=M-MvM+HM9DgBDcJQTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 04:57:40PM -0700, Stefan Beller wrote:

> >> +     GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
> >> +     GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
> >> +     export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
> >> +     git checkout -b mode initial &&
> >> +     git update-index --chmod=+x file0 &&
> >
> > would 'test_chmod +x file0 &&' work here?

Oh, I forgot we had that.

> That is what I was looking for in my previous solution,
> this one doesn't care about the on-disk things at all (regarding
> the mode of files).

It still wouldn't have helped there. It does an on-disk chmod and an
index update, with the assumption that the chmod will be a noop on some
systems. So it's good if you want to put the executable bit in the index
and you'd like the working tree to match if it can, or have its change
ignored otherwise.

But if you care about seeing a diff between the working tree and index,
that still wouldn't work.

> So I would argue that test_chmod may be overkill
> (well we could drop the force flag from the following
> checkout... not sure if that is a good trade off)

The "-f" certainly caught me (I only added it after seeing the test
fail). So maybe it's worth doing. I doubt it's all that big a deal
either way.

-Peff
