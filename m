Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9351CA0FFC
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjIEQAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbjIEHYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:24:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C7A8
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:24:46 -0700 (PDT)
Received: (qmail 13712 invoked by uid 109); 5 Sep 2023 07:24:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:24:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19873 invoked by uid 111); 5 Sep 2023 07:24:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:24:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:24:44 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230905072444.GH199565@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 04, 2023 at 10:56:15AM +0100, Phillip Wood wrote:

> > Yes, I think it would be possible to do something like:
> > 
> >    if: |
> >      (vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)) &&
> >      !contains(vars.CI_BRANCHES_REJECT, github.ref_name)
> > 
> > It doesn't allow globbing, though. Do you need that?
> 
> Oh I'd missed that, yes I do. All the globs are prefix matches but I'm not
> sure that helps.

It does make it easier. There's no globbing function available to us,
but if we know something is a prefix, there's a startsWith() we can use.
It does seem we're getting a combinatorial expansion of things to check,
though:

  - full names to accept
  - full names to reject
  - prefixes to accept
  - prefixes to reject

I wrote "prefixes" but I'm actually not sure how feasible that is. That
implies iterating over the list of prefixes, which I'm not sure we can
do.

-Peff
