Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D507220A21
	for <e@80x24.org>; Fri, 15 Sep 2017 00:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdIOAh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 20:37:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:39364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751516AbdIOAh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 20:37:56 -0400
Received: (qmail 16719 invoked by uid 109); 15 Sep 2017 00:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 00:37:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1441 invoked by uid 111); 15 Sep 2017 00:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 20:38:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 20:37:54 -0400
Date:   Thu, 14 Sep 2017 20:37:54 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170915003754.wlckhuwcftyc32de@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
 <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
 <ef20628e-b7c0-8909-31a0-cc126d0c40ba@ramsayjones.plus.com>
 <1012b31b-7bdd-ea20-f004-1c9f80de733c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1012b31b-7bdd-ea20-f004-1c9f80de733c@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 12:31:38AM +0100, Ramsay Jones wrote:

> > Hmm, about three or four years ago, I spent two or three evenings
> > getting git to compile -Wextra clean. I remember the signed/unsigned
> > issue was the cause of a large portion of the warnings issued by
> > the compiler. I was surprised that it took such a relatively short
> > time to do. However, it affected quite a large portion of the code, so
> > I didn't think Junio would even consider applying it. Also, I only used
> > gcc and was anticipating having additional warnings on clang (but I
> > didn't get around to trying).
> > 
> > Maybe I should give it another go. :-D
> 
> For example, I remember the patch given below reduced the number
> of warnings quite a bit (because it's an inline function in a
> header file).
> 
> I just tried it again tonight; the current master branch has 3532
> warnings when compiled with -Wextra, 1409 of which are -Wsign-compare
> warnings. After applying the patch below, those numbers are reduced
> by 344 to 3188/1065.

I'd love it if we were clean on -Wextra. My big question is many
contortions we'd have to go through in the code. I don't mind at all if
we're actually cleaning as we go (e.g., using types of the correct
signedness, or preventing possible funny interactions). I'm just worried
it will turn into a bunch of noisy casts.

The patch you showed seems like an improvement to the code, but I don't
know if that would be the case for all of them. :)

-Peff
