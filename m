Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82FD1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCYTV2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42516 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751997AbeCYTVU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2ED9A6099F;
        Sun, 25 Mar 2018 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005679;
        bh=4ov0nyi9kSVO01D3B5SAantgYp3rwtYCPu7q2ekx2LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yn/NAOHK+rE4e3Sv432XT5nhAhKHoAn/i6RN0ZsHZmgCsJVBs4nNc+Cd1bRCWHFXo
         L2nPqPDNzbHleuRFSQ7v3xtpUgrcRgnWGJ/n86N17bzeCEEmV8aPEAYQ1/FWmEsfch
         j/NRcN6toyjsOQmSkN6H73prhBTWve7xnwGyPPMGbiSRTOFfe7FfegXKoXAvdalNp2
         vNWZgGU6FWI6KppH9xdn3L+DhwYaCxm3XaCddSqRMGFDNiZ3BOwRKfRta/9oFd5jtS
         AzcBnKjXnnsK6de8QWTpHj8CiUgtVbT1QbvydaxXtSJF4Z43Smg5SVfBvnMf7+WTnm
         Mf7LxckDsQFetVeh1EQcjf17WmgvRBkdV1Faukj0qCPWD6+Zyvj5sGfvB2UDclSznU
         cxIRGZdVbi1+oJdpdXo48T76MQ9C8NNcos/Uhv3Jor4DsJp7d9/UkRM1pMnt3FH6Rj
         z9IobWMTvFE3P/2j7B36BJFOPK1bGeihrwH4ByV9S10Ij2XsXFF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 06/10] t1507: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:51 +0000
Message-Id: <20180325192055.841459-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses a variable consisting of the current
HEAD instead of a hard-coded hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1507-rev-parse-upstream.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 2ce68cc277..93c77eac45 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -209,8 +209,9 @@ test_expect_success '@{u} works when tracking a local branch' '
 	test refs/heads/master = "$(full_name @{u})"
 '
 
+commit=$(git rev-parse HEAD)
 cat >expect <<EOF
-commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
+commit $commit
 Reflog: master@{0} (C O Mitter <committer@example.com>)
 Reflog message: branch: Created from HEAD
 Author: A U Thor <author@example.com>
@@ -224,7 +225,7 @@ test_expect_success 'log -g other@{u}' '
 '
 
 cat >expect <<EOF
-commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
+commit $commit
 Reflog: master@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
 Reflog message: branch: Created from HEAD
 Author: A U Thor <author@example.com>
