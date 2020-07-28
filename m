Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D91C433EB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F0920829
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xcZ5wfDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgG1XfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730134AbgG1XfC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB2BA6101A;
        Tue, 28 Jul 2020 23:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979301;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xcZ5wfDfXyzTNm+I6Mw+xzV7qKMP+oRKv1R1uqPCOnry/ka7NjWFfxVSha7zdJk6G
         xIF+/y3oOduvyOhZ8r3h6dMkZj75OFHGB8JOXKst1f3zvkCs+FNaa/dfj4En906lg4
         KOclf3dyf6xtztwJqRnPsFE3bEXnyXp+TFhYKdN0w2vS5w6cBIEiBFAukGHyiLEGyy
         eTu+JlyeiFNpeCerjemYUxfVgV0ikhuJPuKHnAQC4HE+8vnGcN7JuJUgZQfIergC+E
         bcmWEoEF760ld+v6g6z3Rmt43pb42fCyRPfZMsq76xZr2fpHKLtJbPhn6XvBqt5hVF
         5yOT9BAcftlYgxsgi0WCN6+EubjSnopJlEIgNhSy38Kj7ecoTVuYabQT0O1T13gg3s
         6MXlVqLnewsVSbwe2cr2hzWRyrrQY2S30rsJQuHz29nn5iN+8A+3BS6wJAPsA8J/6b
         d/Hm6lFv6DX5LnnliaC/w3EsL1OEGaBauVtFUVxWGVl5KVVMlZM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 15/39] t7405: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:22 +0000
Message-Id: <20200728233446.3066485-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
