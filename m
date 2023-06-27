Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903EFEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 07:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjF0HJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjF0HJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 03:09:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017B2129
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 00:09:44 -0700 (PDT)
Received: (qmail 29066 invoked by uid 109); 27 Jun 2023 07:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 07:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14503 invoked by uid 111); 27 Jun 2023 07:09:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 03:09:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 03:09:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t7701: make annotated tag unreachable
Message-ID: <20230627070942.GC1226768@coredump.intra.peff.net>
References: <20230624043826.GA104835@coredump.intra.peff.net>
 <259b1b559114ab1a9a0bd7f1ad29a4cba2612ae0.1687617197.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <259b1b559114ab1a9a0bd7f1ad29a4cba2612ae0.1687617197.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2023 at 10:33:47AM -0400, Taylor Blau wrote:

> In 4dc16e2cb0 (gc: introduce `gc.recentObjectsHook`, 2023-06-07), we
> added tests to ensure that prune-able (i.e. unreachable and with mtime
> older than the cutoff) objects which are marked as recent via the new
> `gc.recentObjectsHook` configuration are unpacked as loose with
> `--unpack-unreachable`.
> 
> In that test, we also ensure that objects which are reachable from other
> unreachable objects which were *not* pruned are kept as well, regardless
> of their mtimes. For this, we use an annotated tag pointing at a blob
> ($obj2) which would otherwise be pruned.
> 
> But after pruning, that object is kept around for two reasons. One, the
> tag object's mtime wasn't adjusted to be beyond the 1-hour cutoff, so it
> would be kept as due to its recency regardless. The other reason is
> because the tag itself is reachable.
> 
> Use mktag to write the tag object directly without pointing a reference
> at it, and adjust the mtime of the tag object to be older than the
> cutoff to ensure that our `gc.recentObjectsHook` configuration is
> working as intended.
> 
> Noticed-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Fixes a trivial oversight from an earlier version of this patch noticed
> by Peff.

Thanks, this looks great to me.

-Peff
