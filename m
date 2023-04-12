Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E6C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDLG35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLG34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:29:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4E4ECD
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:29:55 -0700 (PDT)
Received: (qmail 17856 invoked by uid 109); 12 Apr 2023 06:29:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:29:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17081 invoked by uid 111); 12 Apr 2023 06:29:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:29:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:29:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 2/7] t5512: stop referring to "v1" protocol
Message-ID: <20230412062954.GB1681312@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062300.GA838367@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There really isn't a "v1" Git protocol. It's just v0 with an extra probe
which we used to test compatibility in preparation for v2. Any tests
that are looking for before/after behavior for v2 really care about
"v0". Mentioning "v1" in these tests is just making things more
confusing, because we don't care about that probe; we're really testing
v0. So let's say so.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5512-ls-remote.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 64dc6fa91c..ce7a9f1594 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -358,17 +358,17 @@ test_expect_success 'ls-remote --sort fails gracefully outside repository' '
 test_expect_success 'ls-remote patterns work with all protocol versions' '
 	git for-each-ref --format="%(objectname)	%(refname)" \
 		refs/heads/main refs/remotes/origin/main >expect &&
-	git -c protocol.version=1 ls-remote . main >actual.v1 &&
-	test_cmp expect actual.v1 &&
+	git -c protocol.version=0 ls-remote . main >actual.v0 &&
+	test_cmp expect actual.v0 &&
 	git -c protocol.version=2 ls-remote . main >actual.v2 &&
 	test_cmp expect actual.v2
 '
 
 test_expect_success 'ls-remote prefixes work with all protocol versions' '
 	git for-each-ref --format="%(objectname)	%(refname)" \
 		refs/heads/ refs/tags/ >expect &&
-	git -c protocol.version=1 ls-remote --heads --tags . >actual.v1 &&
-	test_cmp expect actual.v1 &&
+	git -c protocol.version=0 ls-remote --heads --tags . >actual.v0 &&
+	test_cmp expect actual.v0 &&
 	git -c protocol.version=2 ls-remote --heads --tags . >actual.v2 &&
 	test_cmp expect actual.v2
 '
-- 
2.40.0.493.gfc602f1919

