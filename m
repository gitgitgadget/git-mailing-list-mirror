Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08F01F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeEUCCL (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751637AbeEUCCI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A3BF60746;
        Mon, 21 May 2018 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868126;
        bh=ZwU1rVb4LwHxL0TAHrv9DCTAzxrxHYfm6ek1EujJzu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KjY7t/WUD8gyK2/8a5cXhBfRi35avnSGpVv5sL3d154psX3rngHi9nvhg0il0C/pS
         3OE0Gial9dXUPHeuLYqrhb239XGLKy/8/ajgzmToTliIY9NPlXu0Eud+PJi23e/nlM
         BSzSDjeaHhPaZe5PaElAXoeHNQQllm3aAQTOUDxSbsW/OK3Pq+G8X352EBOP5/cJP5
         3/ZBCgSl/ZSIECZ4pzYm4DsrLEeAy41YeS/iOlesoEIdOdyXJ5qyBFYdmBbYhw8dqo
         5dDf5vnBkXf4vTwoDD4J9eTUok8nes5ORjY5F08ueSU92DL7Iork+6peEE1Ld2J5CQ
         7th5J/ypl96+QrEVQIL8f2XKr2GJOel+rw7Wa2lFACTLMpKlZRx1lKOhLQfUhuTxVT
         vzdx6xBByUn0l5A6Pcxp7rSGG3N+KRATmoX6z3g9SV9/tNxzADNKT6m56RJBhnCMwR
         LywW23JNuVx4X950ZyF3RrJG4EktUNpQktDj4FkrZpcuIdstQvf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 01/28] t/test-lib: add an SHA1 prerequisite
Date:   Mon, 21 May 2018 02:01:20 +0000
Message-Id: <20180521020147.648496-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
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
