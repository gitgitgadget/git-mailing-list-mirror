Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1E6200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeEFXTT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41246 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752067AbeEFXTF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:19:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C7CC60769;
        Sun,  6 May 2018 23:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648744;
        bh=f9cgKsL1ppHL+qsQs11bBofkP+FHBqNqDL3FAj1rZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MMGlC4jNO5v70uMM8TcQhPbU7y1buacmhtjVicMppOsJ/IiB2Vzip2OTM6TICDQyf
         m/GtQjlv1/XlGhUK8siL9r4ZZ179MAcwUKXOPsrIXOSmDSWRGMvXeK4hvmUoGv+eim
         /AQpzgKyXHiDHIVCxkGZk5EVCUUCKEyb2jwHZeeY+I+zMHlFSOlAjNfR8weMXgqJ0I
         ElBv3C52h8ZrreK3Y7qHlSD2eIBAHgiN/8RL0FS7zz4wE5RScOP4p3xeKFAW+ZfUZN
         NUJHrIwHOOmUAd+/zk2BIy1MTf986fwI2blLOuGmbLTe3C7VaiE2UZeSTIi4Dhlumk
         myEHuOrRa7GqHgK2tI3yWJKv3wUGE3sA6NgeRO7AWrk1vdZEPSE01II5aXxACDZznx
         3pwynhXEbXO+/c+jjCTxUcZ/XnxegNce+cWpPYLx84iByREIdxBT4Bvs0sqklrvBvj
         mx2LXOp6vHpLaVZXRpJzwBmE8oKJuBiWGc/ZzErRAkcswsu7yWP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 27/28] t4208: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:51 +0000
Message-Id: <20180506231752.975110-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4208-log-magic-pathspec.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index a1705f70cf..62f335b2d9 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -45,8 +45,9 @@ test_expect_success 'git log -- :' '
 '
 
 test_expect_success 'git log HEAD -- :/' '
+	initial=$(git rev-parse --short HEAD^) &&
 	cat >expected <<-EOF &&
-	24b24cf initial
+	$initial initial
 	EOF
 	(cd sub && git log --oneline HEAD -- :/ >../actual) &&
 	test_cmp expected actual
