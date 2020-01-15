Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A8C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED9F2187F
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAOSBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:01:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:37136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726574AbgAOSBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:01:42 -0500
Received: (qmail 18367 invoked by uid 109); 15 Jan 2020 18:01:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 18:01:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31641 invoked by uid 111); 15 Jan 2020 18:08:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 13:08:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 13:01:40 -0500
From:   Jeff King <peff@peff.net>
To:     1234dev <1234dev@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can Git repos be hacked or otherwise manipulated?
Message-ID: <20200115180140.GA4081287@coredump.intra.peff.net>
References: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
 <20200114220826.GB3957260@coredump.intra.peff.net>
 <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 03:18:34AM +0000, 1234dev wrote:

> To work around this problem, should we instead host this repo on a
> public service? If so which one would you recommend?

Oops, I forgot to mention the actual solution. :)

Generally it is safe to clone _from_ an untrusted repo, even if it's on
a local filesystem. So untarring the repo and running:

  git clone evil.git safe
  cd safe
  git log

should make it OK to run Git commands inside the "safe" directory.

Jonathan Nieder also mentioned using a bundle file, which may be even
simpler, as it skips the part where you have to deal with tar. :)

Run:

  git bundle create foo.bundle --all

on the sending side, and then you can just:

  git clone foo.bundle safe

on the receiving side.

-Peff
