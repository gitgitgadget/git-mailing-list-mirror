Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC421F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJBNzU (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 09:55:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726373AbfJBNzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 09:55:20 -0400
Received: (qmail 23767 invoked by uid 109); 2 Oct 2019 13:55:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 13:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22050 invoked by uid 111); 2 Oct 2019 13:57:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 09:57:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 09:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org
Subject: Re: missing tags from "git fetch"
Message-ID: <20191002135518.GA3599@sigill.intra.peff.net>
References: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 03:10:12PM +0200, Martin Nicolay wrote:

> I don't know if this is a lack of understanding or a software or
> documentation bug.
> 
> man git-fetch says about tags:
>        By default, any tag that points into the histories being fetched is
>        also fetched; the effect is to fetch tags that point at branches that
>        you are interested in.
> 
> If I fetch without --tags the tags that point to the commits of the fetched
> branch are not fetched. If I fetch with --tags than all tags are fetched but
> I only wish to fetch tags pointing to something in the branch fetched.

It's a documentation bug, I think. We won't auto-follow tags when
fetching into FETCH_HEAD (but this is further confused by the fact that
fetching into FETCH_HEAD will auto-update a tracking ref).

So instead of this:

> $ git fetch origin master

try this:

  $ git fetch origin

or even this:

  $ git fetch origin master:refs/remotes/origin/master

There's more discussion in this thread (but it looks like no patches
ever came out of it):

  https://public-inbox.org/git/20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net/

-Peff
