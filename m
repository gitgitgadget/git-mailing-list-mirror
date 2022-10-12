Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A7DC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJLJB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJLJBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389AB7EF6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w18so25250377wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO0ka02dzn6Z8bqt0b0dDJqdFUzg16NpOFAKwIpa94U=;
        b=V8/0MjS2dBw3nlP/vsgMoKA1jtGA0F2WNUaLv/3JSzPgFZshcLGNO5gablpJu++6zi
         qxhgDb4DJXc9vhGG9iFiuOeLSfuhhbPkG4V0I+e5q5HEcXVxPqASJSETybqMJXGK+zq/
         QUYu2Y9Voxv4M8lrqwoSG6AdxvLFUhYYJegOBLvRQa5nVldZpz1hOMyic2z/2wLPCqpY
         51sEBJG/0ostI4mLPUTXWYkUZRb5sLASpDB3iF6U/9JvF3iEp/LTSBQgc2CDP0xx1P8Q
         4fFK05B6APG/Y48A7u8UhSCzM55P73EVx6r4maIIINNZ9L9gtJGzeqQkedC9MCEioqto
         vfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO0ka02dzn6Z8bqt0b0dDJqdFUzg16NpOFAKwIpa94U=;
        b=AmMgcFAwPxRMgR4nuNpubE9X/R9i7ghurkeGVuMLJV8yM+nERNpVQPCZvI4fy7KFDz
         BRfgqZVWAGtjRagvOlJ0Gu94hHkOKwYL0aeJcIiBTw0C+gHSqECDc7L8Gd/0G3ENECa8
         8hpPLSj+Cpi4swL88QVmQqVTKtDdddG5nAMv9KpH8I6Tq0eqs0SYuoDj4/WA0FnB33ge
         IfpO4Cpuv1jI4wSX9d5TAf5PqJ5U2DlkSgDXD79PhI5ovd2BUV2O7+eaoADF1tzRIOC3
         Pn6Eu43ARmTAw4sWSYeVyfRZgEP9USbbJe8PtBF7ZfYEJu59rJRJVFLhOXz436F3ZyuU
         OT9A==
X-Gm-Message-State: ACrzQf3s66RLEqBCZ69Ffe/Fo/8Ef9wQaLO1wxaPnO+uk90yxUYl7vNa
        U8etTDkfKUCI3ys5A6vvqzPgigRGtRkbXw==
X-Google-Smtp-Source: AMsMyM66NsxVEPnS7RUU5P/w3+lFiOxXEPy+On576T7wHlyJI2rV2g20KTibbacM8lx9IwoVQBxOsg==
X-Received: by 2002:adf:e192:0:b0:232:3648:776d with SMTP id az18-20020adfe192000000b002323648776dmr689252wrb.698.1665565299384;
        Wed, 12 Oct 2022 02:01:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/22] run-command tests: test stdout of run_command_parallel()
Date:   Wed, 12 Oct 2022 11:01:11 +0200
Message-Id: <patch-v2-03.22-c4923358bbd-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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
2.38.0.971.ge79ff6d20e7

