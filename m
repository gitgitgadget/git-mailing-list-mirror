Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CFC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66DC60F21
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhHKTMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:12:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:44544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:12:17 -0400
Received: (qmail 22473 invoked by uid 109); 11 Aug 2021 19:11:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 19:11:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13670 invoked by uid 111); 11 Aug 2021 19:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 15:11:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 15:11:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename
 and tree-wide
Message-ID: <YRQg+IJ3cxb3Vk+c@coredump.intra.peff.net>
References: <cover.1628670288.git.dyroneteng@gmail.com>
 <b6f3b15253d44c9250f59b53aafe471edda9f4b7.1628670288.git.dyroneteng@gmail.com>
 <xmqqsfzf980v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfzf980v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 11:00:00AM -0700, Junio C Hamano wrote:

> > Function `traverse_trees_and_blobs` not only works on trees and blobs,
> > but also on tags, the function name is somewhat misleading. This commit
> > rename it to `traverse_trees_and_blobs_and_tags`.
> 
> This looks pretty much "Meh" to me.
> 
> The current name might mislead people that we are limited to only
> two types, but I doubt the risk of misleading is worth reducing with
> such an overly long name.  The original is long enough X-<.
> 
> When we introduced it at 91904f56 (list-objects.c: factor out
> traverse_trees_and_blobs, 2017-11-02), we may have been better to
> call it traverse_non_commits().  The idea of traverse_commit_list(),
> which is its primary caller, is for its main loop to iterate over
> commits and process them one by one in each iteration, and process
> objects of other types discovered therein by calling this function
> once per each commit [*1*].
> 
> s/trees_and_blobs/non_commits/ will result in a name that is much
> shorter and to the point, I think.

FWIW, I was about reply and suggest the exact same name. :)

As something internal to list-objects.c, I don't think it matters all
that much either way. The name "traverse_commit_list()" is IMHO more
likely to confuse. It is public within the project, and of course
traverses any type of object. So "traverse_objects()" or something may
be more accurate.

OTOH I do not find it all that confusing, and it may not be worth the
disruption to the code base.

-Peff
