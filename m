Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204D21F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeFZHcX (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:23 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46934 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeFZHbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:13 -0400
Received: by mail-io0-f193.google.com with SMTP id u23-v6so11298466ioc.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDw5UhDUyIxKliSSfhW+oVmgrgOFN17vTuv8zWHA+K4=;
        b=dm/wvwyprVyr8xl1jK12VCMwtHiDUXa13RwiTp7eg3QFJU88RW4zAVmrD8to4YrxE0
         G25c1vt7t8Xtg0SzwueDHlPYMjCHSigOC+ypV7Pj6lBPC3RZYhdbpIvFMOerB1gQfpJY
         wF/7heakmJq90jA7k1x4UDDhUjbQ+AtOsMA4vs7RZHPhoO7ole21ntNFpUkJ44NBimGK
         +fbmT8aE6MdNMg05QqUBfIGcAjT9Xx9eI+XIDi2o/bEsoZfXGZ4tbd8oJ5t9V2Lufjdi
         5YynBXV7wtedP7usS1AbY4JP8jx8aZ7ZVfg67xullh+ini93EOJV7ra5ayTyiSNqGpG2
         +law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dDw5UhDUyIxKliSSfhW+oVmgrgOFN17vTuv8zWHA+K4=;
        b=WqgbWKWgff4/159lwIii5QhSYE1xh3fINAQzD+B3jtqJyYsPYgDGAH9XO6zf1mvIW0
         903wwOCP3lgxtRaEphsf2pxc7cx1j5cqFd2ZkXuuVFNUK3uQ2i6qiG1bE5PLY+1uOswB
         b2kD62A+jvIPNDMdNy7EMWBPFW52x7GvwI6W1AFKJvyjMJENSE1r+tOzhG6RPu+HdJOI
         MCYOFtk7mYRlFw/AytmfQwqj39hkQp6cLsdzl1jnuO4YGRejricAvNZtmY9IM8kHrlIe
         rHlwpo7cpS0iyeYMEGIykoYCdKkTyBT/Sc6wQu71erqOas78OGxQjQ/DYF3isZ7p3yEI
         0ZEQ==
X-Gm-Message-State: APt69E1GKweazYSGM1+e5oqxhF3D0pJuDclYJ00vNVtd3Lh8I51PLYrv
        fokkp6lhysQcmBkvMQzPoMYUTw==
X-Google-Smtp-Source: AAOMgpevD9Lrj9Yqmq0orOcnsrV7iKAUupdyknggWbkolp/NHapAwv9VKvRT4xrpHh4p91GpVpZD5A==
X-Received: by 2002:a6b:a282:: with SMTP id l124-v6mr299282ioe.256.1529998271951;
        Tue, 26 Jun 2018 00:31:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:11 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 22/29] t3030: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:54 -0400
Message-Id: <20180626073001.6555-23-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
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
2.18.0.419.gfe4b301394

