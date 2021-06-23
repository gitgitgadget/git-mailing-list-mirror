Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD76C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A7D611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWRvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFWRux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E9C06175F
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o22so1255648wms.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPuASEtP7/3IoCe0Lx7MLQXePN4LXUHTxF5zNbTuszk=;
        b=ttKEcvjFYB1LdRHXTa7dMYkRa10e4mt2cUdZcVB1MfkCN5QuA7aLSgY8qgf/kZlqv5
         oaAtcWf7u6aMaderT83cYyCsqGnKJCEBZ5HowVRDrkxEhcsK1zmwuJ9GyDuSjVnR+Qj9
         5sxXZy0zyoAyoYt/eDEerKsCItFO8RPKsOi2/zMgTXU4PFKyzRqvFKe1QIDSVFCv246d
         Qizv+lHazJKr1Q5gW0HdiC4UXEwdXZj2kWdvg0n869fqNO4hpYQDtvAjZYc3CBf6P6v6
         P7puxzcfRhBlPPPM42v4vtriws22NOn0ET0ELtU+qJFMugUAyyrzB+cFIFwjLJYzdWwq
         EsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPuASEtP7/3IoCe0Lx7MLQXePN4LXUHTxF5zNbTuszk=;
        b=krgcCv2GfhCGILBd50s1I+71lmY0fHy49+fkiozi43iNh/g8Hu4uQ7HVnC/+63NWCm
         kAYHizmTDfy8a2ZR/dkxiq/U5temeE608XulGK/04IZ3ME7BEsaS+Om88zvmpgeCc1og
         2W7IbPgeZSJimXytzYttgJ1cIKvJhggQTBatixoDT52v3/+Pwv4aIzY/pwwk3JgKt2Px
         cU+O4+26Vf3job7lJ9tblBaTTkN4eFxk3MBnmmGoIK5DvJavzCTCrR80zSUHek2jduqY
         q0sK4RDzFG8ENOw9OMEJb6f34pAjL4dMr8M1iUgQ8gSB0zEDoEC/tghFZsOrd92b76ED
         uaug==
X-Gm-Message-State: AOAM533MImdRZJNuPacWRdC76b99d57UpBpYZr/WWmCoJ/oCHpIv7Z7q
        FWS+3gK3/CUk676vb9MCTUVY9Xx8ZFcgbA==
X-Google-Smtp-Source: ABdhPJz3c2qMlJu1lIEacSk5bBChHnx2E+twaFcu1wQ6bsZtokGCGSOfY+4LRQCvT9tZBBa6ZlVpDg==
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr1064754wmq.23.1624470511963;
        Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/25] progress.c tests: add a "signal" verb
Date:   Wed, 23 Jun 2021 19:48:04 +0200
Message-Id: <patch-04.25-900eeb0b115-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "signal" synonym for "update". It is not typical of the
progress.c API to encounter a scenario where we do an update before
the first display_progress(), let's indicate this explicitly by
calling such instances "signal".

It's just a synonym for "update", but we can imagine than the
following "update" calls could elide many "progress" calls, and the
progress bar output will generally be of the same type, whereas the
output where we're asked to emit an update before we've received any
data is a special case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    |  6 +++++-
 t/t0500-progress-display.sh | 10 +++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index eb925d591e1..7ca58a3ee78 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -13,6 +13,9 @@
  *                                  specify the time elapsed since the
  *                                  start_progress() call.
  *   "update" - Set the 'progress_update' flag.
+ *   "signal" - Synonym for "update", used for self-documenting tests,
+ *              i.e. "expect signal here due to hanging ("signal")
+ *              v.s. it was time to update ("update").
  *   "stop" - Call stop_progress().
  *
  * See 't0500-progress-display.sh' for examples.
@@ -78,7 +81,8 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update")) {
+		} else if (!strcmp(line.buf, "update") ||
+			   !strcmp(line.buf, "signal")) {
 			progress_test_force_update();
 		} else if (!strcmp(line.buf, "stop")) {
 			stop_progress(&progress);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 50eced31f03..66c1989b176 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -23,7 +23,7 @@ test_expect_success 'simple progress display' '
 
 	cat >in <<-\EOF &&
 	start 0
-	update
+	signal
 	progress 1
 	update
 	progress 2
@@ -197,7 +197,7 @@ test_expect_success 'progress display with throughput' '
 	cat >in <<-\EOF &&
 	start
 	throughput 102400 1000
-	update
+	signal
 	progress 10
 	throughput 204800 2000
 	update
@@ -255,7 +255,7 @@ test_expect_success 'cover up after throughput shortens' '
 	cat >in <<-\EOF &&
 	start
 	throughput 409600 1000
-	update
+	signal
 	progress 1
 	throughput 819200 2000
 	update
@@ -285,7 +285,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	cat >in <<-\EOF &&
 	start
 	throughput 1 1000
-	update
+	signal
 	progress 1
 	throughput 1024000 2000
 	update
@@ -305,7 +305,7 @@ test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
 	start 40
 	throughput 102400 1000
-	update
+	signal
 	progress 10
 	throughput 204800 2000
 	update
-- 
2.32.0.599.g3967b4fa4ac

