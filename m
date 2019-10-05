Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCABC1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfJEVMT (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfJEVMS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 68F5161C64;
        Sat,  5 Oct 2019 21:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309937;
        bh=HEAARVq6WzbSWTtAFWhDdK2BPOqm0jEDt49JPJTdq10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FWkqupTVwW63Xr+/rhe8MnajsknLdBmidyZoYlWDClgBnYx/m+3XX2Rudwwr08OzH
         BQFXEgETwY0LS0OSHIb//yFci0YMjlQjuuS0yFKpAZ1ztjmoEbvlB/KOEITKfQMB0M
         fpFzUn1HweCib2Bci6G0jBoOjqme5nfCtRVViGwvHUoBLZiDslmTwK3MxZDdRiUUJd
         fj/rV6gYSsq4ZpmIVnB2RlXMKtccTo1w5IK9s+jhXDf2fXAvYdycbiU2Cy6bZZJFFS
         VgY1XtKh0/P5kQNp9fXHcJd//2xr2fQOvlcfHj9RJMqcOPEUKXzhdeGksyvx++8mOW
         ANmp1oPCq64AnFSK5ejJ6Ztb4xcO0z4uNbaV5KeILgRanXfvj3sNAd82yCkwdjukhw
         o8rj/uLJbO4K0MupuKcwAMbI15GomLOFqwFuxSrKeR4pgF0sCKJ7n1qGf1MPy3jdDY
         iar2Ry6kY++xR143a59+MGdSC1V3Y7A8EoMqTGFGBu5G/qXTm/9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 04/15] t1305: avoid comparing extensions
Date:   Sat,  5 Oct 2019 21:11:58 +0000
Message-Id: <20191005211209.18237-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
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
 
