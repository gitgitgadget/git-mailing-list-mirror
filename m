Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C89E1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933954AbeALPX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 10:23:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:42272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933926AbeALPXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 10:23:55 -0500
Received: (qmail 8987 invoked by uid 109); 12 Jan 2018 15:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 15:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31751 invoked by uid 111); 12 Jan 2018 15:24:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 10:24:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 10:23:53 -0500
Date:   Fri, 12 Jan 2018 10:23:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] bisect: avoid using the rev_info flag leak_pending
Message-ID: <20180112152353.GB10210@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <07d0e0c6-d023-bd28-511b-78092cb35b4f@web.de>
 <20180110080754.GE16315@sigill.intra.peff.net>
 <b0fbedea-77d8-5571-6042-03b512c0680d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0fbedea-77d8-5571-6042-03b512c0680d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 07:57:51PM +0100, René Scharfe wrote:

> > If we already have the list of tips, could we just feed it ourselves to
> > bisect_rev_setup (I think that would require us remembering which were
> > "good" and "bad", but that doesn't seem like a big deal).
> 
> That's done already under the covers.  De-globalizing these variables
> would make this visible.
> 
> Another way would be to store the bad and good revs in a format that
> allows them to be used everywhere, thus avoiding confusing
> duplication/conversions.  Commit pointers and arrays thereof should
> work everywhere we currently use object_ids and oid_arrays for bad
> and good revs, right?

I think bisect_rev_setup() has to munge that into "^" and non-"^"
arguments. Though arguably we could shove stuff into the pending commit
list directly.

I dunno. It may not be worth spending more time on it.

-Peff
