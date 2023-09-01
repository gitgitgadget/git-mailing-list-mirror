Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A763CA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjIARcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjIARcT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 13:32:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC6D1B2
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 10:32:16 -0700 (PDT)
Received: (qmail 30579 invoked by uid 109); 1 Sep 2023 17:32:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 17:32:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21266 invoked by uid 111); 1 Sep 2023 17:32:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 13:32:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 13:32:14 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230901173214.GA1947546@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 02:24:59PM +0100, Phillip Wood wrote:

> On 30/08/2023 20:49, Jeff King wrote:
> > This is a more efficient way to do the same thing that
> > ci/config/allow-ref does (which didn't exist back then).
> 
> I like the idea of a more efficient way to skip the ci for certain refs.
> I've got my allow-ref script set up to reject a bunch of refs and run the ci
> on everything else. It's not clear to me how to replicate that with the
> setup proposed here. Would it be possible to add a second variable that
> prevents the ci from being run if it contains ref being pushed?

Drat, I was hoping nobody was using it that way. :)

Yes, I think it would be possible to do something like:

  if: |
    (vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)) &&
    !contains(vars.CI_BRANCHES_REJECT, github.ref_name)

It doesn't allow globbing, though. Do you need that?

-Peff
