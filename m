Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F322C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC41206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgEDQHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:07:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:35942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729207AbgEDQHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:07:10 -0400
Received: (qmail 31695 invoked by uid 109); 4 May 2020 16:07:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 16:07:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18278 invoked by uid 111); 4 May 2020 16:07:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 12:07:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 12:07:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH] CodingGuidelines: drop arithmetic expansion advice to use
 "$x"
Message-ID: <20200504160709.GB12842@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
 <20200504151351.GC11373@coredump.intra.peff.net>
 <xmqqh7wviud9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7wviud9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 08:37:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm, somehow I didn't know about that rule. We have many cases already
> > in the test suite and elsewhere (try grepping for '$(([a-z]', which
> > isn't exhaustive but turns up many examples).
> >
> > Maybe it's time to loosen the rule?
> 
> Let's do that.  It's time.

Here it is in patch form for your convenience.

-- >8 --
Subject: CodingGuidelines: drop arithmetic expansion advice to use "$x"

The advice to use "$x" rather than "x" in arithmetric expansion was
working around a dash bug fixed in 0.5.4. Even Debian oldstable has
0.5.7 these days. And in the meantime, we've added almost two dozen
instances of the "x" form which you can find with:

  git grep '$(([a-z]'

and nobody seems to have complained. Let's declare this workaround
obsolete and simplify our style guide.

Helped-by: Danh Doan <congdanhqx@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 390ceece52..a89e8dcfbc 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -95,10 +95,6 @@ For shell scripts specifically (not exhaustive):
 
  - We use Arithmetic Expansion $(( ... )).
 
- - Inside Arithmetic Expansion, spell shell variables with $ in front
-   of them, as some shells do not grok $((x)) while accepting $(($x))
-   just fine (e.g. dash older than 0.5.4).
-
  - We do not use Process Substitution <(list) or >(list).
 
  - Do not write control structures on a single line with semicolon.
-- 
2.26.2.957.g6dc93e954a

