Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A22F1F732
	for <e@80x24.org>; Wed, 31 Jul 2019 04:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfGaE2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:28:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:56464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387473AbfGaE2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:28:09 -0400
Received: (qmail 11280 invoked by uid 109); 31 Jul 2019 04:28:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:28:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13488 invoked by uid 111); 31 Jul 2019 04:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:29:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:28:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: Warnings in gc.log can prevent gc --auto from running
Message-ID: <20190731042807.GA26237@sigill.intra.peff.net>
References: <qhdnuh$5m5r$1@blaine.gmane.org>
 <20190729100745.GA2755@sigill.intra.peff.net>
 <87v9vl57in.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9vl57in.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 02:50:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Instead, it may make sense to turn the --write-bitmap-index option of
> > pack-objects into a tri-state: true/false/auto. Then pack-objects would
> > know that we are in best-effort mode, and would avoid warning in that
> > case. That would also let git-repack express its intentions better to
> > git-pack-objects, so we could replace 7328482253, and keep more of the
> > logic in pack-objects, which is ultimately what has to make the decision
> > about whether it can generate bitmaps.
> 
> Sounds like pentastate to me :) (penta = 5, had to look it up). I.e. in
> most cases of "auto" we pick a true/false at the outset, whereas this is
> true/true-but-dont-care-much/false/false-but-dont-care-much with "auto"
> picking the "-but-dont-care-much" versions of a "soft" true/false.

I don't think we care about false-but-dont-care-much. Pack-objects just
needs to know whether the bitmaps are the user's expressed intention, or
just something that it should do if it's convenient.

I'll see if I can work up a patch to demonstrate.

> On this general topic a *soft* poke about relying to
> https://public-inbox.org/git/8736lnxlig.fsf@evledraar.gmail.com/ if you
> have time. I think a "loose pack" might be a way forward for the loose
> object proliferation, but maybe I'm wrong.

I just left a reply, though I think most of the discussion there is
about the actual pruning-corruption race. I'm totally on board with the
idea of an "unreachable pack", but AFAIK nobody has produced any
patches yet.

> More generally we're really straining the gc.log pass-along-a-message
> facility.

I definitely agree with that. :)

-Peff
