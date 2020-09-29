Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C61C4727D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DB4207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgI2WNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:13:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:44852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgI2WNN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 18:13:13 -0400
Received: (qmail 19471 invoked by uid 109); 29 Sep 2020 22:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2020 22:13:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22172 invoked by uid 111); 29 Sep 2020 22:13:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2020 18:13:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Sep 2020 18:13:11 -0400
From:   Jeff King <peff@peff.net>
To:     "Wu, Zhichen" <zhwu@amazon.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20200929221311.GA15129@coredump.intra.peff.net>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 29, 2020 at 01:17:59AM +0000, Wu, Zhichen wrote:

> 1. Since v2 protocol has been launched for 2 years, is there any plan
>    in the near future about v1 deprecation?

I suppose it depends what you mean by deprecation.

v2 is not even the default yet (but hopefully will be soon, perhaps in
the next release).

Once that happens, I doubt that we will add new capabilities or features
to v1 in general. Old versions of Git would not be able to take
advantage of them anyway, and new ones would be using v2.

But I don't think v1 will go away for a long time. There will still be
v1 clients and v1 servers hanging around for many years, and modern
versions of Git will need to speak both.

> 2. I see v2 has a capability called “object-format” that provides SHA1
>    option. I’m wondering if that capability will be the only way for
>    client and server to start using SHA256? Or put it as another word,
>    will v2 protocol be the prerequisite of SHA256?

I think it would be impossible to handle object-format via v1, because
the v1 protocol writes the ref advertisement before any capabilities are
negotiated. So I think v1 must implicitly remain sha1-only (and a sha256
repository on the server side would need to either reject a v1 client,
or back-translate as it would for a v2 client which asks for sha1).

-Peff
