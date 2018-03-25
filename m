Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C077D1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCYTVR (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42492 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeCYTVO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06EF260988;
        Sun, 25 Mar 2018 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005673;
        bh=uhTPkzBZHHy5tHt/9Zi3sZ2QkW5NyyTnuvHBCb4vJx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XqrQ4gwSMm2HHe+24BBTztA7eLaC90bxhM1KN5HGmvCp969ZumS5no1m4aAcfyDGT
         PTWvp7/G6REdl8TibZJ9zcj/WTuLdEIgBefxBmvRC1VITidckSUtQJ6geW/SXB4zuB
         2Ae03BgPNlxGilJP8lH4BStvAwN3TEOlHz1tsYvwgcjcBUMUh2Ngtre1aTkIiw2Kko
         BZ4VHicf7tdk/7ZEZgU6Ps153NyDwmjJ46qrZmWA+gy1BsOn0CbIHD3iRvx2yo9oLF
         oYPBUwZSUob2h5nBvJ9rBsutnjojEhGMdzvFnobuA/eYlI7R9Ugu38h/87SEQQSgdC
         WILX5x9yfsgr/WN545NbQbJ5BAfVXUohgb+sCWEoPm/Qm7n8x/nJdcnQfVUtUVKV/I
         6v4sP/2JtKun9SMo7+MD4y/u1obUz3YkZq1YhH3p9FrLzmFrmhvR4vdmiyAVLl3/Bh
         3sfrUb/rgIYFe5bzefr+2/qaUGXtqnXxswBOq7T5spUKgL68D2g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 03/10] t1300: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:48 +0000
Message-Id: <20180325192055.841459-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses the computed blob value instead of
hard-coding a hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1300-repo-config.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fde..dc7e6c2e77 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1587,10 +1587,10 @@ test_expect_success '--show-origin stdin with file include' '
 '
 
 test_expect_success !MINGW '--show-origin blob' '
-	cat >expect <<-\EOF &&
-		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
-	EOF
 	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	cat >expect <<-EOF &&
+		blob:$blob	user.custom=true
+	EOF
 	git config --blob=$blob --show-origin --list >output &&
 	test_cmp expect output
 '
