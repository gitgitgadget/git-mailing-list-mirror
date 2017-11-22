Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CC42036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbdKVDRF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:17:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:37228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751443AbdKVDRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:17:04 -0500
Received: (qmail 18819 invoked by uid 109); 22 Nov 2017 03:17:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 03:17:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30567 invoked by uid 111); 22 Nov 2017 03:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 21 Nov 2017 22:17:19 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Nov 2017 22:17:01 -0500
Date:   Tue, 21 Nov 2017 22:17:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171122031701.GA16789@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <xmqqwp2ki4x8.fsf@gitster.mtv.corp.google.com>
 <20171121231739.GB21197@sigill>
 <xmqqr2srxeu2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2srxeu2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 10:49:25AM +0900, Junio C Hamano wrote:

> WRT existing codepaths that pass 0{40} and refuses to notice a
> potential repository corruption (from getting a NULL for a non null
> object name), I think we would need a sweep of the codebase and fix
> them in the longer term.  As long as that will happen someday, either
> approach between "we know 'no loose object? let's redo the packs' is
> the part that matters performance-wise, so let's do a short-cut only
> for that" and "we know that callers that comes with 0{40} want to get
> NULL back" should be OK, I would think.

I agree. Let's go with the "v2 5/5" I posted then.

I'll try to work up a patch for the fetch.c case I found tomorrow, but I
suspect there are many more. But that's largely orthogonal to the
series.

-Peff
