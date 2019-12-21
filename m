Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B6C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4648206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UMzecauM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfLUTuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41966 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfLUTuI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CECA7607F4;
        Sat, 21 Dec 2019 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957808;
        bh=1tUluqLtKGGOWKuZstGGIANvQnV5D3OR32/G3kdCD+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UMzecauM6M9XK59s/lxSBKjHuGIpbXadY7oef44iv2Omo4byB99YlYPhh8SQSn1aU
         9ptdpcg5bwTQVRPlJGGF8YEHKuYoLy57g5SoSo5ZGlC27VmAwbcT4NHlGWjc0Jqyez
         1YziabXvEA9AQTgJHTnpU0nZOTeF79HjIDrEEchAep4E0bPgkOuOxEgfGgZSxAVBTX
         fWvKPmtfuIjXMCxjtNUCk+pqRdRXFJLd/FExWfeFaAZFG9/p8GwEGIIp8zr5OUpEjD
         KgQaaUPBr14prPtaaQnvP8wOPFfTrvWmd9FNnjdFLau6GsTcqX3tvJuxWyoB633CVD
         TrwumLkc1JRJlTb2Nx262Pm/MKEgH1A+kp5nrc/YR3PG7/7lPJyVtLKzp4V/cZVwev
         9ittBsJVvNFJRuk+WsBhcAswOmcu9NtlSGiCsh2DmasYWooHLQwng1w6uH5w8iU2gk
         OxcNuEf7HHAbA5s+T4Z2Thdc+nd0a3ZMr+Iecvo7tEP2j3rmSqy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/20] t4204: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:22 +0000
Message-Id: <20191221194936.1346664-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4204-patch-id.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 0288c17ec6..8ff8bd84c7 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -25,7 +25,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'patch-id output is well-formed' '
 	git log -p -1 | git patch-id >output &&
-	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
+	grep "^$OID_REGEX $(git rev-parse HEAD)$" output
 '
 
 #calculate patch id. Make sure output is not empty.
