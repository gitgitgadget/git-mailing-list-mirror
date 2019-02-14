Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316CC1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405502AbfBNFus (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:50:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726155AbfBNFus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:50:48 -0500
Received: (qmail 890 invoked by uid 109); 14 Feb 2019 05:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6944 invoked by uid 111); 14 Feb 2019 05:50:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:50:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:50:46 -0500
Date:   Thu, 14 Feb 2019 00:50:46 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/10] files-backend: drop refs parameter from
 split_symref_update()
Message-ID: <20190214055045.GG20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This parameter was added in fcc42ea0c9 (split_symref_update(): add a
files_ref_store argument, 2016-09-04) without comment, but never used.
The splitting is purely mechanical, and doesn't depend on the particular
ref-store. Let's drop this parameter in the name of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dd8abe9185..ef053f716c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2254,8 +2254,7 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct files_ref_store *refs,
-			       struct ref_update *update,
+static int split_symref_update(struct ref_update *update,
 			       const char *referent,
 			       struct ref_transaction *transaction,
 			       struct string_list *affected_refnames,
@@ -2449,7 +2448,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
-			ret = split_symref_update(refs, update,
+			ret = split_symref_update(update,
 						  referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
-- 
2.21.0.rc1.567.g648f076c3f

