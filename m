Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4F41F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeAYAKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:10:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:56498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932293AbeAYAKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:10:17 -0500
Received: (qmail 16291 invoked by uid 109); 25 Jan 2018 00:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31240 invoked by uid 111); 25 Jan 2018 00:10:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:10:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:10:15 -0500
Date:   Wed, 24 Jan 2018 19:10:15 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180125001015.GA17856@sigill.intra.peff.net>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
 <20180124232214.GA11348@sigill.intra.peff.net>
 <87607qyfci.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87607qyfci.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 01:03:25AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > You may also want to use "--threads=1" to avoid non-determinism in the
> > generated packs. In theory, both repos would then produce identical base
> > packs, though it does not seem to do so in practice (I didn't dig in to
> > what the different may be).
> 
> ..and north of 20% with --threads=1.
>
> [...]
>
> Thanks. I'll look into that, although the above results (sans hacking on
> the core pack-objects logic) suggest that even once I create an island
> I'm getting at most 20%.

I think it may be worth figuring out where the two differ. With
--no-reuse-object and --no-reuse-delta, I'd think that the pack
generated for a particular apex commit would be totally deterministic,
regardless of other objects available in the repo. But it's not for some
reason.

-Peff
