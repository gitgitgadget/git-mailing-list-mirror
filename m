Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07CC1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfFIWo0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730001AbfFIWoY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EC1D361B43;
        Sun,  9 Jun 2019 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120263;
        bh=xjTSe1NU0gagAs6yAUNobAN1oT6R968FF3aG7B68HmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rP7VK7z7aFK1R0ar+vWk9hGIYSCwLBe5i3j5WTKQs9hDqlgrejCuJUP714bZNLrPH
         p1RjogTEjddYYPLemfGRaza6tAZsfLOnIOnQtHNibjW0TGWV7ht7uvZUbE3cj0elvX
         gRO6SedZooOjrAxmdhtMLJDH9nFK6k/xn94Oe2VumzRmwjvDrK+9YNzfqqs3KC8+8s
         rrvkMB/TjBR5E2Mz1ttm3JnluSxGp/K/Uj6o4VvjZY4n+r6GW96NzShNu7hI4JmzTv
         oVpEJrGg4NkdHV+CCONkd+jk9/wVZKhG86vune+XmweyUGIUIHS9isREII8DIkTPlT
         23RWWiDE561fa2rNaieKHV2xvvVarvGyNRrYPgn9lTVdDI5AYIjmCLgCR2SGUAFYvY
         Ni0fENzhB0obtSNA50nW6QDU4TLvoR8f5BfynetAKrG8hanKPRW3Ilcwrr4LOK1UB7
         R2LYZxmNqgfbyf1MPNhQj16mPtMlF7T4NepU9Ga8t7cjXh5sqX5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/10] t2203: avoid hard-coded object ID values
Date:   Sun,  9 Jun 2019 22:44:00 +0000
Message-Id: <20190609224400.41557-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2
In-Reply-To: <20190609224400.41557-1-sandals@crustytoothpaste.net>
References: <20190609224400.41557-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with multiple hash algorithms, compute
the object ID used in this test instead of hard-coding it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2203-add-intent.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 68e54d5c44..5bbe8dcce4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -247,12 +247,14 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
 	echo new >new-ita &&
+	oid=$(git hash-object new-ita) &&
+	oid=$(git rev-parse --short $oid) &&
 	git add -N new-ita &&
 	git diff HEAD >actual &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	diff --git a/new-ita b/new-ita
 	new file mode 100644
-	index 0000000..3e75765
+	index 0000000..$oid
 	--- /dev/null
 	+++ b/new-ita
 	@@ -0,0 +1 @@
