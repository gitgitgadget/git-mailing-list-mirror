Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887ECD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIRWcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRWcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:32:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75691
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:32:39 -0700 (PDT)
Received: (qmail 13069 invoked by uid 109); 18 Sep 2023 22:32:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:32:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4729 invoked by uid 111); 18 Sep 2023 22:32:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:32:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:32:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 5/8] fsmonitor: mark unused parameters in stub functions
Message-ID: <20230918223238.GE2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fsmonitor code has some platform-specific functions for which one or
more platforms implement noop or stub functions. We can't get rid of
these functions nor change their interface, since the point is to match
their equivalents in other platforms. But let's annotate their
parameters to quiet the compiler's -Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/fsmonitor/fsm-health-darwin.c    |  8 ++++----
 compat/fsmonitor/fsm-path-utils-win32.c |  7 ++++---
 fsmonitor-ipc.c                         | 10 +++++-----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index 5b1709d63f..c2afcbe6c8 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -4,21 +4,21 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
-int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)
 {
 	return 0;
 }
 
-void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+void fsm_health__dtor(struct fsmonitor_daemon_state *state UNUSED)
 {
 	return;
 }
 
-void fsm_health__loop(struct fsmonitor_daemon_state *state)
+void fsm_health__loop(struct fsmonitor_daemon_state *state UNUSED)
 {
 	return;
 }
 
-void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state UNUSED)
 {
 }
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index c8a3e9dcdb..f4f9cc1f33 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -132,16 +132,17 @@ int fsmonitor__is_fs_remote(const char *path)
 /*
  * No-op for now.
  */
-int fsmonitor__get_alias(const char *path, struct alias_info *info)
+int fsmonitor__get_alias(const char *path UNUSED,
+			 struct alias_info *info UNUSED)
 {
 	return 0;
 }
 
 /*
  * No-op for now.
  */
-char *fsmonitor__resolve_alias(const char *path,
-	const struct alias_info *info)
+char *fsmonitor__resolve_alias(const char *path UNUSED,
+			       const struct alias_info *info UNUSED)
 {
 	return NULL;
 }
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 88575aa54c..153918cf76 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -20,7 +20,7 @@ int fsmonitor_ipc__is_supported(void)
 	return 0;
 }
 
-const char *fsmonitor_ipc__get_path(struct repository *r)
+const char *fsmonitor_ipc__get_path(struct repository *r UNUSED)
 {
 	return NULL;
 }
@@ -30,14 +30,14 @@ enum ipc_active_state fsmonitor_ipc__get_state(void)
 	return IPC_STATE__OTHER_ERROR;
 }
 
-int fsmonitor_ipc__send_query(const char *since_token,
-			      struct strbuf *answer)
+int fsmonitor_ipc__send_query(const char *since_token UNUSED,
+			      struct strbuf *answer UNUSED)
 {
 	return -1;
 }
 
-int fsmonitor_ipc__send_command(const char *command,
-				struct strbuf *answer)
+int fsmonitor_ipc__send_command(const char *command UNUSED,
+				struct strbuf *answer UNUSED)
 {
 	return -1;
 }
-- 
2.42.0.671.g43fbf3903a

