Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D1C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiCBR2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiCBR2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095D19296
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d3so3933455wrf.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yx3evGD/q3dgk3YDgp0Rul5ulb3tmOHQeafKXYN6nNE=;
        b=P0vf4gDBuNDmZ1sHF1wIr1hyY5dD0SmmNhncUC9n3XlNTFDJsWn3ZDz3kFkx6jFjMJ
         vymfSDsavLlUCygqr8dk3f9CJLd6KwHQaBNpQi1iu7us1t8VA86kRcvpk5rESXjfs597
         LNNy7sg8oTdxmcI4Kk6KQTeGbaqNVow6kWDEy5c3SMiPU2RCD9aCaMfdMV3Qd4Vi5bRU
         rOZg3UfuwMVu3TScNbTDA0WaPdWZL+UfBtJXVS460x/5zNCj1xIC0j38+JfGrmXHCA8u
         dVgjE4d9c/1cXlvdMf8xpTEx0piYh/3bnz5Rmtuw8CoLktyjr07qPZS0hPiFT9XGakK1
         p7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yx3evGD/q3dgk3YDgp0Rul5ulb3tmOHQeafKXYN6nNE=;
        b=DimqNPKyoRIuDm6Fq5C51WqhbgO2+fEONIXC36j+zVlUnInOkUqRxokww2jrQe3ewx
         gLqTmX+FaDKYIUDbavoY+eGzPTG81CEPGbjTvjimIaumrHjHVpwoQeF5RJ6hwgRGMUVw
         hMkklnVHT4yAvBktnLN1avEZiEi3ANBP9zVPzmFAlVlULlfbBKtwfXYJ6q+8fU9ZBM+B
         LLbskJVQexJ/qEawxhtU5eTWyb48uTZx70EYSZw0303WJfoGV5lkB1w9rmsOZdFjiq7Z
         evIJa/OnXYu8SnPF7YVbq0d4kd5tcx8+9DDseDkRtwBNElSgM+k0m+F4trMtbzSH//sl
         mQbQ==
X-Gm-Message-State: AOAM532TXwy5yfoMfHhsrvDpewJ9clC9xti6Vrst/ChlhOLwkEQTTzH7
        SDEPw6IFGHKAmTMUDxeLyMpfUPLGQuF6yg==
X-Google-Smtp-Source: ABdhPJyUci1Xkt9qt9lHudfUWP3b65+yoBgKaBzKiAKNNG6wTqEJaqYVKAocpb6x1XjfH5nFWWg8gA==
X-Received: by 2002:adf:c047:0:b0:1f0:1192:669a with SMTP id c7-20020adfc047000000b001f01192669amr6498841wrf.627.1646242062150;
        Wed, 02 Mar 2022 09:27:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/15] checkout tests: don't ignore "git <cmd>" exit code
Date:   Wed,  2 Mar 2022 18:27:23 +0100
Message-Id: <patch-14.15-34cada14fec-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile pattern introduced in 696acf45f96 (checkout:
implement "-" abbreviation, add docs and tests, 2009-01-17) to check
the exit code of both "git symbolic-ref" and "git rev-parse".

Without this change this test will become flaky e.g. under
SANITIZE=leak if some (but not all) memory leaks revealed by these
commands are fixed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2012-checkout-last.sh | 51 +++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 42601d5a310..1f6c4ed0428 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -21,14 +21,20 @@ test_expect_success 'first branch switch' '
 	git checkout other
 '
 
+test_cmp_symbolic_HEAD_ref () {
+	echo refs/heads/"$1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success '"checkout -" switches back' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" switches forth' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+	test_cmp_symbolic_HEAD_ref other
 '
 
 test_expect_success 'detach HEAD' '
@@ -37,12 +43,16 @@ test_expect_success 'detach HEAD' '
 
 test_expect_success '"checkout -" attaches again' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+	test_cmp_symbolic_HEAD_ref other
 '
 
 test_expect_success '"checkout -" detaches again' '
 	git checkout - &&
-	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
+
+	git rev-parse other >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
 	test_must_fail git symbolic-ref HEAD
 '
 
@@ -63,31 +73,31 @@ more_switches () {
 test_expect_success 'switch to the last' '
 	more_switches &&
 	git checkout @{-1} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch2"
+	test_cmp_symbolic_HEAD_ref branch2
 '
 
 test_expect_success 'switch to second from the last' '
 	more_switches &&
 	git checkout @{-2} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch3"
+	test_cmp_symbolic_HEAD_ref branch3
 '
 
 test_expect_success 'switch to third from the last' '
 	more_switches &&
 	git checkout @{-3} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch4"
+	test_cmp_symbolic_HEAD_ref branch4
 '
 
 test_expect_success 'switch to fourth from the last' '
 	more_switches &&
 	git checkout @{-4} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch5"
+	test_cmp_symbolic_HEAD_ref branch5
 '
 
 test_expect_success 'switch to twelfth from the last' '
 	more_switches &&
 	git checkout @{-12} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch13"
+	test_cmp_symbolic_HEAD_ref branch13
 '
 
 test_expect_success 'merge base test setup' '
@@ -98,19 +108,28 @@ test_expect_success 'merge base test setup' '
 test_expect_success 'another...main' '
 	git checkout another &&
 	git checkout another...main &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '...main' '
 	git checkout another &&
 	git checkout ...main &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'main...' '
 	git checkout another &&
 	git checkout main... &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '"checkout -" works after a rebase A' '
@@ -118,7 +137,7 @@ test_expect_success '"checkout -" works after a rebase A' '
 	git checkout other &&
 	git rebase main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase A B' '
@@ -127,7 +146,7 @@ test_expect_success '"checkout -" works after a rebase A B' '
 	git checkout other &&
 	git rebase main moodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase -i A' '
@@ -135,7 +154,7 @@ test_expect_success '"checkout -" works after a rebase -i A' '
 	git checkout other &&
 	git rebase -i main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase -i A B' '
@@ -144,7 +163,7 @@ test_expect_success '"checkout -" works after a rebase -i A B' '
 	git checkout other &&
 	git rebase main foodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_done
-- 
2.35.1.1226.g8b497615d32

