Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE5C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiI3LgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiI3Lfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DF13A971
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2097885wmq.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=edcvGnjUys6js1nbNbzF7GCKkVgsa3OR0PiyhxWow6Q=;
        b=Ht6fnQCUpgZCnJiBzI83ICAH8s5dFhqgMfbOYs5lvWYdmnDY4Ay3/4ycE5sp3g0hpL
         Ed0psb+H62l/i0l9u3wgmbatutldh0OYO46whYdKDE193GHtk+WqbOq91CZj2B0+AsS5
         AB9/afvArCptfI2kRbgHid8uPxJM0qX+E5OyT48IeXJewgv4GFh5Dek2EQV7sbu9pDbt
         TkWaur8KA2WCkFRMUpaBTijABbgR8ILoH5vaulMNY6g+ad4X9biRAQAVC7mtuEvypMo4
         gKqTDGDrwVoxQM/WReNVG6y55zRbAsYZ4kcHD2gpu2/TWTC5296IieAqGimFeAPV6TNv
         NfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=edcvGnjUys6js1nbNbzF7GCKkVgsa3OR0PiyhxWow6Q=;
        b=TDjIn63lvUHi0Rcq5HQZN/yJK22dsXNSaZQPgVE+UQfP6GqhtSF5E1RC1Cp2vYPjuA
         cwT+XlIJEFlE7sYqZWQCgTplIfydiJ8ZPuYi1o8WXH+GPHDXsbkPxbGrMKDojjx+DzBO
         hCo0rOVpUEG/ZJ7kXmogDpKbPlLJH/i9b1764ONJz1dKgd0/JCHLVeoiA39viCpSU6p8
         4fexO3+JAvchW1m2uTe7JW59IC4qLYOSt8oXgSY/8l1CfafLbO7FHQWVKfqMeHlXw1tn
         iLoKa98XKRDoVIlJdKFC0c+Ob/0ZEMdYacwtMxMY8V/GhGOhyEmE+7GJ/EnCqNc0bMaD
         P+SQ==
X-Gm-Message-State: ACrzQf0YI7u+IUB/G9lofzXYgszO6g5hKKQDq/VD774yueYGZ6IXWCrx
        4qQ9ko+rqGorrFxaxILcR4YAZ7aanbBOtw==
X-Google-Smtp-Source: AMsMyM4ISydCGPVKWcEeir2/SJncyYdQUVzufkm7GidpTtNqlxLENZHRaFmgl9LTIFxZTHrRKCIOVA==
X-Received: by 2002:a05:600c:5486:b0:3b4:7e47:e19 with SMTP id iv6-20020a05600c548600b003b47e470e19mr5551596wmb.12.1664537299312;
        Fri, 30 Sep 2022 04:28:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/15] run-command tests: test stdout of run_command_parallel()
Date:   Fri, 30 Sep 2022 13:28:00 +0200
Message-Id: <patch-03.15-d8042722e49-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) to test stdout in
addition to stderr.

When the "ungroup" feature was added in fd3aaf53f71 (run-command: add
an "ungroup" option to run_process_parallel(), 2022-06-07) its tests
were made to test both the stdout and stderr, but these existing tests
were left alone. Let's also exhaustively test our expected output
here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0061-run-command.sh | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7b5423eebda..19af082750a 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -130,8 +130,9 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
@@ -141,8 +142,9 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
 '
 
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
@@ -152,8 +154,9 @@ test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
 '
 
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
@@ -172,8 +175,9 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-tool run-command run-command-abort 3 false 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
@@ -187,8 +191,9 @@ no further jobs available
 EOF
 
 test_expect_success 'run_command outputs ' '
-	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command outputs (ungroup) ' '
-- 
2.38.0.rc2.935.g6b421ae1592

