Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F7C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BBE20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o43IAQg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJCsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40414 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgGJCso (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C40C660A71;
        Fri, 10 Jul 2020 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349316;
        bh=sdiPMkHJAqhWYBmIbDheMBTyfnCQLBUhtI8vWeOPGgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=o43IAQg4U5rFCWjKThhMcCTek+8d/B/1j//jxKn3zKSo41p+FAGJI3cLTsLFIoeNg
         6zp4KyMvgF4tRzzWXIbB4Eb3ixNSOxpOrPNLqAP/3WrBC8J5piUKDiahRMomOwmcOw
         NgaFSSfNsB6n0yR74C6/xjHJ93C2Xi9zKc4vtO+2+fvSn5idgXVEkWsRl/9Hv91Ypi
         +SpdNviX5GxvS1L2FNQeRxfG7uH2GZ2P34ZjBHt1kO56hwjnGMZN7NGXTbeQMECzrd
         4pMnwKrF4KPkPUjXJHkBCLcQtKcaIfCOsD2iurSafnrU/gU2TYD5K3JHnNTPbWaJSJ
         vVNRFT8e1pdaKL/o3gJAxZXOk4iBNZRR2J43xB9ODpzgzFYHbKKLZRvNJ18MhhxkHP
         orCvUdDjtqxKcS9kI+qHyn8qNJpjnGDu5Im19xrmX1OROO7Xr/Glmb5NT9pIWCaKZ0
         vuLB300k1KzPBVMdh+tD8/D7s9UNZ9iXdRWoJIvd8AY+AgGKajQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 28/38] t0410: mark test with SHA1 prerequisite
Date:   Fri, 10 Jul 2020 02:47:18 +0000
Message-Id: <20200710024728.3100527-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test tries to check that we fail if we encounter a repository with
version 0 but an extension.  This is a laudable goal, but the test
cannot work with SHA-256, since SHA-256 repositories always have an
existing extension and are never version 0.  Consequently, even if we
removed the check for format version 0, we'd still fail because it's
completely acceptable to add extensions to a format version 1
repository.

Add a SHA1 prerequisite to this test.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0410-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..cdd4efb57f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+test_expect_success SHA1 'convert shallow clone to partial clone must fail with any extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
