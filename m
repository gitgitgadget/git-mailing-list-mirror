Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12EC320241
	for <e@80x24.org>; Sun,  6 May 2018 23:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeEFXSu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751906AbeEFXSo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3851B60761;
        Sun,  6 May 2018 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648722;
        bh=FwO6egZ+eCKAvx75GR6uOmwfnom5OWjZ+5PGENnpuBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YZg8d3YYWtunrc3A2sQIx/jt0GxpPYNjP0xVBTKhh6g74ZMTkipH/C+pxDgrnkQHl
         NxnBffz/PL43l7vC4Hi7P8iGuefhAhi3ytXdlgTCDvkeYhnIqErDwfgY0n2pgCyPJx
         vbQ83XSGUot/NAR6hUFY1dtHYQVuuyl0Mun7LMF5O6l85VPn+OfMuvNx896TDWMhnd
         WyEWbjoqKaNpS0bpc0h5+h8uzpIRMndI/YaUU6JoUP1CFnYul1vd+SX15Q3Ep6/OAp
         i0mRtJbITGCzeQ+1EQ8OCxQZ2oCHifs7oMlPw+xaHgk3NAPEUtJx8geNK3IakDAPYd
         srFLrlc7/X1WV0T8pJR/qS+Xlg0dWIzQPbg+NGNy7Q+cQLjJZTULVs+Pcx62qj22l5
         WLIlcUabXi3WIN1jNEb6CjW6DtA9yFtk3bPfZzzkJ36Ue65/cJ2qjjNjlxMxrfZ1lt
         lMp8vzwrL2LJ7ZN+wnsbyQ9f2y3BUX/63orUN2JldRLDn5y/knj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 12/28] t3103: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:36 +0000
Message-Id: <20180506231752.975110-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
 
