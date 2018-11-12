Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37CFE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKMAZB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:25:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:35600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727185AbeKMAZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:25:01 -0500
Received: (qmail 28598 invoked by uid 109); 12 Nov 2018 14:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:31:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11042 invoked by uid 111); 12 Nov 2018 14:30:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:30:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:31:28 -0500
Date:   Mon, 12 Nov 2018 09:31:28 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181112143128.GA9913@sigill.intra.peff.net>
References: <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
 <87lg635hz4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg635hz4.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 11:20:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Just a comment on this from the series:
> 
>     Note that it is possible for this to actually be _slower_. We'll do a
>     full readdir() to fill the cache, so if you have a very large number of
>     loose objects and a very small number of lookups, that readdir() may end
>     up more expensive.
> 
>     In practice, though, having a large number of loose objects is already a
>     performance problem, which should be fixed by repacking or pruning via
>     git-gc. So on balance, this should be a good tradeoff.
> 
> Our biggest repo has a very large number of loose objects at any given
> time, but the vast majority of these are because gc *is* happening very
> frequently and the default expiry policy of 2wks is in effect.
> 
> Having a large number of loose objects is not per-se a performance
> problem.

Yes, you're right. I was trying not to get into the rabbit hole of
discussing theoretical tradeoffs, but it is worth addressing. I've
updated that commit message in the patches I'll send out momentarily.

-Peff
