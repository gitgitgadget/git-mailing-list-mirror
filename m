Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A4C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E55206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jldcrd7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfLUTuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41972 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbfLUTuH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B7D53607F0;
        Sat, 21 Dec 2019 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957807;
        bh=PPh+KIhAigigKBimDAnxsmI6PGl1f018JooyKawflik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jldcrd7w49KpwghjuuHvVrVN37e/8LWFdjv6MixMFi7vDdM3ejlq7nnqrB6BDz1i+
         3G9aBtFKBRE//SyuppCkLtnr77Dycc2NhQKqAXf3LUg0euVaIgIoTYg/T2FPFI5hix
         uhUrSAP2OxIoQEKkNqOXuzYAoSt/uXl2q80NavGuk7bdD2NG5Ng8SBSphLkQjAxbw7
         7yUClZjsenkKdcuswTgiGifGLDeXVyGH5JNjoSiI2eFwmuNI1WEQKpQuGzIuYfLHKz
         1FwSJ9VzsoDzOFLKNjB7Pdjn/7OAuY4eFvC+txkl331DiGQ3KzNrevFfR9L6pk8q/7
         CF0ZyrH4znQVTp/NuRqio5Wfsp5yYCC0RFkrafh0DrRc5WiE/XDN57XlefwmV+1gmp
         3+TP1LMnllTLL13yGZcyEqoeOotLo/DehubAKizVc5TRlxSRknDdGpOm92TiKLOSnM
         BzX7pH0pEb23gSJMP95D3KYTggEkrHyUegIxoB6xFyshhri+kPb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/20] t4200: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:20 +0000
Message-Id: <20191221194936.1346664-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length example object ID in the test,
look one up using the translation tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4200-rerere.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 55b7750ade..831d424c47 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,6 +25,7 @@ test_description='git rerere
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	cat >a1 <<-\EOF &&
 	Some title
 	==========
@@ -210,7 +211,7 @@ test_expect_success 'set up for garbage collection tests' '
 	echo Hello >$rr/preimage &&
 	echo World >$rr/postimage &&
 
-	sha2=4000000000000000000000000000000000000000 &&
+	sha2=$(test_oid deadbeef) &&
 	rr2=.git/rr-cache/$sha2 &&
 	mkdir $rr2 &&
 	echo Hello >$rr2/preimage &&
