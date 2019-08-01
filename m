Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F901F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfHAVvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:51:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:59524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726403AbfHAVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:51:49 -0400
Received: (qmail 32667 invoked by uid 109); 1 Aug 2019 21:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 21:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31808 invoked by uid 111); 1 Aug 2019 21:53:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2019 17:53:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Aug 2019 17:51:48 -0400
From:   Jeff King <peff@peff.net>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] checkout.c: unstage empty deleted ita files
Message-ID: <20190801215148.GA30137@sigill.intra.peff.net>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
 <20190801160756.12601-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801160756.12601-1-vcnaik94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 09:07:56AM -0700, Varun Naik wrote:

> It is possible to delete a committed file from the index and then add it
> as intent-to-add. After `git checkout HEAD`, the file should be
> identical in the index and HEAD. The command already works correctly if
> the file has contents in HEAD. This patch provides the desired behavior
> even when the file is empty in HEAD.
> 
> `git checkout HEAD` calls tree.c:read_tree_1(), with fn pointing to
> checkout.c:update_some(). update_some() creates a new cache entry but
> discards it when its mode and oid match those of the old entry. A cache
> entry for an ita file and a cache entry for an empty file have the same
> oid. Therefore, an empty deleted ita file previously passed both of
> these checks, and the new entry was discarded, so the file remained
> unchanged in the index. After this fix, if the file is marked as ita in
> the cache, then we avoid discarding the new entry and add the new entry
> to the cache instead.
> 
> This change should not affect newly added ita files. For those, inside
> tree.c:read_tree_1(), tree_entry_interesting() returns
> entry_not_interesting, so fn is never called.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---
> This patch fixes and tests only "checkout", because "restore" has not
> reached maint yet. A second patch on the merge of this patch into master
> with a test case for "restore" is coming.

Thanks, this version looks good to me!

-Peff
