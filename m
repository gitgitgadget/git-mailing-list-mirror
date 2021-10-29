Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF9C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774EF60E8C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJ2VMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:12:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49834 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhJ2VMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:12:33 -0400
Received: (qmail 23876 invoked by uid 109); 29 Oct 2021 21:10:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 21:10:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23000 invoked by uid 111); 29 Oct 2021 21:10:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 17:10:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 17:10:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Message-ID: <YXxjK8FL3HraUEd0@coredump.intra.peff.net>
References: <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
 <871r4umfnm.fsf@evledraar.gmail.com>
 <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
 <211029.86bl38w124.gmgdl@evledraar.gmail.com>
 <YXxcIQQS7GQzRwUa@coredump.intra.peff.net>
 <xmqqk0hvk1bc.fsf@gitster.g>
 <xmqqee83k0zx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee83k0zx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 01:52:02PM -0700, Junio C Hamano wrote:

> > I tend to agree with the above.  Let's not over-engineer things.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 29 Oct 2021 13:48:58 -0700
> Subject: [PATCH] Revert "logmsg_reencode(): warn when iconv() fails"
> 
> This reverts commit fd680bc5 (logmsg_reencode(): warn when iconv()
> fails, 2021-08-27).  Throwing a warning for each and every commit
> that gets reencoded, without allowing a way to squelch, would make
> it unpleasant for folks who have to deal with an ancient part of the
> history in an old project that used wrong encoding in the commits.

Thanks for tying this up.

I do think fd680bc5's documentation was good, though. So I'd suggest
squashing this in, or applying it on top.

-- >8 --
Subject: [PATCH] log: document --encoding behavior on iconv() failure

We already note that we may produce invalid output when we skip calling
iconv() altogether. But we may also do so if iconv() fails, and we have
no good alternative. Let's document this to avoid surprising users.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-options.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 54d8bb3db0..dc685be363 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -40,7 +40,9 @@ people using 80-column terminals.
 	defaults to UTF-8. Note that if an object claims to be encoded
 	in `X` and we are outputting in `X`, we will output the object
 	verbatim; this means that invalid sequences in the original
-	commit may be copied to the output.
+	commit may be copied to the output. Likewise, if iconv(3) fails
+	to convert the commit, we will quietly output the original
+	object verbatim.
 
 --expand-tabs=<n>::
 --expand-tabs::
-- 
2.33.1.1446.g3ed047b518
