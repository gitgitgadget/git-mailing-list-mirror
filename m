Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394831F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeB0WlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:41:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:39706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751730AbeB0Wk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:40:59 -0500
Received: (qmail 12132 invoked by uid 109); 27 Feb 2018 22:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:40:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28698 invoked by uid 111); 27 Feb 2018 22:41:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:41:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:40:57 -0500
Date:   Tue, 27 Feb 2018 17:40:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
Message-ID: <20180227224057.GB3484@sigill.intra.peff.net>
References: <20180226204151.GA12598@sigill.intra.peff.net>
 <20180227114704.193145-1-dstolee@microsoft.com>
 <20180227213305.GB6899@sigill.intra.peff.net>
 <xmqqsh9mnjzk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh9mnjzk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 02:30:39PM -0800, Junio C Hamano wrote:

> -- >8 --
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Tue, 27 Feb 2018 06:47:04 -0500
> Subject: [PATCH] sha1_name: fix uninitialized memory errors
> 
> During abbreviation checks, we navigate to the position within a
> pack-index that an OID would be inserted and check surrounding OIDs
> for the maximum matching prefix. This position may be beyond the
> last position, because the given OID is lexicographically larger
> than every OID in the pack. Then nth_packed_object_oid() does not
> initialize "oid".
> 
> Use the return value of nth_packed_object_oid() to prevent these
> errors.
> 
> Also the comment about checking near-by objects miscounts the
> neighbours.  If we have a hit at "first", we check "first-1" and
> "first+1" to make sure we have sufficiently long abbreviation not to
> match either.  If we do not have a hit, "first" is the smallest
> among the objects that are larger than what we want to name, so we
> check that and "first-1" to make sure we have sufficiently long
> abbreviation not to match either.  In either case, we only check up
> to two near-by objects.

Yep, this looks good to me. Thanks for wrapping it up.

-Peff
