Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181191F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeHSVGy (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55102 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbeHSVGx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 28A4F6081C;
        Sun, 19 Aug 2018 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701276;
        bh=l7BbuanO+KI9IQXaN8aalOwRIXDHYxrbPSK7IkN3XMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IDbeomH/2fKwsn2ha9vjkg46CH0clOvs4TMU+2BQaIgGCYIuWbZgTaL1xyDHDvfTN
         dl2/siGM4eMiM3lB07sB+2Qtrc3bbXnmCCaVTGTDGmx7w+0G/qao/EfQClLtWaAcXN
         FpjWvMKrV4CuH4m0WDadT2+9p1qnmluVe23L54Rj2rDFmLvg1WsZeyLWcHk0gxIFZH
         xjZOLsDJZdjya12qDHVzR66eTFUhgS+AcYISnWzEw9Rqj+G4UUCX9tRDUUWLH5fKAn
         frMMLDCpGgAtfeUPhUR/HayxlLsRSEVT3w+4gZ17v+jlRKF/V0fJiNZUfzyCugy2eo
         9n6jlOnNnq1MQwMzVZbdOttaIP3Fdh6+5MJPXiPSahSInpKVZ/b7tzUTHDlyE25gX3
         2QFvYNsy7y9xwe0E+Xo5ShJX7c/rtIo0esMtLv3H1SWDjHpUoPpmXTYnuH6Exak0Hg
         ZDYGtgc2+ewElEVv8HkF+LrCwKk0x8qAQdyFyqWJghYwj7OaPWu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 10/11] t1406: make hash-size independent
Date:   Sun, 19 Aug 2018 17:53:50 +0000
Message-Id: <20180819175351.449973-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a 40-based constant, split the output of
for-each-ref and for-each-reflog by field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1406-submodule-ref-store.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index e093782cc3..d199d872fb 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -39,7 +39,7 @@ test_expect_success 'rename_refs() not allowed' '
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
-	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	master 0x0
 	new-master 0x0
@@ -48,7 +48,7 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 '
 
 test_expect_success 'for_each_ref() is sorted' '
-	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	sort actual > expected &&
 	test_cmp expected actual
 '
@@ -65,7 +65,7 @@ test_expect_success 'verify_ref(new-master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort | cut -c 42- >actual &&
+	$RUN for-each-reflog | sort | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/master 0x0
