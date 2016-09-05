Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21E820705
	for <e@80x24.org>; Mon,  5 Sep 2016 23:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbcIEXVt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 19:21:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38515 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932366AbcIEXVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 19:21:48 -0400
Received: (qmail 13592 invoked by uid 109); 5 Sep 2016 23:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 23:21:48 +0000
Received: (qmail 22717 invoked by uid 111); 5 Sep 2016 23:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 19:21:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 19:21:45 -0400
Date:   Mon, 5 Sep 2016 19:21:45 -0400
From:   Jeff King <peff@peff.net>
To:     "Leho Kraav (Conversion Ready)" <leho@conversionready.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.10.0: multiple versionsort.prereleasesuffix buggy?
Message-ID: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
References: <beba7c55-3f18-66a2-acd9-77f2a5cc55a7@conversionready.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <beba7c55-3f18-66a2-acd9-77f2a5cc55a7@conversionready.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2016 at 01:42:28AM +0300, Leho Kraav (Conversion Ready) wrote:

> Here's the testing tree https://github.com/woothemes/woocommerce
> 
> .git/config has:
> 
> [versionsort]
> 
> 
>     prereleasesuffix = -beta
>     prereleasesuffix = -RC
> 
> $ git tag -l --sort=version:refname
> [...]
> 2.6.0-RC1
> 2.6.0-RC2
> 2.6.0-beta-1
> 2.6.0-beta-2
> 2.6.0-beta-3
> 2.6.0-beta-4

So that seems wrong. Even weirder, if I set _only_ "-beta", I get:

  $ git tag -l --sort=version:refname | grep -v ^2.6.0
  2.6.0-beta-2
  2.6.0-beta-3
  2.6.0-beta-4
  2.6.0
  2.6.0-RC1
  2.6.0-RC2
  2.6.0-beta-1

Umm...what? beta-1 is sorted away from its companions? That's weird.

I wondered if the presence of "-" after the suffix ("beta-1" rather than
"beta1") would matter. It looks like that shouldn't matter, though; it's
purely doing a prefix match on "do these names differ at a prerelease
suffix".

But something certainly seems wrong.

-Peff
