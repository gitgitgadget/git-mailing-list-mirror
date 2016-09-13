Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43DCF207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbcIMDYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:42324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754778AbcIMDYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:13 -0400
Received: (qmail 20397 invoked by uid 109); 13 Sep 2016 03:24:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:13 +0000
Received: (qmail 18615 invoked by uid 111); 13 Sep 2016 03:24:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:24:10 -0700
Date:   Mon, 12 Sep 2016 20:24:10 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 13/16] test-config: setup git directory
Message-ID: <20160913032410.jvga3y4beqf22hw4@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t1308 test script uses our test-config helper to read
repository-level config, but never actually sets up the
repository. This works because git_config() blindly reads
".git/config" even if we have not configured a repository.

This means that test-config won't work from a subdirectory,
though since it's just a helper for the test scripts, that's
not a big deal.

More important is that the behavior of git_config() is going
to change, and we want to make sure that t1308 continues to
work. We can just use setup_git_directory(), and not the
gentle form; there's no point in being flexible, as it's
just a helper for the tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 3c6d08c..83a4f2a 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -72,6 +72,9 @@ int cmd_main(int argc, const char **argv)
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
+
+	setup_git_directory();
+
 	git_configset_init(&cs);
 
 	if (argc < 2) {
-- 
2.10.0.230.g6f8d04b

