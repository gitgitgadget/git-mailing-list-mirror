Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B0C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EC820715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfKVNAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:00:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:57946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726813AbfKVNAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 08:00:22 -0500
Received: (qmail 21050 invoked by uid 109); 22 Nov 2019 13:00:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 13:00:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24697 invoked by uid 111); 22 Nov 2019 13:04:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 08:04:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 08:00:20 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org
Subject: Re: missing tags from "git fetch"
Message-ID: <20191122130020.GA22423@sigill.intra.peff.net>
References: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr>
 <20191002135518.GA3599@sigill.intra.peff.net>
 <alpine.LSU.2.20.1910251150411.2754@cpza.bfz-tzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1910251150411.2754@cpza.bfz-tzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 12:17:26PM +0200, Martin Nicolay wrote:

> >  $ git fetch origin master:refs/remotes/origin/master
> 
> I thought it would work, but it works only once. On the second time the ref
> for the remote branch is deleted. It seems git is confused by specifying a
> ref it expect to manage itself.

It seems like a bad interaction with `fetch.prune` (I don't have it set,
and the problem doesn't appear, but if I set it, I can reproduce your
issue).

I'm not sure why, though. It's true that the ref _is_ mentioned in the
configured refspec for origin, but we shouldn't be looking at that
refspec at all (since we have a refspec on the command line).

-Peff
