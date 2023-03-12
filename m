Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23478C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCLUQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCLUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD923C7D
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j11so40838894edq.4
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d895dUOxWPPChw42PvJDA9T4pBTSv8OFKsLOHA7WlWE=;
        b=Y2mWkOoziTHUXx7MBAy0+Vwo/Y3pegkiSw+Wh/ttE6kFDiPi5MqG+M6YvW5QBSqNhT
         yiMhV3m5IQqvpEb8c6e0PxsqLy0UU27rqkUGlGhDF0Kkw63EAavhYUo6Dv/iDmjf71qP
         aGLQ/EdN1bbU9EPtKEEWN1m43rYsVADkaa4sJ+w8VBDonuI76fA8n6jbCfMgYCt1wII9
         OMILmxtXZ7Jkv+tR03BygABQcPwo4rH6r7D+e6V0buY2gx7lOYSkFtXIasWON7YLPVnu
         yTnHndiFlcTKPqmJo3QaNTILPkw2i2z02qPJ2jqAnNYbRABYphZIpJYNaIpLQ/lsK8M/
         PZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d895dUOxWPPChw42PvJDA9T4pBTSv8OFKsLOHA7WlWE=;
        b=geFlg8sDx24Zw4ZFaWtuNwpmx2zovYOTjigcTTw0TcxIZzzrG/s61fHNYAUB2/zFE7
         fb775tMkBTTINTP4Z4WJTHD9tvy49qwQ79Wujgvp1fe0nMBJQhwURWRXEs3mb9rM5Uhf
         VOciB1En6zyJFtgopfBvH6gHfI8B3KNlRt782abka3mKDweDvj66q6n8dZ2WqbqLAUvd
         UgFEUxj6oB+rgwqQ2ehta/SIsJ9YfKG3DmFfrtMJVp39B/5R78V7jqeTfWJdk41G61Me
         5U3NDep//QBN41DcSyVMjVYnwubPkeOAFY42txNBZkifORvDJvfuW0NbUnDwOxEFE/QK
         jFdA==
X-Gm-Message-State: AO0yUKWhkJkQXorCTPkx6L0u6mT2jqqCcB7qC6+tsDNRdxsXyegl2RSj
        qUaiVYj4NvCdJAcbIJB/hODQq4Lbps9VRQ==
X-Google-Smtp-Source: AK7set8Y6f4PgTDMF/RUzDK0ukrFusadj9Bhez1Vv53ZEGHvywrCOs7z+LTw5lja/lYptOGQTl9+EA==
X-Received: by 2002:a17:907:7f0b:b0:888:7ac8:c0f4 with SMTP id qf11-20020a1709077f0b00b008887ac8c0f4mr34402480ejc.25.1678652126329;
        Sun, 12 Mar 2023 13:15:26 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:26 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 1/7] t1005: assert output of ls-files
Date:   Sun, 12 Mar 2023 21:15:13 +0100
Message-Id: <20230312201520.370234-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'reset should work' in t1005-read-tree-reset.sh compares two files
"expect" and "actual" to assert the expected output of "git ls-files".
Several other tests in the same file also create files "expect" and
"actual", but don't use them in assertions.

Assert output of "git ls-files" in t1005-read-tree-reset.sh to improve
test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1005-read-tree-reset.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 12e30d77d0..26be4a2b5a 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -41,7 +41,8 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'two-way reset should remove remnants too' '
@@ -56,7 +57,8 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain reset should remove remnants too' '
@@ -71,7 +73,8 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s &&
 	git reset --hard &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f should remove remnants too' '
@@ -86,7 +89,8 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
@@ -101,7 +105,8 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.39.2

