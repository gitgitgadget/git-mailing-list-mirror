Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7051F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMK0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0U (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:20 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F1526046C;
        Thu, 13 Sep 2018 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815908;
        bh=l7BbuanO+KI9IQXaN8aalOwRIXDHYxrbPSK7IkN3XMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DkwcYMxBmE/qfYpZ/UpqxxmUlkE86y+bQalmjp+n3xnh2+rpyEF/Yh+T5YB2icUUX
         tiWqjCHaUe1iOXcbA6WhWawU4vFnQ0U5j507ThKWc4QihLqyfYPK7eJ+FiqzNOixo/
         5mFc42rhM0yttH9XqFAbWGiu/b3QrP3c5mH8TsEQU3JdzMIpkzxA/EGa2cAKniZUGK
         k2d7JXmJYzOc71VHhri/HFcYv6E5qGuq2qm/OBvNG0gbZ7xakdt+n09WrBxBDyAD1l
         VFkykrmmbhFmIs3C/kAjGAZDXEXqnBY965UN+X4nQPEBq6RS+BgOZ0jfLdQ4Ir6Tny
         NApngJTlxRpsTOaB41u2rJAmxP4Od6ZTvEdH+YEK/l7t0csm3clnkDcprsdjFP2F3N
         qz2HUyDinQaqpE6qJSSNH7cXERhpfHJ5UsaeBIodlCsdLeikjKv8+c/Vw20sHEgOME
         SOrwfI1kXycljEfu0uA76R6PIRIx4Mywrx1TKtvgiluPPMiqx67
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/12] t1406: make hash-size independent
Date:   Thu, 13 Sep 2018 05:17:40 +0000
Message-Id: <20180913051742.252276-11-sandals@crustytoothpaste.net>
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
