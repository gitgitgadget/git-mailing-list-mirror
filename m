Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD970C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A6061185
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhINXwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:52:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235806AbhINXwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:52:36 -0400
Received: (qmail 28514 invoked by uid 109); 14 Sep 2021 23:51:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 23:51:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30609 invoked by uid 111); 14 Sep 2021 23:51:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 19:51:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 19:51:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 01/11] serve: rename is_command() to parse_command()
Message-ID: <YUE1dXos1UP9kO+h@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_command() function not only tells us whether the pktline is a
valid command string, but it also parses out the command (and complains
if we see a duplicate). Let's rename it to make those extra functions
a bit more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 serve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/serve.c b/serve.c
index 1817edc7f5..fd88b95343 100644
--- a/serve.c
+++ b/serve.c
@@ -163,7 +163,7 @@ static int is_valid_capability(const char *key)
 	return c && c->advertise(the_repository, NULL);
 }
 
-static int is_command(const char *key, struct protocol_capability **command)
+static int parse_command(const char *key, struct protocol_capability **command)
 {
 	const char *out;
 
@@ -251,7 +251,7 @@ static int process_request(void)
 			BUG("Should have already died when seeing EOF");
 		case PACKET_READ_NORMAL:
 			/* collect request; a sequence of keys and values */
-			if (is_command(reader.line, &command) ||
+			if (parse_command(reader.line, &command) ||
 			    is_valid_capability(reader.line))
 				strvec_push(&keys, reader.line);
 			else
-- 
2.33.0.917.gae6ecbedc7

