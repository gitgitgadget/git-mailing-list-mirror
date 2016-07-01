Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6067620FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcGAIEb (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 04:04:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:38849 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751674AbcGAIE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 04:04:27 -0400
Received: (qmail 28876 invoked by uid 102); 1 Jul 2016 07:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:56:57 -0400
Received: (qmail 14552 invoked by uid 107); 1 Jul 2016 07:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:57:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 03:56:52 -0400
Date:	Fri, 1 Jul 2016 03:56:52 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH] Makefile: drop extra dependencies for test helpers
Message-ID: <20160701075651.GA20653@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A few test-helpers have Makefile dependencies on specific
object files. But since these files are part of libgit.a
(which all of the helpers link against), the inclusion is
simply redundant.

These were once necessary, but became redundant due to
5c5ba73 (Makefile: Use generic rule to build test programs,
2007-05-31), which added the $(GITLIBS) dependency (but
didn't prune the extra dependency lines). Later commits then
cargo-culted the practice (e.g., b4285c7).

Note that we _do_ need to leave the dependencies on the svn
library, as that is not part of the usual link command.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed while working on the common-main series.

 Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Makefile b/Makefile
index de5a030..22815a2 100644
--- a/Makefile
+++ b/Makefile
@@ -2225,16 +2225,8 @@ perf: all
 
 .PHONY: test perf
 
-t/helper/test-ctype$X: ctype.o
-
-t/helper/test-date$X: date.o ctype.o
-
-t/helper/test-delta$X: diff-delta.o patch-delta.o
-
 t/helper/test-line-buffer$X: vcs-svn/lib.a
 
-t/helper/test-parse-options$X: parse-options.o parse-options-cb.o
-
 t/helper/test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
-- 
2.9.0.317.g65b4e7c
