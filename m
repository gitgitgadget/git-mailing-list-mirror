Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CBC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6761166
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhDOJm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhDOJm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:42:56 -0400
Received: (qmail 10037 invoked by uid 109); 15 Apr 2021 09:42:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:42:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14706 invoked by uid 111); 15 Apr 2021 09:42:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:42:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:42:33 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <YHVQ9RPLk8/r+8mS@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHVQ9RPLk8/r+8mS@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 10:06:13AM +0200, Patrick Steinhardt wrote:

> I don't think it would help usability to add new `--show-blobs` and
> `--show-trees` options. The user interface to show this kind of
> information exists already with `--objects`, and by adding another way
> of asking a similar query would raise the question of how these two ways
> interact with each other:
> 
>     - Does `--show-blobs` have effect if `--objects` is not set?
> 
>     - Is `--objects` redundant if we have `--show-blobs`, or would
>       `--objects --show-blobs` list all objects regardless of whether
>       they're blobs or not?
> 
>     - What would happen if the user says `--show-blobs --no-objects`?
> 
>     - Are these options mutually exclusive?
> 
> We avoid all these questions by just adding it as a filter.

I'm not too worried about those. I'd imagine that "--objects" becomes a
documented synonym for "--show-trees --show-blobs --show-commits
--show-tags", and then the usual interactions take over.

But...

> Furthermore, the filter also allows future iterations which build on top
> of this. If we had a combined OR filter in addition to the existing
> combined AND filter, the user could say "Give me all blobs which aren't
> bigger than a specific size PLUS all trees with a depth smaller than 5
> PLUS all commits and tags". It's not like I'd know of a specific usecase
> for this right now, but I think the potential of having such filters in
> the future is a plus.

Yeah, that's true. My biggest complaint is lack of an OR filter, but we
could add that later. And then we would be _more_ flexible, as you note,
since we could and/or more filters.

So I'm OK proceeding with this direction.

-Peff
