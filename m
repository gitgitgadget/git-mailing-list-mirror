Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593CE1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbdCGSfl (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:35:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:39939 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbdCGSfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 13:35:39 -0500
Received: (qmail 19754 invoked by uid 109); 7 Mar 2017 13:36:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:36:21 +0000
Received: (qmail 25616 invoked by uid 111); 7 Mar 2017 13:36:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:36:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:36:19 -0500
Date:   Tue, 7 Mar 2017 08:36:19 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/6] send-pack: use skip_prefix for parsing unpack status
Message-ID: <20170307133618.azljsixuv4o6f24p@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids repeating ourselves, and the use of magic
numbers.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not necessary, but just a cleanup while I was here.

 send-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 12e229e44..243633da1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -133,10 +133,10 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 static int receive_unpack_status(int in)
 {
 	const char *line = packet_read_line(in, NULL);
-	if (!starts_with(line, "unpack "))
+	if (!skip_prefix(line, "unpack ", &line))
 		return error("did not receive remote status");
-	if (strcmp(line, "unpack ok"))
-		return error("unpack failed: %s", line + 7);
+	if (strcmp(line, "ok"))
+		return error("unpack failed: %s", line);
 	return 0;
 }
 
-- 
2.12.0.429.gde83c8049

