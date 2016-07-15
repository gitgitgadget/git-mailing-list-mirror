Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96302018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbcGOKgj (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:36:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:45327 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:36:38 -0400
Received: (qmail 18348 invoked by uid 102); 15 Jul 2016 10:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:36:38 -0400
Received: (qmail 14428 invoked by uid 107); 15 Jul 2016 10:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:36:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:36:35 -0400
Date:	Fri, 15 Jul 2016 06:36:35 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 11/12] receive-pack: turn on connectivity progress
Message-ID: <20160715103635.GK19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we receive a large push, the server side of the
connection may spend a lot of time (30s or more for a full
push of linux.git) walking the object graph without
producing any output. Let's give the user some indication
that we're actually working.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d309109..7db1639 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1342,6 +1342,7 @@ static void execute_commands(struct command *commands,
 	data.cmds = commands;
 	data.si = si;
 	opt.err_fd = err_fd;
+	opt.progress = err_fd && !quiet;
 	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
 
-- 
2.9.1.434.g748be50

