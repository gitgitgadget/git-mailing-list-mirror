Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEFC56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828B5221FE
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKRSpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:45:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:34290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKRSpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:45:45 -0500
Received: (qmail 24799 invoked by uid 109); 18 Nov 2020 18:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 18:45:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16702 invoked by uid 111); 18 Nov 2020 18:45:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Nov 2020 13:45:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Nov 2020 13:45:43 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <20201118184543.GA3016@coredump.intra.peff.net>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet>
 <20201118183022.GA8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118183022.GA8396@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 07:30:22PM +0100, SZEDER Gábor wrote:

> > I wonder whether there is a way to change the `JGIT` prereq in a way
> > that automagically will recognize a (future) SHA256-enabled JGit?
> > Something like
> > 
> > test_lazy_prereq JGIT '
> > 	jgit --version &&
> >         test_have_prereq !SHA1 ||
> > 	test "$(git rev-list -n 1 HEAD)" = "$(jgit rev-list -n 1 HEAD)"
> > '
> > 
> > What do you think?
> 
> I'm not sure.  It is surely a substantial effort to fully support
> SHA256, and I suppose there will be JGit versions with only partial
> support.  I'm worried that there will be versions that can already
> read SHA256 objects, but can't read/write SHA256 pack bitmaps, or
> can't transfer/negotiate SHA256 objects yet (for t5512), so even
> though they could fulfill such a prereq test above, the test would
> still fail.

Yeah, it's likely we'll need to just match the output of "jgit
--version". Since their support is hypothetical at this point, I think
it makes sense to go with your original patch. It does mean we'll later
have to remove the SHA1 prereq from those tests, but that's OK. It's not
very many tests, and your commit message clearly explains what is going
on.

-Peff
