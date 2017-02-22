Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D94201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbdBVXdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:33:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:60292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbdBVXdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:33:36 -0500
Received: (qmail 725 invoked by uid 109); 22 Feb 2017 23:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 23:33:36 +0000
Received: (qmail 19705 invoked by uid 111); 22 Feb 2017 23:33:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:33:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 18:33:33 -0500
Date:   Wed, 22 Feb 2017 18:33:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
 <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
 <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net>
 <xmqqwpchanxz.fsf@gitster.mtv.corp.google.com>
 <20170222215833.d7htyo32ptfse5l4@sigill.intra.peff.net>
 <xmqqshn5am74.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshn5am74.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 02:35:11PM -0800, Junio C Hamano wrote:

> A solution along your line would help Negotiate users OOB experience
> without hurting the servers that do not offer Negotiate, but until
> that materializes, users can set the lazier http.emptyAuth on
> (without selectively setting http.<host>.emptyAuth off for sites
> without Negotiate) and hurt the servers by throwing an empty auth
> anyway regardless of the default, so the flipping of the default is
> not fundamentally adding more harm in that sense.

I was hoping to materialize it today. :)

Here's what I came up with. I have a lot of questions about the second
patch which I'll outline there. But I think it may be a good start.

  [1/2]: http: restrict auth methods to what the server advertises
  [2/2]: http: add an "auto" mode for http.emptyauth

 http.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

-Peff
