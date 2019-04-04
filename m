Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D98D20248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfDDXbH (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:47462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729098AbfDDXbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:31:07 -0400
Received: (qmail 1551 invoked by uid 109); 4 Apr 2019 23:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20563 invoked by uid 111); 4 Apr 2019 23:31:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:31:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:31:05 -0400
Date:   Thu, 4 Apr 2019 19:31:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/12] update_info_refs(): drop unused force parameter
Message-ID: <20190404233105.GL21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time the force flag meant something when writing info/refs,
but it hasn't done anything since 60d0526aaa (Unoptimize info/refs
creation., 2005-09-14).

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/server-info.c b/server-info.c
index ab03c1b3c2..41274d098b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -78,7 +78,7 @@ static int generate_info_refs(FILE *fp)
 	return for_each_ref(add_info_ref, fp);
 }
 
-static int update_info_refs(int force)
+static int update_info_refs(void)
 {
 	char *path = git_pathdup("info/refs");
 	int ret = update_info_file(path, generate_info_refs);
@@ -269,7 +269,7 @@ int update_server_info(int force)
 	 */
 	int errs = 0;
 
-	errs = errs | update_info_refs(force);
+	errs = errs | update_info_refs();
 	errs = errs | update_info_packs(force);
 
 	/* remove leftover rev-cache file if there is any */
-- 
2.21.0.714.gd1be1d035b
