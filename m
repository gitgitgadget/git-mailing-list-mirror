Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9DC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiCBNXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbiCBNXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE91125
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so2066159wms.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iYHtH6wEucn9NO8wlPK2l0j8Cz3wOFSZ/d+hbUAQoQ=;
        b=j8a0kFN1y9Jyqs3LcpnLuuSXiqooPmNKUyZIbOwb6KbuiZjVvJC1VWDthTSbo56zY0
         WHSkTewTu0mYS1wMlJ0yVp3nyfYo3TXdoiEJok9o8qSvWjgPLmhLkKQHfPog0RQLEW1z
         wvugLeLH8BgXZOpZlhn89eEpbUvy418ieffzm9V6nqkfuq0M3CG7MDsLYhR+vA0yNxZE
         mCylT0rTw686TqoOBD31n0IEsHwSEM4C7mifR664L7EB8OMngpprNqoJYAM0RahPdApT
         TVmgNHMnUlb/MD0IQNE7lx3C+slyQDTwjQ++LWS1GLLjEoiieztdIC3KDebpvtdOCia4
         u1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iYHtH6wEucn9NO8wlPK2l0j8Cz3wOFSZ/d+hbUAQoQ=;
        b=VL+HCbhsF4Qxs+3oLe8jsJPV0cJPrvLGFgSiFYSPfXOLiYCQE2U79wgR/t7vKTFtUQ
         /llEulWAURbyes8WjMWC1Y49E4kRoM3kyJPHIG9m+FxhHkUnQtD+oGvDdoivQ1rNVbET
         ePWPFY1H1/G14qWykRSR2GiYuAVN3vcngp0EaY8JWGFpYa4AuigmvGB6FbVNp3d2CFh4
         CokzcNy433RiGem9Fz5ScLKFR46l/A/iE89bcICMfq1vMvR8O2alva5HMxTqvITYwgfW
         8Rjf9dy/k6+iFb9GFlMtm/ffbuXIq9mTq3VuPaRpm8ZwZyUV1w7YD6D3sjy7G5oZ52hP
         bRMA==
X-Gm-Message-State: AOAM530ZOwclDY6eyEE6hDw4ap1aZuTvTob04GBs+kpBOQfCT+tPJfLG
        LJ7jtjdZrzJhWr0BQchfAH9ae8LHklcxbw==
X-Google-Smtp-Source: ABdhPJxfFnyddAfbttD2ADb4cuuxTkp+kbmymzgZaOFDzaBrY7Em5notLsDVnHw5PzuBAiNSjtuv7Q==
X-Received: by 2002:a7b:c0d8:0:b0:381:3901:ab92 with SMTP id s24-20020a7bc0d8000000b003813901ab92mr19878744wmh.139.1646227355409;
        Wed, 02 Mar 2022 05:22:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] hook tests: turn exit code assertions into a loop
Date:   Wed,  2 Mar 2022 14:22:20 +0100
Message-Id: <patch-01.10-706460d10b9-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) to use a for-loop instead of a copy/pasting the same test
for the four exit codes we test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 29718aa9913..ff64597e959 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -53,31 +53,16 @@ test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 	test_must_be_empty stdout.actual
 '
 
-test_expect_success 'git hook run: exit codes are passed along' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 1
-	EOF
-
-	test_expect_code 1 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 2
-	EOF
-
-	test_expect_code 2 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 128
-	EOF
-
-	test_expect_code 128 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 129
-	EOF
-
-	test_expect_code 129 git hook run test-hook
-'
+for code in 1 2 128 129
+do
+	test_expect_success "git hook run: exit code $code is passed along" '
+		write_script .git/hooks/test-hook <<-EOF &&
+		exit $code
+		EOF
+
+		test_expect_code $code git hook run test-hook
+	'
+done
 
 test_expect_success 'git hook run arg u ments without -- is not allowed' '
 	test_expect_code 129 git hook run test-hook arg u ments
-- 
2.35.1.1228.g56895c6ee86

