Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D796A1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeGBAZr (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53432 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGBAZI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:08 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so9882515itd.3
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEWfkIdKfV4z+6dDfi288zRtCu5zRNzgxQIdD2zoCzQ=;
        b=EjlMNP8D6ne1lvnbDvkb7NWRPkKTkdQodSafgZR+nA7BXlDximT8yN9BEcnVqz9Pk0
         qiKPMy2iSk4J1oZrvBT8VfjrR19ylHvDrD/YpkkXfuqO5IS5OULrU2EvlOOWUfGPWBvj
         HEbIR6TjbwiF8JNQOdSxcWQu/s0j0Q4p8qYRXLXVeDmJ5eAjDD4dyIoKZ6CubT5q5GH4
         +zQ3ZLeo9VWqQ6Hmm9H72K5v0++4TCTUcj7jyxvvAntiVmLr1DHVZ4iQ+zEFSZZozmG8
         2RiDwN/BdE3LFuQjZSeO5Fff9eJzxZyASsA1igpXPKNCIoNIOmKR3wDiwHKvWOzuj3kM
         4ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DEWfkIdKfV4z+6dDfi288zRtCu5zRNzgxQIdD2zoCzQ=;
        b=GSY8mqaxS2/exZmbXFVxNCdXpOfvxk7r9gbQcdTm6rZ/hLhFTQ9PeIYT5pOJmEgaPw
         AyAsyKvJQekfvEJosCnAbPKzuUoJyqpa2fuCPSJy6JpoXTmP2ir2iwCnN1cavb/sdkuz
         RgAvRMZ+CH31KE00cd51T9uBnHkNeBvzRZNzbG5f2Wcpi9kKojiN7sLpvj5BR17bPEGq
         xMB7EB/ertSULy8NRp2f8qepUXbHgzanisFx0U8mV3PzuofXmxwuC53D5xGjW0WdDL6M
         s0dmST1mEEY3szkcHr0L5B1ep9nCOU07WYuTMUoMKwUQ2f5l0SGebXbA2kWoDhm+2Afn
         f3Ww==
X-Gm-Message-State: APt69E0Dl3YFZdcP6zvnMHsR3H8TTkyTcse+9et/PFS4iz7eRTe0VUbi
        fBgBd+1uovq5umX/3qHwowBS+g==
X-Google-Smtp-Source: AAOMgpdR5etKpiyaPtufDMBB0+21Rs0lvBgE1wwqM6vg7PtPfo0n/grUoVcJOWa+CLdvIfeQmj4nsA==
X-Received: by 2002:a24:d3cf:: with SMTP id n198-v6mr8754758itg.152.1530491107936;
        Sun, 01 Jul 2018 17:25:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 19/25] t3030: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:23:59 -0400
Message-Id: <20180702002405.3042-20-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3030-merge-recursive.sh | 340 ++++++++++++++++++-------------------
 1 file changed, 170 insertions(+), 170 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 3563e77b37..ff641b348a 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -36,15 +36,15 @@ test_expect_success 'setup 1' '
 	test_tick &&
 	git commit -m "master modifies a and d/e" &&
 	c1=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o1	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o1	d/e"
