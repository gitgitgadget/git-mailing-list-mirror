Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDDC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B6261474
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhFNKlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhFNKii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:38:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2977C0613A3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n7so7813962wri.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKdHbjwNT2h1uxYqxzxZOgPsrToLQVFrXqodsNNOvzk=;
        b=UgX6C2X1HTdmjo18atcJKbjTim0gHlxO4MyeASwCP+bL5SRHGSRGPW8KLbgqIeFwdK
         JjB6NKrsLUkQuiKU+r3fYRSRNSdWG7OHNESg1dKk08TEmCSyzsl8xEJ2en0BXL3C8Xz0
         //tguSDOPqB3jfF/VCAaE40aBHKZRIpcaDuJRz+t5KQO5VUUPvkY09NMHzSrryDThCFQ
         bWXiSRlKMSOpZDhMTXekHWGskv8Howo5/3lN1tuSQajhowYRMp8SGH5lg26WF7OCbkr9
         Jl75gZKCFdwBCNMYwI9cbTmm6e7Uz3IYgoTS8bKGUvoXISvJiE5LvkNwV3rhBKmU3l4k
         /dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKdHbjwNT2h1uxYqxzxZOgPsrToLQVFrXqodsNNOvzk=;
        b=fzzfGo4D9zKwbTVFNRL7VRinBJCB6lmYTxjpCQQlT1Cqh/l+qYQT1JMjrQ7MYRLkbB
         /9rU0fYsr22ffibYK8XJZhnPUTQw4zdJRDH7jSIOVM2Dg9EfwlU6br04gsFKXWw82YNK
         WpRR/LdI1cNzmJd74Yyi2uTBk9SNF29xnJAfb2UJJaT+X8wjPczry/DaFY1ICEcliEqf
         PH4KAhKnt0ZMfMNzxKSboL5jyBLre1OM2NUAUFW6XdcHLfyrC/FadMZZtee9hBB43DvP
         Wv1iZCKA9lvcSAQSSH5LRYb7vdj3VcFKxgfw0VYhFyhjPXH1xNPKevKGzr7hn4ME0sah
         Qf1g==
X-Gm-Message-State: AOAM533NOIGZ+Iv17Mxg7/k+ltZMNdFdjllWMlqMPN4ZWp4q5ojg6JQf
        9ya9xHhlFwQjyH0mu8hheoOc6LL2Yqg/CA==
X-Google-Smtp-Source: ABdhPJynl9zVYOq+mhpxd/IQkDxkQobmtQIcIrqTjGYsBYgJaJXtAVX5bxTsWvxjGoEq0lK/EaZldA==
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr18212993wrd.309.1623666846295;
        Mon, 14 Jun 2021 03:34:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:05 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 25/30] hooks: allow callers to capture output
Date:   Mon, 14 Jun 2021 12:33:14 +0200
Message-Id: <patch-25.30-251085b7525-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
2.32.0.rc3.434.gd8aed1f08a7

