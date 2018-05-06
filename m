Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD780200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEFXS0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751855AbeEFXSY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DEE3860763;
        Sun,  6 May 2018 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648702;
        bh=oKvRwWbk6cfuHa1DVFlRMwRWPMGJ1H/s9CadZ3ULrPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tsHGZhfOQdG0AHRj2aq1Ap2bPeok7uf98M2aFdF4uHj4HHSUVBE1tekn+XNA7NLVP
         mmcOH3v4h0+LwPzTDD/Zo40egsbWhT9qb0pRkUyO/co6FoPJVT1W8qS49zephtn9aS
         zdYhhXipmxfgMetQP+qyBTG9qBAbTwagjVT1ju7g2GNYx77xbsF6zcLl6XcIqHRntj
         k2PGcxH15BltuxTNLKeNFe196odCqtw4v+j3Ec92+c1aDvgxpsiE2A4ME0Uj4REFLa
         aBqq3OvKoMzfZ6CpbpgRlAqYjMjnCQJGQaAxWxkoP7aR2G4Qu+cZWKntO0MsquNMTW
         syZJQU4GhaLXz0XJzJNJxbzOnFTQf55jyDeE7Lm1+v8boS1LKFgikxTd9heogpNMRS
         EoKiCnBXPgPt35ULFYFrNfkt4KbzB8Tef0vHjyf6gfdF7fnqisowklGgOFtWyS4vet
         ag6oLZaUgY0s9xHhKzxbbka58aatEgqi8mMBTYJTrXGLM/Pp1g7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 04/28] t/test-lib: introduce FULL_HEX
Date:   Sun,  6 May 2018 23:17:28 +0000
Message-Id: <20180506231752.975110-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we have a variable, $_x40, which contains a regex that matches
a full 40-character hex constant.  However, with NewHash, we'll have
object IDs that are longer than 40 characters.  In such a case, $_x40
will be a confusing name.  Create a $FULL_HEX variable which will always
reflect a regex matching the appropriate object ID, regardless of the
length of the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 58c2ea52c6..6d09bd99df 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,7 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+FULL_HEX="$_x40"
 ZERO_OID=$_z40
 EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
@@ -196,7 +197,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID FULL_HEX
 
 # Each test should start with something like this, after copyright notices:
 #
