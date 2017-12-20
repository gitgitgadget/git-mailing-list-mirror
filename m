Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93861F404
	for <e@80x24.org>; Wed, 20 Dec 2017 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755121AbdLTNFF (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 08:05:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:44008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755073AbdLTNFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 08:05:04 -0500
Received: (qmail 9017 invoked by uid 109); 20 Dec 2017 13:05:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 13:05:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12417 invoked by uid 111); 20 Dec 2017 13:05:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 08:05:29 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 08:05:02 -0500
Date:   Wed, 20 Dec 2017 08:05:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171220130501.GC17569@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
 <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
 <20171208212832.GC7355@sigill.intra.peff.net>
 <f1584860-d0d6-db82-0a49-021924c3e2b7@web.de>
 <20171219113855.GA24558@sigill.intra.peff.net>
 <f79ae9a3-de47-c41e-fea6-6a0fedf4ef63@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f79ae9a3-de47-c41e-fea6-6a0fedf4ef63@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 07:26:06PM +0100, René Scharfe wrote:

> > That's the same duality we have now with string_list.
> 
> Hmm, I thought we *were* discussing string_list?

Right, I guess what I was wondering is if a wrapper over string_list
really ends up any better than having the dual-natured string_list.

If they both use the same struct, then your wrappers are all just
functions. And isn't that more or less what we have now?

If they're actually different structs, then that complicates call
signatures for functions that take a list (unless we are getting into
polymorphism, they need to specify one of the types, even if they don't
particularly care whether it's an allocated list or not).

-Peff
