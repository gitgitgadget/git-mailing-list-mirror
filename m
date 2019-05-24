Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288861F609
	for <e@80x24.org>; Fri, 24 May 2019 07:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfEXH10 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 03:27:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388910AbfEXH10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 03:27:26 -0400
Received: (qmail 25687 invoked by uid 109); 24 May 2019 07:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 07:27:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6922 invoked by uid 111); 24 May 2019 07:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 03:28:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 03:27:24 -0400
Date:   Fri, 24 May 2019 03:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190524072724.GH25694@sigill.intra.peff.net>
References: <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
 <87tvdlt1jp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvdlt1jp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 09:26:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I spent a while thinking and experimenting with this tonight. The result
> > is the patch below. Ævar, do you still have a copy of the repo that
> > misbehaved? I'd be curious to see how it fares.
> 
> No, sorry. I think we could make an artificial test to emulate it, which
> would be something like:
> 
>  * ~1 million commits
>  * local clone setup to fetch all branches/tags (default 'git clone')
>  * local a bit ahead/behind
>  * Have old "main" pack with *.bitmap, bunch of other packs/loose objects without that
>  * push try to push the local change upstream (or to a topic branch)
> 
> I tried briefly to emulate this with git.git with:
> [...]
> But didn't get anywhere, probably because here my topics are all stuff I
> have already, and I just have 2x packs.

Yeah, I haven't been able to find a reproduction for this problem at
will. The bitmaps are _supposed_ to be sprinkled around through the
commit graph so that we don't have to walk far. But presumably in your
case that was not so.

I'm not sure what tickles the bitmap-writer to fail so hard. Is it
having too many refs? Weird patterns in the graph? Just a ton of
commits?

-Peff
