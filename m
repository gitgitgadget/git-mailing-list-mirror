Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34A2C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiA0L4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiA0L4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637AC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so4239049wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kYtJsuwNZDXBXHoC4q0SYmSbcnil5Abb621HU0q04c=;
        b=IV0X2CzqbOzMlTsEFVreYDqvjNIuGUyehZEEy4sxScMarLjL9wbMhUpbwalKaakWPD
         BWGIQT/a2fNsdDU/g4Rf4ecKY81PxbETFc2jNeFjrFrxkF/+geB4ZqlntpKYtjG6o1FG
         +ngU4Wi2EMOU1Nq81nzd9TRv+jHq/Eu3YHFcKxxqDNIwGnSEQ73Pr44cxHcccP3lfw4U
         spOq5KEXTNyYmtpHRAEddiqwP8E3C3YapUiLQ+Kx9z9sxPoUYlI/8HbzJIStug7lMGUO
         aqmf5smgi0WsW32md/dO3lLVfFYKZ7dy1oDzqDzybSwsL6QlkhQj7vaqt1JO6FGkWFpo
         FSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kYtJsuwNZDXBXHoC4q0SYmSbcnil5Abb621HU0q04c=;
        b=KkybBeRAgtyNKIaV132WV4RSJSMAufrvevXzY5Fp4QkV5F9ysUobSYISVEylPZoOHs
         XRpSrz/PQWsbGCmGVjKpZJpvzl2nweFZ0I+VO1nhR1Xv7gm86eHtszx6kqUk90VGbGOc
         pfuDlPovF7h36uoyHZxodtAR535Mok1KO6yN3P3f/bG9kmoGdi2iNBSGgUOjwb9L8ZY8
         jhp9Zk9dVJet6GHo4cRwvkw+/xLrqZM8ND1VjZpbkDnGtlqCrAjixuFcPI+jA7F8NjZk
         yypax3yrjRPIKAdTDE8jMiC5MmFw4nqKvaqfuyRRMqDSsqlVR4rIBe6QngoPu52aUKfb
         zmAw==
X-Gm-Message-State: AOAM533EEk+kqBmkf3cX9zskbN7QrPNPB/DxsuAKUCqgTs6DxdSjvqPH
        qWtR0RrbrQUCfEJB6tcYtu5Noh0DP7woOA==
X-Google-Smtp-Source: ABdhPJznUUu7sCN+ZDxcwfgZ8yzw+AEiip5T4Ii2CXb5t1tICJgwgRCoejEZVCDxiA1wnA1p+OD8lg==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr2799329wrv.715.1643284597897;
        Thu, 27 Jan 2022 03:56:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 3/9] grep tests: add missing "grep.patternType" config tests
Date:   Thu, 27 Jan 2022 12:56:25 +0100
Message-Id: <patch-v9-3.9-a75b288340b-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
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
index 424c31c3287..34d8f69c1de 100755
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
2.35.0.894.g563b84683b9

