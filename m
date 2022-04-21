Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F97C4332F
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384185AbiDUM2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384098AbiDUM21 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3D2F391
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k22so6478088wrd.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJwMc0kRtfeQ7rp6CEgyW/0okm5hyFhJiH7mGFGz7WA=;
        b=oB6nv8uHtb08ATBHwPFA/Igr+NYE44y9DMQKV7GD+negMzyqIBYslKnvn1OdFsSHqI
         2klzrtgU1O7r+qnZiGPVDbk/s/ekbesoZQQ9Nd69DkZvS+77MSFSrIms+aaPSMV+JTTX
         lGWoqPzoesESPFsZf3Gx4nykan8881AGZL5TYnOfYEFZdbMfxSgHKLOngk/x8DWQCqJ0
         bmLHODpJerErkY+qBRCW4Lsnu79r0sY5GbSZULWGUDKJz6+ICCZwYg7JrfoxYXKLUdc8
         KF/iFMT4oUDRSy8ysoNtXMuibQIpo5+yAp8J3PylaeaDZYA+qTzOc96/hTiYnDc4iSzU
         v3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJwMc0kRtfeQ7rp6CEgyW/0okm5hyFhJiH7mGFGz7WA=;
        b=2AcQZ8X0p515NZvyDATSaGzzCXmapE8fSsdx0hCtiFp7YybLzPfQ3lKIYc2noiCc67
         L9L7plhx21Avs28M8ky9jfvn5GAE5z1Y0DgqRc0CxENzHWVRWg1dL00ZA4zBl6BGOBMT
         +slPVoICbLmYJ5qOApajHiYNQTfLIAFBqPVB6h43wBln5CWBo/r6HFdF4sk5QaJvi36l
         XQ60GcLwTKk0Sms1awznKfLZIW8/B35fQobFFQNEEefizPYvGGAtnZ0pNtBpjQ9KFtAy
         4/uJ8y6EaUPFap0Seh8ANRZTCHoiT/ocwIidbcCZpGGydUtHbC1SCYv2xdmC4B6lpgcU
         sOCg==
X-Gm-Message-State: AOAM533FIVQxXPFARFER7eqexK0e2wusO3Dl+m4MbuHq6GsBgKfvxl5M
        bkB+LzPUukDuw+MBIJX5TzaZzYDJKaC+zw==
X-Google-Smtp-Source: ABdhPJw2ZepOxYE6AamAADmY2csvg1RoAwV58dErYR705lcKEB4m3MNYZ64OUhAw1T4j8fDZF1DZ3w==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr19039749wre.333.1650543936530;
        Thu, 21 Apr 2022 05:25:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] run-command tests: test stdout of run_command_parallel()
Date:   Thu, 21 Apr 2022 14:25:27 +0200
Message-Id: <patch-2.6-d9c9b158130-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com> <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
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
 t/t0061-run-command.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index ee281909bc3..131fcfda90f 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -130,17 +130,20 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -154,7 +157,8 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-tool run-command run-command-abort 3 false 2>actual &&
+	test-tool run-command run-command-abort 3 false >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -163,7 +167,8 @@ no further jobs available
 EOF
 
 test_expect_success 'run_command outputs ' '
-	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
-- 
2.36.0.893.g80a51c675f6

