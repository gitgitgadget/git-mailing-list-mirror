Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617DC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBXGjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBXGji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBF6355B
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:28 -0800 (PST)
Received: (qmail 3693 invoked by uid 109); 24 Feb 2023 06:39:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31119 invoked by uid 111); 24 Feb 2023 06:39:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/21] prio-queue: mark unused parameters in comparison
 functions
Message-ID: <Y/hbnxLl88xiCrH9@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prio_queue_compare_fn interface has a void pointer to allow callers
to pass arbitrary data, but most comparison functions don't need it.
Mark those cases to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c                   | 6 ++++--
 negotiator/skipping.c      | 2 +-
 t/helper/test-prio-queue.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index e433c33bb0..0606d16e3a 100644
--- a/commit.c
+++ b/commit.c
@@ -801,7 +801,8 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 	return 0;
 }
 
-int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_,
+					    void *unused UNUSED)
 {
 	const struct commit *a = a_, *b = b_;
 	const timestamp_t generation_a = commit_graph_generation(a),
@@ -821,7 +822,8 @@ int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void
 	return 0;
 }
 
-int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
+int compare_commits_by_commit_date(const void *a_, const void *b_,
+				   void *unused UNUSED)
 {
 	const struct commit *a = a_, *b = b_;
 	/* newer commits with larger date first */
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0f5ac48e87..4867efc5f5 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -50,7 +50,7 @@ struct data {
 	int non_common_revs;
 };
 
-static int compare(const void *a_, const void *b_, void *unused)
+static int compare(const void *a_, const void *b_, void *data UNUSED)
 {
 	const struct entry *a = a_;
 	const struct entry *b = b_;
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 133b5e6f4a..496c7be07d 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 #include "prio-queue.h"
 
-static int intcmp(const void *va, const void *vb, void *data)
+static int intcmp(const void *va, const void *vb, void *data UNUSED)
 {
 	const int *a = va, *b = vb;
 	return *a - *b;
-- 
2.39.2.981.g6157336f25

