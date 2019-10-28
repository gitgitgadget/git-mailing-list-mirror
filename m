Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1ABC1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfJ1A71 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728939AbfJ1A70 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BDD1961C70;
        Mon, 28 Oct 2019 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224365;
        bh=HEAARVq6WzbSWTtAFWhDdK2BPOqm0jEDt49JPJTdq10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mrMVqT6nUiXfIAiV392UewVyOFwXADCUtH2/y1TFRD4Nz0Rjelqzp5hq6fwSHgxpx
         XuBx+ZmliNYh56OIYW+HR2ZRhwdL5/KPZp2RP0EehCtqQKeGW/wKy+O6iwJFTZePKY
         uNvKzXIa1lkmfUJoXT/bZhMGKxmkUBjDum194+Z0zYKvmjPD9BMhvzNJ1yo9uUULuU
         cj6DMlOr1yzIJTeuXVyavxHiGIDr11Air1cxiEmJ4yE/JkkoBYWKYE93MUSKK40Hse
         QpKJE/HaQP/jacc34KKSyGp24BEGmc3ndFMEPwBKMnEbC99wYa0gG0OCccHw3ltNOE
         +pi5a+N9od0nveMmUIxrBxRV/zcg8cqKNVCv3zo4QsUkur7JGRmBeAEa9Kd/f6zqNa
         7puJ3XJ8p2bytoYTZth+Q0i7PpyVJkKldx31uTlmwUHhFxi5k2SGrWnK6hbh2bOl+3
         VAPWgU0Tc2pXp7m3CKUDeKlLZPQ8m7rBFw/WL5gG+GSeZZjAi/Q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 04/15] t1305: avoid comparing extensions
Date:   Mon, 28 Oct 2019 00:58:56 +0000
Message-Id: <20191028005907.24985-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A repository using a hash other than SHA-1 will need to have an
extension in the config file.  Ignore any extensions when comparing
config files, since they don't usefully contribute to the goal of the
test.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1305-config-include.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index d20b4d150d..f1e1b289f9 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -63,7 +63,7 @@ test_expect_success 'listing includes option and expansion' '
 	test.one=1
 	EOF
 	git config --list >actual.full &&
-	grep -v ^core actual.full >actual &&
+	grep -v -e ^core -e ^extensions actual.full >actual &&
 	test_cmp expect actual
 '
 
