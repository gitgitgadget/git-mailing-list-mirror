Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76011C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjASXAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjASW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:30 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789F4F378
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:49:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E2D0AB44;
        Thu, 19 Jan 2023 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1674167948;
        bh=oct2DIGdGL7GKpUTl7mGrsbxX2GArwqamgQPYsbizr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUYgP/489QBE2xmcnl2Aj2j7yOlQ1m2NFvTrrCYyEL4JKPmgzAX6x7WjnGjE0qxTk
         +RJnR+/gwv7uZNhItBT3blmzrcI2HSW4TGEsVEFK04zjG1pQBiV5OIkiQMVA0Al/Pc
         vyaPc44YmSKm4KfGaC974fLwqvwSp4exfrmJDd1w=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     git@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t4014: Add test checking cover-letter To header
Date:   Thu, 19 Jan 2023 14:38:54 -0800
Message-Id: <20230119223858.29262-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119223858.29262-1-zev@bewilderbeest.net>
References: <20230119223858.29262-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I at first inadvertently broke this in the process of adding
--{to,cc}-cmd support to format-patch and didn't immediately notice
because there wasn't a test for it, so let's add one now.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 t/t4014-format-patch.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 012f155e10ae..ba5fd0efe2ae 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2368,4 +2368,11 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cover-letter gets To: header' '
+	rm -fr patches &&
+	git config --unset-all format.to &&
+	git format-patch -o patches --cover-letter --to "R E Cipient <rcipient@example.com>" main..side >list &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" patches/0000-cover-letter.patch
+'
+
 test_done
-- 
2.39.1.236.ga8a28b9eace8

