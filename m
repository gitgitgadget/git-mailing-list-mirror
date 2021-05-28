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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F739C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1510F611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhE1MPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbhE1MOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:14:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE4C061354
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q5so3095137wrs.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOgdpNLc8PGAK/W5GNH1UaftrJhOB3vvgq3B9Qv58Qc=;
        b=RFZe3ois1xi3uP13ruyLs55LYGTPbSYfkMBb3Sw7n6AmuRp9/WyVoQxEj50+KwIKFT
         3+Xq0foTss416RvpZs4ETpzavQD+9OGT3Oh4v0z0TxOtDMsszttnt2FjboeqhWaCAVlC
         ggjx/EY7LewU53G5fc1i7hFR0g2JkXHA7v4lN2Muh8UhCRa2PGvSPlDAFCm2GCpclqze
         c4z00dHnPWYauJ1dcGxHMVbvpL1LUq+jErPIu8QHEzJMa8XKeEiOFtjsGs8QwKt7p1+r
         Ll1r3HSYQoAs/LFE1tYVO3KQnVZGZqvrbEUQL91Lz3qd4/W2maE2R1qcS7JrOsN883fx
         9v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOgdpNLc8PGAK/W5GNH1UaftrJhOB3vvgq3B9Qv58Qc=;
        b=Pfjp/bDbF/Gv2wZyEJ6hVu/0XKO/sB0pQx2BGr5OSvkrk6PuMFgrQFQuw7haY1HXMP
         XiBwMCoZ7Cv7t3paE9UGZPkGgzFJu5KwDgiJl2pLjD6wLHHJpi+ymo1KFW6BQNqFzfHj
         KLhhxPznOpeaulsa5Ep6kflhk/G43ov9kNIwhQR8DXofNnqTNPEpdBaGW88BpCz4lYop
         GwiDd/eUrx4jhuOSxmPlDhu0ouyQ0NGVwQ7shDwvbbytv+5oPuWoOdgDIOVzyAXQI+9e
         LY7lIiS3ffRoorCGFesAeR6bxSxvUZiL7Lii8MbxZOLX4jZ3EA2RxYZFoqAFfR6rWS2o
         eY9g==
X-Gm-Message-State: AOAM533k3rmLW4KNS4nu1gWObxFR4en+4gG9BJS/9ecsLt+ppVBJrDDW
        jFsnATGoNRNBaoPoLKDg9ScrgYPT/nNe2Q==
X-Google-Smtp-Source: ABdhPJxqowNgSkzxlI/8eyS358nPmGcB7szKNXOAzzSagMRDwSIfRhe/YZSfWq3pjHEzNvKzH++4dQ==
X-Received: by 2002:adf:d081:: with SMTP id y1mr8260560wrh.179.1622203924461;
        Fri, 28 May 2021 05:12:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:12:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 26/31] hooks: allow callers to capture output
Date:   Fri, 28 May 2021 14:11:28 +0200
Message-Id: <patch-26.31-7f10efb7858-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 2 +-
 hook.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 0faa24ec825..17ae65eca31 100644
--- a/hook.c
+++ b/hook.c
@@ -166,7 +166,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index ff1697d1087..5f895032341 100644
--- a/hook.h
+++ b/hook.h
@@ -49,6 +49,14 @@ struct run_hooks_opt
 	 */
 	feed_pipe_fn feed_pipe;
 	void *feed_pipe_ctx;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.32.0.rc1.458.gd885d4f985c

