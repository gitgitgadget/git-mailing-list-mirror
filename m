Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64B91F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405107AbfBNFsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:48:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:43710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726129AbfBNFsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:48:05 -0500
Received: (qmail 725 invoked by uid 109); 14 Feb 2019 05:48:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:48:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6809 invoked by uid 111); 14 Feb 2019 05:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:48:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:48:03 -0500
Date:   Thu, 14 Feb 2019 00:48:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/10] diff: drop options parameter from
 diffcore_fix_diff_index()
Message-ID: <20190214054803.GA20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sole purpose of this function is to fix the sorting order of the
queued diff entries. It doesn't need to know about any diff options, so
we can drop the unused parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 2 +-
 diff.c     | 2 +-
 diff.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 23c8d351b3..a838c219ec 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -531,7 +531,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
-	diffcore_fix_diff_index(&revs->diffopt);
+	diffcore_fix_diff_index();
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_leave("diff-index");
diff --git a/diff.c b/diff.c
index 5306c48652..3e7d11fb70 100644
--- a/diff.c
+++ b/diff.c
@@ -6224,7 +6224,7 @@ static int diffnamecmp(const void *a_, const void *b_)
 	return strcmp(name_a, name_b);
 }
 
-void diffcore_fix_diff_index(struct diff_options *options)
+void diffcore_fix_diff_index(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	QSORT(q->queue, q->nr, diffnamecmp);
diff --git a/diff.h b/diff.h
index b512d0477a..8f55aad5ba 100644
--- a/diff.h
+++ b/diff.h
@@ -367,7 +367,7 @@ int git_config_rename(const char *var, const char *value);
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
 void diffcore_std(struct diff_options *);
-void diffcore_fix_diff_index(struct diff_options *);
+void diffcore_fix_diff_index(void);
 
 #define COMMON_DIFF_OPTIONS_HELP \
 "\ncommon diff options:\n" \
-- 
2.21.0.rc1.567.g648f076c3f

