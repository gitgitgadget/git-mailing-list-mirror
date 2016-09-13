Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B952220985
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbcIMDXy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:42294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754656AbcIMDXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:52 -0400
Received: (qmail 20339 invoked by uid 109); 13 Sep 2016 03:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:52 +0000
Received: (qmail 18464 invoked by uid 111); 13 Sep 2016 03:24:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:48 -0700
Date:   Mon, 12 Sep 2016 20:23:48 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 09/16] pager: make pager_program a file-local static
Message-ID: <20160913032348.btinenvjy6y2xsbg@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is only ever used by the routines in pager.c,
and other parts of the code should always use those routines
(like git_pager()) to make decisions about which pager to
use. Let's reduce its scope to prevent accidents.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h       | 1 -
 environment.c | 1 -
 pager.c       | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 6738050..4f23952 100644
--- a/cache.h
+++ b/cache.h
@@ -1786,7 +1786,6 @@ extern void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
 extern void setup_pager(void);
-extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
diff --git a/environment.c b/environment.c
index ca72464..c266428 100644
--- a/environment.c
+++ b/environment.c
@@ -40,7 +40,6 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
-const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
diff --git a/pager.c b/pager.c
index d747f50..8aa0a82 100644
--- a/pager.c
+++ b/pager.c
@@ -7,6 +7,7 @@
 #endif
 
 static struct child_process pager_process = CHILD_PROCESS_INIT;
+static const char *pager_program;
 
 static void wait_for_pager(int in_signal)
 {
-- 
2.10.0.230.g6f8d04b

