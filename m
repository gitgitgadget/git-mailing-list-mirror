Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF3207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755028AbcIMDYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754930AbcIMDYW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:22 -0400
Received: (qmail 20416 invoked by uid 109); 13 Sep 2016 03:24:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:22 +0000
Received: (qmail 18638 invoked by uid 111); 13 Sep 2016 03:24:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:24:19 -0700
Date:   Mon, 12 Sep 2016 20:24:19 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 15/16] init: expand comments explaining config trickery
Message-ID: <20160913032418.boochwwign64nfvv@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-init may copy "config" from the templates directory and
then re-read it. There are some comments explaining what's
going on here, but they are not grouped very well with the
matching code. Let's rearrange and expand them.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3a45f0b..e935895 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -191,16 +191,19 @@ static int create_default_files(const char *template_path)
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
 
-	/* First copy the templates -- we might have the default
+	/*
+	 * First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
 	 */
 	copy_templates(template_path);
-
 	git_config(git_default_config, NULL);
-	is_bare_repository_cfg = init_is_bare_repository;
 
-	/* reading existing config may have overwrote it */
+	/*
+	 * We must make sure command-line options continue to override any
+	 * values we might have just re-read from the config.
+	 */
+	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
 
-- 
2.10.0.230.g6f8d04b

