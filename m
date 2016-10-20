Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9E920986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbcJTGRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:17:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59857 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753574AbcJTGRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:17:02 -0400
Received: (qmail 18423 invoked by uid 109); 20 Oct 2016 06:17:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:17:02 +0000
Received: (qmail 21018 invoked by uid 111); 20 Oct 2016 06:17:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:17:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:16:59 -0400
Date:   Thu, 20 Oct 2016 02:16:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] test-*-cache-tree: setup git dir
Message-ID: <20161020061659.6yzrphnhd4jkbyhg@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These test helper programs access the index, but do not ever
setup_git_directory(), meaning we just blindly looked in
".git/index". This happened to work for the purposes of our
tests (which do not run from subdirectories, nor in
non-repos), but it's a bad habit.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-dump-cache-tree.c  | 1 +
 t/helper/test-scrap-cache-tree.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 44f3290..7af116d 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -58,6 +58,7 @@ int cmd_main(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
+	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	istate = the_index;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 5b2fd09..27fe040 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -7,6 +7,7 @@ static struct lock_file index_lock;
 
 int cmd_main(int ac, const char **av)
 {
+	setup_git_directory();
 	hold_locked_index(&index_lock, 1);
 	if (read_cache() < 0)
 		die("unable to read index file");
-- 
2.10.1.619.g16351a7

