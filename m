Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51BC433ED
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758C920829
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jc1Rga8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgG1XfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730149AbgG1XfG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0304560AFD;
        Tue, 28 Jul 2020 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979304;
        bh=L4ikSk2ksF5tOP+JVJ03gA5CEshYrAarLzuzOB/wnpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jc1Rga8bbOAY39LAIv4ZtZdIuSeN1aTtr8HaY2NaHAh6aCaFrcW4JpCczpX2UolQH
         //IR/3claMnOxgs6YZ/JxfeujuqVfmsymMVsoUJJuk7EY43sLCGYvDM7RvzLCt3R65
         5rwKjzVeVzzzZWMi6k0RIDUrSAzCfW8H4998/sy27pXVT8Zhn/4QcdgsrISX3s6QhC
         z0OPHwHd4M1EH+Syj1j/qHa/rRwrkx9keLDgRuC2i+lNI6KzaG3QEFS+TiNUN2Xc7C
         WbZbKLvau8ENIeXhtVuxVkKRs4JrsFlXcstbwy5iACsY8Q3Di3Vv7euYIVzaDC5W8p
         7zgRKbd2atUjoTJOikVRA6RSzAjujoCI37JavgaT2EkPKynASSeH99uFRiUxuxwtRs
         x7/sPt+P4BqhyRpeVIkYoOzWV5Aoff2kmJRII9CNLIrq9tEWOIpk+O4TgcaPUFSE75
         DQcvNEWkiyay1I53/iOXfEWIA4X8x/8wOBkExoklo0pYu1r24Mc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 20/39] t8011: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:27 +0000
Message-Id: <20200728233446.3066485-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
index 831125047b..bdda0c03fe 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup simulated porcelain' '
 	cat >read-porcelain.pl <<-\EOF
 	my $field = shift;
 	while (<>) {
-		if (/^[0-9a-f]{40} /) {
+		if (/^[0-9a-f]{40,} /) {
 			flush();
 			$hash = $&;
 		} elsif (/^$field (.*)/) {
