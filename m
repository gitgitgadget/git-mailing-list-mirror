Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013AC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7423661155
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhDARrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhDARmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360DC0225BA
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1125188wmq.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wJTM7pZEfyegDI5HT6aAfVtznByrjaix/R2aXA7PfEI=;
        b=VM+MEVogEK/7dWBh+SJwmZH7O3qBZSsOJDgaB2qLk1iIn2hteqD2MSo2VBvLZ2oQxJ
         bAqbskQRwZ9zUP2DVO06MITP+aJRgrscR+/JnYLyUVARSl04jyyTf1MhOMPW7xkin65R
         /KZ33+j7XNFoM0plHUhppvwV8nQHpvbNRYvHP8ragA28guhOOgAHSSDBUC27MB49WdFe
         8rBEigaT/79aJDCfFMCcidCEhbzCTFsqga1caAwF5WU8wdQPT8LLmaRwi6jmEHXEGmq3
         Xo/vCL+nNCDAE8z2dgHTJ7HPAPknWtU37nVSyVyDm22BAL5s86DWITxaBWTz5oUj0PEs
         HSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wJTM7pZEfyegDI5HT6aAfVtznByrjaix/R2aXA7PfEI=;
        b=k7kZfPkhsiaYHEsPDpV59K1rRHNJChqPQseI88HiaQ7ybBVCEPAikdyQHga+jPFpJS
         FqVIdv5xSPH4D39IDaQvVdCBKp7AQIDWWJjRAZo089JuaPAMw94JLHQSnonroR52G+zb
         WBqY/A0ebbMaCy91mYP8+2TI9UpGdoYnpYOKroh55YnRXQfEE9sTmUdx0K7uaB960BD6
         AAZX1E07/0w1MiuJca/GCSTB3mw224ATr528gHdLb1q71cuMhxExzO33+OYF/JNuhSdQ
         FnM5yRBxHjy10e3Soix0UlUYX8HZ2LN+Lnk67F88vbpx6qvY5hnGDkQu+o5xS7Kt3ASJ
         Mplw==
X-Gm-Message-State: AOAM532yd4zFpDmlL0RtBoVcpr6c92BhqZNJHNPYjWpfRToxZJQ3vVoP
        3VP6p7EoT/1vDfGN2BoZYUxsapdTIyw=
X-Google-Smtp-Source: ABdhPJxUG195CvbQFMz48ijEl0F30KuR4VMRBZqYoaifYwIpt9fzUbXctHVCaAeNw/yEDkbjftxKcw==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr8782361wml.162.1617291670529;
        Thu, 01 Apr 2021 08:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a131sm8962097wmc.48.2021.04.01.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:10 -0700 (PDT)
Message-Id: <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:46 +0000
Subject: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor` to call
 the daemon via IPC
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `core.fsmonitor` setting is supposed to be set to a path pointing
to a script or executable that (via the Hook API) queries an fsmonitor
process such as watchman.

We are about to implement our own fsmonitor backend, and do not want
to spawn hook processes just to query it.  Let's use `Simple IPC` to
directly communicate with the daemon (and start it if necessary),
guarded by the brand-new `core.useBuiltinFSMonitor` toggle.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c        |  5 +++++
 fsmonitor.c     | 20 +++++++++++++++++---
 repo-settings.c |  3 +++
 repository.h    |  2 ++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 955ff4f9461d..31f2cbaf6dfb 100644
--- a/config.c
+++ b/config.c
@@ -2515,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
 
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
index 9c9b2abc9414..d7e18fc8cd47 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -148,14 +149,27 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 /*
  * Call the query-fsmonitor hook passing the last update token of the saved results.
  */
-static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
+static int query_fsmonitor(int version, struct index_state *istate, struct strbuf *query_result)
 {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	const char *last_update = istate->fsmonitor_last_update;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int result;
 
 	if (!core_fsmonitor)
 		return -1;
 
+	if (r->settings.use_builtin_fsmonitor > 0) {
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+		return fsmonitor_ipc__send_query(last_update, query_result);
+#else
+		/* Fake a trivial response. */
+		warning(_("fsmonitor--daemon unavailable; falling back"));
+		strbuf_add(query_result, "/", 2);
+		return 0;
+#endif
+	}
+
 	strvec_push(&cp.args, core_fsmonitor);
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
@@ -263,7 +277,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	if (istate->fsmonitor_last_update) {
 		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
-				istate->fsmonitor_last_update, &query_result);
+				istate, &query_result);
 
 			if (query_success) {
 				if (hook_version < 0)
@@ -293,7 +307,7 @@ void refresh_fsmonitor(struct index_state *istate)
 
 		if (hook_version == HOOK_INTERFACE_VERSION1) {
 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
-				istate->fsmonitor_last_update, &query_result);
+				istate, &query_result);
 		}
 
 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
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
index b385ca3c94b6..7eeab871ac3e 100644
--- a/repository.h
+++ b/repository.h
@@ -41,6 +41,8 @@ struct repo_settings {
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
+
+	int use_builtin_fsmonitor;
 };
 
 struct repository {
-- 
gitgitgadget

