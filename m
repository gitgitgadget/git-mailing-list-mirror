Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A09C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5E1205F4
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgAHHao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:30:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:60054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbgAHHan (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 02:30:43 -0500
Received: (qmail 20097 invoked by uid 109); 8 Jan 2020 07:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 07:30:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7814 invoked by uid 111); 8 Jan 2020 07:36:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 02:36:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 02:30:42 -0500
From:   Jeff King <peff@peff.net>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Kevin Daudt <me@ikke.info>, git <git@vger.kernel.org>
Subject: Re: SHA-1 chosen-prefix colission attack
Message-ID: <20200108073042.GD1675456@coredump.intra.peff.net>
References: <20200107173111.GB923852@alpha>
 <20200107203147.r33c5plp5g7pmxmj@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107203147.r33c5plp5g7pmxmj@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 03:31:48PM -0500, Santiago Torres Arias wrote:

> > > As a side result, this shows that it now costs less than 100k USD to
> > > break cryptography with a security level of 64 bits (i.e. to compute
> > > 264 operations of symmetric cryptography).
> 
> Just to clarify:
> 
>     As a stopgap measure, the collision-detection library of Stevens and Shumow [SS17]
>     can be used to detect attack attempts (it successfully detects our attack).
> 
> At the end of section 7.0,

And if anyone is curious, you can test your build of Git against their
sample files by running:

  $ t/helper/test-tool sha1 <messageA
  fatal: SHA-1 appears to be part of a collision attack: 8ac60ba76f1999a1ab70223f225aefdc78d4ddc0

Unfortunately you can't test with actual Git objects, because their
chosen-prefixes don't have object headers. They do estimate that a
classical collision is down to ~11k USD to compute, so maybe we'll see
one eventually. :)

-Peff
