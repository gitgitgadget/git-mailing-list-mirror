Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF510C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8094B6112D
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhEETCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:02:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhEETCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:02:45 -0400
Received: (qmail 19757 invoked by uid 109); 5 May 2021 19:01:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 19:01:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12932 invoked by uid 111); 5 May 2021 19:01:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 15:01:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 15:01:47 -0400
From:   Jeff King <peff@peff.net>
To:     Theodor Negrescu <theodor.negrescu@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
Message-ID: <YJLrm0nqWL6TnUFb@coredump.intra.peff.net>
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
 <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
 <CAEumJaCmcReO4ry7DP14zDg0R5L5QgULZpZmaqBY5g=EQD4U+Q@mail.gmail.com>
 <YJLla4gNEMS2yxCv@coredump.intra.peff.net>
 <CAEumJaA7NBm9Kdx7aCD1gavGguLmGcnvFcA52YvUk7g_FPzHZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEumJaA7NBm9Kdx7aCD1gavGguLmGcnvFcA52YvUk7g_FPzHZw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 09:59:58PM +0300, Theodor Negrescu wrote:

> You're right, "notepad ~/test.txt" doesn't work either.
> I figured out a workaround:
> [alias]
>     cfg = "!git config --file $(echo ~)/git-settings/.gitconfig "
> However what confuses me is that I also have
> [core]
>     hooksPath = ~/git-settings/hooks
> and that ~ works. So why doesn't it work in config --file?

Some config options that refer to paths specifically expand "~", exactly
because there is no shell involved when Git reads them.

-Peff
