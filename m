Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BCC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjIRWdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRWdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:33:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875468F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:32:57 -0700 (PDT)
Received: (qmail 13086 invoked by uid 109); 18 Sep 2023 22:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:32:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4738 invoked by uid 111); 18 Sep 2023 22:32:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:32:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:32:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 6/8] fsmonitor/darwin: mark unused parameters in system
 callback
Message-ID: <20230918223256.GF2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass fsevent_callback() to the system FSEventStreamCreate() function
as a callback. So we must match the expected function signature, even
though we don't care about all of the parameters. Mark the unused ones
to satisfy -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/fsmonitor/fsm-listen-darwin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 36c7e13281..11b56d3ef1 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -191,12 +191,12 @@ static void my_add_path(struct fsmonitor_batch *batch, const char *path)
 }
 
 
-static void fsevent_callback(ConstFSEventStreamRef streamRef,
+static void fsevent_callback(ConstFSEventStreamRef streamRef UNUSED,
 			     void *ctx,
 			     size_t num_of_events,
 			     void *event_paths,
 			     const FSEventStreamEventFlags event_flags[],
-			     const FSEventStreamEventId event_ids[])
+			     const FSEventStreamEventId event_ids[] UNUSED)
 {
 	struct fsmonitor_daemon_state *state = ctx;
 	struct fsm_listen_data *data = state->listen_data;
-- 
2.42.0.671.g43fbf3903a

