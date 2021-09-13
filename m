Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D603FC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C1C61056
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhIMRVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:21:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46376 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhIMRVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:21:40 -0400
Received: (qmail 20677 invoked by uid 109); 13 Sep 2021 17:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 17:20:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11940 invoked by uid 111); 13 Sep 2021 17:20:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 13:20:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 13:20:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
Message-ID: <YT+IU9J3yn1vlOuc@coredump.intra.peff.net>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
 <YT586/CO7QsTb3TK@coredump.intra.peff.net>
 <xmqqlf41ghmk.fsf@gitster.g>
 <87mtog4pai.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtog4pai.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 02:29:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As for this strvec.h s/int/size_t/ topic. I'm not taking that anywhere,
> Jeff suggested it and came up with the patch, I figured more helpful
> than "if we change s/int/size_t/g for x, shouldn't we change that for y
> which whe assign x to?" would be patches I had to do that, which I'd
> come up with after Jeff suggested this direction in response to another
> topic.

I'm not inherently opposed to further int/size_t cleanups. But the
trouble is that my single patch stands on its own as an improvement to a
real issue, and does not (as far as I know) have any functional
downsides (either known or even hypothetical, aside from the obvious
mismatch that some callers will still use "int").

But doing wide-spread int/size_t conversion has less obvious immediate
benefit, is much easier to get wrong, and may introduce further
complications (e.g., differences of opinion in whether we should be
passing strvecs around more, or just using size_t in more places).

So I don't mind a series in that direction (though I don't necessarily
think it is the best use of time), but I'd prefer not to see my original
patch tied up in it.

-Peff
