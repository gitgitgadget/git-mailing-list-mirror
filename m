Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiCYTfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiCYTfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69393280C07
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4982431wme.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+LzLtJnw8U7+9CW8Ia8wPvelcL8menWKNrscQreQWU=;
        b=no4e6Iywa89+nSxMLmjbtIGaJFEv08V0OZoSZAv66Y+uG+L4FIO/0vb5YF4W3Hi1Kx
         cwiuzJ/Pg1JdKU7gbzvQMW5WB/YP1hLQVbkw6O3LRwCaudIcPfUGrE9bCKJMbeEor07V
         bAp0/TVXJOSgGRqVQE+Af5VRLs22l7lc6VyyRfuGBjTgsXj3lbZJqHk6nzAsGU6U6N4t
         xIQbWQxeMn2QQTI+I/t/3+huTFfFDP/b/7iyjznZIJKT4lkjyJzT4VGzKxYR1xyR+4w6
         5kxc/lY3TddXihqrHl428h1ovhZsWn/CAAGlASSuPbIdfH/4wUsyaS2kpD4C7ySo84vE
         NMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+LzLtJnw8U7+9CW8Ia8wPvelcL8menWKNrscQreQWU=;
        b=VLTpyRGDCoRmX/4Ivi7oRbGNXNpomtwS6cwe/N3WqVPw/2PF4ant7v03nofF3Tws6Q
         2eSY7x/GAZSSIXQ+HOtWVCcROC59bLnHYIwsTHJvfUx/MTIx3hb8RQm/n5ar0AnW8jC2
         pjaUl3ZFMFcUC37dLeEeszi2ZOTGk6juV0wtX2yF9ZWJRVjfZXVaNeqxcbXdSFEBpx1A
         eY4HE4rQV8ItP+g8RtJRPVExmNgIwRoq4xUH6i11HFhBjMqRRHMY8iFB9Nl2KA5zP6on
         KPFOQK28MhpvdxLKP+EmgFP4Ec4ODQoiQZsDAZmrW0zhqtlBmjByFIoVX99MctVqFyE+
         tXdA==
X-Gm-Message-State: AOAM530POLQAXIGyihD//oaewxj4M514a3ZzWKrhMbknZ0A+dCyhxU91
        u0a0uSsuNxZ3D8mGhP4Dank+pX3/12QQKg==
X-Google-Smtp-Source: ABdhPJyKNt1ZZ6DIK1fpuU8c80b5dc7KMNOUDvKilHYNBqCM5lkDQxS1jtO2TdXLN1qq6vB+IRVm/g==
X-Received: by 2002:a05:600c:4e92:b0:38c:73e8:7dcd with SMTP id f18-20020a05600c4e9200b0038c73e87dcdmr11807978wmq.196.1648236262690;
        Fri, 25 Mar 2022 12:24:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 5/6] ci: use `--github-workflow-markup` in the GitHub workflow
Date:   Fri, 25 Mar 2022 20:24:14 +0100
Message-Id: <RFC-patch-v3-5.6-72058db67b0-20220325T183946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

[Ævar: due to re-structuring on top of my series the {begin,end}_group
in CI isn't needed at all to get "group" output for the test
suite. This commit includes the now-squashed "ci/run-build-and-tests:
add some structure to the GitHub workflow output":]

The current output of Git's GitHub workflow can be quite confusing,
especially for contributors new to the project.

To make it more helpful, let's introduce some collapsible grouping.
Initially, readers will see the high-level view of what actually
happened (did the build fail, or the test suite?). To drill down, the
respective group can be expanded.

Note: sadly, workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details),
therefore we take pains to ensure to end any previous group before
starting a new one.

[Ævar: The above comment isn't true anymore, as that limitation has
been removed by basing this on my patches to run "make" and "make
test" directly from the top-level of main.yml.

Those are now effectively their own "group", effectively giving this
stage another group "level" to use. This means that the equivalent of
"make test" won't be on the same level as an individual test failure.

We no longer take any pains to ensure balanced group output as a
result (which was a caveat the previous ci/lib.sh implementation had
to deal with., We just need to "cat" the generated *.markup]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                        | 2 +-
 ci/print-test-failures-github.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 304380958bd..f84bac0fd36 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -74,7 +74,7 @@ MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 case "$CI_TYPE" in
 github-actions)
 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
-	GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
diff --git a/ci/print-test-failures-github.sh b/ci/print-test-failures-github.sh
index 218aaf19763..e432a601621 100755
--- a/ci/print-test-failures-github.sh
+++ b/ci/print-test-failures-github.sh
@@ -17,7 +17,7 @@ github-actions)
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			cat "t/test-results/$test_name.out"
+			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-- 
2.35.1.1517.g20a06c426a7

