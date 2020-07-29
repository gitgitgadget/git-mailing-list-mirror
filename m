Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FABC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E402067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B7XyoX5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgG2XP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgG2XPT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85E5960CF6;
        Wed, 29 Jul 2020 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064488;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B7XyoX5TdyvcjgU8yjYtQqRpGbSGNRxwGxWlE2y7QtTS9Sf0AXZYqcyi3yygfYNBj
         dELF/gT1BDSVg2mHWLFm+c7XodWj6/0/WdHLAvYqBlLfl9f6kVBKRgxC8bxVITv2Nj
         b0VnsZYoKZTue/V236bAl88aEZ165LDrZe4rtorzi4fZpvliFrJq8tCWDGAQyM0/2R
         MK9nAMhMX/3TjIxeZzMRCNbs2pqWQc9aWm3dHQJ9crzmoV7I8NlbJ/3magysJeqwyD
         n+WzuvYRda8o9WMd1nP0BU7/W6AYXpnzVrZvttzzWr1bOcZQXfMzyDp9ai79doXubU
         qGQebxVtsoUKXuDSosYKEZNQge8pMoraoKbG1D1312t3AHKBhLJY0uVAxyqsnm01Tr
         wAtM4R9MVkaTtMnsK1BiFTcEnqLNU8DZ7XIkBHlI0Qss5ycJZWX5NVTxwxVO3GL4kD
         uY2ASmBEPrfNk28CyPaELH2mWRHI8/ZpecZSROugFG2La74GfoO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 06/39] t6101: make hash size independent
Date:   Wed, 29 Jul 2020 23:13:55 +0000
Message-Id: <20200729231428.3658647-7-sandals@crustytoothpaste.net>
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

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6101-rev-parse-parents.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7683e4a114..7531262a5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+	git rev-parse start | grep "^$OID_REGEX$"
 '
 
 test_expect_success 'start^0' '
