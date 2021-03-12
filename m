Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B641164F90
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCLBZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:25:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:33048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhCLBYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:24:37 -0500
Received: (qmail 19961 invoked by uid 109); 12 Mar 2021 01:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Mar 2021 01:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15735 invoked by uid 111); 12 Mar 2021 01:24:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 20:24:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 20:24:36 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: store credential when PKI auth is used
Message-ID: <YErC1LIaxomLd3Gu@coredump.intra.peff.net>
References: <20210306225253.87130-1-john@szakmeister.net>
 <YEkljZWg4+lTQRyS@coredump.intra.peff.net>
 <CAEBDL5U=BxHzYWmG2Cpw+XcMJTF8_Qp0KXoKz6N+fHp1ZWdbRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEBDL5U=BxHzYWmG2Cpw+XcMJTF8_Qp0KXoKz6N+fHp1ZWdbRQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 08:01:53PM -0500, John Szakmeister wrote:

> >   - I think proxy_cert_auth would probably want the same treatment.
> 
> Oh, I think I misread this before making my fixes.  I think what you're
> saying here is that proxy_cert_auth should be approved and rejected
> in the same spots as the client cert auth?  I missed that but am happy
> to add it, if that's what you meant.  The only trouble is that I don't have
> a great way of checking that particular feature.

Yep, that's what I meant. Looking at CURLE_SSL_* in curl.h, it looks
like there's no way to distinguish a proxy cert problem from a regular
cert problem. So probably we'd need to reject both when we see
CURLE_SSL_CERTPROBLEM. As long as somebody is not using both at once, it
would not matter at all. And even if they are, the worst case is having
to put in their password again.

That said, given that nobody has asked for it and you have no easy way
of testing it, I'm content to leave it be for now. Your patches
shouldn't make anything worse there, and it shouldn't be too hard to
find this discussion in the list archive later.

-Peff
