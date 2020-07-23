Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71131C43463
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519A220771
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HRy4LctB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgGWBKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387645AbgGWBK2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C343660CF8
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466596;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=HRy4LctBrOw4NKgu92de6EpUZRPLmeKS/KMQfuSM9XXDQCy/lkpiYsWYPWyHvuVeN
         t8rftwmccMBychBgGUvzb2GijiGuw0mS2q5MW0i+9hre0ep3cRuOz46s79UD0x4AWV
         vCxFvd/ci/4cT/iz4AMfY/W+Ovlr3XZa1fd7tmIOd+ILTR6LAQCXuKcOTFBdE+vu5R
         3dXcOmSU6pEsqkZdDohF9n0aCaIkAEWRGU77fZxDld2TozLjNJbrVCEJ7kclFqdl24
         WRkWBKIAgIXaIIr+hsqC44CM+px8N7efSoiOY6MivLb/uZRecK2ljz6z9yxb7A3h6R
         8LYMcKqbQbrF3WZVhWs8pJg4BJOYfjxru15S2SnYqKrziBc1O3XC7U3FhfAflRWnqb
         dLFZjVLDWJjlaZp2YfT7HDm3QTH2Zi5+q6PqvM5dSqXz9bXppAS4aEC5hTGG1Pm12r
         uWuD9XueG8GyDDfGZ1k0OPVULvmoywSVrShCrbkkr67RrvvJMP9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 15/39] t7405: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:19 +0000
Message-Id: <20200723010943.2329634-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID instead of hard-coding a fixed size all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7405-submodule-merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index aa33978ed2..6a1e5f8232 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -195,7 +195,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
@@ -214,7 +214,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
