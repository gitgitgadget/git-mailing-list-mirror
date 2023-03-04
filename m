Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84FC678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDKbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDKbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:31:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E31ACEB
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:31:49 -0800 (PST)
Received: (qmail 16866 invoked by uid 109); 4 Mar 2023 10:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:31:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3764 invoked by uid 111); 4 Mar 2023 10:31:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:31:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:31:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 5/5] parse-options: use prefix_filename_except_for_dash()
 helper
Message-ID: <ZAMeExFKTULOFZF1@coredump.intra.peff.net>
References: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since our fix_filename()'s only remaining special case is handling "-",
we can use the newly-minted helper function that handles this already.

Signed-off-by: Jeff King <peff@peff.net>
---
If we do eventually find that "!file || !*file" is a sign of a bug, we
could perhaps just simplify this whole function away. :)

 parse-options.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 25bae8b585b..6dd4c090e03 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -63,10 +63,8 @@ static void fix_filename(const char *prefix, char **file)
 {
 	if (!file || !*file)
 		; /* leave as NULL */
-	else if (!strcmp("-", *file))
-		*file = xstrdup(*file);
 	else
-		*file = prefix_filename(prefix, *file);
+		*file = prefix_filename_except_for_dash(prefix, *file);
 }
 
 static enum parse_opt_result opt_command_mode_error(
-- 
2.40.0.rc1.500.g967c04631e