-		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o1	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o1	d/e" &&
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -54,15 +54,15 @@ test_expect_success 'setup 2' '
 
 	rm -rf [abcd] &&
 	git checkout side &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -75,15 +75,15 @@ test_expect_success 'setup 2' '
 	test_tick &&
 	git commit -m "side modifies a" &&
 	c2=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o2	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o2 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o2	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o2 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -93,15 +93,15 @@ test_expect_success 'setup 3' '
 
 	rm -rf [abcd] &&
 	git checkout df-1 &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -112,15 +112,15 @@ test_expect_success 'setup 3' '
 	test_tick &&
 	git commit -m "df-1 makes b/c" &&
 	c3=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o3	b/c"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o3 0	b/c"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o3	b/c" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o3 0	b/c" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -130,15 +130,15 @@ test_expect_success 'setup 4' '
 
 	rm -rf [abcd] &&
 	git checkout df-2 &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -149,15 +149,15 @@ test_expect_success 'setup 4' '
 	test_tick &&
 	git commit -m "df-2 makes a/c" &&
 	c4=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o4	a/c"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o4 0	a/c"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o4	a/c" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -167,15 +167,15 @@ test_expect_success 'setup 5' '
 
 	rm -rf [abcd] &&
 	git checkout remove &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -190,13 +190,13 @@ test_expect_success 'setup 5' '
 	test_tick &&
 	git commit -m "remove removes b and modifies a" &&
 	c5=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o5	a"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o5 0	a"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o5	a" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o5 0	a" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -207,15 +207,15 @@ test_expect_success 'setup 6' '
 
 	rm -rf [abcd] &&
 	git checkout df-3 &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -226,15 +226,15 @@ test_expect_success 'setup 6' '
 	test_tick &&
 	git commit -m "df-3 makes d" &&
 	c6=$(git rev-parse --verify HEAD) &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o6	d"
-		echo "100644 $o0 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 blob $o0	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o6	d" &&
+		echo "100644 $o0 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o6 0	d"
 	) >expected &&
 	test_cmp expected actual
@@ -286,11 +286,11 @@ test_expect_success 'merge-recursive result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a"
-		echo "100644 $o2 2	a"
-		echo "100644 $o1 3	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 $o0 1	a" &&
+		echo "100644 $o2 2	a" &&
+		echo "100644 $o1 3	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -325,10 +325,10 @@ test_expect_success 'merge-recursive remove conflict' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a"
-		echo "100644 $o1 2	a"
-		echo "100644 $o5 3	a"
-		echo "100644 $o0 0	c"
+		echo "100644 $o0 1	a" &&
+		echo "100644 $o1 2	a" &&
+		echo "100644 $o5 3	a" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -347,9 +347,9 @@ test_expect_success 'merge-recursive result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	a"
-		echo "100644 $o3 0	b/c"
-		echo "100644 $o0 0	c"
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o3 0	b/c" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -369,11 +369,11 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a"
-		echo "100644 $o1 2	a"
-		echo "100644 $o4 0	a/c"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 $o0 1	a" &&
+		echo "100644 $o1 2	a" &&
+		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -393,11 +393,11 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a"
-		echo "100644 $o1 3	a"
-		echo "100644 $o4 0	a/c"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 $o0 1	a" &&
+		echo "100644 $o1 3	a" &&
+		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -417,11 +417,11 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
-		echo "100644 $o6 3	d"
-		echo "100644 $o0 1	d/e"
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
+		echo "100644 $o6 3	d" &&
+		echo "100644 $o0 1	d/e" &&
 		echo "100644 $o1 2	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -441,11 +441,11 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
-		echo "100644 $o6 2	d"
-		echo "100644 $o0 1	d/e"
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
+		echo "100644 $o6 2	d" &&
+		echo "100644 $o0 1	d/e" &&
 		echo "100644 $o1 3	d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -465,13 +465,13 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=M/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	M/a"
