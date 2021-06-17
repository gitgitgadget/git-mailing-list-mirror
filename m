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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D8C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989FE61263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhFQKZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhFQKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B7C0617AF
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b11so3269842edy.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGNXQs5KcZYZ57foWIBK6vEeJYRgxZ7UI+ID4j51V8A=;
        b=NhfDSPKLksq9//YPPM7/hkS4yfAP1e5Wgb58QpwWAA7g1l+yaT7Y5N6FE+Dvo6eru8
         LyLI+/Q7sSyq6g+6KCJE1T6y5ybqc57ldEN7ezpTHRCb/1DkxvGQPDjWNbCmiTNwFsP1
         ySOiAdaEIVsV2Wk/h+PNsCEdICTgX6DWiQ6ryw22g2KmZhgA9ruwewOxM+Lt5btoBXQ5
         bQG0wwbKD73yGBvCZmXSKFfC8o9jYpxy4b9SklLQG+U0crWMRuuVQLFSuV8CYLObQcfl
         YdhlSxj5N8OyUT5ZCq9VSU11sRLA8+qHVt3B1aOBCEaBcZVaBOZjXFDTV945x9EivZSm
         oeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGNXQs5KcZYZ57foWIBK6vEeJYRgxZ7UI+ID4j51V8A=;
        b=hwHi/aPtnA6vrunuLXAKevMHzzCvsZ379B0KDlmimHKsB8LisBeLySYTPoyLjCu0pB
         jKZ0IMM65c8LGheCsbmYk6T8ToxdtzL2XKInl0WP+6u5pF6BLfyAklK/29fn2ui1CzDR
         IniZVXx1GOX+YaP4y0SU4ilzjX3uVysmfl0qpUAuxvAn+TCiwI0uWcJ5aYzq1kMGxq05
         8FA3AcdvS6BCn7KG5l6R64XRcYShDNFIppbZMafmoP8q4j2EqqqqeeqSDbrmAQwgJ8iU
         /6gkIgtESCkpxfleuOx04w7dSFDF8JO4plr2HhvOWvw2fMiRoYKKs2wdpCW4ujhugCwm
         0Ucg==
X-Gm-Message-State: AOAM533kNwMELvzPJeaoCpV+0CIGeK1LzYBrR7wZqMlnNiXPLIK+n4Lx
        CMwpY0tzsQeeEX4mqs1lmEEcLsj67obOTw==
X-Google-Smtp-Source: ABdhPJzyUZCXxkmpwzDfP2VsJPx1sHNBq2BqECtfmIMDdxj3iBRKNUwCGcQmkCjF48eL0GtVYg/CcQ==
X-Received: by 2002:a05:6402:1644:: with SMTP id s4mr5502864edx.190.1623925397216;
        Thu, 17 Jun 2021 03:23:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:16 -0700 (PDT)
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
Subject: [PATCH 10/27] commit: use hook.h to execute hooks
Date:   Thu, 17 Jun 2021 12:22:44 +0200
Message-Id: <patch-10.27-e3f8482d80-20210617T101217Z-avarab@gmail.com>
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
index f1aafd67d4..dad4e56544 100644
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
index 8ea55a447f..e8147a88fc 100644
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
index 3de479f90e..8f46984ffb 100644
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
2.32.0.576.g59759b6ca7d

