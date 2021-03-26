Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271FC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BEF619FE
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhCZInv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:43:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49654 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhCZInl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 04:43:41 -0400
Received: (qmail 29816 invoked by uid 109); 26 Mar 2021 08:43:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 08:43:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2284 invoked by uid 111); 26 Mar 2021 08:43:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 04:43:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 04:43:39 -0400
From:   Jeff King <peff@peff.net>
To:     shadewither <shdwthr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to disable git verification of ssl proxy?
Message-ID: <YF2eu7Q8LXUnRCGY@coredump.intra.peff.net>
References: <CAKrd5586jDVOSF-aYqqtA=Dt-Qn=zC89MHXkpS=7hNHP779stg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKrd5586jDVOSF-aYqqtA=Dt-Qn=zC89MHXkpS=7hNHP779stg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 11:06:31AM +0800, shadewither wrote:

> git version 2.25.1 / Ubuntu 20.04
> http.sslverify=false does not work. git insists on verifying ssl proxy
> and complains.
> curl has an option of --proxy-insecure to disable proxy verification,
> what is the equivalent for git?

I don't think there is one. Peeking at the curl source code,
--proxy-insecure is setting CURLOPT_PROXY_SSL_VERIFYPEER and
CURLOPT_PROXY_SSL_VERIFYHOST both to 0.

So I think we'd need to plumb through an http.proxysslverify option that
is equivalent to http.sslverify, but using the PROXY variants with
curl_easy_setopt().

-Peff
