Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE1C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 03:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJ2DC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJ2DCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 23:02:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F282BC7
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u24so1146081edd.13
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8yNpg9XZXMeNNgms1SNXPH9wjHkWJCsbbV/B91Klfg=;
        b=KSwYzJuy8f8nmdBDbNBmMelt+UPF4MKFu3En68onaGO6qaGQyz94cs2Iy2fEv155+r
         n1O39k5AOCn02URhE5KRIRAVlHY5VqaGEU7TPQA8jg8D0v5bL240JOMAPUs/BTIxS7p1
         2Iu/HzNqgoI6vl2nkVJO+5XmiAf+udk8QtWdkVhjl19iFFoj0HHMewGYV/BX8olvO5Rv
         S9pzD7Qa/CSDJZtDjnkwE+3hv5yx8NJUFs71m1psLig98iAElE33m7mQO+z+JQ+Y8pOo
         Zo+9zJKv+QMAUDO6RQ10ROB3tIBQrqSQdECjnu029AiOswhjoGbfoqUrJBBZcwKYGPGG
         F7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8yNpg9XZXMeNNgms1SNXPH9wjHkWJCsbbV/B91Klfg=;
        b=ZP3iXCiVqDHSbuYbFcb4wL5E+NKjFWPvPAC+PADer4NwzmFsIS5jog5C2W5BooRRda
         QiouPSMphnYY2O1aI72qAfsXZyBZBL0GtwDXJ6j0Nlx7JJ1ojWpfDbsfDUBw4+DRG26D
         a6dTSiNrnxV+TRE8H+bMm5giUxTNlQUCZcR28fm2M9fWGbMEuKGGIkyeVCsL0Syb219Z
         wXUXld1lbri8kmTfcd10F8GC9g1/op01Ltgjdik9m7R+FtKYCSjS4Hg+LkVJc6ab3tf0
         AHNYdVrjaGeAV6lVq+fzipRImZTud9ollRtCzEg0ZZ9Xm3T9Q+DLAFNli5d/KMD5nIyb
         892A==
X-Gm-Message-State: ACrzQf1wm3V23OJ/YboR8Z8596UTrhM+2908TrTcRKr3MWUplKOj18f2
        5F4ofFlGa7a0gNGJl2MkI77gICF8D8KWqQ==
X-Google-Smtp-Source: AMsMyM6X5+MQgqcGRbw2lE645tTx4rwkWa1djZb/v4icWmjEo00+9TI39mep/bnQ2wEw4J44zOHSIA==
X-Received: by 2002:a05:6402:294a:b0:461:b661:d903 with SMTP id ed10-20020a056402294a00b00461b661d903mr2298088edb.407.1667012477388;
        Fri, 28 Oct 2022 20:01:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dy14-20020a05640231ee00b00461621cae1fsm195393edb.16.2022.10.28.20.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:01:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] run-command tests: test stdout of run_command_parallel()
Date:   Sat, 29 Oct 2022 04:59:47 +0200
Message-Id: <patch-3.3-6d6c2241bf2-20221029T025520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
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
 t/t0061-run-command.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7b5423eebda..e2411f6a9bd 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -130,7 +130,8 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -141,7 +142,8 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
 '
 
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -152,7 +154,8 @@ test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
 '
 
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -172,7 +175,8 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-tool run-command run-command-abort 3 false 2>actual &&
+	test-tool run-command run-command-abort 3 false >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
@@ -187,7 +191,8 @@ no further jobs available
 EOF
 
 test_expect_success 'run_command outputs ' '
-	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
+	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
-- 
2.38.0.1280.g8136eb6fab2

