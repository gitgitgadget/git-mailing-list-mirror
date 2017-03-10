Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E111FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbdCJTGr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:06:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:42164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755402AbdCJTGp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:06:45 -0500
Received: (qmail 26838 invoked by uid 109); 10 Mar 2017 19:06:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 19:06:44 +0000
Received: (qmail 22352 invoked by uid 111); 10 Mar 2017 19:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 14:06:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 14:06:42 -0500
Date:   Fri, 10 Mar 2017 14:06:42 -0500
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
Message-ID: <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170310151556.18490-1-vegard.nossum@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Note: your original email didn't make it to the list because it's over
100K; I'll quote liberally].

On Fri, Mar 10, 2017 at 04:15:56PM +0100, Vegard Nossum wrote:

> I've used AFL to generate a corpus of pack files that maximises the edge
> coverage for 'git index-pack'.
> 
> This is a supplement to (and not a replacement for) the regular test cases
> where we know exactly what each test is checking for. These testcases are
> more useful for avoiding regressions in edge cases or as a starting point
> for future fuzzing efforts.
> 
> To see the output of running 'git index-pack' on each file, you can do
> something like this:
> 
>   make -C t GIT_TEST_OPTS="--run=34 --verbose" t5300-pack-object.sh
> 
> I observe the following coverage changes (for t5300 only):
> 
>   path                  old%  new%    pp
>   ----------------------------------------
>   builtin/index-pack.c  74.3  76.6   2.3
>   pack-write.c          79.8  80.4    .6
>   patch-delta.c         67.4  81.4  14.0
>   usage.c               26.6  35.5   8.9
>   wrapper.c             42.0  46.1   4.1
>   zlib.c                58.7  64.1   5.4

I'm not sure how I feel about this. More coverage is good, I guess, but
we don't have any idea what these packfiles are doing, or whether
index-pack is behaving sanely in the new lines. The most we can say is
that we tested more lines of code and that nothing segfaulted or
triggered something like ASAN.

That's something I guess, but I'm not enthused by the idea of just
dumping a bunch of binary test cases that nobody, not even the author,
understands.

-Peff
