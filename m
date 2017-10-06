Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99511FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbdJFRQ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:16:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751766AbdJFRQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 13:16:26 -0400
Received: (qmail 16487 invoked by uid 109); 6 Oct 2017 17:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 17:16:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7924 invoked by uid 111); 6 Oct 2017 17:16:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 13:16:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 13:16:23 -0400
Date:   Fri, 6 Oct 2017 13:16:23 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] refs_resolve_ref_unsafe: handle d/f conflicts for
 writes
Message-ID: <20171006171623.kjzeavnzopowvqzv@sigill.intra.peff.net>
References: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
 <20171006144217.y6oxux26hh2fb7og@sigill.intra.peff.net>
 <38c17fdc-7a3b-d166-1abe-afe64fc823c5@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38c17fdc-7a3b-d166-1abe-afe64fc823c5@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 07:09:10PM +0200, Michael Haggerty wrote:

> I do have one twinge of uneasiness at a deeper level, that I haven't had
> time to check...
> 
> Does this patch make it easier to *set* HEAD to an unborn branch that
> d/f conflicts with an existing reference? If so, that might be a
> slightly worse UI for users. I'd rather learn about such a problem when
> setting HEAD (when I am thinking about the new branch name and am in the
> frame of mind to solve the problem) rather than later, when I try to
> commit to the new branch.

Good question. The answer is no, it's allowed both before and after my
patch. At least via git-symbolic-ref.

I agree it would be nice to know earlier for such a case. For
symbolic-ref, we probably should allow it, because it's plumbing that
may be used for tricky things. For things like "checkout -b", you'd
generally get a timely warning as we try to create the ref.

The odd man out is "checkout --orphan", which leaves the branch unborn.
It might be nice if it did a manual check that the ref is available (and
also that it's syntactically acceptable, though I think we may do that
already).

But all of that is orthogonal to this fix, I think.

-Peff
