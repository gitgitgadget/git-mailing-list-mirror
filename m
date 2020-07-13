Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E071C43464
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD80206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xxmauhdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGMCuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40832 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728773AbgGMCuI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B145360A72;
        Mon, 13 Jul 2020 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608577;
        bh=sdiPMkHJAqhWYBmIbDheMBTyfnCQLBUhtI8vWeOPGgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XxmauhdqeaWjlqdQ+5AdztfqYfhs4h7Si/jovD1d7IjAUx+gOJZiZ8HjHcDujxJwd
         1BMbxk2uUq97E0tyPw1gIJsPxZ72gLpxcCUXLhq/yVK2+jGA7sNT+H/yw2qZGcxZXr
         p61ZKhpmGvho2ESs2A0Xy2XCDHb0d35TJyAN0zNFKUlmJ+qtOIAjHZfwUUL1nTt9xW
         8ifSmFb2MfrI0TVR5N/ny5noW//1pXe5xt+r5r+KwqXwHL8tDYYB4OTLLWAotyDf3f
         YjqqvnS7HA6cWKw7bHTm8yV//n38T4Ca58gPUeYFxXJFC3C65VRSLhqLYDmU32q5wv
         YbUIkhzy6EPTIoGj9XlTfX+YUnahPJvjjBqx/rGXK1gNcD6CH8YF5Uf39Y/Vvr37J7
         BpN4YevUMcq/CGkIG5ld+05B166XpJ07H75atfFt5Dnow60TwPILxiVS7bPvXdmAkN
         n8vhFjOs6Yffpy4K3ML5qLPIrUrk83xMSMgGg0F0umiEnsQKkHE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 28/39] t0410: mark test with SHA1 prerequisite
Date:   Mon, 13 Jul 2020 02:48:58 +0000
Message-Id: <20200713024909.3714837-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
