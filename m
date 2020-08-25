Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E9C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37E72074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYTwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:52:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgHYTvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:51:50 -0400
Received: (qmail 2426 invoked by uid 109); 25 Aug 2020 19:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 19:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1375 invoked by uid 111); 25 Aug 2020 19:51:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 15:51:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 15:51:48 -0400
From:   Jeff King <peff@peff.net>
To:     Nelson Elhage <nelhage@nelhage.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone --shallow-since can result in inconsistent shallow
 clones
Message-ID: <20200825195148.GC1419759@coredump.intra.peff.net>
References: <CAPSG9dZV2EPpVKkOMcjv5z+NF7rUu=V-ZkZNx47rCv122HsiKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSG9dZV2EPpVKkOMcjv5z+NF7rUu=V-ZkZNx47rCv122HsiKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:38:04AM -0700, Nelson Elhage wrote:

> It's unfortunately a bit unclear to me what _should_ happen here. We
> really want a way to mark `89ea0c5` as "partially-shallow", and send
> its second parent, but not its first parent, but shallowness is a
> property of an entire commit, not of a specific commit/parent
> relationship. However, it'd be nice if we at least ended up with a
> consistent state, instead of with a repository with invalid `shallow`
> marks.

I think this is the same issue I reported recently here:

  https://lore.kernel.org/git/20200721160643.GA3288097@coredump.intra.peff.net/

AFAICT the shallow feature is just defective and can't accurately
represent this situation. Unfortunately nobody seemed to have any bright
ideas, and the developer who implemented most of the shallow features
(including shallow-since) is no longer active.

So I suspect it is fixable, but probably requires somebody to get pretty
familiar with the shallow code, and propose a fix that involves both
code and a protocol change.

-Peff
