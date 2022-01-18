Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF32C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbiARPzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiARPze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D9C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c2so23130466wml.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agf5irCqbwactz4W2Ijf8GjmALs7sGe7+n69YR7sr3k=;
        b=cikItxXFKyx8bU/PsAqoxaw+obGPhLn5spaZX5XSd30z1qQHy6dQGR6Zueh9ujKwDP
         Oy/fqlUxVZSffgInlrcpeYVIau+L010gJuSGZd6gTZeA4aRW7Qbm2xIsPdpUQKfWcoLM
         uzeCW2JAbFrApuKTGUO3GKx5tylSVfaWo+EquEnoMFfm29iQZJlTzx4XR95SXrz7z9BS
         1IuSkMYz/7xiqvILbD0ZJ3lutXqxyU2zU0w7RKuRr3YedTTfVS1lrNGLA5ERmoIkS53m
         QztyfGWfVkgs3CQvh3C/9D0YFv3p5B5nFysuk2RVh8zU3XM27qf/VGwvpX5QR4HU4dHL
         qrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agf5irCqbwactz4W2Ijf8GjmALs7sGe7+n69YR7sr3k=;
        b=0DkamLF94g6UybpUeVJA/J53mhvYz5wj/+UeXSc6sjq37fB98gMeeEb6d3saBbbTGO
         dLEOHv2ejbLz1pp+yVNqLynZZxAaz/HW8ZTmdI62P5k8qN4A+VqJr7hrwdbD9+txUX1g
         hPGyS1BYK93AIgVp6i4eaF4u0yMx6+IocXugdn6wO7Ox4J8fm6lRHFJ2UMFd58xZlkQS
         RAjO42ZpHAZFqfpB2fiSLlb60ywaruCLyt6QnH0S9WgrAH/qAcrOaGR+MTLPosexxLqa
         50GREBlo/GtErZvgQ4Oi79/ivi7UquCx4g77k6lVx5WF7K6uWujfM4zKKAYn2/Ojp2Vt
         bbtg==
X-Gm-Message-State: AOAM53249AyyOiZleFJBtIKmn1ednID+cq+ENsirpnlpbf0mu2e1JaM2
        nDa8Oaugup+5SI5DKxw9vEt/8h7Owyo/wQ==
X-Google-Smtp-Source: ABdhPJwVaUeiHg9uoxX29h7J/jAiIRIYud1fCvBwULxoZ8KwbaXxLW5kn18MhedV8rjVSb6mGkb22Q==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr32939996wml.49.1642521332008;
        Tue, 18 Jan 2022 07:55:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 03/10] grep tests: add missing "grep.patternType" config tests
Date:   Tue, 18 Jan 2022 16:55:15 +0100
Message-Id: <patch-v8-03.10-59092169e55-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
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
2.35.0.rc1.864.g57621b115b6

