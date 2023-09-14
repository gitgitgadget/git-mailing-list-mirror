Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB46EE0212
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 00:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjINAoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 20:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINAoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 20:44:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAB1BCC
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 17:44:08 -0700 (PDT)
Received: (qmail 25527 invoked by uid 109); 14 Sep 2023 00:44:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 00:44:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1972 invoked by uid 111); 14 Sep 2023 00:44:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Sep 2023 20:44:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Sep 2023 20:44:06 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230914004406.GA2224848@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
 <20230905072444.GH199565@coredump.intra.peff.net>
 <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
 <20230911093616.GA1605460@coredump.intra.peff.net>
 <59b423e9-d99e-4817-8a33-c50419593740@gmail.com>
 <20230914003010.GA1709842@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914003010.GA1709842@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two minor corrections in what I wrote...

On Wed, Sep 13, 2023 at 08:30:10PM -0400, Jeff King wrote:

> (BTW, one other thing I tried was using fromJSON(vars.CI_CONFIG) in the
> "on" expression, which in theory would allow globbing. But it doesn't
> look like expressions work at all in that context. And even if they did,
> I'm not sure we could make it work such that an empty CI_CONFIG used
> some defaults, since there's no conditional-expression ternary
> operator).

It's not a real ?: operator, but GitHub does use the word "ternary" to
describe the short-circuit behavior of:

  condition && "if-true" || "if-not-true"

So in theory we could do:

  on: ${{ fromJSON(var.CI_ON != '' && vars.CI_ON || "[pull_request, push]" }}

but I couldn't make it work (it complains about the value of "on" in
such a way that I assume it is simply not expanding expressions at all).

> We have the necessary bits at the protocol: push-options. But it's up to
> the server-side hooks to decide which ones are meaningful and to do
> something useful with them. It looks like GitLab supports:
> 
>   git push -o ci.skip=1 ...
> 
> but I don't think GitHub respects any equivalent option.

The syntax here is actually just "git push -o ci.skip", without the
equals.

-Peff
