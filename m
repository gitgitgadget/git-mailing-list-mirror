Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA4E1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 06:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfG3G7v (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 02:59:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:55158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727453AbfG3G7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 02:59:50 -0400
Received: (qmail 2606 invoked by uid 109); 30 Jul 2019 06:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jul 2019 06:59:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5291 invoked by uid 111); 30 Jul 2019 07:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 03:01:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 02:59:49 -0400
From:   Jeff King <peff@peff.net>
To:     Ibrahim El Rhezzali <ibrahim.elrhezzali@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Improved git signing interface
Message-ID: <20190730065949.GB4901@sigill.intra.peff.net>
References: <CACi-FhDeAZecXSM36zroty6kpf2BCWLS=0R+dUwuB96LqFKuTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACi-FhDeAZecXSM36zroty6kpf2BCWLS=0R+dUwuB96LqFKuTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 22, 2019 at 04:16:15PM +0200, Ibrahim El Rhezzali wrote:

> I have been selected by the Linux Foundation to work on a summer
> project. I would like to abstract the git signing interface and add
> support for signatures using decentralized identifiers (DID).
> Decentralized identifiers are an emerging standard [0] that allows
> individuals to control their own digital identities, and is often
> called self-sovereign identity (SSI). The SSIMeetup is a good place to
> learn more about SSI [1] and DIDs [2].
> 
> The project’s current goal is to abstract the current GPG interface
> into a more ‘generic’ API that supports the existing OpenPGP and X.509
> functionality while creating the ability to write additional signature
> drivers.

Neat. I'm always wary of supporting "emerging standards", because
sometimes they turn out not to emerge and you are left with historical
cruft. :) But if your changes to Git are mostly around making the
signing config more generic, I think that is something people are
interested in (signify has come up as a possibility before).

You might find this discussion interesting (that patch and the
sub-thread):

 https://public-inbox.org/git/20180409204129.43537-9-mastahyeti@gmail.com/

One of the points I think people didn't like was how Git would detect
signatures embedded in objects (i.e., is matching PEM-like lines enough,
or what would other signing systems want?).

That patch was later dropped in favor of the work from Henning Schild:

  https://public-inbox.org/git/cover.1531208187.git.henning.schild@siemens.com/

which is much more geared at just adding gpgsm support. There were
various discussions about how it could eventually be extended to new
formats. I skimmed over the documentation from your branch and it looks
like a pretty sane layout, with backwards compatibility.

> I have implemented a prototype that works and passes all tests, and in
> the coming weeks I plan to submit a series of patches for your review.
> I first need to clean up the Git history to make it easy to follow. I
> will also ensure that people using the current approach to GPG signing
> can use the proposed approach with only minor changes. The flag
> “--gpg-sign” would evolve to “---sign”, though I would like to
> preserve an alias to the old flag if possible.

Yes, this must not be "minor changes" but "no changes" to be accepted.
It's OK to deprecate things, but old options cannot immediately stop
working. From this email and looking at your config patches, it looks
like that's the route you plan to take. Good.

I look forward to seeing the cleaned-up patches. :)

-Peff
