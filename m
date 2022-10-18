Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B923C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJRBGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJRBFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:05:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58935BAF
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:05:53 -0700 (PDT)
Received: (qmail 28790 invoked by uid 109); 18 Oct 2022 01:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:05:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13463 invoked by uid 111); 18 Oct 2022 01:05:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:05:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:05:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/12] date: mark unused parameters in handler functions
Message-ID: <Y0378IyBza5uo2Md@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing approxidates, we use a table to map special strings (like
"noon") to functions which handle them. Not all functions need the "now"
parameter, as they are not relative (e.g., "yesterday" does, but "pm"
does not). Let's annotate those to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 date.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 68a260c214..53bd6a7932 100644
--- a/date.c
+++ b/date.c
@@ -1101,7 +1101,7 @@ static void date_tea(struct tm *tm, struct tm *now, int *num)
 	date_time(tm, now, 17);
 }
 
-static void date_pm(struct tm *tm, struct tm *now, int *num)
+static void date_pm(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	int hour, n = *num;
 	*num = 0;
@@ -1115,7 +1115,7 @@ static void date_pm(struct tm *tm, struct tm *now, int *num)
 	tm->tm_hour = (hour % 12) + 12;
 }
 
-static void date_am(struct tm *tm, struct tm *now, int *num)
+static void date_am(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	int hour, n = *num;
 	*num = 0;
@@ -1129,7 +1129,7 @@ static void date_am(struct tm *tm, struct tm *now, int *num)
 	tm->tm_hour = (hour % 12);
 }
 
-static void date_never(struct tm *tm, struct tm *now, int *num)
+static void date_never(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	time_t n = 0;
 	localtime_r(&n, tm);
-- 
2.38.0.371.g300879f34e

