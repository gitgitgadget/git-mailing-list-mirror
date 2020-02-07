Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C4C3F68F
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D33214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vtEOULQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBGAxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgBGAxl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 750D860FC5;
        Fri,  7 Feb 2020 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036820;
        bh=8FU4zHKprYpeY3ERg5TngHjUqssaMsZOwf9nyGbqoW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vtEOULQGKUiNhJdqv5RcASH4LAVOzM35UxumhgnPJLLp7RVK+DMBwvJQf/yRjlGuD
         Tt0R74Rg1mvVatGLeIaohc8r6XNqdXGUKKw0GGKcjBq6SODeJ+aI5swePmylKVBWjP
         9Gmn20VzF09a8xmWNne99HqRF4II0x6qZFTGhCz/UyLoDDdTlZaTxOlVuULpp0SDB+
         m/aAoeEOHJ4ZSPZgrJ94Ssb642TXcZv4zgVjm35qwKGfz44Bv0ctry+29CG8qSBB6o
         6RJrGFqn2zRF0xyC74qP5vuhpne7b2CI/LM+7I9lxIR3wpVWKD68eGkhp7pztyixDj
         1Hq2Rp2nQMQtzErHsjBJSRQRvMwz6T3ki/kVma/806Csf2muN7yCeiYRRns6ddPypi
         T49lis6OhaZ29IPPqeTG+FoUNaQuGUFqBRXnXydlLFXx3scFpdG+6BUq62V58F4PST
         O2ei5hKAa1hAo0rh20ScIG4t2CrxsUpQDxLYMcgN+rp6jzwLCyH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/21] t5607: make hash size independent
Date:   Fri,  7 Feb 2020 00:52:50 +0000
Message-Id: <20200207005254.1495851-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index b7a3fdf02d..9108ff6fbd 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -64,7 +64,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
 	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
-	grep "^-[0-9a-f]\\{40\\} " boundary
+	grep "^-$OID_REGEX " boundary
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
