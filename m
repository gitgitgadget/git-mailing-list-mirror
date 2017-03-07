Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738F81FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 14:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbdCGOGV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:06:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:39736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbdCGOGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:06:02 -0500
Received: (qmail 19884 invoked by uid 109); 7 Mar 2017 13:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:37:39 +0000
Received: (qmail 25626 invoked by uid 111); 7 Mar 2017 13:37:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:37:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:37:36 -0500
Date:   Tue, 7 Mar 2017 08:37:36 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 4/6] send-pack: improve unpack-status error messages
Message-ID: <20170307133736.4lpn7mgme26dqs3m@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the remote tells us that the "unpack" step failed, we
show an error message. However, unless you are familiar with
the internals of send-pack and receive-pack, it was not
clear that this represented an error on the remote side.
Let's re-word to make that more obvious.

Likewise, when we got an unexpected packet from the other
end, we complained with a vague message but did not actually
show the packet.  Let's fix that.

And finally, neither message was marked for translation. The
message from the remote probably won't be translated, but
there's no reason we can't do better for the local half.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 243633da1..83c23aef6 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -134,9 +134,9 @@ static int receive_unpack_status(int in)
 {
 	const char *line = packet_read_line(in, NULL);
 	if (!skip_prefix(line, "unpack ", &line))
-		return error("did not receive remote status");
+		return error(_("unable to parse remote unpack status: %s"), line);
 	if (strcmp(line, "ok"))
-		return error("unpack failed: %s", line);
+		return error(_("remote unpack failed: %s"), line);
 	return 0;
 }
 
-- 
2.12.0.429.gde83c8049

