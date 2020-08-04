Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A9C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329192076C
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgHDHYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:24:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:47334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgHDHYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:24:19 -0400
Received: (qmail 464 invoked by uid 109); 4 Aug 2020 07:24:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 07:24:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9488 invoked by uid 111); 4 Aug 2020 07:24:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 03:24:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 03:24:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 01/10] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200804072417.GA183951@coredump.intra.peff.net>
References: <cover.1596480582.git.me@ttaylorr.com>
 <08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 02:57:09PM -0400, Taylor Blau wrote:

> diff --git a/revision.c b/revision.c
> index 6de29cdf7a..e244beed05 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -684,7 +684,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	if (!revs->repo->objects->commit_graph)
>  		return;
>  
> -	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
> +	revs->bloom_filter_settings = get_bloom_filter_settings(revs->repo);
>  	if (!revs->bloom_filter_settings)
>  		return;

I think you could get rid of the revs->repo->objects->commit_graph check
above now, as get_bloom_filter_settings() would return NULL if there is
no commit_graph at all.

-Peff
