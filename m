Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F218C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B39610FB
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbhJFJwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbhJFJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC17C061760
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so7523100edc.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGwtl8OFt96Q0FRWHyxdUAx2la0Y0Hu6MF14NqBZskI=;
        b=eYSysEjiGgL7Qnh5oIvLAlrGh4TalkIdYHvRm/I1Dpv7cVJhujkmgf1OT9tVwQ+31W
         qNzjm4eHPtb9TLNYf6atrlyLFbEP2D1HOC3ADS+egW7wHj6nbLwixsCis/oaGqk0GUT8
         ohc67Z5LYaN8im7NEoEV2vNa2a3ndS9eZ2vj2M54e0ZCu92rJT5LNuejU8twPsTrzYdi
         tU0ly9jJZ1NfLMSaq35dUxRHC1zYKN04MnStTm7cvolwJvHR+oTHKMQ8ep3Dto5B+ZKt
         SFxs2dZJ6oLiZq7eRYsa3Ba+ts7bgXbsntYZrK8OjUQPtPMmKjm9aHep+iNj2/FQ+C45
         IzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGwtl8OFt96Q0FRWHyxdUAx2la0Y0Hu6MF14NqBZskI=;
        b=BWlcTl6UfdBBwVDT0xgu/BfUFJ7XdwsYsVaRgjf+ZF3dIlU8Cia8lXzoZH4a+1Dpjd
         65S6Q3DifoHjGCzPf3Ti27eNAjfsn+rSa51ykIXd/IiGynEQOvDTk6OrbCtFuXeD1R48
         OHjK5wmRsDHVqbIlnbIZeJVTDX0fbFVOLUBb9kKB6Re8MuUd7nJwwQc4AwLl4XSoJPfm
         6NbWope07F3FoD/Itwz/ZQStNa4Z0uPtnj4PeSBmAt/s+GNNL26B77Z4ebBqUVea8WU3
         2BPD/9lX2KuXofA8xEZN0KiMibWxRo2G0yhUT23ntdX4wHoGG2Ta/P+jyMBqxsp3jJ+P
         bsgw==
X-Gm-Message-State: AOAM530Gv/5ocKPSfP1tCM3L/FCrur/mtkY77vteLudpaFCWPpUcDM7q
        UfoSEYH173P8kzFu2GbWZlyHTo9aPJNpUQ==
X-Google-Smtp-Source: ABdhPJyWKCi/mAltDUvyhqEAgcm4MtavqjU/ceW3eCj1nQkSlxQmd8VC8Ma5UUL0CylsDP8IsD8A3w==
X-Received: by 2002:a05:6402:2345:: with SMTP id r5mr23216477eda.202.1633513843798;
        Wed, 06 Oct 2021 02:50:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] leak tests: mark all checkout-index tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:33 +0200
Message-Id: <patch-06.10-7ab1583c77d-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*{checkout,switch}*" as passing when git is
compiled with SANITIZE=leak. They'll now be whitelisted as running
under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
"linux-leaks" CI target).

Unfortunately almost all of those tests fail when compiled with
SANITIZE=leak, these only pass because they run "checkout-index", not
the main "checkout" command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2002-checkout-cache-u.sh             | 1 +
 t/t2003-checkout-cache-mkdir.sh         | 1 +
 t/t2004-checkout-cache-temp.sh          | 1 +
 t/t2005-checkout-index-symlinks.sh      | 1 +
 t/t2081-parallel-checkout-collisions.sh | 1 +
 5 files changed, 5 insertions(+)

diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index 70361c806e1..fc95cf90485 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index -u test.
 With -u flag, git checkout-index internally runs the equivalent of
 git update-index --refresh on the checked out entry.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf6750..f0fd441d810 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -10,6 +10,7 @@ also verifies that such leading path may contain symlinks, unlike
 the GIT controlled paths.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index a9352b08a8b..9bb503a9757 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index --temp test.
 With --temp flag, git checkout-index writes to temporary merge files
 rather than the tracked path.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 9fa56104743..112682a45a1 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index on filesystem w/o symlinks test.
 This tests that git checkout-index creates a symbolic link as a plain
 file if core.symlinks is false.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index f6fcfc0c1e4..6acdb89d12b 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -11,6 +11,7 @@ The tests in this file exercise parallel checkout's collision detection code in
 both these mechanics.
 "
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
-- 
2.33.0.1441.gbbcdb4c3c66

