Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F1BC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiF3KS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiF3KS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1FC44765
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so1397713wmq.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEZFQkOqyYy1MZt3kx43+eLRYUgmjBXl1ASRhBSL+YU=;
        b=MM8CY7WFy9QO6Z1VGcvRx/C2cy1fJcvSMDUgNktnPL3HdjMWn+aueIH14JwKbJ70Na
         G0S/XOhxWSTKjVCZdcuNW6X9DpVgfCBHPq4gVPMU8abBiwgOJ2jHESJ+oYgw5+GcOS9O
         TKInXAg8UU7EibbQezd2CQ/h5Ez9nUs6MhVHMca3xeHPbLVUpxTvvnjPxWuDCBtTQKwF
         lwWEUFMcjTiq4egOIjUusOoWPHsZuU4JAHBG4e9EI36doh2x9spSOGJeOA36TaQo4kxM
         F2tDf96VLNTlcrkNmPwSZ5kfYncE3p1utypeuU48Dcc7tSZzvxXfhAa0vkrIUhxy3sIs
         VFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEZFQkOqyYy1MZt3kx43+eLRYUgmjBXl1ASRhBSL+YU=;
        b=17QkJZLcwGh8sYRVhqUDVJxwKWFLmrIy7D5jgG0DIrWDQ6eUlHLlMdxXKGhIkXwQMT
         7ABFmrUABp0xZ1Njm38mXSZhF23jl0IC5f0O+Y22VAPAN+6D8xDVV+tAAHt+z3eRTZv0
         vizKBWAVUtdNy4yoD2+pqtCyKPHxVvovvt7GyXwlbrvVpqFY5wI7AYgGsdT1IMxDglTY
         Qi7gDRKvPr9//fV88iKi2JMqccpUh0OYTAo1jC44d0VfwkWTISfKVck/RXxA1Pt3ClR8
         2ihLueOsRWI/mt7R+k/c0CX0yrOSqj0oYHwUFwe86qYejbS2Jf9S49ijfewTGkdR6csr
         QUTQ==
X-Gm-Message-State: AJIora9KT46wmsFWb+yIBOfdS+fEnze6mbYqE8gtOk5b65EStt0o7vmU
        lCssBdTGerBXch05ixig6vR5T2oB7LoiBw==
X-Google-Smtp-Source: AGRyM1vpEtcys1iFmIruGTrQgL6DVgvs3e/XA2AWz1aYCA4GAgEhPC+4IZHrCwv1uLj6JBf/0fvtkg==
X-Received: by 2002:a05:600c:4149:b0:3a0:4728:60e7 with SMTP id h9-20020a05600c414900b003a0472860e7mr8981478wmm.10.1656584333923;
        Thu, 30 Jun 2022 03:18:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm5978427wmi.29.2022.06.30.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:18:53 -0700 (PDT)
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
Subject: [PATCH v2 1/3] tests: add missing double quotes to included library paths
Date:   Thu, 30 Jun 2022 12:18:34 +0200
Message-Id: <patch-v2-1.3-f4ef137d076-20220630T101646Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix inclusion errors which would occur if the $TEST_DIRECTORY had $IFS
whitespace in it.

See d42bab442d7 (core.fsyncmethod: tests for batch mode, 2022-04-04)
and a242c150ebb (vimdiff: integrate layout tests in the unit tests
framework ('t' folder), 2022-03-30) for the two relevant commits. Both
were first released with v2.37.0-rc0 (and were also part of v2.37.0).

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
2.37.0.880.gf07d56b18ba

