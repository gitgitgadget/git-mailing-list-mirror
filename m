Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3EC2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59F5206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ddr4XvgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLUTuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfLUTuG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5E75607F1;
        Sat, 21 Dec 2019 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957806;
        bh=jSzi3+oT97M7iFE7O5sO3e4khL3Sau129ZFQhFJcuLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ddr4XvgTz9AFDpu6nBqiCLBttOHUXapjIeTuB4EGVsuXp+O0da+CYh+JEhVcXr+8m
         pqz3udR0UykA9BSUliOmS7d04W2W4txTe7Qh5tnJ5b1wVMxcwQOzr+ZyJLH7HdjWpg
         M2m8sj4uznZvIbYOwqkWBBI2hYkQU7yYu4gJlIDio059c5XM1ZiTL1Tslgnf85JmZ/
         FzGB+0KQtobtm6B+OS1N/L4lxNzGMT5x8/mS4zYDZD78D+ipUvKRAiGWVhcP6/6HhU
         jH/R16Q9HqUDJGvC8BUA1crV5zT2W2DzcmLajwP2PKuMK3GXBlgyXXLiVPN8k9qMZs
         ESusgW50G6kwuWT929EnrfnYM87iZJKP6wwjvmcl0vBWr7To6OxRFNxU2ZHMpHV2Nd
         8szIUGUZRqhsBhWIgjng9lU01rIHCNk9NTVZgflRQ/LH/oVzVZN48C2Nc8B9R5EEwO
         IPKTA+twiXBfiawFOHR4ooccMR8Lsg1LubpjAstTGvsWYlZvm3r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/20] t4066: compute index line in diffs
Date:   Sat, 21 Dec 2019 19:49:18 +0000
Message-Id: <20191221194936.1346664-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the object ID used in the index line will differ between different
algorithms, compute these values instead of hard-coding them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4066-diff-emit-delay.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index 5df6b5e64e..6331f63b12 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -18,7 +18,7 @@ test_expect_success 'set up history with a merge' '
 '
 
 test_expect_success 'log --cc -p --stat --color-moved' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	commit D
 	---
 	 D.t | 1 +
@@ -26,7 +26,7 @@ test_expect_success 'log --cc -p --stat --color-moved' '
 
 	diff --git a/D.t b/D.t
 	new file mode 100644
-	index 0000000..1784810
+	index 0000000..$(git rev-parse --short D:D.t)
 	--- /dev/null
 	+++ b/D.t
 	@@ -0,0 +1 @@
@@ -42,7 +42,7 @@ test_expect_success 'log --cc -p --stat --color-moved' '
 
 	diff --git a/C.t b/C.t
 	new file mode 100644
-	index 0000000..3cc58df
+	index 0000000..$(git rev-parse --short C:C.t)
 	--- /dev/null
 	+++ b/C.t
 	@@ -0,0 +1 @@
@@ -54,7 +54,7 @@ test_expect_success 'log --cc -p --stat --color-moved' '
 
 	diff --git a/B.t b/B.t
 	new file mode 100644
-	index 0000000..223b783
+	index 0000000..$(git rev-parse --short B:B.t)
 	--- /dev/null
 	+++ b/B.t
 	@@ -0,0 +1 @@
@@ -66,7 +66,7 @@ test_expect_success 'log --cc -p --stat --color-moved' '
 
 	diff --git a/A.t b/A.t
 	new file mode 100644
-	index 0000000..f70f10e
+	index 0000000..$(git rev-parse --short A:A.t)
 	--- /dev/null
 	+++ b/A.t
 	@@ -0,0 +1 @@
