Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315EF20323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdCTEJi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:09:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:47347 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdCTEJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:09:37 -0400
Received: (qmail 23884 invoked by uid 109); 20 Mar 2017 04:02:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:02:55 +0000
Received: (qmail 29205 invoked by uid 111); 20 Mar 2017 04:03:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:03:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:02:51 -0400
Date:   Mon, 20 Mar 2017 00:02:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 5/8] tag: Implicitly supply --list given the -n option
Message-ID: <20170320040250.7kb3sc25fjilhsta@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318103256.27141-6-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 10:32:53AM +0000, Ævar Arnfjörð Bjarmason wrote:

> Most of the work for this was done in my preceding "tag: Implicitly
> supply --list given another list-like option", but I've split off this
> patch since it's more contentious. Now invocations these invocations
> will be synonymous:

s/invocations these/these/

>     git tag -n 100
>     git tag -n --list 100
> 
> Whereas before the former would die. This doesn't technically
> introduce any more ambiguity than change to the other list-like
> options, but it does introduce the possibility for more confusion
> since instead of the latter of these dying:
> 
>     git tag -n100
>     git tag -n 100
> 
> It now works entirely differently, i.e. invokes list mode with a
> filter for "100".

I think:

  git tag --list -n 100

is similarly confusing now. It's really the optional-argument thing that
is misleading, though I suppose silently converting the extra argument
into a filter does add an extra helping of confusion (most other
programs would complain "100 is not a rev" or something, but git-tag
just produces no output).

As I said in the other patch, I could take or leave this one for now,
but I think I'd lean towards "leave".

>  Documentation/git-tag.txt |  9 +++++----
>  builtin/tag.c             |  2 +-
>  t/t7004-tag.sh            | 17 ++++++++++++++++-
>  3 files changed, 22 insertions(+), 6 deletions(-)

The patch itself looks fine.

-Peff
