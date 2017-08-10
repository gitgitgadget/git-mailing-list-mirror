Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723D91F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbdHJXXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752281AbdHJXXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:23:17 -0400
Received: (qmail 2388 invoked by uid 109); 10 Aug 2017 23:23:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:23:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11824 invoked by uid 111); 10 Aug 2017 23:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:23:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:23:15 -0400
Date:   Thu, 10 Aug 2017 19:23:15 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170810232315.twkrj32er552bryg@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
 <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
 <fbd7e636-0087-9c2b-746f-e2413c6d2133@jupiterrise.com>
 <20170810225428.jubkaistxz33ykco@sigill.intra.peff.net>
 <c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 01:17:51AM +0200, Tom G. Christensen wrote:

> > OK, thanks for double-checking. I'm still puzzled why your build
> > succeeds and mine does not.
> 
> I know what's going on now and it's so simple.
> Red Hats version of curl 7.15.5 includes a number of patches including one
> that backports support for CURLPROTO_* (as part of a fix for CVE-2009-0037).
> I haven't checked el6 but I would not be surprised if there where similar
> things going on there.

el6 should have it already as part of 7.19.7, right?

> So in conclusion version based #ifdefs are misleading when used with curl as
> shipped with RHEL.

Yeah, that's certainly an interesting finding. In this case your builds
are missing out on redirect protection that we _could_ be providing.

If we do keep the compat ifdefs around this feature, it may be worth
converting them to "#ifdef CURLPROTO_HTTP" to more directly check the
feature.

-Peff
