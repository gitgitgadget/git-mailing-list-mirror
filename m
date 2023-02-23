Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AF5C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjBWKun (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjBWKuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:50:40 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A370515E8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:50:37 -0800 (PST)
Received: (qmail 24763 invoked by uid 109); 23 Feb 2023 10:50:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:50:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20108 invoked by uid 111); 23 Feb 2023 10:50:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:50:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:50:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/16] t5541: stop marking "used receive-pack service" test
 as v0 only
Message-ID: <Y/dE/KbM/PYlGAYm@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a test which checks to see if a request to git-receive-pack was
made. Originally, it was checking the entire set of requests made in the
script so far, including clones, and thus it would break when run with
the v2 protocol (since that implies an extra request for fetches).

Since the previous commit, though, we are only checking the requests
made by a single push. And since there is no v2 push protocol, the test
now passes no matter what's in GIT_TEST_PROTOCOL_VERSION. We can just
run it all the time.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push-smart.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index ef39d14ed2..f8bf533c33 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -86,12 +86,7 @@ test_expect_success 'used receive-pack service' '
 	POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 	EOF
 
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
+	check_access_log exp
 '
 
 test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
-- 
2.39.2.981.g6157336f25

