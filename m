Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0111FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758959AbcLPCaQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:30:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:57393 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLPCaP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:30:15 -0500
Received: (qmail 8706 invoked by uid 109); 16 Dec 2016 02:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 02:30:15 +0000
Received: (qmail 8541 invoked by uid 111); 16 Dec 2016 02:30:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 21:30:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 21:30:12 -0500
Date:   Thu, 15 Dec 2016 21:30:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] t5000: extract nongit function to test-lib-functions.sh
Message-ID: <20161216023011.7k4wyekid3zitl56@sigill.intra.peff.net>
References: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function abstracts the idea of running a command
outside of any repository (which is slightly awkward to do
because even if you make a non-repo directory, git may keep
walking up outside of the trash directory). There are
several scripts that use the same technique, so let's make
the function available for everyone.

Signed-off-by: Jeff King <peff@peff.net>
---
I waffled on the name. Something like test_outside_repo() is more
descriptive, but as this is prepended to existing commands, the lines
already end up quite long.

 t/t5000-tar-tree.sh     | 14 --------------
 t/test-lib-functions.sh | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 830bf2a2f6..886b6953e4 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,20 +94,6 @@ check_tar() {
 	'
 }
 
-# run "$@" inside a non-git directory
-nongit () {
-	test -d non-repo ||
-	mkdir non-repo ||
-	return 1
-
-	(
-		GIT_CEILING_DIRECTORIES=$(pwd) &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd non-repo &&
-		"$@"
-	)
-}
-
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fdaeb3a96b..adab7f51f4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -994,3 +994,17 @@ test_copy_bytes () {
 		}
 	' - "$1"
 }
+
+# run "$@" inside a non-git directory
+nongit () {
+	test -d non-repo ||
+	mkdir non-repo ||
+	return 1
+
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non-repo &&
+		"$@"
+	)
+}
-- 
2.11.0.348.g960a0b554

