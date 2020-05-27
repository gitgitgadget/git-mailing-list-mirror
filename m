Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC7C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5243207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgE0HcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 03:32:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgE0HcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 03:32:06 -0400
Received: (qmail 20465 invoked by uid 109); 27 May 2020 07:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 07:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1586 invoked by uid 111); 27 May 2020 07:32:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 03:32:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 03:32:05 -0400
From:   Jeff King <peff@peff.net>
To:     Xirui Zhao <zhaoxirui434@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: "git restore --staged" on a newly created repository
Message-ID: <20200527073205.GC4006199@coredump.intra.peff.net>
References: <1F3FD418-38D2-4A10-A882-666D4327F993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1F3FD418-38D2-4A10-A882-666D4327F993@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 02:18:34PM +0800, Xirui Zhao wrote:

> Tested on git version 2.27.0-rc1 (latest build from master branch on github) and 2.26.2
> `git restore --staged file` on a newly created repository outputs
> error "fatal: could not resolve HEAD", but `git reset file` correctly
> unstages the file.

Yeah, "restore" is based on git-checkout, which is a little pickier than
"git reset" here. I don't think this ever worked in any version of
git-restore. It would probably be OK for it to use the empty tree when
HEAD is unborn, at least when operating in git-restore mode.

-Peff
