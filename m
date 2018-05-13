Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A68A1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeEMCZz (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751890AbeEMCZx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC31660748;
        Sun, 13 May 2018 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178352;
        bh=jwCbX6p4Anm0nvAMx6ZYoOjow7PN1S/o1Ep0P88PSWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=przZj1SogUMg+trVKZSI4OEF7Hcb4UGtyLoRG8+m+17u1At7pgfRzdzz7YQq8RPwi
         LmjSl8Y5ZH8E6MWmJ8EBvrvyaO3KHpBw7wGjIZbaHnC/CSXINfui+h65FKwSjhluKj
         HBzRvhCSQ4d7evIEmlWh45h0MnZAHqUnBGu9dQRUpAUNK2ad8dHoEIS+jSFig2e4NU
         emTKrgKkJbvnM7NH3KSc6bMx8v8BX8pqjoovvoqPYyTq6Uaq1TFI5Vxbbs02n6a4/v
         r+mZD2M+osZ6TAtNmwdn6k2Fc9OKS/qUTGUYmCJkjHB4h+lMqNUfftt35qE57RYL5U
         X+OYj19vbshXHFNbVM3QB3eXUG7tChBCiLqIn1I6eWmTO6SSqRknlix2rjj+Z4t93y
         OZNbrmPJoSvYbEihB1vSUsI6AoCK8FlodNusIVNWb0lH5BiqinMmEi/CMTilYVxrGB
         En10ShTRj1lZ7+MXOtWUqf2RS3zIZByt0AGxqpLU0K+hpdUvXTL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 21/28] t4029: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:31 +0000
Message-Id: <20180513022438.60003-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4029-diff-trailing-space.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index f4e18cb8d3..eaa56521e8 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -6,7 +6,7 @@ test_description='diff honors config option, diff.suppressBlankEmpty'
 
 . ./test-lib.sh
 
-cat <<\EOF > exp ||
+cat <<\EOF >expected ||
 diff --git a/f b/f
 index 5f6a263..8cb8bae 100644
 --- a/f
@@ -20,9 +20,12 @@ exit 1
 
 test_expect_success "$test_description" '
 	printf "\nx\n" > f &&
+	before=$(git rev-parse --short $(git hash-object f)) &&
 	git add f &&
 	git commit -q -m. f &&
 	printf "\ny\n" > f &&
+	after=$(git rev-parse --short $(git hash-object f)) &&
+	sed -e "s/^index .*/index $before..$after 100644/" expected >exp &&
 	git config --bool diff.suppressBlankEmpty true &&
 	git diff f > actual &&
 	test_cmp exp actual &&
