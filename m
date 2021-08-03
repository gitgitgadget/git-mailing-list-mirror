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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011FBC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B3B60BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbhHCTjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbhHCTjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A038C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so13026384wrp.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3M6Wi9+FeyUUGQHId/NJKBrc/edlEsrrPDNsfUYGmdU=;
        b=tPEqGF88lmGJyCkgWYZH5LBGqERk88VlPORxhpQTbih376Ya76QsyxgMQOt0WKPOuh
         1VFTidnoyS4pG16kdgZ31uKVpr+5dli1iZUStGL5OcCywW/MD0TiIY18kJ0VAlp8kc/n
         kkPPEOlW5uSEf7EeY5dDs+/0Kf1MzEuVlg4GzEmqDhLK+f1CqsKyvxqCPwM6YZP8QL34
         EFew0rPB37PwpOlGZCJl7SlDVN4+tkoG1X6fjSUVDo8jHELNrwybJKH/Ezm14BLNgGWP
         KvTMiD8TXj0FTVYJaNgEHWVCEocUyJSBH8lIEHsRfZK/DC9ZQELghqi7mx/NvPGtBuQg
         Y+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3M6Wi9+FeyUUGQHId/NJKBrc/edlEsrrPDNsfUYGmdU=;
        b=GliQy+xoHzgitAq/xAvZXO1ujMx+jpAqhfYsiKYvPRr45x+ARW2GZjSnYKVyrtj3L+
         wCiDoomMyD0WJmxdZ+r+aIQjruv/xg7DvU5jCKUBxdN0gZPrZWJDMre+CteZf5yLHCXY
         yP/8iPJ9I/c+rrM4rmSuYOICPn0LV6K1rpZ2gmLkpsarNTYTQcb/XEIyjx3eyM5HXVlQ
         mhHv6jTmVZk4nKZELx7YkVLf5gZCIVwSPY1V8gAboIPslpMcSIAMT/E7M2Zmnev5CT0p
         fJCgm/S3m7/DVVzXWZPEnjbI3TIm1097E3g2xLrwfvLuVDxFyuyKkX/bPYL5EHwuURls
         aGGg==
X-Gm-Message-State: AOAM533+XnUPL1Mu8aOlGHIL2YYu4jKvKyfd9vxH1qzXu03acczvdbQU
        RiOe1E+GALq+JySZsTVbgWtBt45N1n8TPA==
X-Google-Smtp-Source: ABdhPJzbjLvxauLIHBENoWEStV4qqc7QAYshKAP+iD/8DIQIYAz24GgQpBEkU+M7Wjo856MHgJoOZw==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr24980878wrp.54.1628019559367;
        Tue, 03 Aug 2021 12:39:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:18 -0700 (PDT)
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
Subject: [PATCH v4 09/36] gc: use hook library for pre-auto-gc hook
Date:   Tue,  3 Aug 2021 21:38:35 +0200
Message-Id: <patch-v4-09.36-2b8500aa675-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library.

To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
using it extensively for these simple cases of wanting to run a single
hook under a given name, and having it free the memory we allocate for
us.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c |  3 ++-
 hook.c       | 21 +++++++++++++++++++++
 hook.h       | 13 +++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1ac..2f74cf394d3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -394,7 +395,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks_oneshot("pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/hook.c b/hook.c
index c8ff3975043..981a9bf46e6 100644
--- a/hook.c
+++ b/hook.c
@@ -170,3 +170,24 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	return cb_data.rc;
 }
+
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
+{
+	const char *hook_path;
+	int ret;
+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
+
+	if (!options)
+		options = &hook_opt_scratch;
+
+	hook_path = find_hook(hook_name);
+	if (!hook_path) {
+		ret = 0;
+		goto cleanup;
+	}
+
+	ret = run_hooks(hook_name, hook_path, options);
+cleanup:
+	run_hooks_opt_clear(options);
+	return ret;
+}
diff --git a/hook.h b/hook.h
index 361984c69d4..2201ab9d568 100644
--- a/hook.h
+++ b/hook.h
@@ -51,7 +51,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
 /**
  * Takes an already resolved hook found via find_hook() and runs
  * it. Does not call run_hooks_opt_clear() for you.
+ *
+ * See run_hooks_oneshot() for the simpler one-shot API.
  */
 int run_hooks(const char *hookname, const char *hook_path,
 	      struct run_hooks_opt *options);
+
+/**
+ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
+ * with run_hooks().
+ *
+ * If "options" is provided calls run_hooks_opt_clear() on it for
+ * you. If "options" is NULL a scratch one will be provided for you
+ * before calling run_hooks().
+ */
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
+
 #endif
-- 
2.33.0.rc0.595.ge31e012651d

