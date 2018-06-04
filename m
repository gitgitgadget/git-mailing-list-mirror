Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84461F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeFDXxF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:53:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33240 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbeFDXxA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:53:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A76960745;
        Mon,  4 Jun 2018 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156371;
        bh=l7BbuanO+KI9IQXaN8aalOwRIXDHYxrbPSK7IkN3XMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cyaOi6oeV+latl+sIP+PHwfbC7yX7IQueKN6726XuWfSH6nst4KpcyKfi9uHJeIGJ
         8ToACPOjo3S2cnAmvV+mFuQ0eccbsDaqTIzXlWWCpHcrEEiu1YL/1SlXA5vuYr1BzT
         oD0oKmsYi+lfqSgsIUpk8KrOLUavQbXl8gAE02FsobujSvnGRe+tldre10WTqCz6ow
         r7CB9Gzyvq3ynJK1OmL3MOgLiOOr3KCLmEszPuoUC+3gYSdx1j7MjavyLwRlRAoEse
         t3LH4iYXh1bo7zcZx9vTsjhjSn+YoT9kOjkK9uhEDrxI2WfLVCkrzmam+R7Nhmn7kZ
         1XZ9bLCDfRcxIoirxpMYags4ZoDmo8Xo+SnzGw7Gxjjs8/EZ6Sxa+HakxjW9E1qt9X
         P/hbBHlcwQpbBaCFvbD3Jq9Lv95yKHOEgTxBBhAEoF1pXCzhgW4OzBYQiu77MZHoj8
         6Pitfh3kSu2ElCx8TejsU9mQJ5S5uQgGdyc1N1BG8MAfGjEN9da
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 09/10] t1406: make hash-size independent
Date:   Mon,  4 Jun 2018 23:52:28 +0000
Message-Id: <20180604235229.279814-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
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
