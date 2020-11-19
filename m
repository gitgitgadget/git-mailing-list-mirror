Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF0C6379F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0DA2224A
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgKSPpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:45:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:35588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgKSPpA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:45:00 -0500
Received: (qmail 30921 invoked by uid 109); 19 Nov 2020 15:44:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Nov 2020 15:44:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29131 invoked by uid 111); 19 Nov 2020 15:44:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Nov 2020 10:44:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Nov 2020 10:44:58 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <20201119154458.GA25426@coredump.intra.peff.net>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet>
 <20201118183022.GA8396@szeder.dev>
 <20201118184543.GA3016@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011191215140.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2011191215140.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 12:19:10PM +0100, Johannes Schindelin wrote:

> > Yeah, it's likely we'll need to just match the output of "jgit
> > --version". Since their support is hypothetical at this point, I think
> > it makes sense to go with your original patch. It does mean we'll later
> > have to remove the SHA1 prereq from those tests, but that's OK. It's not
> > very many tests, and your commit message clearly explains what is going
> > on.
> 
> It's not just removing the SHA-1 prereq, but testing for a new-enough
> version.
> 
> This most likely entails adding a new test helper to `t/helper/` that
> allows using `versioncmp()` via the command-line, with some clever way to
> indicate the different outcomes, and then using that in a new prereq.
> 
> You know, if it was me, I would opt for the simpler (and future-proof)
> solution I presented above. But hey, if that complex solution using
> `versioncmp()` floats your boat, who am I to stop you.

But that was my (and Gábor's) point: it is not future proof, because we
don't know whether it is a sufficient test until we actually see a
version of JGit with the correct support.

Not only that, but your proposed solution relies on having commits in
the repository, which is not something that a prereq should be relying
on.

We may or may not need the version check eventually, but my point is
that we should be punting on it until we know what is needed.

-Peff
