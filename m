Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F8C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51C206B6
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LRg4OD8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBNXIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:08:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32954 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbgBNXII (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 18:08:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5843A6079A;
        Fri, 14 Feb 2020 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581721687;
        bh=FJMhbi/7Ytm9Y9jhwNLSykkMKem6TRJ0bzYScke0fM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LRg4OD8yP8Jl59eIjNu8CFHfFlA1hLVMEL9jnx8qHuOqukoz7zURAUmiy6egNok9W
         ATPXBQybFJhe0zbQ70w1pRAF4nnV1R+RfKdw7K5xLQWMklXKz/+b1oEgeStHelZsvX
         94j/A40mzjlwOajHF+94H87EOA5jateGmf+lhN58BlYWkITJCeEuB8WUpFxgQjzCPo
         QD+JMEsmvDbipcD3OTMsJnVHoRhGyXDWnwpQ0ayRVV411gJNyL90gN//qmyqP+m9Vg
         5NKcV9KUzQJcpzUMq+XB6fkSooj10gyLlMGq95kqq+cG37JKkFb+EVaPZa05Gzqe7V
         OBb843ke2jJWzIHzq5LZ7epuHj8/hAqw5Gyr/m2X8GeKifZu/Hb6RH24OtnJWa+JMV
         amjH9szr1DeEuWNdE4JEIwhQ1OGY5mhS1xypiFuKNkjfc/9TTyEsCymaQYU0J34bPI
         RpGxCmQZ2S5xtRWixWqXK1rvogLoZWSPZa4S8n0dsfUAxJxwRpl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t1300: add test for urlmatch with multiple wildcards
Date:   Fri, 14 Feb 2020 22:59:28 +0000
Message-Id: <20200214225929.541306-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0
In-Reply-To: <20200214225929.541306-1-sandals@crustytoothpaste.net>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

Our urlmatch code handles multiple wildcards, but we don't currently
have a test that checks this code path. Add a test that we handle this
case correctly to avoid any regressions.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t1300-config.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 983a0a1583..8b0cac80a3 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1408,6 +1408,8 @@ test_expect_success 'urlmatch favors more specific URLs' '
 		cookieFile = /tmp/wildcard.txt
 	[http "https://*.example.com/wildcardwithsubdomain"]
 		cookieFile = /tmp/wildcardwithsubdomain.txt
+	[http "https://*.example.*"]
+		cookieFile = /tmp/multiwildcard.txt
 	[http "https://trailing.example.com"]
 		cookieFile = /tmp/trailing.txt
 	[http "https://user@*.example.com/"]
@@ -1454,6 +1456,10 @@ test_expect_success 'urlmatch favors more specific URLs' '
 
 	echo http.cookiefile /tmp/sub.txt >expect &&
 	git config --get-urlmatch HTTP https://user@sub.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/multiwildcard.txt >expect &&
+	git config --get-urlmatch HTTP https://wildcard.example.org >actual &&
 	test_cmp expect actual
 '
 
