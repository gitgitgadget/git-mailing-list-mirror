Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FD31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfHHKmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 06:42:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731487AbfHHKmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 06:42:13 -0400
Received: (qmail 11784 invoked by uid 109); 8 Aug 2019 10:42:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 10:42:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18946 invoked by uid 111); 8 Aug 2019 10:44:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 06:44:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 06:42:12 -0400
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature-request: git-bundle --quiet
Message-ID: <20190808104212.GA14189@sigill.intra.peff.net>
References: <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 07:19:11PM +0000, Robin H. Johnson wrote:

> I started trying to make a stab at implementing this, but the code
> wasn't standing out for it. Hopefully somebody else has poked at it
> before:
> 
> I'd like to have a --quiet option for git-bundle, such that only errors
> are sent to stderr, and not the packing progress.

This seems like a reasonable thing to want.

It looks like you'd have to teach cmd_bundle() to use parse_options(),
parse a quiet flag, and then pas that down to create_bundle(). Then it
would pass it along to write_pack_data(), which would decide whether to
pass "-q".

That would allow:

  git bundle --quiet create foo.bundle ...

-Peff
