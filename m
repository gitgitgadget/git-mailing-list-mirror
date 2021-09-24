Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E83C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D5261265
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbhIXShF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:37:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:54628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344756AbhIXShF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:37:05 -0400
Received: (qmail 19070 invoked by uid 109); 24 Sep 2021 18:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:35:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11047 invoked by uid 111); 24 Sep 2021 18:35:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:35:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:35:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 04/16] t5312: drop "verbose" helper
Message-ID: <YU4acRiq8YrhEOYu@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t5312 has several uses of the "verbose" helper, as described in
8ad1652418 (t5304: use helper to report failure of "test foo = bar",
2014-10-10). Back then the "-x" trace option for tests was new, and was
not as pleasant to use (e.g., some tests failed under "-x", we did not
support BASH_XTRACEFD, etc).

These days it is clear that "-x" is the preferred way to get extra
output, and we don't need to mark up individual tests. Let's get rid of
the uses of "verbose" here, as one step toward eradicating it totally.

Signed-off-by: Jeff King <peff@peff.net>
---
I've been tempted to do this tree-wide for a while, and I don't mind
doing that separately. But as I was touching these tests, it seemed like
a good time to do it here.

 t/t5312-prune-corruption.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 11423b3cb2..165cc80fa4 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -31,21 +31,21 @@ test_expect_success 'create history reachable only from a bogus-named ref' '
 test_expect_success 'pruning does not drop bogus object' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	test_might_fail git prune --expire=now &&
-	verbose git cat-file -e $bogus
+	git cat-file -e $bogus
 '
 
 test_expect_success 'put bogus object into pack' '
 	git tag reachable $bogus &&
 	git repack -ad &&
 	git tag -d reachable &&
-	verbose git cat-file -e $bogus
+	git cat-file -e $bogus
 '
 
 test_expect_success 'destructive repack keeps packed object' '
 	test_might_fail git repack -Ad --unpack-unreachable=now &&
-	verbose git cat-file -e $bogus &&
+	git cat-file -e $bogus &&
 	test_might_fail git repack -ad &&
-	verbose git cat-file -e $bogus
+	git cat-file -e $bogus
 '
 
 # subsequent tests will have different corruptions
@@ -78,7 +78,7 @@ test_expect_success 'create history with missing tip commit' '
 test_expect_success 'pruning with a corrupted tip does not drop history' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	test_might_fail git prune --expire=now &&
-	verbose git cat-file -e $recoverable
+	git cat-file -e $recoverable
 '
 
 test_expect_success 'pack-refs does not silently delete broken loose ref' '
-- 
2.33.0.1071.gb37e412355

