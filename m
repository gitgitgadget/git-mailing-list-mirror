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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD2C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963B761442
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhFNKie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhFNKg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8CC061146
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so12719610wms.0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDj19W/ZMPD1pE1RrzzE8ywI3DvZNTt9FGRMV/zGuOs=;
        b=Eie817kywaAve2NKs+60zCm+X8nVvuVtGMB4eYQ3/J108JvAt2AHEMTgva/+k4sQRV
         Xqv3ZDYsU1HNdgD/OxVDF8NBIGodCVDTYoHGWRXUHLCefihLEGKbgKnaWD5rrj7sYEUh
         NjrdAIyxjnxjoU6Ue8GpA1YkeHWIcmsI0cTjvvl9TB+216OFTtTmWYt92xjlpf3i0BWr
         CVZjORD6Y9q5R2s8ZpRtFKEu1E3+4ssVgwzHFfBSAlsxgeckXF2Scb/V68UGGMT+9CpD
         UppKZX0BIOeDHW9t/GcIqHFaTcktR5TnwUijP5cdpzZHlVAe2QXKWcTv7F5oVFcpzh/9
         NXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDj19W/ZMPD1pE1RrzzE8ywI3DvZNTt9FGRMV/zGuOs=;
        b=OZrtCgf3pFp6esYjS6wkttnwOX2g4YCCiVvPfUxa7jFM8tHWHIaLo9hK0KGnskI3eq
         3t1KsCOb8MIgDPyPnKnQYzcdmBU9egzdkLKX/9TELzr1XlWj9W5GP4myoSn/tPavwPxo
         UQmnDLThufgwWRRO3THOF3xboOK9DmaSoRwcrYcMvmWV5Vo4vz+9Jf/N2V1IeejekWKf
         G+1nHg465kZvZ0V6A2xyqMCTJNicWS6mrFGdTMM0HkEPWZ/pvytTjmM+CbpAiTDHVSD1
         mqJ+scL9muMGrAaDDlDXhF8V+SLuzPpuLNtzW5rRbufwzbF4MIiHkN/8OcWokm5BJakU
         Ei+w==
X-Gm-Message-State: AOAM530e8iYYVxIOzoUXzZC6HPmCSnjFjVWJryUtsjDB7pilINHGfMFg
        NxkgUH8bmq59q4sNUw1yuMFtz1bWOzJNRQ==
X-Google-Smtp-Source: ABdhPJw9FUxTzOogh6BOlTY3inGbV5F76n6PG5fVcrA/epAHbR+QPgyMOxoQXbzJDwnxvwa0y58Oaw==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr32161774wmb.142.1623666834699;
        Mon, 14 Jun 2021 03:33:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:54 -0700 (PDT)
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
Subject: [PATCH v2 12/30] commit: use hook.h to execute hooks
Date:   Mon, 14 Jun 2021 12:33:01 +0200
Message-Id: <patch-12.30-7756f10aac9-20210614T101920Z-avarab@gmail.com>
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

Teach run_commit_hook() to call hook.h instead of run-command.h. This
covers 'pre-commit', 'commit-msg', and
'prepare-commit-msg'.

Additionally, ask the hook library - not run-command - whether any
hooks will be run, as it's possible hooks may exist in the config but
not the hookdir.

Because all but 'post-commit' hooks are expected to make some state
change, force all but 'post-commit' hook to run in series. 'post-commit'
"is meant primarily for notification, and cannot affect the outcome of
`git commit`," so it is fine to run in parallel.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c |  2 +-
 commit.c         | 16 ++++++++++------
 sequencer.c      |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f1aafd67d46..dad4e565443 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1045,7 +1045,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/commit.c b/commit.c
index 8ea55a447fa..e8147a88fc6 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1698,22 +1699,25 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
+	const char *arg;
 	int ret;
-
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
+
+	ret = run_hooks(name, &opt);
+	run_hooks_opt_clear(&opt);
 
 	return ret;
 }
diff --git a/sequencer.c b/sequencer.c
index 3de479f90e1..8f46984ffb7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1446,7 +1446,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.32.0.rc3.434.gd8aed1f08a7

