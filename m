Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC041F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfGWUQv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:16:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbfGWUQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:16:51 -0400
Received: (qmail 10194 invoked by uid 109); 23 Jul 2019 20:16:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jul 2019 20:16:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12838 invoked by uid 111); 23 Jul 2019 20:17:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2019 16:17:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jul 2019 16:16:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Raitanen, Adam" <araitane@ciena.com>
Cc:     James Knight <james.d.knight@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [**EXTERNAL**] Re: Possible bug in Makefile when executing
 curl-config
Message-ID: <20190723201649.GA4995@sigill.intra.peff.net>
References: <DM6PR04MB47939645A97D099241AD25F0D0C40@DM6PR04MB4793.namprd04.prod.outlook.com>
 <20190722211219.GB31664@sigill.intra.peff.net>
 <DM6PR04MB479387667E7EDEF2A27BFCA2D0C70@DM6PR04MB4793.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR04MB479387667E7EDEF2A27BFCA2D0C70@DM6PR04MB4793.namprd04.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 23, 2019 at 07:43:01PM +0000, Raitanen, Adam wrote:

> Yes there is a config.mak.autogen and it does not have an entry for CURL_CONFIG, although it has a correct entry for CURLDIR.
> 
> The config.log also shows it checking for curl-config and not finding it then proceeding anyway:
> 
> configure:5917: checking for curl-config
> configure:5945: result: no

OK, that makes sense from what I see in configure.ac. The "--with-curl"
flag does not interact at all with the curl-config test, but only sets
CURLDIR.

It seems like we should at least look for $CURLDIR/bin/curl-config in
such a case. But I think the fallback patch I showed earlier would
probably work for you, too (since on your system "curl-config --libs" is
likely just going to show "-lcurl" anyway).

Let's see what James says.

-Peff
