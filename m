Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA741F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeC3VEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:04:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:49458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752568AbeC3VET (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:04:19 -0400
Received: (qmail 31969 invoked by uid 109); 30 Mar 2018 21:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 21:04:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 544 invoked by uid 111); 30 Mar 2018 21:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 17:05:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 17:04:17 -0400
Date:   Fri, 30 Mar 2018 17:04:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 10/13] pack-objects: clarify the use of
 object_entry::size
Message-ID: <20180330210416.GH14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-11-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-11-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:50AM +0100, Nguyễn Thái Ngọc Duy wrote:

> While this field most of the time contains the canonical object size,
> there is one case it does not: when we have found that the base object
> of the delta in question is also to be packed, we will very happily
> reuse the delta by copying it over instead of regenerating the new
> delta.
> 
> "size" in this case will record the delta size, not canonical object
> size. Later on in write_reuse_object(), we reconstruct the delta
> header and "size" is used for this purpose. When this happens, the
> "type" field contains a delta type instead of a canonical type.
> Highlight this in the code since it could be tricky to see.

Thanks for digging down here. I have definitely been confused by this in
the past.

The subject says "clarify" so I was a little surprised to see code
changes. It looks like we're just avoiding reassigning on top of the
value repeatedly, which is part of that clarification. It looks like a
noop to me.

-Peff