-		echo "100644 $o0 0	M/b"
-		echo "100644 $o0 0	M/c"
-		echo "100644 $o1 0	M/d/e"
-		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 $o1 0	M/a" &&
+		echo "100644 $o0 0	M/b" &&
+		echo "100644 $o0 0	M/c" &&
+		echo "100644 $o1 0	M/d/e" &&
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -479,17 +479,17 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=a1/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	M/a"
-		echo "100644 $o0 0	M/b"
-		echo "100644 $o0 0	M/c"
-		echo "100644 $o1 0	M/d/e"
-		echo "100644 $o1 0	a"
-		echo "100644 $o1 0	a1/a"
-		echo "100644 $o0 0	a1/b"
-		echo "100644 $o0 0	a1/c"
-		echo "100644 $o1 0	a1/d/e"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
+		echo "100644 $o1 0	M/a" &&
+		echo "100644 $o0 0	M/b" &&
+		echo "100644 $o0 0	M/c" &&
+		echo "100644 $o1 0	M/d/e" &&
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o1 0	a1/a" &&
+		echo "100644 $o0 0	a1/b" &&
+		echo "100644 $o0 0	a1/c" &&
+		echo "100644 $o1 0	a1/d/e" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	test_cmp expected actual &&
@@ -497,21 +497,21 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=z/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	M/a"
-		echo "100644 $o0 0	M/b"
-		echo "100644 $o0 0	M/c"
-		echo "100644 $o1 0	M/d/e"
-		echo "100644 $o1 0	a"
-		echo "100644 $o1 0	a1/a"
-		echo "100644 $o0 0	a1/b"
-		echo "100644 $o0 0	a1/c"
-		echo "100644 $o1 0	a1/d/e"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
-		echo "100644 $o1 0	d/e"
-		echo "100644 $o1 0	z/a"
-		echo "100644 $o0 0	z/b"
-		echo "100644 $o0 0	z/c"
+		echo "100644 $o1 0	M/a" &&
+		echo "100644 $o0 0	M/b" &&
+		echo "100644 $o0 0	M/c" &&
+		echo "100644 $o1 0	M/d/e" &&
+		echo "100644 $o1 0	a" &&
+		echo "100644 $o1 0	a1/a" &&
+		echo "100644 $o0 0	a1/b" &&
+		echo "100644 $o0 0	a1/c" &&
+		echo "100644 $o1 0	a1/d/e" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
+		echo "100644 $o1 0	d/e" &&
+		echo "100644 $o1 0	z/a" &&
+		echo "100644 $o0 0	z/b" &&
+		echo "100644 $o0 0	z/c" &&
 		echo "100644 $o1 0	z/d/e"
 	) >expected &&
 	test_cmp expected actual
@@ -589,8 +589,8 @@ test_expect_success 'merge-recursive simple w/submodule result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o5 0	a"
-		echo "100644 $o0 0	c"
+		echo "100644 $o5 0	a" &&
+		echo "100644 $o0 0	c" &&
 		echo "160000 $c1 0	d"
 	) >expected &&
 	test_cmp expected actual
@@ -601,13 +601,13 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	git merge rename &&
 	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 blob $o0	e"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
-		echo "100644 $o0 0	d/e"
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 blob $o0	e" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
+		echo "100644 $o0 0	d/e" &&
 		echo "100644 $o0 0	e"
 	) >expected &&
 	test_cmp expected actual
@@ -617,17 +617,17 @@ test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 
 	git checkout -f rename &&
 	git merge rename-ln &&
-	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	( git ls-tree -r HEAD && git ls-files -s ) >actual &&
 	(
-		echo "120000 blob $oln	a"
-		echo "100644 blob $o0	b"
-		echo "100644 blob $o0	c"
-		echo "100644 blob $o0	d/e"
-		echo "100644 blob $o0	e"
-		echo "120000 $oln 0	a"
-		echo "100644 $o0 0	b"
-		echo "100644 $o0 0	c"
-		echo "100644 $o0 0	d/e"
+		echo "120000 blob $oln	a" &&
+		echo "100644 blob $o0	b" &&
+		echo "100644 blob $o0	c" &&
+		echo "100644 blob $o0	d/e" &&
+		echo "100644 blob $o0	e" &&
+		echo "120000 $oln 0	a" &&
+		echo "100644 $o0 0	b" &&
+		echo "100644 $o0 0	c" &&
+		echo "100644 $o0 0	d/e" &&
 		echo "100644 $o0 0	e"
 	) >expected &&
 	test_cmp expected actual
-- 
2.18.0.203.gfac676dfb9

