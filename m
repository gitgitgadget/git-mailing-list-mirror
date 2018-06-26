Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169FE1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeFZHbO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43929 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeFZHbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:08 -0400
Received: by mail-io0-f195.google.com with SMTP id i23-v6so12102899iog.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW1KM/Mv96Cjbtro4rU8/wSszWghiqgUD/R4D2vavEA=;
        b=lWnk0rFwKa2N7oJV8G61FRcUFtUQNEvvvqmU44HJa+UbjPPDKdg9j93VGC6+7OraCI
         Af1VJ6iEZHYIhMyEOyJj7YWOCZqjqXq4tYHNIGE5sz896qfE3vEpvH0WrC/NbINdTEVv
         gY1JozGP12cVpFdRObkrUpwtfw71zs6u/4+S/YCPlx2Pd8RfVfDP2rXMPh18sA3YaP6N
         MjV2dNUVq1jETirlQhEDFfxzxdObrrRrSneBUBXd2ADmQ4qZB7YJuWxVXCwrmn1ayIXH
         Cn1MakmAbVVha8vEpNKoJa8aOi7AUV/hNd2QWMNJaj+tSSnSv3jjqjXjEJ5c5U2ZU08u
         VHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=GW1KM/Mv96Cjbtro4rU8/wSszWghiqgUD/R4D2vavEA=;
        b=U+sGBE2aR/5FLOLLgj06jrj/dP0lyPCrMqtfWKWjLFeDxQj5ZQ4428mQWnbOWyHYje
         nGxkyl+IhX75KaoRofiO1hYBgHyIFRY9do8W72XadXRohtPNZrDxOikPuuFVgzdRB+PF
         ya9gsbuNGa9sj0tKeRyAnJSb1yMq1ERQGm8f//nlXQusmH14Ta+JSjog85KBBy7elE4/
         +f6dQLZX4k2S/Z8LmOxdqcuOnvwUtjJBdaCM21osj20nqzlD8j1crlR4EGqAFPMF6NsS
         sb6b1D/jetFWBISc8RfyNKkaFmoSoqSu0XGwgoKmvpDkf1JQPcuE7zPRc5gOpgJVSK6o
         euow==
X-Gm-Message-State: APt69E0puldhbTwDOJ9lJWea/GSVkdjtMzc0ROC478pjz25DLBzu55Xc
        kZ7QUfsAYw1Kv7P3B4M7TzPNuw==
X-Google-Smtp-Source: AAOMgpfYDA9rTf/zi8oZ7J/Y0LAXagaLK+cRbGeQFI4ImmM3+bcLLBFU3Ot8AkIxprBTe0r3x3mY5w==
X-Received: by 2002:a6b:821e:: with SMTP id e30-v6mr317013iod.110.1529998267442;
        Tue, 26 Jun 2018 00:31:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 18/29] t0000-t0999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:50 -0400
Message-Id: <20180626073001.6555-19-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
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
2.18.0.419.gfe4b301394

