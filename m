Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23A71F461
	for <e@80x24.org>; Thu, 16 May 2019 03:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEPDeZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:34:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:58952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfEPDeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:34:24 -0400
Received: (qmail 4576 invoked by uid 109); 16 May 2019 03:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 03:34:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26954 invoked by uid 111); 16 May 2019 03:35:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 23:35:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 23:34:22 -0400
Date:   Wed, 15 May 2019 23:34:22 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] Use xmmap_gently instead of xmmap in use_pack
Message-ID: <20190516033422.GD4596@sigill.intra.peff.net>
References: <20190516003130.racexnofe7cxra3t@glandium.org>
 <20190516003736.25544-1-mh@glandium.org>
 <20190516003736.25544-2-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516003736.25544-2-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:37:36AM +0900, Mike Hommey wrote:

> use_pack has its own error message on mmap error, but it can't be
> reached when using xmmap, which dies with its own error.

Makes sense. Amusingly this xmmap comes from c4712e4553 (Replace mmap
with xmmap, better handling MAP_FAILED., 2006-12-24), which specifically
moved everything to xmmap for its error handling, and dropped all of the
MAP_FAILED checks. But it forgot to remove this one.

So we could also go the other way, and just remove the unreachable
check. I do think the error from use_pack() is better though, so I like
the direction you went.

-Peff
