Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437B81F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeEMCZB (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45192 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751887AbeEMCZA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C079360735;
        Sun, 13 May 2018 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178299;
        bh=ZwU1rVb4LwHxL0TAHrv9DCTAzxrxHYfm6ek1EujJzu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lTXXM+fc1HhkvRWVS0b24TZZheLYYEtUh6/EiiyijTVsqV4211/KWxdO9epsXsPcd
         V3nHKCJ+JDe3KZf27s/hgXmJyT+wFEh3aJzywxpk7GL/PiA8DjwuVTpIc7tiNHCIyV
         6BWMKmnbgLWYmHP4/qBr7gL5+1GmhGWChG4Z3NgYm6SPpvueB/sAm2gNaIpQxUksAQ
         zBBuJHDO5tjO22BNromKuolsfYJP5MfMRp2f/oFeC+nQiJHquJ01OP7A1aVOdaiesW
         wX8Rd8ND9mV1BmJF594ETEvp4m640TFqPzpHtNvXB8kSrn+E+LyY5bFp1y2UMnmsXR
         qViDeqwlMn5mnobwjbZI65BTkKoMWerKhrZ9eTruMoxpSmH92a+bNuiDV0MDZZppLo
         N397OOargIBgV9FUYgDLGnXIUC62gBqd0zTGTNlxKXrMTXN/rggf2qjqsnURfDd8nE
         6qmlI67ff0mHeNQ7aLyDXHB3t8Y7Jwi2/UD5fT3gPnv2k7qNk3B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/28] t/test-lib: add an SHA1 prerequisite
Date:   Sun, 13 May 2018 02:24:11 +0000
Message-Id: <20180513022438.60003-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some basic tests in our codebase that test that we get fixed
SHA-1 values.  These are valuable because they make sure that our SHA-1
implementation is free of bugs, but obviously these tests will fail with
a different hash.

There are also tests which intentionally produce objects that have
collisions when truncated to a certain length to test our handling of
these cases.  These tests, too, will fail with a different hash.

Add an SHA1 prerequisite to annotate both of these types of tests and
disable them when we're using a different hash.  In the future, we will
create versions of these tests which handle both SHA-1 and NewHash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ea2bbaaa7a..fce728d2ea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1212,3 +1212,10 @@ test_lazy_prereq TIME_T_IS_64BIT 'test-tool date time_t-is64bit'
 test_lazy_prereq CURL '
 	curl --version
 '
+
+# SHA1 is a test if the hash algorithm in use is SHA-1.  This is both for tests
+# which will not work with other hash algorithms and tests that work but don't
+# test anything meaningful (e.g. special values which cause short collisions).
+test_lazy_prereq SHA1 '
+	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+'
