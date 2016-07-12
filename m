Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5010C20196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbcGLWjw (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:52 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35704 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbcGLWju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:50 -0400
Received: by mail-pa0-f67.google.com with SMTP id dx3so1832982pab.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZ70TH4wii961kT2KaKdE+GU4b2kC6pycMvWHiMoemQ=;
        b=JjTcivLmaSC5H3WqOme9vmoyHFjd8X0TSr1JLsIMbA6mcQDMNuksyT5jIVuU4Bs57w
         DFUp/hz9xnalx7tC/a5zkZGeNcZYexrKhji7UHkEUD1Vzc7zWGIasjv7H7s7GeQvDsU7
         Ow63x8TmGs59saPbtK3Esa8o142Ss0i3x2mzjRTWbSuW+W3xq/njK51pOyUzNVdO5y4+
         bUMDsalYDc9VL+GCklcZIVjfx9fImDez/tTKgQrHZhMnH1jXcVez1pyfSezXy+HKhQ24
         6euU8VIj05nZKI8gNsqOqFJPYRNc4jLoW/DzDe9rRBGCUHuY/vCDRv226MltFXybGS1J
         Wv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZ70TH4wii961kT2KaKdE+GU4b2kC6pycMvWHiMoemQ=;
        b=iu7ztdrWrZbOq/vo/wk9vbbfUuSIAXQhM8wxo/bp6HkGC0F5P2lniny96tnz2ahkHr
         Xw1HfwxNaoHu5lpFeUmPLk4GqC+hWHpPO4nLwser1LG0vtun/Y4EWl/gQy4jBe4b3+zj
         z+rL41ATnU6WHvCWmJdQoikU4kwYMtVp7Rh9d36xBm/TC3ERkvltXgIZnB3IHK7Lrgro
         On2TYJ6Oh42X6oeQYoXZHrYk05Hj2Css+i5MRNIGX/lxrFJrlTFyWWrZ3M0t7tOMUdX7
         6Nkn1+ew7Ynt2Cg/oN40QaAoB4sc6Qv6VAPF+IRSwnp8BOiwj7JirG6ISJ3CmRPmUoY7
         oUNw==
X-Gm-Message-State: ALyK8tIv4uv8/trH9qv78Znxg3ueX3TV3r7Yw+YZ3m6jkPX+h+g1JO91kCSuPumA4Z7oRQ==
X-Received: by 10.66.65.109 with SMTP id w13mr8272433pas.142.1468363155600;
        Tue, 12 Jul 2016 15:39:15 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:15 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 5/9] t6030: explicitly test for bisection cleanup
Date:	Wed, 13 Jul 2016 04:05:34 +0530
Message-Id: <20160712223538.28508-6-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add test to explicitly check that 'git bisect reset' is working as
expected. This is already covered implicitly by the test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
I faced this problem while converting `bisect_clean_state` and the tests
where showing breakages but it wasn't clear as to where exactly are they
breaking. This will patch  will help in that. Also I tested the test
coverage of the test suite before this patch and it covers this (I did
this by purposely changing names of files in git-bisect.sh and running
the test suite).

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..a17f7a6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git bisect reset cleans bisection state properly' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
+	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
+	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
+	test_path_is_missing "$GIT_DIR/head-name" &&
+	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
+	test_path_is_missing "$GIT_DIR/BISECT_START"
+'
+
 test_done
-- 
2.9.0

