Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBAC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826D661932
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC2NFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:05:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:35564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhC2NFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:34 -0400
Received: (qmail 10889 invoked by uid 109); 29 Mar 2021 13:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 13:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13670 invoked by uid 111); 29 Mar 2021 13:05:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 09:05:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 09:05:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:04:31PM -0500, Taylor Blau wrote:

> Here is another reroll of my series to implement a reverse index in
> preparation for multi-pack reachability bitmaps. The previous version
> was based on 'ds/chunked-file-api', but that topic has since been merged
> to 'master'. This series is now built directly on top of 'master'.

I gave the whole thing another careful read. Most of what I found were
small nits, but enough that I think one more re-roll is worth it.

The biggest question is what we want to happen next. As you note, the
concept of a midx .rev file is useless until we have the matching
.bitmap file. So we _could_ let this sit in next while the dependent
bitmap topic is reviewed, and then merge them down together. But I'm
inclined to treat this as an independent topic that can get merged to
master on its own, since the early cleanups are valuable on their own,
and the .rev parts at the end, even if dead, won't hurt anything.

If we did want to break it up, the useful line would be after "allow
marking a pack as preferred" (while it is mostly intended for the bitmap
selection, it is theoretically useful on its own to make it more likely
to find a copy of an object with a useful delta).

-Peff
