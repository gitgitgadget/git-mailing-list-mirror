Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365FC433EB
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999E2206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mnDJwrTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGMCt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40592 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbgGMCtY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5FD5660A5C;
        Mon, 13 Jul 2020 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608563;
        bh=kzD44krolsMhdpvZfmNLjC7VTRRu/RTNvK14D0Rz7Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mnDJwrTTQAcRYFL4IS5NzX9A0O/fUgCXfqQwBQLDCEFvkOv4Yh9jYPjRFlB2YaJky
         19MKZxMUW6sDY3KDcIip7ZVvip9q/YLb8Xm/NZIHcHBDaq71igr/ewqdD6OTltmoQZ
         X87wgM56oBG9ra0eHT42cIOYUopT/Pv/K5ZdKYMdrREseGr8qFtQUSqbn6+UdZHBUU
         u2XIMoEXQ5GWl/XTISbWagvSC5WFnukwZGQ91TaX644iE8acMqVr6iOaTBCYbeBcGf
         OsFE0Y3951yLZsmvdxMrZEDbLTG5Y1eVjFndF14NAsA2Kwu9VO3UCwLAU8fVxJ2eGp
         Eo7UEsW2bffkbEA36CwaeNylTfZmISgWXU8CVoe4O7KaW6QXHHYfHe4dsBQEgYtc6f
         o3L6H6HUMUwjk5RPPXN5MyHGu6f7m3cLit3a28hlW/Xm+HCgSW6BvHIqsQLT1QYphy
         mx1BOVsHiZo3dpu51tFyCvCg57cSStRwKoQ5qPo2TWLeuJStGzL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 02/39] t1001: use $ZERO_OID
Date:   Mon, 13 Jul 2020 02:48:32 +0000
Message-Id: <20200713024909.3714837-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID to make the test hash independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1091-sparse-checkout-builtin.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7cd45fc139..84acfc48b6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -369,7 +369,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git clone repo unmerged &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C unmerged rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C unmerged update-index --index-info <input &&
@@ -396,7 +396,7 @@ test_expect_success 'sparse-checkout reapply' '
 	echo dirty >tweak/deep/deeper2/a &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C tweak rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C tweak update-index --index-info <input &&
