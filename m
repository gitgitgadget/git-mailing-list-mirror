Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550EB207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934824AbcI2S0n (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:26:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:50027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934682AbcI2S0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:26:40 -0400
Received: (qmail 11402 invoked by uid 109); 29 Sep 2016 18:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 18:26:23 +0000
Received: (qmail 3403 invoked by uid 111); 29 Sep 2016 18:26:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:26:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 14:26:21 -0400
Date:   Thu, 29 Sep 2016 14:26:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
Message-ID: <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-3-gitster@pobox.com>
 <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
 <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 11:13:45AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think anytime you would use GIT_CONFIG_NOSYSTEM over --local, it is an
> > indication that the test is trying to check how multiple sources
> > interact. And the right thing to do for them is to set GIT_ETC_GITCONFIG
> > to some known quantity. We just couldn't do that before, so we skipped
> > it.  IOW, something like the patch below (on top of yours).
> 
> OK, that way we can make sure that "multiple sources" operations do
> look at the system-wide stuff.

Exactly.

> > Note that the
> > commands that are doing a "--get" and not a "--list" don't actually seem
> > to need either (because they are getting the values out of the local
> > file anyway), so we could drop the setting of GIT_ETC_GITCONFIG from
> > them entirely.
> 
> "either" meaning "we do not need to add --local and we do not need
> GIT_CONFIG_NOSYSTEM"?

Yes. I didn't test it with your core.abbrev patch 4/4, but I _didn't_
have to touch their expected output after pointing them at a non-empty
etc-gitconfig file in the trash directory. Which implies to me they
don't care either way (which makes sense; they are asking for a specific
key which is supposed to be found in one of the other files).

-Peff
