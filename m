Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBFC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhL1BH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhL1BHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D34C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s1so35296766wrg.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaBfzdFgbIGYfqAHshh2MaMbazHVXFkbV5gMyEnC+uQ=;
        b=cDcpR5Sfh0O/kAwzw//hc+Y3BaVOqCw6UKnSPuwVS/bB5FpL0fcmzfWel+A0aROgZu
         Ux3Tn9pUUgT6pfnrnUT7TSDIvLlu2UYstPaACVPezdipLVy7OyTVaJL3SQuYgr7+sEla
         ytjtwCpV6BKxRhFUAh2gENhLQ+YA/xYTn5vIOKpiCzavy6D72kCBDK9ivFHSxnHa2kc1
         HZNBRE94QizFKvcPB0/Y9SesGH//jeeDqvbYxd8XaqChqAVypLD2k+Slg1Q+87thXaSz
         ZsUIzSmRWk/UT55d7rG9pMRz2wIqdCgdK/1t5X9j3zFEUvmGGPq/zDlx5hyDmDTVMLCh
         gmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaBfzdFgbIGYfqAHshh2MaMbazHVXFkbV5gMyEnC+uQ=;
        b=qp8c9/I8j6yil5U6nv5zsSkWehqc2M5oBiqmXIx6BiGZ2nSjVBx2LpgRK8nZ0OFd87
         L5PBh60jXF3wkOHeamiNceImXpbf3yJLac6MN/YjloVXobz1Nf7KkYmc7XUIIqBwu9wy
         JXijIRYtLpZrI3ghh4hFVe/pQ+h8E45NKxf+1DrqsWBB7Vo8qgN0JVY7L6jRXmrk3TYi
         2FAelTv7gCDGeKm4HUI/R88qviNA8KmTbo+/4qFE6SVKmzUyFlDF6GFkV20ChCAtDPgf
         Uq8DlTtOLE0/6QNg3mCNAy+nsrYkKPOxCek4ab+dRHtArxCWVCOK2DrJVbTMXo3tKmst
         05Pw==
X-Gm-Message-State: AOAM531SwFJ/xHPbUiTrwM/8u8PM3ChmlLAh+FxAtyzr16wdi0Ke8Z6T
        Pwrksp6PBWUEKl7lYsjE1zcIVzgVGxnxITD5
X-Google-Smtp-Source: ABdhPJztY14HBkKtMH/52t7uE95x7ub3SlCzVhtJbGQVc4akySMgcgv5BiWRTKJvr0z4MR74H9G9qg==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr14627981wro.88.1640653670141;
        Mon, 27 Dec 2021 17:07:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 03/10] grep tests: add missing "grep.patternType" config tests
Date:   Tue, 28 Dec 2021 02:07:38 +0100
Message-Id: <patch-v7-03.10-e1b4b5b77e0-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the grep tests to assert that setting
"grep.patternType=extended" followed by "grep.patternType=default"
will behave as if "--basic-regexp" was provided, and not as
"--extended-regexp". In a subsequent commit we'll need to treat
"grep.patternType=default" as a special-case, but let's make sure we
ignore it if it's being set to "default" following an earlier
non-"default" "grep.patternType" setting.

Let's also test what happens when we have a sequence of "extended"
followed by "default" and "fixed". In that case the "fixed" should
prevail, as well as tests to check that a "grep.extendedRegexp=true"
followed by a "grep.extendedRegexp=false" behaves as though
"grep.extendedRegexp" wasn't provided.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7810-grep.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..dce653d749d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,65 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=basic \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins & defers to grep.patternType" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=extended \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.patternType=fixed \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=basic \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=[extended -> default -> fixed]" '
+		echo "${HC}ab:a+b*c" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			-c grep.patternType=fixed \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
 		echo "${HC}ab:abc" >expected &&
 		git \
@@ -478,6 +537,15 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp=false and grep.patternType=default" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.patternType=extended \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=basic" '
 		echo "${HC}ab:a+bc" >expected &&
 		git \
-- 
2.34.1.1250.g6a242c1e9ad

