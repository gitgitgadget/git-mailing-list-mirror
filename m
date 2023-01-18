Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FBBC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjARUgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjARUf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:35:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0027488
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:35:31 -0800 (PST)
Received: (qmail 3319 invoked by uid 109); 18 Jan 2023 20:35:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:35:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24924 invoked by uid 111); 18 Jan 2023 20:35:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:35:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:35:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/6] t1007: modernize malformed object tests
Message-ID: <Y8hYEgMze3bY44/0@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in t1007 for detecting malformed objects have two
anachronisms:

 - they use "sha1" instead of "oid" in variable names, even though the
   script as a whole has been adapted to handle sha256

 - they use test_i18ngrep, which is no longer necessary

Since we'll be adding a new similar test, let's clean these up so they
are all consistently using the modern style.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1007-hash-object.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index ac5ad8c740..2d2148d8fa 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -203,23 +203,23 @@ done
 test_expect_success 'too-short tree' '
 	echo abc >malformed-tree &&
 	test_must_fail git hash-object -t tree malformed-tree 2>err &&
-	test_i18ngrep "too-short tree object" err
+	grep "too-short tree object" err
 '
 
 test_expect_success 'malformed mode in tree' '
-	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
-	bin_sha1=$(echo $hex_sha1 | hex2oct) &&
-	printf "9100644 \0$bin_sha1" >tree-with-malformed-mode &&
+	hex_oid=$(echo foo | git hash-object --stdin -w) &&
+	bin_oid=$(echo $hex_oid | hex2oct) &&
+	printf "9100644 \0$bin_oid" >tree-with-malformed-mode &&
 	test_must_fail git hash-object -t tree tree-with-malformed-mode 2>err &&
-	test_i18ngrep "malformed mode in tree entry" err
+	grep "malformed mode in tree entry" err
 '
 
 test_expect_success 'empty filename in tree' '
-	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
-	bin_sha1=$(echo $hex_sha1 | hex2oct) &&
-	printf "100644 \0$bin_sha1" >tree-with-empty-filename &&
+	hex_oid=$(echo foo | git hash-object --stdin -w) &&
+	bin_oid=$(echo $hex_oid | hex2oct) &&
+	printf "100644 \0$bin_oid" >tree-with-empty-filename &&
 	test_must_fail git hash-object -t tree tree-with-empty-filename 2>err &&
-	test_i18ngrep "empty filename in tree entry" err
+	grep "empty filename in tree entry" err
 '
 
 test_expect_success 'corrupt commit' '
-- 
2.39.1.616.gd06fca9e99

