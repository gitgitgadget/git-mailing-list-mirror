Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FEB1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 06:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfIEGzT (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:55:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731583AbfIEGzT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:55:19 -0400
Received: (qmail 25351 invoked by uid 109); 5 Sep 2019 06:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 06:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24356 invoked by uid 111); 5 Sep 2019 06:57:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 02:57:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 02:55:18 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jon@jonsimons.org, matvore@comcast.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] treewide: rename 'struct exclude' to 'struct
 path_pattern'
Message-ID: <20190905065518.GD21450@sigill.intra.peff.net>
References: <pull.329.git.gitgitgadget@gmail.com>
 <8cdffbd1c82c34a7dbdb18cb396e5e422889aad6.1567533893.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cdffbd1c82c34a7dbdb18cb396e5e422889aad6.1567533893.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 03, 2019 at 11:04:55AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The first consumer of pattern-matching filenames was the
> .gitignore feature. In that context, storing a list of patterns
> as a list of 'struct exclude' items makes sense. However, the
> sparse-checkout feature then adopted these structures and methods,
> but with the opposite meaning: these patterns match the files
> that should be included!
> 
> It would be clearer to rename this entire library as a "pattern
> matching" library, and the callers apply exclusion/inclusion
> logic accordingly based on their needs.
> 
> This commit renames 'struct exclude' to 'struct path_pattern'
> and renames several variable names to match. 'struct pattern'
> was already taken by attr.c, and this more completely describes
> that the patterns are specific to file paths.

I agree that the current name is overly restrictive, and this is a step
in the right direction. However, when I see path_pattern that makes me
think of our command-line pathspecs.

I wonder if there's a name that could more clearly distinguish the two.
Or if it's sufficient to just become Git jargon that "pathspec" is the
command-line one and "path_pattern" is the file-based one (we're at
least pretty consistent about the former already).

I think one could also make an argument that the name collision is a
sign that these two things should actually share both syntax and
implementation, since we're exposing too similar-but-not-quite versions
of the same idea to users. But given the compatibility issues, it's
probably not worth changing the user facing parts at this point (and I
also haven't thought too hard about it; there may be reasons why the two
_should_ differ).

-Peff
