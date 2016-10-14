Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2651F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbcJNTA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 15:00:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754875AbcJNTAy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 15:00:54 -0400
Received: (qmail 22318 invoked by uid 109); 14 Oct 2016 19:00:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 19:00:54 +0000
Received: (qmail 8083 invoked by uid 111); 14 Oct 2016 19:01:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 15:01:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 15:00:51 -0400
Date:   Fri, 14 Oct 2016 15:00:51 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161014190051.oxrfreb56nogkdv7@sigill.intra.peff.net>
References: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <d727ee5d-5f0f-e6df-3f83-35fe74641ace@oracle.com>
 <20161013204351.rezqssvw63343l4g@sigill.intra.peff.net>
 <0e4173b6-8fbb-4223-b061-524c7ebfd4d7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e4173b6-8fbb-4223-b061-524c7ebfd4d7@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 08:55:29AM +0200, Vegard Nossum wrote:

> On 10/13/2016 10:43 PM, Jeff King wrote:
> > No problem. I do think you'll benefit a lot from packing everything into
> > a single pack, but it's also clear that Git was doing more work than it
> > needed to be. This was a known issue when we added the racy-check to
> > has_sha1_file(), and knew that we might have to field reports like this
> > one.
> 
> After 'git gc' (with the .5G limit) I have 23 packs and with your patch
> I now get:
> 
> $ time git fetch
> 
> real    0m26.520s
> user    0m3.580s
> sys     0m0.636s

Cool. That's about what I'd expect based on the size numbers you gave
earlier. The other 23 seconds are likely being spent on passing the ref
advertisement over the network.

-Peff
