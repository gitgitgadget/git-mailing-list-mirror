Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDCA1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeEMCZc (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45256 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752001AbeEMCZ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1175760744;
        Sun, 13 May 2018 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178328;
        bh=XEKVT3yPmx3r4ENn87G2DLpPzpqiCkYlXAwj93wMTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HuH99jK9lyR3O8UIa1doGwdBuhSe+m30Gp8utGB7iZ0jwapfD2sW9W5mS4P101uwG
         UN7FjoI2z7baSijV0HgYsWzmi0jH4aHt4Wpyg/tZOEA7FWoDGloD4LrGmoHIZsxRCS
         7+wWu9/+h3x+u4Pdkvdx9SMfkQy3asXO+PhVPTRz8KMbBYolzGtP7knSmXjsjpmYoQ
         8/2PmtJiYBr/pQINPHZoatHMUzHZrcOKBnvz9uQ0B5NjeDmkgmX4mFeePiP3D+pOrD
         3O5ORsWN+g4C9S1U0q0kSVjcUJePgFcLkSH6NwJGN+H4hj7BItRDaSpzfcA5bqhW7N
         rdiSUAVHnUcZYggr7eatGoEWC2ME2+S/fEdRaj27zWnZnFIFk6Mln1+zdDHkJ2UaFj
         zDKDJfO899JhAsRTeKx93g6lhTOfxL0n+HesP0fKGu3JYPDS4aBcm2lK+l4TEgumxy
         PGG+cexH2aLcnGBCgjOAJ46rMRa8NvufoLdvtbMLHcrfZK3xuLV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/28] t4044: skip test if not using SHA-1
Date:   Sun, 13 May 2018 02:24:19 +0000
Message-Id: <20180513022438.60003-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test relies on objects with colliding short names which are
necessarily dependent on the hash used.  Skip the test if we're not
using SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4044-diff-index-unique-abbrev.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index d5ce72be63..647905e01f 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -3,6 +3,12 @@
 test_description='test unique sha1 abbreviation on "index from..to" line'
 . ./test-lib.sh
 
+if ! test_have_prereq SHA1
+then
+       skip_all='not using SHA-1 for objects'
+       test_done
+fi
+
 cat >expect_initial <<EOF
 100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
 EOF
