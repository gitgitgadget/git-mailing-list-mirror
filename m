Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B9CC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFUWVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFUWVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:21:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95F3135C
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i10so17060501wrc.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LivxJKOMR5lXnXI0qAnfvuf3k2o55hfJt+zsuEMHb5k=;
        b=TA3QdYfhKtXv+GrRfCE9vGPH6QYub2ZVmPQSfqRXpMeo8NYuse04nx7i979XGnwKPa
         DPC/9Mb2sO/+/vKPpc8wJ5xsq3K7I5R5XcLM8yg2r6nsIM1ZSK/rTr7FSXQjPgGqCUJS
         kK5CXBQDezgk0WpA3Cvb1xpsairSuIYJtCJTE/jN6c8af3KxyVbGyrtiIPstHcCDuKE0
         DTN9HfVJWNGJs74AwLfFRllgiaoXaTGD4X6k8YgYTo93YrKYmcG6/fLcyqKbmVvPma45
         rHjXBGnkl7zbCtzL/xV/YFZoxzDxds0152pA6aiInNPpNAi2wh2D1Z21WdxEqaHkzX46
         Rj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LivxJKOMR5lXnXI0qAnfvuf3k2o55hfJt+zsuEMHb5k=;
        b=7Oz6TnjeyWL7nk57kZjuq1bjKQVSFzIE+9yfbh519DKEmabThqmo7sSxh9DLFuU0GO
         VAIi51NvBUnK/b6SUfZXQ1oN3Ed7S/o1xF+WnQjUSHand+TvQ8LqfHijUkhG8AicGEh/
         KmJr9vulpmZCps9PCDBVwnzrxAhE5cV7WdMcm9TzC5xfHJ5bH0ajcjMRl2r+9XYfqR9f
         dB8nk2LCmxDnctVRsu+jfAXDjoFRP0hJjSs/M+elCoIqX/+FQ+U9KuFksYIB4G1RbQZY
         /vzWrEKaHwoqKEEMIu/d4VdKyrtSBpB1jN4s94L1qUy6RaC1egNx5v5jxEaeTfQ2i1UI
         hpRg==
X-Gm-Message-State: AJIora/W/ViI63IVJlMvANhjcTT00ngFQHR5vUHUKmxnmwADqRRM3Q2K
        oDdrgwWYmIVrFkZAHfgpWlK3Ckbf5y1Knw==
X-Google-Smtp-Source: AGRyM1tgwrIOQPzd5+hfb1XFSjVzCXQNJIZtzATyRcJP9UlAl2Q481z1uJ2cwSTTy5iXRFu8YOif0A==
X-Received: by 2002:a5d:66c3:0:b0:21b:994a:a6fa with SMTP id k3-20020a5d66c3000000b0021b994aa6famr177003wrw.15.1655850103695;
        Tue, 21 Jun 2022 15:21:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0020fe61acd09sm17547431wrr.12.2022.06.21.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:21:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] tests: add missing double quotes to included library paths
Date:   Wed, 22 Jun 2022 00:21:38 +0200
Message-Id: <patch-1.3-05ba5e7f837-20220621T221928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two inclusions added in d42bab442d7 (core.fsyncmethod: tests for
batch mode, 2022-04-04) that needed to be quoted, and the same sort of
issue in a242c150ebb (vimdiff: integrate layout tests in the unit
tests framework ('t' folder), 2022-03-30). Both were first released
with v2.37.0-rc0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3700-add.sh            | 2 +-
 t/t3903-stash.sh          | 2 +-
 t/t7609-mergetool--lib.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 8979c8a5f03..8689b48589c 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -8,7 +8,7 @@ test_description='Test of git add, including the -- option.'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-. $TEST_DIRECTORY/lib-unique-files.sh
+. "$TEST_DIRECTORY"/lib-unique-files.sh
 
 # Test the file mode "$1" of the file "$2" in the index.
 test_mode_in_index () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 20e94881964..2a4c3fd61c0 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. $TEST_DIRECTORY/lib-unique-files.sh
+. "$TEST_DIRECTORY"/lib-unique-files.sh
 
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index d848fe6442b..330d6d603d7 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -7,7 +7,7 @@ Testing basic merge tools options'
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
-	. $GIT_BUILD_DIR/mergetools/vimdiff &&
+	. "$GIT_BUILD_DIR"/mergetools/vimdiff &&
 	run_unit_tests
 '
 
-- 
2.36.1.1239.gfba91521d90

