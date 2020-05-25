Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488DDC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D5D20776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PZdJ2E1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbgEYUAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390422AbgEYT7z (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:55 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC41B60D0B;
        Mon, 25 May 2020 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436793;
        bh=MMfJEd2BJ7WjAZeGiNm4voySOTAFCGpDlJvsq+dHUZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PZdJ2E1y28B+F9+GmIN3BCwy4uNl9OJLV6AIAp7FiQi3EOHNWvXesHNerAKj3jzcG
         zrd+9XfHUrxPUlh++IiU6HGtp4GxQ/KyYfQkppS2ZPZdUMhXBOkuZl/F3hJSC8v0MQ
         hW62QD2dC/3TD83Q2LsXsTcEFfOwGPWc+MM8+FSL6ch87Gq53bpnM9R8hPmyuc1iGQ
         7U70tpE/VsY+rgF67esA0PL+MnpIQhPr0hRBqqFlSWwutQwob2pf04ghWpRRwO3bKY
         0XCnaJOSDv7OKsB5rSZRhdfc4w1g0nZxsDAhBccfEbFPa1n/EJaeB7pHW2iH0J02Oy
         9cEDCd0a03eJZysKE8+T2z5bWx14kPoG5aSvMFlaZEmQbnaFWS/oPeG5MKlX8jr2Y3
         nnfeI1lWIGUUgvOpY77FCmLUSCx1I9UdLBM3Qj+GioeCv1UowaS6C+KmVGEnMKsUmB
         LssU4fT/MV7xrZV+heZ46AsGxB8XThQ+55T1dq+EE91qqm3MF/X
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 23/44] t3200: mark assertion with SHA1 prerequisite
Date:   Mon, 25 May 2020 19:59:09 +0000
Message-Id: <20200525195930.309665-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the test assertions in this test checks that git branch -m works
even without a .git/config file.  However, if the repository requires
configuration extensions, such as because it uses a non-SHA-1 algorithm,
this assertion will fail.  Mark the assertion as requiring SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..2a3fedc6b0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -402,7 +402,7 @@ EOF
 
 mv .git/config .git/config-saved
 
-test_expect_success 'git branch -m q q2 without config should succeed' '
+test_expect_success SHA1 'git branch -m q q2 without config should succeed' '
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
