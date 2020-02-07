Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D597C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5436220838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pVf8/SDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBGAxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55594 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgBGAxp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D3A2F607F5;
        Fri,  7 Feb 2020 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036819;
        bh=1MOOFACdi6walbZenN3/PtmmpgSl97nBTVUJrzTxn5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pVf8/SDHwT5UR37PvHvylA0FeEfrs7I21vkW67BhffTFPDECY89AF/N7KMnheGGcl
         Dso2P2RmZNTo5PL/Z4QFL2a+o/Wrj0rrIRTWAFtjemUS4ZeZRy+JzQivLjYUoqERjC
         Ovd3dCcIbkpNEEOoiRhZyW9NC2FrCx9lSV+Ca2cSb72eBS1N1UVGOozax5MUZUdtNU
         5UfIkoUN1GRgOYuMOUVVXIA7QIbdTRBE9SIDB81eT5/IJnk/xnpjZ6B+uHpjXlhnnU
         z5/DFqcLKtWU7ev7AxbPTit0rm3V5rt6PbiU8q05CPAd5fZCZUeUNAKbUPJDUlqAkd
         31wjNLiQsfdbdjZouZbVCPQSaxSl52Rw/PYblAXmr5oAaoSmSBb8LJSHSSp9VRqzTf
         hvv1lhpfJUyhBVfCOyOc+GNusbWEZ2+6b6ErwN3dzYUwapR/yvL4iCmcN7KSwdmd6o
         g6UWqxUpyOFO64c5r+3E+cEYZWKWSIl+JpAanPkOwL5FtnqEArs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/21] t5321: make test hash independent
Date:   Fri,  7 Feb 2020 00:52:47 +0000
Message-Id: <20200207005254.1495851-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the proper pack constants defined in lib-pack.sh to make this test
work with SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5321-pack-large-objects.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index a75eab87d3..8a56d98a0e 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -10,8 +10,8 @@ test_description='git pack-object with "large" deltas
 . "$TEST_DIRECTORY"/lib-pack.sh
 
 # Two similar-ish objects that we have computed deltas between.
-A=01d7713666f4de822776c7622c10f1b07de280dc
-B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+A=$(test_oid packlib_7_0)
+B=$(test_oid packlib_7_76)
 
 test_expect_success 'setup' '
 	clear_packs &&
