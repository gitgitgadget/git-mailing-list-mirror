Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC2EC77B7D
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjESACn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjESACm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:02:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A93130
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:02:40 -0700 (PDT)
Received: (qmail 6078 invoked by uid 109); 19 May 2023 00:02:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:02:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26625 invoked by uid 111); 19 May 2023 00:02:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:02:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:02:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] a few format-patch leak fixes
Message-ID: <20230519000239.GA1975039@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I got bit earlier by the leak-checker complaining about an old leak on
jc/send-email-pre-process-fix, so I started to poke at the code.  I see
that you since silenced it via 20bd08aefb (t9001: mark the script as no
longer leak checker clean, 2023-05-17).

I think that's an OK solution for the release period. But since I dug
into the actual leak, I didn't want those fixes to go to waste. :)

So these can be applied at our leisure post-release, though I think the
first one could also be taken independently, and is enough to fix t9001
(obviously we could also take them both, but the first one is the less
risky of the two, since we're in an -rc period).

  [1/2]: format-patch: free rev.message_id when exiting
  [2/2]: format-patch: free elements of rev.ref_message_ids list

 builtin/log.c         | 15 ++++++++-------
 t/t9001-send-email.sh |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

-Peff
