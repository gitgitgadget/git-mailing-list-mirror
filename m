Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABDEB1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIMK0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0T (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:19 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D4736075B;
        Thu, 13 Sep 2018 05:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815906;
        bh=n2q+5jArOMtA3KGun1CSIhNhb9NjZPjzKuIMSy+c/d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sW7A/BNRG9CvFblW+aQYCTA6+H9Oc87kgf5WCOzbI2suDZC+Zog9hzKDCtUiiQT/r
         k3tXefE6C3UEwsLyoLnDz/L+83nCZWILXuc/E9FXuaPeWC2RgsR2F/VxJp3zJ4G4ch
         0Ng8enQoyokompsXM1I37AKDCFeV3B9PilXhYnoQjiccxkjXqeTRh+t8sXEAKea/pa
         8sNvqJmCDPb/AH6zCwOjiFJ5lk1Rkwq58ob4+rmtxfm/1nETK5QYQ/7wgFn4nb9tx7
         54LWEMii3jNPiYKd47n1r+fS/AsNfvj5e2Nja9AM55UlmO2OOPi45wXXZ07CZKPXOa
         eXMuIslcpQi7a/u66ojcEGwDF/km+Ywa7PYIeoP4ovj0uL8qbSB2tqDdjiRH5H1BNg
         sc938RmqPl9b4bQ3RL3nJ3WjsRBpDC9sTdALADR85fyBkVdOWms18gqZGbQ4zm9Vlb
         TdNQIQ1W9cqybfXJyPVBXXMRYndRM+2dkhex9/ArYVV1pFVz7RU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/12] t1405: make hash size independent
Date:   Thu, 13 Sep 2018 05:17:39 +0000
Message-Id: <20180913051742.252276-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
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
