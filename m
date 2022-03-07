Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B1C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiCGMu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbiCGMuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B24ECD1
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j26so12723598wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kr3O9vpmsT14aQgP7pbd/to4TXOIFtHN4oAdr+J2k8Y=;
        b=lQ5a4AKyZzKZculk+vyrU5f42+NdaVMEbo4/ebFW6b0GOYOZOMduk7Lz0IQAapnyf5
         Gnbjc6LUmSkBnwyWJeC6xMy/JxFCu12va4/Q5g9CScJ89FCI5r9wAbgX/y2DApB1NH3z
         pCmI/8XvYB6SS9SpXQnLW13es0Czmrk1A4h2syvuh4jM+MaafAvK5rEtIS9aCfIy5gtv
         8iUlepvSciBBf/cX6pRTygCRhB/D9pyuvxq/xyEdbv+INhQRUSkyG6D8Jnje0Q1zgpK9
         QUWpNOtC+Ngjw423t3Jw9IOnR22y6zmGKb2kbxm6MGJzShHr0HRINn14HlCuRTiKowPs
         s+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kr3O9vpmsT14aQgP7pbd/to4TXOIFtHN4oAdr+J2k8Y=;
        b=PHJnH7W7YWzcN2QQsJl4p8D63IKQ/Kwmkux6TZm8EQJBzBnkXBLMM8FvDQ+DUVBZ21
         JyI7+Y9CdXxLr+koTgdyvYYeWlZohXrH7/+twqKQDfwx6DYtPKm31u24C+pYJrHdggAi
         QjGFtqxfPFlAOr+X+Y3RPmOujVAjq4iZJHevc3cZu4tBlYGsiZpKSZbJ8extzcTecFjD
         gFrVebnr/FThTK8RPVSxVAMOP/5biU50mwFuUF1Qk54SjS76JMYqd8EXqEK1WSZqE0I6
         2ISwXa1ww1NyK2U6Pprx8VKzZ4czFAc4A1sg9dZaScPXh7TOc6p4sS4bJDfEXQSHp5ZZ
         gyFQ==
X-Gm-Message-State: AOAM5304XPFiDTeW/an3z1a5e8lYuOJHtKikXI2TQAZpj28/Z7Zf5SnC
        WSTzk5N1cf3oEpuclaWi2i21Yjv/N5REKQ==
X-Google-Smtp-Source: ABdhPJwNd6TkCetrxLhMJrnMxtQXVT0QXpCl4LBliWxMGi1qgCNtNftOGzDhtkOirMcdLaJDqZTnAw==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id p17-20020a5d48d1000000b001e32401f229mr8233195wrs.694.1646657364103;
        Mon, 07 Mar 2022 04:49:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/15] tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)"
Date:   Mon,  7 Mar 2022 13:48:53 +0100
Message-Id: <patch-v2-02.15-e1105b029d6-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the test_stdout_line_count helper added in
cdff1bb5a3d (test-lib-functions: introduce test_stdout_line_count,
2021-07-04) so that we'll spot if git itself dies, segfaults etc in
these expressions.

Because we didn't distinguish these failure conditions before I'd
mistakenly marked these tests as passing under SANITIZE=leak in
dd9cede9136 (leak tests: mark some rev-list tests as passing with
SANITIZE=leak, 2021-10-31).

While we're at it let's re-indent these lines to match our usual
style, as we're having to change all of them anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6005-rev-list-count.sh | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 86542c650e2..e960049f647 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --max-count and --skip test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
@@ -14,39 +13,39 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'no options' '
-    test $(git rev-list HEAD | wc -l) = 5
+	test_stdout_line_count = 5 git rev-list HEAD
 '
 
 test_expect_success '--max-count' '
-    test $(git rev-list HEAD --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --max-count=3 | wc -l) = 3 &&
-    test $(git rev-list HEAD --max-count=5 | wc -l) = 5 &&
-    test $(git rev-list HEAD --max-count=10 | wc -l) = 5
+	test_stdout_line_count = 0 git rev-list HEAD --max-count=0 &&
+	test_stdout_line_count = 3 git rev-list HEAD --max-count=3 &&
+	test_stdout_line_count = 5 git rev-list HEAD --max-count=5 &&
+	test_stdout_line_count = 5 git rev-list HEAD --max-count=10
 '
 
 test_expect_success '--max-count all forms' '
-    test $(git rev-list HEAD --max-count=1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -n1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -n 1 | wc -l) = 1
+	test_stdout_line_count = 1 git rev-list HEAD --max-count=1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -n1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -n 1
 '
 
 test_expect_success '--skip' '
-    test $(git rev-list HEAD --skip=0 | wc -l) = 5 &&
-    test $(git rev-list HEAD --skip=3 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=5 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=10 | wc -l) = 0
+	test_stdout_line_count = 5 git rev-list HEAD --skip=0 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=5 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=10
 '
 
 test_expect_success '--skip --max-count' '
-    test $(git rev-list HEAD --skip=0 --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=0 --max-count=10 | wc -l) = 5 &&
-    test $(git rev-list HEAD --skip=3 --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=3 --max-count=1 | wc -l) = 1 &&
-    test $(git rev-list HEAD --skip=3 --max-count=2 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=3 --max-count=10 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=5 --max-count=10 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=10 --max-count=10 | wc -l) = 0
+	test_stdout_line_count = 0 git rev-list HEAD --skip=0 --max-count=0 &&
+	test_stdout_line_count = 5 git rev-list HEAD --skip=0 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=3 --max-count=0 &&
+	test_stdout_line_count = 1 git rev-list HEAD --skip=3 --max-count=1 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 --max-count=2 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=5 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=10 --max-count=10
 '
 
 test_done
-- 
2.35.1.1242.gfeba0eae32b

