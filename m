Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6607C43457
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE55E2053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZuqEbuFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgGWBKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387565AbgGWBJ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A6E2660CF4
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466598;
        bh=nz4+OtGq3fE7rGU2uzYwanb+xiaiZY8Q9Rnalz28LGI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=ZuqEbuFYE+Q3yAa5BIlh2KNxG3iySGY9p7dlVyreT/AFt/Odue55kbkHITN9flbYi
         ESsSE6W9NguybXKjIzKRgJsvfKOqkhKhlfZuNnuRb6ZsIq7NbGtXDOvxrkXh18DBx7
         gjKG2sfiVqh/m4Hm8OgbxMUXtLlQqd5m6n7KB9mXBBGHORVkSaujk0Xhr3k7YTE1jx
         YQlgvF9TTN/bQGyRKoYuHEqSXGIMIeV7vqR70tH8a16AvE5w8miF9dkUzNAQAilhxG
         gX4hgAVdS0/AlA+iMwk+thPWOsoL+QdI6X9WxNci/Y4xKcx/ObamdHQ1Bnsvw0c6d1
         fDED89EnERhwmrBV2Ee/BC3MWv5X1ly5uWjm1wbhFqs5hsFBmoCSeu3hCNPJx3r8z5
         gI8v6Lzm9BmZJDelxp487TsN/atHJ6s626ZrQcDJDVXoL2mhHlvhepkgUKwQiJDf/C
         Pc2firrbWsk+dsqLFBjuohIjF1gH3oHPwnvBCX4Jq3Rk2TCukIx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 20/39] t8011: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:24 +0000
Message-Id: <20200723010943.2329634-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
