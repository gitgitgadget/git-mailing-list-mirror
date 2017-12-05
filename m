Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1E220C11
	for <e@80x24.org>; Tue,  5 Dec 2017 07:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbdLEHCw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 02:02:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:48322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750740AbdLEHCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 02:02:51 -0500
Received: (qmail 29955 invoked by uid 109); 5 Dec 2017 07:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Dec 2017 07:02:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29844 invoked by uid 111); 5 Dec 2017 07:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 05 Dec 2017 02:03:12 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Dec 2017 02:02:50 -0500
Date:   Tue, 5 Dec 2017 02:02:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule
 by default
Message-ID: <20171205070249.GC4788@sigill.intra.peff.net>
References: <20171128213214.12477-1-avarab@gmail.com>
 <20171128213214.12477-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171128213214.12477-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 09:32:13PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the build process so that instead of needing to supply
> DC_SHA1_SUBMODULE=YesPlease to use the sha1collisiondetection
> submodule instead of the copy of the same code shipped in the sha1dc
> directory, it uses the submodule by default unless
> NO_DC_SHA1_SUBMODULE=UnfortunatelyYes is supplied.
> 
> This reverses the logic added by me in 86cfd61e6b ("sha1dc: optionally
> use sha1collisiondetection as a submodule", 2017-07-01). Git has now
> shipped with the submodule in git.git for two major releases, if we're
> ever going to migrate to fully using it instead of perpetually
> maintaining both sha1collisiondetection and the sha1dc directory this
> is a logical first step.
> 
> This change removes the "auto" logic Junio added in
> cac87dc01d ("sha1collisiondetection: automatically enable when
> submodule is populated", 2017-07-01), I feel that automatically
> falling back to using sha1dc would defeat the point, which is to smoke
> out any remaining users of git.git who have issues cloning the
> submodule for whatever reason.

I'm not sure how I feel about this. I see your point that there's no
real value in maintaining two systems indefinitely.  At the same time, I
wonder how much value the submodule strategy is actually bringing us.

IOW, are we agreed that the path forward is to get everybody using the
submodule?

It seems like it's going to cause some minor pain for CI and packaging
systems that now need to care about submodules (so at least flipping the
switch, but maybe also dealing with having a network dependency for the
build that was not already there).

I'll admit I'm more sensitive to this than most people, since I happen
to maintain a fork of Git that I run through an internal CI system. And
that CI otherwise depends only on the locally-held fork, not any
external resources. But I'm probably in a fairly unique situation there.

-Peff
