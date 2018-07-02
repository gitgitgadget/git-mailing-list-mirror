Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461F61F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeGBAZU (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37218 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeGBAZE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:04 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so9843594itc.2
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kbIAvQpKC/3+fxFGorDG3eKBCZDo6FdMBRIRcyI6wB0=;
        b=LkA2Udh5ly02XTbD1DgCCNfi9ql+ISwYpuB3XuIYaNyRS4I9/gL7Pkec3i+kYPAKyr
         OPjcNybT68WvdUSHKLL4pss0KhtNvb4uYzKtbVr0Qn+BgLbRPZuKPDdXGa9EDmTjviom
         QczDPx6KaQcnGcmSsHLK+CYWp13qnltMiyiDSFY8h/r9Tw156LtxU3tXu8MKLzBOimOC
         s4MGHaKHRj7Rh6BSUUOyo36f6Wjx7mwFeCsR5i7fivwkle71v7joBpn8Fjkm9q5enceO
         LTqTWaCdR9Jq5qwI7lN1vvuA/+TTrMMJ+A4ctHDaHObU7WpLTMmX8Mc05Y9QNks9Uy7M
         OJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kbIAvQpKC/3+fxFGorDG3eKBCZDo6FdMBRIRcyI6wB0=;
        b=DWZAstxyghmzOzMbhJ/Cf2qfBiL+cun7PvRPLvJfxTLRSNO3DxuGCDZIFAwjQkceEA
         HmhYjEGavKuX+JPUeZ8Roe9loqZ8SYFhaoUe+lql/cxR86tTWtazGa5cn8v/AVjl4d4w
         l3xZS75mKjMzHgMa8tE5jJgNiftbdLxG/zo4Du8ajxLTsPkI/iPW1YoMkIUWtiiQcMF2
         3MsBV8Hmn0yIs25hjLECleGicuBhsUOv9/oN26ufFvNKHyfZxvilTxQZOXEaRlD3b8YZ
         AgL/MkX+DFZS8TpL7ytzjHyn1SO8Bv0A6unBPvsDYipVG6WXkEgk0CSlK8uaGY7AyA7K
         119g==
X-Gm-Message-State: APt69E1sfQm1PNAYRHwLyy/WaEGP6Yp5GrGTem7NcpftCtEt5DAq2GRD
        b/7UH2XQ2bx3f/a+XvJPYbAliQ==
X-Google-Smtp-Source: AAOMgpcIdt+R1mttWBKyzQbaJAXNvHQ0mjPaMWyGziK3NRUns6VVh8BahH0JI3QMiLb+rpXbHVpnvA==
X-Received: by 2002:a24:ed06:: with SMTP id r6-v6mr7786303ith.59.1530491103683;
        Sun, 01 Jul 2018 17:25:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/25] t0000-t0999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:23:55 -0400
Message-Id: <20180702002405.3042-16-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0000-basic.sh      |  2 +-
 t/t0003-attributes.sh | 24 ++++++++++++------------
 t/t0021-conversion.sh |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index af61d083b4..34859fe4a5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1081,7 +1081,7 @@ test_expect_success 'very long name in the index handled sanely' '
 	(
 		git ls-files -s path4 |
 		sed -e "s/	.*/	/" |
-		tr -d "\012"
+		tr -d "\012" &&
 		echo "$a"
 	) | git update-index --index-info &&
 	len=$(git ls-files "a*" | wc -c) &&
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f19ae4f8cc..5c37c2e1f8 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -34,15 +34,15 @@ test_expect_success 'open-quoted pathname' '
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
-		echo "[attr]notest !test"
-		echo "\" d \"	test=d"
-		echo " e	test=e"
-		echo " e\"	test=e"
-		echo "f	test=f"
-		echo "a/i test=a/i"
-		echo "onoff test -test"
-		echo "offon -test test"
-		echo "no notest"
+		echo "[attr]notest !test" &&
+		echo "\" d \"	test=d" &&
+		echo " e	test=e" &&
+		echo " e\"	test=e" &&
+		echo "f	test=f" &&
+		echo "a/i test=a/i" &&
+		echo "onoff test -test" &&
+		echo "offon -test test" &&
+		echo "no notest" &&
 		echo "A/e/F test=A/e/F"
 	) >.gitattributes &&
 	(
@@ -51,7 +51,7 @@ test_expect_success 'setup' '
 	) >a/.gitattributes &&
 	(
 		echo "h test=a/b/h" &&
-		echo "d/* test=a/b/d/*"
+		echo "d/* test=a/b/d/*" &&
 		echo "d/yes notest"
 	) >a/b/.gitattributes &&
 	(
@@ -287,7 +287,7 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	(
 		cd bare.git &&
 		(
-			echo "f	test=f"
+			echo "f	test=f" &&
 			echo "a/i test=a/i"
 		) >.gitattributes &&
 		attr_check f unspecified &&
@@ -312,7 +312,7 @@ test_expect_success 'bare repository: test info/attributes' '
 	(
 		cd bare.git &&
 		(
-			echo "f	test=f"
+			echo "f	test=f" &&
 			echo "a/i test=a/i"
 		) >info/attributes &&
 		attr_check f f &&
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9479a4aaab..6a213608cc 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -785,7 +785,7 @@ test_expect_success PERL 'missing file in delayed checkout' '
 		cd repo &&
 		git init &&
 		echo "*.a filter=bug" >.gitattributes &&
-		cp "$TEST_ROOT/test.o" missing-delay.a
+		cp "$TEST_ROOT/test.o" missing-delay.a &&
 		git add . &&
 		git commit -m "test commit"
 	) &&
@@ -807,7 +807,7 @@ test_expect_success PERL 'invalid file in delayed checkout' '
 		git init &&
 		echo "*.a filter=bug" >.gitattributes &&
 		cp "$TEST_ROOT/test.o" invalid-delay.a &&
-		cp "$TEST_ROOT/test.o" unfiltered
+		cp "$TEST_ROOT/test.o" unfiltered &&
 		git add . &&
 		git commit -m "test commit"
 	) &&
-- 
2.18.0.203.gfac676dfb9

