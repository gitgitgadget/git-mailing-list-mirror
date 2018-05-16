Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D82F1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeEPB7M (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47574 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752610AbeEPB7I (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B026460443;
        Wed, 16 May 2018 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435947;
        bh=Nz6IbdxERGl3lIklFZYepT609HYw3CuZ4hjLkeLRsyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=n/j8ptnlNP2qBt5oORrnSatEQO3juxPTJ8bka1auIG3KvLNZ6v+9wURaiHsW0i1EK
         zAEqtMOtLRpNm+/1I9kwZxGpMs3H+M6HQpqV1F1hCfg//alvKKkpShLeabMnSXRqzv
         qYc8LS9PqOCeqBgZQGjcYa+VzFXo2Xi3aVxoJs+jBJP8Yp5B1oT9GKoUOnexugpM0o
         IuJtac6beMm+Xdtc4Us47YeFOzg89zbn/pO7ilpqVArh6dZ7NNNlSifR52jhJK8LIm
         DfhzqdyHVHImaI/aNLdxLjv9zOfCmi8Y3c0RFbGYsZN71OpgC3RYv1s3fIXhdhlQmt
         8U31Bz/3aTEE3QlzjarZBAtZYQz6Jk5o8i30QwLsVoq9gwMVfbpDOpxLAG7ryc/MVZ
         sSkqC9dOjtQgWuespdcbhdaEPYtjoThRAsa8j/OHtYX5GXblCuHjbxiFouXRV3l6bt
         6lLBWcdgahmBLYKCGlT1cOQ8GEBq2TPRcTlYVaAyQBOQMUMhjeo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 28/28] t5300: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:30 +0000
Message-Id: <20180516015630.661349-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5300-pack-object.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 65ff60f2ee..9e66637a19 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -466,9 +466,11 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 
 test_expect_success \
     'fake a SHA1 hash collision' \
-    'test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
-     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
-		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
+    'long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
+     long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
+     test -f	.git/objects/$long_b &&
+     cp -f	.git/objects/$long_a \
+		.git/objects/$long_b'
 
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
