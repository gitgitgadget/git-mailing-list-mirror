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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E645C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2957061263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFQK0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhFQKZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58416C0611BC
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb6so8907786ejc.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2q84uGasL8ocPuaf06RJk4OoAS9Os898GqdlZKBJydM=;
        b=drNoiDc1zDV7CfZLbneoIgqX2ZDzXPcTG8eFuPuesJwF/DZKMBl++PpOasB3L8zz3V
         RqdMUbSRQQCQWf8h3ZK20Gv8OmM1Ddkd2Qsaxt5y1vsbfeDHTJHEHVxmCkm+6P9PcLNS
         Rf2PA97Mf4L6JiBSo2n+4wHK8xHR2xkZBNqOM5GkYN/E915JNakXFbEJPz/QFkdDngZl
         jO1NG6e5EG8pSHCJ3a0Mqbv3Ja3QrXnAxH7JMidgErVlFS8kPLaGiGKQhpueg65Wz+PQ
         g9W2Kt7/IvTuzLxaOO0OaaeiQQtxoErRJKfEj3+Hf5gjhmQhbadMcZ4iINXh+kABUTWE
         DGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2q84uGasL8ocPuaf06RJk4OoAS9Os898GqdlZKBJydM=;
        b=HJjgcRrvk6uUgj1i3Z+OTEuG3CfW05+8//6XDVBEhJ/NagTqkt66ODZeiQ8Q+kvp01
         FwsTywpjXfJINes92vpcTgRP+JWukBcgs9N2yZ+7P3+mTgqkVl82L2MAvCWwR3jJvU3S
         miOw1W9z/EtlROgi1TTDFYTypAuCe0tdQftRGjz8/Vxg6ShglXR2hz65WO3IHUP44AzA
         Nqo2mVTJA8pjSrTcksxnbgYCN8uMzdPSmcri6wFHbXVWyU+JFR+j1l4qq5Xad5Ijv7iz
         3REkwqLBlqouIVjDECN++Y1sLKWqe+c8+o9TPuzKl/dYfJWvPsIsEPh4xTrOXJMUmmew
         1HaQ==
X-Gm-Message-State: AOAM532Bc2DlMCerpqBkwotSP2PTtebV8GRZFxqKVNZDLDtL8tT6RYjF
        lvuO2GUkmke0EXjII3xCewDmZ65yoDLZOw==
X-Google-Smtp-Source: ABdhPJyv/lqxX4VhIBqLA60AMyg1JEpMrWDlX4VDTBWWxn9MlYvikHD8aFOTe8TIhRQ5RjCcQe9Leg==
X-Received: by 2002:a17:906:744:: with SMTP id z4mr4470904ejb.347.1623925408762;
        Thu, 17 Jun 2021 03:23:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:27 -0700 (PDT)
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
Subject: [PATCH 23/27] hooks: allow callers to capture output
Date:   Thu, 17 Jun 2021 12:22:57 +0200
Message-Id: <patch-23.27-7f7fcc0688-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
index 2dca969f9e..e7f3b468ea 100644
--- a/hook.c
+++ b/hook.c
@@ -192,7 +192,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index b78a8e4805..1302efa590 100644
--- a/hook.h
+++ b/hook.h
@@ -66,6 +66,14 @@ struct run_hooks_opt
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
2.32.0.576.g59759b6ca7d

