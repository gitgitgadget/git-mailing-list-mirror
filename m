Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9620C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbhLVC7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbhLVC7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:59:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81983C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r17so1856994wrc.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4gXma/8cAPxQp7flO4XHKVGbDGmiA3qObLzIdSU6Lo=;
        b=WJMNMlsiZ2eKF5+QSpVNUmUXXxz3pQOChjPIMMtRaRe3YIUeqHgIQKNTS0ddKsGx1r
         auQKEOtUnvPh8SFtNcu5dzm2LraONSoKudFJ8Aptsq/bx5RmLn05cJ6K5LDvmHhHNA58
         x9bGzoCYwlLN1gVFBHQZM0A4/X6XL8dh82Gz8RgIoCCWWc/rTL50dJAoNVhUcNuKH9J3
         h5Rdiw9mmJ0U3gxLktCD/z6+b24o6zZzzdMEyQkqHeKP0Z8cN60IfUcO/RSGpK8hw0Fq
         u8+VoyBcP23AE+WrUfNbzDDNE67M9N3XuGmxoZChbQLNG7zIFbjbdxRgg7irRHkGCERE
         ashg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4gXma/8cAPxQp7flO4XHKVGbDGmiA3qObLzIdSU6Lo=;
        b=BAsurjdepicIovvxCP3TVG6Mki38/8WpuM/bt0or6OXWvXYBjx1AS9p9KsFBwjWWpN
         RHMtPoSts62DWBV5K4d9lAIdUQ5n87/W0dL1Rhoivv0ULxSQaacXxCokttWPgmhnfef8
         fidsvw7/CgScu+AOQiaXwYVmiybPDpHqv4tCbSI5zfL205YdK6MICaNs4hVBYGxp3gNj
         tZRZ44WJRr92vpCFL6hF+oLTVjQeqotvgAjHecwabeWXRHuWBSuKXn1qaKfH28zUGiRW
         2gRY6cUnbSyGKy37UnwtqSZudQ+o7GEanHVrAfF9P4+9EhktZ2xJmfKODGY96M0bcV8U
         8m6w==
X-Gm-Message-State: AOAM533wvxJ2A0E9rA9R4hJHklARc7NPYlEOw9bSCCzO8bIu436yPDzO
        G8vZy8S3IRoIJYD5CtGjR90pOLIiMXOPFA==
X-Google-Smtp-Source: ABdhPJxojldgZpIjMvR2ib6gWL1GQExr+b1HW7vg8M/5pyjSMCyge2Lpq0TWTQES6NJgAhVpkp2C5w==
X-Received: by 2002:adf:c7d2:: with SMTP id y18mr588874wrg.717.1640141943946;
        Tue, 21 Dec 2021 18:59:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm611577wru.66.2021.12.21.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:59:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/7] grep tests: add missing "grep.patternType" config test
Date:   Wed, 22 Dec 2021 03:58:53 +0100
Message-Id: <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com> <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
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
prevail.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..113902c3bda 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,25 @@ do
 		test_cmp expected actual
 	'
 
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
-- 
2.34.1.1146.gb52885e7c44

