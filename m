Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAE41F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEIVaV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:30:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:53684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726682AbfEIVaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:30:21 -0400
Received: (qmail 10064 invoked by uid 109); 9 May 2019 21:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6493 invoked by uid 111); 9 May 2019 21:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:30:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:30:19 -0400
Date:   Thu, 9 May 2019 17:30:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/14] wt-status: drop unused status parameter
Message-ID: <20190509213019.GF15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2_fix_up_changed() function doesn't actually need to see the
wt_status struct. It's possible that could change in the future, but
this is a static-local function with one caller. It would be easy to
read-add it back then. Let's drop the unused parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index f4fa982638..4c365ca6fd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2045,9 +2045,7 @@ static void wt_porcelain_v2_submodule_state(
 /*
  * Fix-up changed entries before we print them.
  */
-static void wt_porcelain_v2_fix_up_changed(
-	struct string_list_item *it,
-	struct wt_status *s)
+static void wt_porcelain_v2_fix_up_changed(struct string_list_item *it)
 {
 	struct wt_status_change_data *d = it->util;
 
@@ -2107,7 +2105,7 @@ static void wt_porcelain_v2_print_changed_entry(
 	char submodule_token[5];
 	char sep_char, eol_char;
 
-	wt_porcelain_v2_fix_up_changed(it, s);
+	wt_porcelain_v2_fix_up_changed(it);
 	wt_porcelain_v2_submodule_state(d, submodule_token);
 
 	key[0] = d->index_status ? d->index_status : '.';
-- 
2.21.0.1382.g4c6032d436

