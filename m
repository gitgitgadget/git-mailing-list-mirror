Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC4C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDVNly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:41:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D261703
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:41:52 -0700 (PDT)
Received: (qmail 13249 invoked by uid 109); 22 Apr 2023 13:41:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:41:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28897 invoked by uid 111); 22 Apr 2023 13:41:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:41:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:41:50 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 0/3] fixing some parse_commit() timestamp corner cases
Message-ID: <20230422134150.GA3516940@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g>
 <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
 <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 04:51:03PM +0200, Thomas Bock wrote:

> Even though the affected commit objects are malformed, it would be very
> helpful if this problem could be solved somehow, from a user perspective.
> Such malformed objects can potentially occur also in other comparably old
> projects, where searching for commits that have been made in a specific time
> window in the past could be useful or even necessary in some cases.

Yeah, after sleeping on it for a bit, I think it is worth fixing. I also
found another parsing bug in the same function. ;)

So here's the result.

  [1/3]: t4212: avoid putting git on left-hand side of pipe
  [2/3]: parse_commit(): parse timestamp from end of line
  [3/3]: parse_commit(): handle broken whitespace-only timestamp

 commit.c               | 29 +++++++++++++++++++++-------
 t/t4212-log-corrupt.sh | 44 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 9 deletions(-)

-Peff
