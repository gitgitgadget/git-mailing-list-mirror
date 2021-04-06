Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C0C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB1F613C4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhDFRnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:43:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:42794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhDFRnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:43:05 -0400
Received: (qmail 8281 invoked by uid 109); 6 Apr 2021 17:42:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:42:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30672 invoked by uid 111); 6 Apr 2021 17:42:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:42:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:42:56 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 5/8] list-objects: implement object type filter
Message-ID: <YGydoFoIROcqFGHC@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <acf01472af9a8e370f549d57593a4f9924c24f7c.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acf01472af9a8e370f549d57593a4f9924c24f7c.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:50PM +0100, Patrick Steinhardt wrote:

> While it already is possible to filter objects by some criteria in
> git-rev-list(1), it is not yet possible to filter out only a specific
> type of objects. This makes some filters less useful. The `blob:limit`
> filter for example filters blobs such that only those which are smaller
> than the given limit are returned. But it is unfit to ask only for these
> smallish blobs, given that git-rev-list(1) will continue to print tags,
> commits and trees.
> 
> Now that we have the infrastructure in place to also filter tags and
> commits, we can improve this situation by implementing a new filter
> which selects objects based on their type. Above query can thus
> trivially be implemented with the following command:
> 
>     $ git rev-list --objects --filter=object:type=blob \
>         --filter=blob:limit=200
> 
> Furthermore, this filter allows to optimize for certain other cases: if
> for example only tags or commits have been selected, there is no need to
> walk down trees.

Makes sense, and the implementation looks reasonable to me.

-Peff
