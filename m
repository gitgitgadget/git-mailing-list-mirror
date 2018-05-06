Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AD6200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeEFXTG (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41196 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752015AbeEFXSz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 971EE60444;
        Sun,  6 May 2018 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648733;
        bh=jwCbX6p4Anm0nvAMx6ZYoOjow7PN1S/o1Ep0P88PSWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FVj8ZU3uGfDi8YTfsR5hGW7Phdr/9Vz7y7CXCsWld8rzKEEQHvsG+5u1Wk2ZYBUju
         9mj9OjNQoTtmNFh8uwjaHRZNoyBr7rG0Z6kFrEc8bWemoixmGTbYrD4Q8rDLRSBmLo
         xW+buIlkLKmswDNfhqvCpag0g98hwMzMTDxxhew75idrSV1ZaTcc8MZkVv5Vyr1/TP
         rJghl1FzMu5jT0qcWJOUNageXfN4vadDjgOUk8UDmXXMvS+x0bDH3WWdUOpg07AGao
         wgjBpSpwFxPsWBoCsWfoCEaVKf3o6JbeMLYOFENMeukvo+yE4ovsqAIPYzoOZPzd03
         tkCsdwaYPJWbmnLMCrVeVZLpUH6OHx1S4eQgiQwsaRmsg/tm7q2CXnydQZGKjeOn20
         tF7lfwDxMLOUHVppJ1tzpmsa2nIICvUGqblPdUuCKGwazcVH2lUYn0BgjDUGsnhrzb
         znmllp+sQTNda0CEYH1cfAbffVwUdTLBJodvBfoum9fwiTBT498
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 21/28] t4029: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:45 +0000
Message-Id: <20180506231752.975110-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
