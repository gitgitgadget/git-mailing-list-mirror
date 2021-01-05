Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5CC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA75F224F9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbhAEGsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 01:48:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:45900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbhAEGr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 01:47:59 -0500
Received: (qmail 26266 invoked by uid 109); 5 Jan 2021 06:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Jan 2021 06:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21125 invoked by uid 111); 5 Jan 2021 06:47:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Jan 2021 01:47:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Jan 2021 01:47:18 -0500
From:   Jeff King <peff@peff.net>
To:     stratus@tuta.io
Cc:     git@vger.kernel.org
Subject: Re: git tag truncates tag list
Message-ID: <X/QLds2oVvOAF1nb@coredump.intra.peff.net>
References: <MQFZ9EW--3-2@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MQFZ9EW--3-2@tuta.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 04:39:20AM +0100, stratus@tuta.io wrote:

> git tag misses out some tags from this repo here, there seem to be too many to show:
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> 
> It cuts the list short, losing either the latest ones with simply 
> git tag
>  or the earliest using either 
> git tag  --sort=-creatordate
>   or 
> git tag --sort=-taggerdate
> 
>  Is there some config option somewhere to show the full list?

I see 680 tags with all of those commands, which matches the number of
tags reported by:

  git ls-remote --tags --refs \
    https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux

Perhaps a silly question, but which tags do you think are missing? Are
you confused that 5.10 and 5.11 do not show up at the end? If so, it's
because they sort byte-wise between 5.1 and 5.2. So they're there, just
not at the end, with "git tag". When sorting by creatordate or
taggerdate, they appear at the beginning (because you chose a descending
sort).

-Peff
