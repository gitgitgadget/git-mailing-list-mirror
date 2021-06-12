Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A6C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0568611CB
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhFLEaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhFLEaP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:30:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58691C061767
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso7104458pjp.2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOPWrx792qnVTqGh1fO0w44RLC5KmcDTCvJubsoU5s0=;
        b=TwcdMcu6qAiaYgLrxJwboclCeN7s+7iKZKhREUTvsRTj9QW0YYCSVBra5PHDi8dK/8
         jW6uEcIK6yIXk6THVHijbjKQK9Q8RmQrCw3Wh1zUUFRf3K/FCD+1xYA1t82GqXSoQAnF
         Ej98EhaJR6AJi7+IGnrbwru15XGnTvNHMehcI+zHNp2VxqafH+B3HDL2l85l1P3tCqEL
         al6C+xNy4HWtXqvOlmq1p1jgSCZ4v0YVeJSGZKfI2Mxx1paGng0uWjNTHWu0kB83TC3E
         pO/w6z/Yd0hafQzhQ4cNAgKkFmBKGU8y7pPndsqC7DyZt+KSBOWzH/uM4OO8ugpsNk5n
         SVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOPWrx792qnVTqGh1fO0w44RLC5KmcDTCvJubsoU5s0=;
        b=UZp9CRV4gZMUem2zGCDXixW9NwYh1c6VsNyPckyHoRddxe9/jRb2nroyvmPCyIogoi
         oJd3CXr+7j9PuWhzxfz1Os4PxjimcFvDZdFJpTIc4NUXLB0iu/ZnwB2/4gNoin1QnM6y
         lu9rXzZgDf6og/O77CRxSTJUtKM6NgrO3hY2AwQUuZvO0gliEAz4whktg6WakD/hBdJ0
         JYs+POMWyzqT/DXbmvPIjFDHdoiTrcPTNeNgHFAeuT/Ks2s3LjnfBf70YV+jdjCtxhZL
         qv/fr0PxXODeNq2obYa29FdvZAO2l3MvZkiJvvSI7PRNexN4f1VJKXRdGeaUkEX10r/j
         YOGg==
X-Gm-Message-State: AOAM530BtmYu26UJpMZwYH/Y5U9Au7JTVs6D3wOrLDDMl4YPNaqLxiBh
        s6vTfkVHXsCraZh2A3pR4OMOmkPc3OflMg==
X-Google-Smtp-Source: ABdhPJwQ1ULDCKNI3Yug13rhOCwv/jjBj50dZUP+S3gK1CfNSHPbnbxXf5TR3i3dtoLosYdfdooR5w==
X-Received: by 2002:a17:90a:d082:: with SMTP id k2mr9503118pju.15.1623472095772;
        Fri, 11 Jun 2021 21:28:15 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id w19sm11272539pjg.48.2021.06.11.21.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:28:15 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] t6400: use test_line_count_cmd to count # of lines in stdout
Date:   Sat, 12 Jun 2021 11:27:54 +0700
Message-Id: <20210612042755.28342-4-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210612042755.28342-1-congdanhqx@gmail.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..9d7b9354c5 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd --out = 5 git ls-files -s &&
+	test_line_count_cmd --out = 4 git ls-files -u  &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 2 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 3 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd --out = 5 git ls-files -s  &&
+	test_line_count_cmd --out = 4 git ls-files -u  &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 2 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 3 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.32.0.278.gd42b80f139

