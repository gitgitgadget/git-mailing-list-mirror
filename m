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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B1C4360C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEDA23121
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437101AbhALVh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436883AbhALUTm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED5C0617B9
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t16so3865690wra.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4Ume2w83CGfLz5W95CZmWjd4oB3YWF7eatdtPXwYK4=;
        b=IA194zY+dLGA8iN9j3YaU6Z0EiiYlW8W1OpzakBlaZ1T/LlmoNBsyoW5O91jt4MHbl
         6nfEGB+htrqXI/TbJ5oBYriRMmUCBk/uWTHvNtr6LI1iTH6VD5G2hPPHNjQ2tX70MGy0
         sR+1mOnRbjWf/QSpUg9CpGYGdWc4SW6iLIEj6BF0C6CsxxDVyfxl1sEIxP+YYjZYUsUl
         f7YuUQqkRJM4dhVMwao7OCcBPS9bQ8TSeV4sF6NLpMs5VckeksenZegbTOJJY1tz0znZ
         tZVh+v81CbI+xGImyvMf0SiUn5oj1BF9Hp4gNIzjJr17HS9xvK8oSo0aIa4M3rfGXGyo
         UG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4Ume2w83CGfLz5W95CZmWjd4oB3YWF7eatdtPXwYK4=;
        b=cCAnx5J2tKuKFaa+xk2KWThFFJmtX0YY1d/J4GD/6CYDx5twaY9GXuGX613HVnxLOz
         dtaWiaxwPpyffarIp8FgD+qvQlJLNsOYR+H5rr1MKMhDAomxHMcDK2Zapmo0BGoVP62f
         tNu2d2HmV7B8nzgp7j8QJ7VLfoETjq4YWhDDn/vKO316f7aqNxjzRRuV1j5/huDBtC+J
         xh+91/eQuByPldkSb5JsDma+8wjv/OCPjqRHu2cew23iWVUyqnFJU+SdpPnFr2/TdAEL
         7klITYZ/Mhymb4oSyIyEosnoW/Z73jWhhf7bnWGtsFPa2Q0Ny1Fy1E7XHpz6w0TFu0zG
         7DZw==
X-Gm-Message-State: AOAM531POdFpbVHqFH0R+GR9J12y/6QLv7kdb/Ky7JGMPXos5hVxGvc4
        4FdJ/DATzXMbdiEc5g/kob5bGpfMR4VMEw==
X-Google-Smtp-Source: ABdhPJz20RqqXOiERgJuFcsY65Fu0DE+Hcs1kFtiJDxiHsFb/xmYibHE6c8kD/DuiadAz01AjoaGIA==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr587743wra.68.1610482721711;
        Tue, 12 Jan 2021 12:18:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/22] tests: refactor a few tests to use "test_commit --append"
Date:   Tue, 12 Jan 2021 21:18:00 +0100
Message-Id: <20210112201806.13284-17-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a few more tests to use the new "--append" option to
"test_commit". I added it for use in the mailmap tests, but this
demonstrates how useful it is in general.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1412-reflog-loop.sh   |  7 ++-----
 t/t2012-checkout-last.sh | 12 +++---------
 t/t7810-grep.sh          | 18 +++---------------
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 3acd895afb..977603f7f1 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -4,11 +4,8 @@ test_description='reflog walk shows repeated commits again'
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
-	test_tick &&
-	echo content >file && git add file && git commit -m one &&
-	git tag one &&
-	echo content >>file && git add file && git commit -m two &&
-	git tag two
+	test_commit one file content &&
+	test_commit --append two file content
 '
 
 test_expect_success 'setup reflog with alternating commits' '
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index e7ba8c505f..c95aa3e78f 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -5,13 +5,9 @@ test_description='checkout can switch to last branch and merge base'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	echo hello >world &&
-	git add world &&
-	git commit -m initial &&
+	test_commit initial world hello &&
 	git branch other &&
-	echo "hello again" >>world &&
-	git add world &&
-	git commit -m second
+	test_commit --append second world "hello again"
 '
 
 test_expect_success '"checkout -" does not work initially' '
@@ -93,9 +89,7 @@ test_expect_success 'switch to twelfth from the last' '
 
 test_expect_success 'merge base test setup' '
 	git checkout -b another other &&
-	echo "hello again" >>world &&
-	git add world &&
-	git commit -m third
+	test_commit --append third world "hello again"
 '
 
 test_expect_success 'another...master' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 991d5bd9c0..312e0f8cb4 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -687,21 +687,9 @@ test_expect_success 'grep -C1 hunk mark between files' '
 '
 
 test_expect_success 'log grep setup' '
-	echo a >>file &&
-	test_tick &&
-	GIT_AUTHOR_NAME="With * Asterisk" \
-	GIT_AUTHOR_EMAIL="xyzzy@frotz.com" \
-	git commit -a -m "second" &&
-
-	echo a >>file &&
-	test_tick &&
-	git commit -a -m "third" &&
-
-	echo a >>file &&
-	test_tick &&
-	GIT_AUTHOR_NAME="Night Fall" \
-	GIT_AUTHOR_EMAIL="nitfol@frobozz.com" \
-	git commit -a -m "fourth"
+	test_commit --append --author "With * Asterisk <xyzzy@frotz.com>" second file a &&
+	test_commit --append third file a &&
+	test_commit --append --author "Night Fall <nitfol@frobozz.com>" fourth file a
 '
 
 test_expect_success 'log grep (1)' '
-- 
2.29.2.222.g5d2a92d10f8

