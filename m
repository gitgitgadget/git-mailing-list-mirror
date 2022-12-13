Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98548C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiLMLRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLMLRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:17:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C21A390
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:16:58 -0800 (PST)
Received: (qmail 14532 invoked by uid 109); 13 Dec 2022 11:16:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:16:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4351 invoked by uid 111); 13 Dec 2022 11:16:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:16:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:16:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 9/9] userdiff: mark unused parameter in internal callback
Message-ID: <Y5hfKWD84y72CFHK@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f12fa9ee6c (userdiff: add and use for_each_userdiff_driver(),
2021-04-08), lookup of userdiffs is done with a generic
for_each_userdiff_driver(). But the name lookup doesn't use the "type"
field, of course.

We can't get rid of that field from the generic interface because it is
used by t/helper/test-userdiff.c. So mark it as unused in this instance
to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---

 userdiff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 151d9a5278..e25356a061 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -315,7 +315,8 @@ struct find_by_namelen_data {
 };
 
 static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
-				       enum userdiff_driver_type type, void *priv)
+				       enum userdiff_driver_type type UNUSED,
+				       void *priv)
 {
 	struct find_by_namelen_data *cb_data = priv;
 
-- 
2.39.0.546.g5ea984bc66
