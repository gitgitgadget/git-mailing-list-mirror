Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55141F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEMCZp (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45280 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbeEMCZn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C29360745;
        Sun, 13 May 2018 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178331;
        bh=FwO6egZ+eCKAvx75GR6uOmwfnom5OWjZ+5PGENnpuBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=e/lKC9nKsrcJJvRSjWAJruI9R47J1B1YXQoiZcKef/xR8NSIS1LNF32K2HGYNyZx6
         6v/C8G9IufeqmJaGf5SRLK98H9i6n1DGdaCRZNHdfeuCTcSzso+SUME7PkZ5wNKOuB
         zozrsTpbvVkanP8QGW9OyHo2DX0G4xDq8t4kXkOtNEyVYszdGM9VgC5J++tlBwp8wc
         mu+mvYn6j7O4BV42hvosO2O7tu5oUdAeFBJ9cyiD8zS+80h5CHZI9yFaBLjNwfYzNI
         evDRk/RZQydlTIxoxBXgeHzxiSs9CxHg3YyuXyivprt91QHlpykrsWtiKRPx73+jZV
         PYqVC/V4KXCBjxtXd+8xH81L5T69S4VInY4C4gCfarhXnzSucq2GT91bdoosV4KrKh
         BOkJMsqqbqYKp/71JqT+AESVoS119Dm4a3MlbVEc2K+2jRnlGufgWzZfyKuptg0PI7
         Jc3MwLwdUIDePxFBn8Su9u4fZMkAAuM5X9iTql/wmV0orROn4H1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/28] t3103: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:22 +0000
Message-Id: <20180513022438.60003-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses variables and command substitution for
trees instead of hard-coded hashes.  This also has the benefit of making
it more obvious how the test works.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3103-ls-tree-misc.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 09dcf043fd..14520913af 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -17,7 +17,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
-	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	tree=$(git rev-parse HEAD:a) &&
+	rm -f .git/objects/$(echo $tree | sed -e "s,^\(..\),\1/,") &&
 	test_must_fail git ls-tree -r HEAD
 '
 
