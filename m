Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9931F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeEUCDa (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51122 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752718AbeEUCDV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:03:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 609C46074A;
        Mon, 21 May 2018 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868200;
        bh=f9cgKsL1ppHL+qsQs11bBofkP+FHBqNqDL3FAj1rZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gfa7Z2XvB2TR+hqaddnYcNr+QJUCa+wPIPGVWOKW08YKak6O65yeKbjCnOLuTUHiB
         r0kRYsHGRmKDs/0cru+ZUeLSnnshcO7lX3KkWEnJa9k00fhVF0vi0zw7STWKBtQsDg
         2nzduRkUx2DeV2cy9ltPc8tAL1zh7lhsZIp+JbJQ54O36pw/NZJxKuUUOnfCLmKe3Q
         mpZHGWd6OC6dBuOaCHjdxEDX1OOKnod/LNxLn8reBO2xQBhxI0MfqIm2hS8lTLsSht
         qKjY++vDIMWr2+3VMg28VBc099uOEQBI7VIv2pkUUXSEjUGgarspWYo9RgaJ+PuHl0
         UGI3YuEjnbnYFNmU3A4tvLNOddJLj9Yz9ImBKVzbL7iXrX/klHUU9ZVCJ2qLYfxsWk
         szmPvfvjuttui4Oc+xo3w3AKqhQjAvDXYjAOXosOSKNuTyQ558126rEU20LXrk5U26
         94PdtVIe1f5KHJPoh/7L1z+NTn86emEyefJXcSFezFq7TWNmpTt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 27/28] t4208: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:46 +0000
Message-Id: <20180521020147.648496-28-sandals@crustytoothpaste.net>
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
