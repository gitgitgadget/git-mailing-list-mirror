Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29D11F461
	for <e@80x24.org>; Thu, 16 May 2019 04:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfEPEOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 00:14:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725818AbfEPEOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 00:14:46 -0400
Received: (qmail 4903 invoked by uid 109); 16 May 2019 04:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 04:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27136 invoked by uid 111); 16 May 2019 04:15:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 00:15:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 00:14:44 -0400
Date:   Thu, 16 May 2019 00:14:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190516041444.GG4596@sigill.intra.peff.net>
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <871s0zwjv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s0zwjv0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 10:20:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Since this is going to have to happen anyway
> 
> The SHA-1 <-> SHA-256 transition is planned to happen, but there's some
> strong opinions that this should be *only* for munging the content for
> hashing, not adding new stuff while we're at it (even if optional). See
> : https://public-inbox.org/git/87ftyyedqd.fsf@evledraar.gmail.com/

One reason for this is that the transition plan calls for being able to
convert between the sha1 and sha256 representations losslessly (which
makes interoperability possible and avoids a flag day). So even if the
sha256 format understood floating-point timestamps in the committer
header, we'd have to have some way of representing that same information
in the sha1 format. Which implies putting it into a new header, as you
described below.

And if it's in a new header in sha1, then is there any real advantage in
having it somewhere else in the sha256 version? I dunno. Maybe a little,
as eventually all of the sha1 formats would die off, after everybody has
transitioned.

-Peff
