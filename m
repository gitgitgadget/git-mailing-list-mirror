Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3598FC6FA86
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiI1KC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiI1KC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B9E3EF5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 03:01:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2030389wmr.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7BIA39oYEMTuhj/f/4Xm5zrkA8krf1MVYEh1uz1XDDs=;
        b=WTGz3jzu3rnbWFU0yPpT3g3bgDfMuBoUwdSJNSASJE2BvuR0SLhkhTyUP/pFidcT+n
         o3MgMem9evoVk+u/AlZh+F8f0QGdC0lYzommDmR4cMxEhrxf00oLozDVMwIskaKgAS41
         6FeqBLtLaf7Ai0tgk2GLjY4IqzI/NLODNnk8BMy8xP32FM+3N6Oksy3tHCpSL+6Ypuxi
         boqfnwYBNg+WqtHN40Eazy9pj0H9ntMdoPKyIkrHgyUgSRkxjYy0O3fvIACVqt1+vFkZ
         A46dIRn8mZqzqGkBFTs8x8LIVLGFX5GnQ3UGHewjkIgZhBmkOHs9vf4xsuTfoyiGRvoO
         hixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7BIA39oYEMTuhj/f/4Xm5zrkA8krf1MVYEh1uz1XDDs=;
        b=Lz/r1eT5rIrLhigoAmbCO7Nz1Zib4b8nzxRkoTTU3ShxzMvDL5ckpIcnEyLDrv7PkY
         /4dmtkSbpIogjNarE2KZdb9bl8ogcuvFDvEy6TF6Pnio8YUVFjKcH2uaW51A5KB/ZjRM
         lNJg6Wxfg24bf3f4Z29z7mTmMX350NmV/escaL5lG/hKbbalh66F2HZDyDT4ITvxOHHl
         aN38zaMNdVEuebmCQmxAuCegxcK4VKYonen5guwaRZdmaUxMg4EL0m+kcvBcc014O2Mx
         4o8Rpap2mHBOi8OcjAZlgMl5xIxNc7Hm0SOvhwiP/sn4obN4c0QYhGlbUKkWdpe8RXOj
         zXcw==
X-Gm-Message-State: ACrzQf2pQUYRFEE/Qp665dTZtIgACDNJk2Bcs3E49pJb85T6DAhr3+6M
        aybf8Qc8k80baXZY/ajZ+0h72xl1A6cm5Q==
X-Google-Smtp-Source: AMsMyM6tZC2BseYW1f3OhEP/69foy1AqWWplZPN40f+EBP2jsMJg1DkFAhG3YgRkaDcENEnLxYdmIg==
X-Received: by 2002:a1c:541d:0:b0:3b4:b691:d4ff with SMTP id i29-20020a1c541d000000b003b4b691d4ffmr5825640wmb.56.1664359317229;
        Wed, 28 Sep 2022 03:01:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4-20020adfe684000000b0022ae0965a8asm3818174wrm.24.2022.09.28.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:01:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
Date:   Wed, 28 Sep 2022 12:01:54 +0200
Message-Id: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 131b94a10a7 (test-lib.sh: Use GLIBC_TUNABLES instead of
MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04) compiling with
SANITIZE=leak has missed reporting some leaks. The old MALLOC_CHECK
method used before glibc 2.34 seems to have been (mostly?) compatible
with it, but after 131b94a10a7 e.g. running:

	TEST_NO_MALLOC_CHECK=1 make SANITIZE=leak test T=t6437-submodule-merge.sh

Would report a leak in builtin/commit.c, but this would not:

	TEST_NO_MALLOC_CHECK= make SANITIZE=leak test T=t6437-submodule-merge.sh

Since the interaction is clearly breaking the SANITIZE=leak mode,
let's mark them as explicitly incompatible.

A related regression for SANITIZE=address was fixed in
067109a5e7d (tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK,
2022-04-09).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: I think this is worth considering for v2.38.0. We've had this
check since v2.36.0

But 2.34 just recently got migrated to Debian testing (just a few days
ago), I suspect other distros are either upgrading to it now, or will
soon: https://tracker.debian.org/pkg/glibc;

When I upgraded to it I discovered that all of our tests pass with
SANITIZE=leak, i.e. unless TEST_NO_MALLOC_CHECK=1 is provided we
completely disable the LeakSanitizer in favor of glibc.

 t/test-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65df2fd220..02f438d47ec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -563,8 +563,10 @@ case $GIT_TEST_FSYNC in
 esac
 
 # Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
-# the test with valgrind and have not compiled with SANITIZE=address.
+# the test with valgrind and have not compiled with conflict SANITIZE
+# options.
 if test -n "$valgrind" ||
+   test -n "$SANITIZE_LEAK" ||
    test -n "$SANITIZE_ADDRESS" ||
    test -n "$TEST_NO_MALLOC_CHECK"
 then
-- 
2.38.0.rc1.925.gb61c5ccd7da

