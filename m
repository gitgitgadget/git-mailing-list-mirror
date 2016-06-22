Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1564C20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcFVTlB (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:41:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:58733 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbcFVTlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:41:00 -0400
Received: (qmail 7479 invoked by uid 102); 22 Jun 2016 19:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:40:53 -0400
Received: (qmail 5047 invoked by uid 107); 22 Jun 2016 19:41:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:41:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 15:40:51 -0400
Date:	Wed, 22 Jun 2016 15:40:51 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] p4211: explicitly disable renames in no-rename test
Message-ID: <20160622194051.GB1697@sigill.intra.peff.net>
References: <20160622193904.GA1509@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160622193904.GA1509@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

p4211 tests line-log performance both with and without "-M".
In v2.9.0, the case without "-M" appears to have regressed
badly, but that is only because we flipped on renames by
default.

Let's have the test explicitly disable renames to get
consistent timings (and to match the presumed intent of the
test, which is to see the effects with and without renames).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p4211-line-log.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p4211-line-log.sh b/t/perf/p4211-line-log.sh
index 3d074b0..b7ff68d 100755
--- a/t/perf/p4211-line-log.sh
+++ b/t/perf/p4211-line-log.sh
@@ -23,11 +23,11 @@ test_perf 'git log --follow (baseline for -M)' '
 	git log --oneline --follow -- "$file" >/dev/null
 '
 
-test_perf 'git log -L' '
-	git log -L 1:"$file" >/dev/null
+test_perf 'git log -L (renames off)' '
+	git log --no-renames -L 1:"$file" >/dev/null
 '
 
-test_perf 'git log -M -L' '
+test_perf 'git log -L (renames on)' '
 	git log -M -L 1:"$file" >/dev/null
 '
 
-- 
2.9.0.204.g1499a7b
