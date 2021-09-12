Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BDC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F7B6101E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhILWnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:43:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:45728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231891AbhILWnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:43:08 -0400
Received: (qmail 17085 invoked by uid 109); 12 Sep 2021 22:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 22:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2995 invoked by uid 111); 12 Sep 2021 22:41:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 18:41:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 18:41:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] difftool: use "struct strvec" API in
 run_{dir,file}_diff()
Message-ID: <YT6CMdITxaZZqufr@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <patch-1.2-e7481eb0c0c-20210911T182009Z-avarab@gmail.com>
 <YT6BnnXeAWn8BycF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT6BnnXeAWn8BycF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 06:39:26PM -0400, Jeff King wrote:

> It only becomes apparent with the second patch. I would have found it
> much easier to understand with something like the patch below. And then
> a further patch to use strvec_pushv instead of manually looping (even
> getting rid of the argc parameters entirely!), and one to convert
> run_file_diff() to use a struct child_process (which fixes its memory
> leak).
> 
> -- >8 --
> difftool: prepare "diff" cmdline in cmd_difftool()

Note that this actually introduces a new leak of the strvec in the
caller. So it would probably want the "ret =" think I suggested to be
squashed in.

(I wasn't really planning to make a finished patch, but just trying to
illustrate what had confused me in your original. I ended up closer than
I had planned, though).

-Peff
