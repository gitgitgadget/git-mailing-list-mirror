Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3DFC433F4
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1829E2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RtrsUtWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGZTyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgGZTyv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1C3A461013;
        Sun, 26 Jul 2020 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793290;
        bh=nz4+OtGq3fE7rGU2uzYwanb+xiaiZY8Q9Rnalz28LGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RtrsUtWPNPKUqw6XC84oco++Ef0sgCwJytPL5GKdK9+64XCBWTOxtncIYdabIi5rP
         C3BITYVlctiUvrPK7dmmy2aKbZTkkdSk0OPEz0Tgf6qRTNMGrKeqmi9T8ReMWUZ7UA
         l5A9Y46kEyILsusy08itwWQM/bC6RrKVqeE9ztn+YHc6aXDAohnusS2yo22jke/bx/
         reaV3JGhnoHTdQm9CF1tQCA1wg5jfg4ZAmuVIArQTqeVHoQzZERZHbmLG/ETZaDEN/
         3qa/4UVZeL8JE9lW/3zvm6aPaTcr5IIpXRvLruG9L1afqNGGyCNC7ssKZ2O50Yovlf
         ZKbSHqpg/GxUyHgXplYJ88bqY0LXlMCUd7VhQsEx83IZFKLWZbnONDReJkpkBVxGvq
         6L25G1Kixn9zxxJGa+QBw0YbLpskJwH1oLyQrUIwXYZCofsanuAnNM7UHsre7PpxE7
         +WcMI2040cO7kYTjw+ECkE9gMLdOIO/H+ZXLUC/ynZBZvYE9YV2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 20/39] t8011: make hash size independent
Date:   Sun, 26 Jul 2020 19:54:05 +0000
Message-Id: <20200726195424.626969-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow lines which start with either a 40- or 64-character hex object ID,
to allow for both SHA-1 and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8011-blame-split-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index 831125047b..8a4626d496 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup simulated porcelain' '
 	cat >read-porcelain.pl <<-\EOF
 	my $field = shift;
 	while (<>) {
-		if (/^[0-9a-f]{40} /) {
+		if (/^[0-9a-f]{40,64} /) {
 			flush();
 			$hash = $&;
 		} elsif (/^$field (.*)/) {
