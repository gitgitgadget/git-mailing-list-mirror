Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A642C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 18:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDESPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDESPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 14:15:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B865B2
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 11:15:07 -0700 (PDT)
Received: (qmail 5500 invoked by uid 109); 5 Apr 2023 18:15:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Apr 2023 18:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13587 invoked by uid 111); 5 Apr 2023 18:15:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 14:15:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 14:15:05 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <20230405181505.GA517608@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net>
 <ZC2wppC62E7wOcqM@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC2wppC62E7wOcqM@xps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote:

> Yeah, agreed, the scripts we install are fine from all I can tell. I
> should've clarified, but what I care about is our build infra as well as
> our test scripts. That's neither clear from the commit description nor
> from the changes that I'm doing.

Ah, OK, that makes more sense.

> I'd be happy to keep the current state of installed scripts as-is and
> resend another iteration of this patch that only addresses shebangs used
> in internal scripts.

We generally try to use $PERL_PATH even for building and testing by
invoking "$PERL_PATH script.pl", and declaring a perl() wrapper within
the test scripts. But I would not be surprised if there are cases where
we fail to (and nobody noticed because it usually just works to find one
at /usr/bin/perl).

IMHO we should aim for fixing those inconsistencies, and then letting
people set PERL_PATH as appropriate (even to something that will find it
via $PATH if they want to).

-Peff
