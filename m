Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217DC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4E02077B
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 01:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLNBAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 20:00:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:46728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726404AbfLNBAD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 20:00:03 -0500
Received: (qmail 5084 invoked by uid 109); 14 Dec 2019 01:00:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Dec 2019 01:00:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32270 invoked by uid 111); 14 Dec 2019 01:04:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 20:04:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 20:00:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191214010002.GA945704@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214003820.GA927924@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 07:38:21PM -0500, Jeff King wrote:

> That's because LIB_H is created by running find in the local filesystem.
> So until it's generated, we don't realize it's there to check. I kind of
> wonder if it should be part of LIB_H. I suspect that on some systems,
> we'd fail to notice a rebuild when command-list.txt is updated (but
> nobody noticed, because it is only systems that do not have
> compiler-supported dependency tracking, and most developers are no
> modern platforms that do).

Actually, this probably isn't true. We have an explicit dependency for
help.o on command-list.h, so it would get built properly then.

Its inclusion in LIB_H is still wonky, though. It sometimes is included
and sometimes not, depending on whether ls-files or find is used.

-Peff
