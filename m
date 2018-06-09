Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A261F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeFIGGY (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:06:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751380AbeFIGGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:06:23 -0400
Received: (qmail 19016 invoked by uid 109); 9 Jun 2018 06:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 06:06:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 876 invoked by uid 111); 9 Jun 2018 06:06:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 02:06:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 02:06:21 -0400
Date:   Sat, 9 Jun 2018 02:06:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/2] pack-bitmap: add free function
Message-ID: <20180609060621.GB30224@sigill.intra.peff.net>
References: <cover.1528397984.git.jonathantanmy@google.com>
 <b9be1d0371e5dc694e5e7ac88a900f985faabec8.1528397984.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9be1d0371e5dc694e5e7ac88a900f985faabec8.1528397984.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 12:04:14PM -0700, Jonathan Tan wrote:

> Add a function to free struct bitmap_index instances, and use it where
> needed (except when rebuild_existing_bitmaps() is used, since it creates
> references to the bitmaps within the struct bitmap_index passed to it).
> 
> Note that the hashes field in struct bitmap_index is not freed because
> it points to another field within the same struct. The documentation for
> that field has been updated to clarify that.

Hrm, this one fixes the leaks I noticed in the previous patch. I'm OK
with doing it separately if it breaking it down this way makes the code
easier to reason about. But we should probably say something in the
commit message about it.

-Peff
