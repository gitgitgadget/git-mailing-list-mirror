Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DDB1F461
	for <e@80x24.org>; Fri, 17 May 2019 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfEQAXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:23:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727612AbfEQAXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:23:06 -0400
Received: (qmail 7739 invoked by uid 109); 17 May 2019 00:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 00:23:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8859 invoked by uid 111); 17 May 2019 00:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 20:23:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 20:23:04 -0400
Date:   Thu, 16 May 2019 20:23:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Michael Osipov <michael.osipov@siemens.com>
Subject: Re: [PATCH] Makefile: remove the NO_R_TO_GCC_LINKER flag
Message-ID: <20190517002303.GB13525@sigill.intra.peff.net>
References: <20190516093412.14795-1-avarab@gmail.com>
 <20190516180521.1933-1-avarab@gmail.com>
 <20190516222525.GC11784@sigill.intra.peff.net>
 <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 08:21:09AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Far be it from me to care about AIX, but it seems like this is ripe for
> > regressions, because we don't know which platforms were relying on "-R"
> > instead of "-Wl,-rpath", and now everybody will be using the latter by
> > default.
> 
> I do not have a stake in AIX, either, but I had the same reaction.
> 
> Those who found having to give NO_R_TO_GCC_LINKER=NoThanks annoying
> could have passed CC_LD_DYNPATH=-Wl,-rpath instead, but that is not
> much shorter or sweeter X-<; with this change, they do not have to
> do anything, but those who are broken can pass CC_LD_DYNPATH=-R to
> unbreak it.  So it may not be the end of the world, but this move
> certainly smells like robbing non-GCC users to pay GCC users to me.

Thanks, I wasn't quite clear on whether there was an escape hatch for
people who were broken (I took Ævar's "perhaps we should follow this up"
meaning we needed to add new knobs, but it is really just "perhaps we
should set this existing knob by default on AIX"). So that at least
quells the worst of my worries.

After that, I agree it's now just a question of the default. I don't
have a sense whether the majority is helped or hurt here (I admit that I
did not even know about these flags, despite compiling with gcc for the
past 13 years, so possibly everybody was perfectly happy with the
existing behavior).

-Peff
