Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB92C47082
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5C26115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEVN6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEVN6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517CC06138D
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o127so12549096wmo.4
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2viLlPo1a4qnDiU6SmThgEJ8hz95NNWBvJdvSCqw4xc=;
        b=AfJXg5h2wBbTPbLu8jAy3nO5kJClxcqLMHm9Gdo/JxXkmRK/91ksnLLOWq9cdToTlk
         NZueISGKcOjyq2H3EzZLw5P/xcsLfq0A4erX+j+78He1bch4xGdoo/vGb6gIPK1XsIbA
         oqOjKQUa/yyvXR28QK8I2TtvwH34j8efBuzMhWcT/1AHIjgomZ+8Xwm15rV+/PPUp+Ki
         vfqGU8B84VQhXa5B62Rw62e55vW/7oim3io7amU0v0GE2q7rNnqVeIzKYJ/5nkVBonJq
         TA9w9F1xo/d9zuuHwLmM59Bfk00hyaQiN4bn9wFVeQvXf7iuykhgPNASh9+F06RmIvOB
         0Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2viLlPo1a4qnDiU6SmThgEJ8hz95NNWBvJdvSCqw4xc=;
        b=gSQMvcu+PVpl80VW9g6Ye4vTdu+pso3OcNWDkDaeaCjb+/5vQUm8itvbAe34Y4z7Nv
         TfmagKY1MG2nQYGIimuyA/hSkDvgJDnVa5jTgNUXiiGN58E1MXoEP2lzscgaVW7KRHRN
         Sr+824NiGAJvH1iyDijXMZwtf6njWRMc23NCuIlmq6w/aUDwcQQIDYmVlGvNsm4MpMGF
         +7cZPMukstL6PPg2kqXpA2bWm09YL47He35emJryJjkF6N7+4IOyV4wTF52K0HXUlzWE
         zp7izNRP9nFiriQ9e9J2P6gpvlkpeTgWQOEdPawLNnX/jUIx6DmyXhxodSN5TFk+OGkc
         6agQ==
X-Gm-Message-State: AOAM5326rkG2KAj4xmJRoTed2AbxXkmHKwiUBbJRUhyaXccZzy/a9h1/
        aCIz1Z0U6G03LyE2lJOPbz6n4l5or/I=
X-Google-Smtp-Source: ABdhPJxm2lbqZzQEgBPehipBF1yBuXI4jxARtdgZhw755y9rdiCu69Bk1xuKYsf+FyJAb6CQ0b3wjA==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr13593149wmj.128.1621691835047;
        Sat, 22 May 2021 06:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm5505562wrr.48.2021.05.22.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:14 -0700 (PDT)
Message-Id: <7e097cebc14328bc1ec6e30fc164270e0889ff06.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:46 +0000
Subject: [PATCH v2 07/28] fsmonitor: introduce `core.useBuiltinFSMonitor` to
 call the daemon via IPC
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Use simple IPC to directly communicate with the new builtin file
system monitor daemon.

Define a new config setting `core.useBuiltinFSMonitor` to enable the
builtin file system monitor.

The `core.fsmonitor` setting has already been defined as a HOOK
pathname.  Historically, this has been set to a HOOK script that will
talk with Watchman.  For compatibility reasons, we do not want to
overload that definition (and cause problems if users have multiple
versions of Git installed).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c        |  5 +++++
 fsmonitor.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
 repo-settings.c |  3 +++
 repository.h    |  2 ++
 4 files changed, 53 insertions(+)

diff --git a/config.c b/config.c
index a896f44cba1f..c82f40c22b43 100644
--- a/config.c
+++ b/config.c
@@ -2501,6 +2501,11 @@ int git_config_get_max_percent_split_change(void)
 
 int repo_config_get_fsmonitor(struct repository *r)
 {
+	if (r->settings.use_builtin_fsmonitor > 0) {
+		core_fsmonitor = "(built-in daemon)";
+		return 1;
+	}
+
 	if (repo_config_get_pathname(r, "core.fsmonitor", &core_fsmonitor))
 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
 
diff --git a/fsmonitor.c b/fsmonitor.c
index 9c9b2abc9414..c6d3c34ad78e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -231,6 +232,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 
 void refresh_fsmonitor(struct index_state *istate)
 {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0, hook_version = -1;
 	size_t bol = 0; /* beginning of line */
@@ -247,6 +249,46 @@ void refresh_fsmonitor(struct index_state *istate)
 	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
+
+	if (r->settings.use_builtin_fsmonitor > 0) {
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update, &query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		/*
+		 * Regardless of whether we successfully talked to a
+		 * fsmonitor daemon or not, we skip over and do not
+		 * try to use the hook.  The "core.useBuiltinFSMonitor"
+		 * config setting ALWAYS overrides the "core.fsmonitor"
+		 * hook setting.
+		 */
+		goto apply_results;
+	}
+
 	/*
 	 * This could be racy so save the date/time now and query_fsmonitor
 	 * should be inclusive to ensure we don't miss potential changes.
@@ -301,6 +343,7 @@ void refresh_fsmonitor(struct index_state *istate)
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
 	if (query_success && query_result.buf[bol] != '/') {
 		/* Mark all entries returned by the monitor as dirty */
diff --git a/repo-settings.c b/repo-settings.c
index f7fff0f5ab83..93aab92ff164 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_multi_pack_index = value;
 	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
 
+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
+		r->settings.use_builtin_fsmonitor = 1;
+
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
diff --git a/repository.h b/repository.h
index b385ca3c94b6..d6e7f61f9cf7 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,8 @@ enum fetch_negotiation_setting {
 struct repo_settings {
 	int initialized;
 
+	int use_builtin_fsmonitor;
+
 	int core_commit_graph;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
-- 
gitgitgadget

