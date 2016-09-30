Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02715207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbcI3TgB (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:50595 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbcI3TgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:00 -0400
Received: (qmail 31162 invoked by uid 109); 30 Sep 2016 19:36:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:00 +0000
Received: (qmail 13447 invoked by uid 111); 30 Sep 2016 19:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:35:57 -0400
Date:   Fri, 30 Sep 2016 15:35:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 1/6] check_connected: accept an env argument
Message-ID: <20160930193557.q6dtz3wcnui4ndrr@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets callers influence the environment seen by
rev-list, which will be useful when we start providing
quarantined objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 1 +
 connected.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/connected.c b/connected.c
index 8e3e4b1..136c2ac 100644
--- a/connected.c
+++ b/connected.c
@@ -63,6 +63,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 				 _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
+	rev_list.env = opt->env;
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
 	if (opt->err_fd)
diff --git a/connected.h b/connected.h
index afa48cc..4ca325f 100644
--- a/connected.h
+++ b/connected.h
@@ -33,6 +33,11 @@ struct check_connected_options {
 
 	/* If non-zero, show progress as we traverse the objects. */
 	int progress;
+
+	/*
+	 * Insert these variables into the environment of the child process.
+	 */
+	const char **env;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.10.0.618.g82cc264

