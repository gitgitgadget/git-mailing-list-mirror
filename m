Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECCC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0661214
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhIOShQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:37:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:48456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhIOSg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:57 -0400
Received: (qmail 528 invoked by uid 109); 15 Sep 2021 18:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26904 invoked by uid 111); 15 Sep 2021 18:35:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:35:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 08/11] docs/protocol-v2: clarify some ls-refs ref-prefix
 details
Message-ID: <YUI89iI+KRVK+YAz@coredump.intra.peff.net>
References: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've never documented the fact that a client can provide multiple
ref-prefix capabilities. Let's describe the behavior.

We also never discussed the "best effort" nature of the prefixes. The
client side of git.git has always treated them this way, filtering the
result with local patterns. And indeed any client must do this, because
the prefix patterns are not sufficient to express the usual refspecs
(and so for "foo" we ask for "refs/heads/foo", "refs/tags/foo", and so
on).

So this may be considered a change in the spec with respect to client
expectations / requirements, but it's mostly codifying existing
behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-v2.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 213538f1d0..9347b2ad13 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -193,7 +193,11 @@ ls-refs takes in the following arguments:
 	Show peeled tags.
     ref-prefix <prefix>
 	When specified, only references having a prefix matching one of
-	the provided prefixes are displayed.
+	the provided prefixes are displayed. Multiple instances may be
+	given, in which case references matching any prefix will be
+	shown. Note that this is purely for optimization; a server MAY
+	show refs not matching the prefix if it chooses, and clients
+	should filter the result themselves.
 
 If the 'unborn' feature is advertised the following argument can be
 included in the client's request.
-- 
2.33.0.917.g33ebf6a5f6

