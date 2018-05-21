Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21F31F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEUCDc (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752711AbeEUCDW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:03:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F15D060747;
        Mon, 21 May 2018 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868201;
        bh=Nz6IbdxERGl3lIklFZYepT609HYw3CuZ4hjLkeLRsyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m8njNST435ciH5MSlGuJCPdipOHopydQFTLQ9NoXZlHrKFcTCVhxRunjtnuPS8KMj
         gEk38JSnQFqmJpsbOpvmDg9sIZlREDkg3DgqT2c+H/Ddx3j/1b4r6xjoGr8IQh+yBn
         Bk+q/aHxYjhNX7Y/O2X0vvKUSfuCyLYaWp29NKKehNqMoWqBxDQaZGjCqy0uslV3JR
         LvuNMz0ZM8OkhvFzXemWMROOd7g+BOIQ0c/O0/iaBXF8UWa0bijU1wwPKiVghen20Y
         ZI7bWQdFWKAWv3wnDZuvDLCtzX6JsQafjMWBgclvfBrOew+PyF8KVb31bDiruiOq5F
         n9oXWwSX3cscUabjvXEz0Zql+Xhz0WfCquSxeT/DuDtr/7lBoW8bWruIHpe/GPdLsH
         szX5yhzfE+hwCG7cBvI0IOyIeTrZ7ZMeG+eh/DFWaNr525xMcQCj89clbMrHG3jQrQ
         5XYt25f6U7+BK9mSwZTmHDDlko1svBIvoOzS9WReNsIQ32XZd2e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 28/28] t5300: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:47 +0000
Message-Id: <20180521020147.648496-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
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
