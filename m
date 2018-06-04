Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8201F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeFDXw5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33234 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751361AbeFDXwv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85A2B60746;
        Mon,  4 Jun 2018 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156370;
        bh=n2q+5jArOMtA3KGun1CSIhNhb9NjZPjzKuIMSy+c/d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j/xhfzkIZee5htkeG9bjySBLi/RqetexkFhHHPRIGeeNHGhAhv2r3SUdcusPh8NOY
         Ooiw7FkO4q+cHrmR4aT/wva9BfYu+zJaJs4WI5i5evX7J7Ccc8Edma50w2sqaNvfTw
         WKwXVlBckEHjd2u42wwcAWLMuAkvODRJCbi0V3P6lLeBhCzWjorOdo2yrw5Kc3W5Ec
         /QyBgyJSfjCY7YDfF4hegLfXAvJwWv8UQSm4vM6iAlAMvBTRMF+8NgbVES2DhrIy24
         PyCEsH/IFf+7whtWbquTLqChXNHAcCXvVTKcLjlx75jAU0G88Sv1iBfpPonnpQACAV
         O00QFka7FS74Y/z8TIBum12tHPmyoHy1CszEUzbSBQavil0ZR7ER+0vprGEkQakvAp
         OX+zLrzeEHrH1Qrhquy0a++E3mMCV23H4VD0SsDCThcqhQ3FoKhEZ/BbMAPQjZQoR8
         j6YeNjZWwTcbv+VXxbpdRHyCMPDXdYG3lnErKQi9ejUumT8hFLg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 08/10] t1405: make hash size independent
Date:   Mon,  4 Jun 2018 23:52:27 +0000
Message-Id: <20180604235229.279814-9-sandals@crustytoothpaste.net>
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
 t/t1405-main-ref-store.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a74c38b5fb..331899ddc4 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -54,7 +54,7 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 '
 
 test_expect_success 'for_each_ref() is sorted' '
-	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	sort actual > expected &&
 	test_cmp expected actual
 '
@@ -71,7 +71,7 @@ test_expect_success 'verify_ref(new-master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort -k2 | cut -c 42- >actual &&
+	$RUN for-each-reflog | sort -k2 | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/master 0x0
