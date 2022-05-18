Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6393FC433FE
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiERUFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiERUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99E2375C2
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j25so4136240wrc.9
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pH+9sYH/nHev4eul/h9aNVoyU7/+f8iUHy/fDXuV5bg=;
        b=KVm8CJ7Hbjq6T2XO8KmeS+FlBslCyvU/Ls+5lDnBsuNO6bhsGQvUaIN8KEnLfn6HYL
         eYG5Ry2PWlSmM9lMFu5dyu6Iy+UqfQzHUhJ1Ql20EJaUoGFHgqD8rfTXh+ZiCMalyAch
         Ggh+dhglemkyHGS9SXvD/obDt4HECEeg5Q7nnFKkokcIWVxIURIqRHaJ30DKb7LwyJPP
         sUhcVVgl5NtniuVOE+OQXvI7xPf2xl/QpkybX0odtVsSmKzaga3bwCoKz3mJ+WaNPrRL
         C+aHG6neGRW4NXcqFV7fCoFdO8wQCPiF1NStRVsG9mLE2Wvx9vz8jXVdgDDtSvBdJBHw
         z1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pH+9sYH/nHev4eul/h9aNVoyU7/+f8iUHy/fDXuV5bg=;
        b=zul/35hTXH9bz86pF0oxeIZVq5k4dxk3uDBU9gjL6HFItXkL61cd8HbAR1N+47vZ43
         8+2J/E0eM6IP6IZDsd2fF8S3SlexkDc2r1RDDg+ZycgHi9MgYJpyaiY41qtUIq/QwU9K
         O3rzSwS/ErF9mdaI7ezfKh/nu/Pabt9wrrsxLvK2jeYloiNq6/y3ssyQOpF2oyw3SCQ5
         1GwVDiVlkTfMtVxaBLua6FZ8CKT0I3OjpTU1gaHEndyoWDh2nP5FyAUuR6+FmbZMaJyx
         l1C3oYH5ebFew0kIfPXGA0TswXqEHOIvQmc9wo5YfnaqoiZEnfhKBZqvnlNdDnWekv5t
         m3jQ==
X-Gm-Message-State: AOAM532yy/c0Mq6q+TL0w24aquQyllytshmju3diVYSZZo9NiqQfyBYl
        WiuWJ330Fx5+4xbSqwWxg7EBAL0G7oH6Zg==
X-Google-Smtp-Source: ABdhPJyEoQheDasbQ+qEGm2rWGns5AfQR/CZ53v/pqjQPvpkJkbforWGD3BOuDCFaChyA7JWztY1Hw==
X-Received: by 2002:a5d:4f8c:0:b0:20e:5f7c:db32 with SMTP id d12-20020a5d4f8c000000b0020e5f7cdb32mr1082472wru.596.1652904331644;
        Wed, 18 May 2022 13:05:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] run-command tests: test stdout of run_command_parallel()
Date:   Wed, 18 May 2022 22:05:19 +0200
Message-Id: <patch-v2-3.8-a8e1fc07b65-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) to test stdout in
addition to stderr. A subsequent commit will add additional related
tests for a new feature, making it obvious how the output of the two
compares on both stdout and stderr will make this easier to reason
about.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0061-run-command.sh | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index ee281909bc3..7d00f3cc2af 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -130,18 +130,21 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 cat >expect <<-EOF
@@ -154,8 +157,9 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-tool run-command run-command-abort 3 false 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 cat >expect <<-EOF
@@ -163,8 +167,9 @@ no further jobs available
 EOF
 
 test_expect_success 'run_command outputs ' '
-	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
-	test_cmp expect actual
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
 '
 
 test_trace () {
-- 
2.36.1.952.g0ae626f6cd7

