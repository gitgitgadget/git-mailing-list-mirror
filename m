Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CA71F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJDCHu (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:07:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726884AbeJDCHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:07:49 -0400
Received: (qmail 5472 invoked by uid 109); 3 Oct 2018 19:18:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 19:18:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16646 invoked by uid 111); 3 Oct 2018 19:17:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 15:17:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:18:05 -0400
Date:   Wed, 3 Oct 2018 15:18:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003191805.GB16666@sigill.intra.peff.net>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 02:59:34PM -0400, Derrick Stolee wrote:

> > They don't help yet, and there's no good reason to enable bitmaps for
> > clients. I have a few patches that use bitmaps for things like
> > ahead/behind and --contains checks, but the utility of those may be
> > lessened quite a bit by Stolee's commit-graph work.  And if it isn't,
> > I'm mildly in favor of replacing the existing .bitmap format with
> > something better integrated with commit-graphs (which would give us an
> > opportunity to clean up some of the rough edges).
> 
> If the commit-graph doesn't improve enough on those applications, then we
> could consider adding a commit-to-commit reachability bitmap inside the
> commit-graph. ;)

That unfortunately wouldn't be enough for us to ditch the existing
.bitmap files, since we need full object reachability for some cases
(including packing). And commit-to-commit reachability is a trivial
subset of that. I'm not sure if it would be better to just leave
.bitmaps in place as a server-side thing, and grow a new thing for
commit-to-commit reachability (since it would presumably be easier).

I'm still excited about the prospect of a bloom filter for paths which
each commit touches. I think that's the next big frontier in getting
things like "git log -- path" to a reasonable run-time.

-Peff
