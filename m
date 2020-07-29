Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A2C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A077B2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KjjzlrXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgG2XPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgG2XPY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9B23261011;
        Wed, 29 Jul 2020 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064492;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KjjzlrXhx5z+LGKzzqMl8IpL1706HOlq4D0E8eidD0u1YDVVMhEAJl9ZqZJawAakQ
         J8SasczzeGhpmAxmZjS974dF6e1jaee5MzQbx5xmKRWND8Qm9nDhEk+HapmNdj6r5F
         JsvqoWGTI/d2FJ7trmI11Ju/mZmPLL8099Adbyr4lY1DTNCW6QIWdGkpYCCJdKhG+3
         dIgD1vLWX0pN+cUuOsu9nNJ5p53l+NTKNnCbjg5BiKvZcK6ALCctasYCtE8Nuop5B/
         9mQOxRCZxVXAZ+3QQYej3xg0O9tbhj0cruD+KLypUZf9PKTDvqJjzj4/jx89NURiih
         Wk89ZWl6n6DRVJhRVdfQR6gJuL5cgwlvv93IR08z/D1TgQyWnSxDHMKbf9U+DuhBRk
         Bt1vAbtz49DIC7wW0lm9h8yxabweymhs/cj+KTIVy02kFphqC7A5DxZ7LvhzsNKFAF
         kA6Ja004mcnFfo4RbrUnlZY6eO7X67DF9KpSLjA//30gH3UPqVf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 15/39] t7405: make hash size independent
Date:   Wed, 29 Jul 2020 23:14:04 +0000
Message-Id: <20200729231428.3658647-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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
