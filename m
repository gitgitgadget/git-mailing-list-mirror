Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4499C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BAC6117A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhERHeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:34:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240235AbhERHeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:34:44 -0400
Received: (qmail 11280 invoked by uid 109); 18 May 2021 07:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 07:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5412 invoked by uid 111); 18 May 2021 07:33:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 03:33:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 03:33:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
Message-ID: <YKNtxUtDXoWwaVrc@coredump.intra.peff.net>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
 <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
 <xmqqk0nx58lq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0nx58lq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 06:54:57AM +0900, Junio C Hamano wrote:

> Just after the previous step justified its simplification of its
> progress logic based on how small the buffer is, this step makes it
> 16 times as big, which felt a tiny bit dishonest.  We probably
> should say somewhere that 128k is still small enough that the
> rewrite in the previous step is still valid ;-)

I noticed that, too. I'm not sure if still is small enough. For local
pack writes, etc, it seems fine. But what about "index-pack --stdin"
reading over the network?

Updating progress every 8k instead of every 128k seems like it would be
more responsive, especially if the network is slow or jittery. I dunno.
Maybe that is too small to care about for the modern world, but I just
want to make sure we are not being blinded by the fast networks all of
us presumably enjoy. :)

-Peff
