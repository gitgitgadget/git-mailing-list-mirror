Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB506C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjH2XqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbjH2Xp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71FE1B3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:23 -0700 (PDT)
Received: (qmail 14855 invoked by uid 109); 29 Aug 2023 23:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19868 invoked by uid 111); 29 Aug 2023 23:45:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 09/22] trace2: mark unused us_elapsed_absolute parameters
Message-ID: <20230829234522.GG227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many trace2 targets ignore the absolute elapsed time parameters.
However, the virtual interface needs to retain the parameter since it is
used by others (e.g., the perf target).

Signed-off-by: Jeff King <peff@peff.net>
---
 trace2/tr2_tgt_event.c  | 23 +++++++++++++----------
 trace2/tr2_tgt_normal.c | 20 ++++++++++++--------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 53091781ec..59910a1a4f 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -335,7 +335,7 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 }
 
 static void fn_child_start_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute,
+			      uint64_t us_elapsed_absolute UNUSED,
 			      const struct child_process *cmd)
 {
 	const char *event_name = "child_start";
@@ -367,7 +367,8 @@ static void fn_child_start_fl(const char *file, int line,
 }
 
 static void fn_child_exit_fl(const char *file, int line,
-			     uint64_t us_elapsed_absolute, int cid, int pid,
+			     uint64_t us_elapsed_absolute UNUSED,
+			     int cid, int pid,
 			     int code, uint64_t us_elapsed_child)
 {
 	const char *event_name = "child_exit";
@@ -388,7 +389,8 @@ static void fn_child_exit_fl(const char *file, int line,
 }
 
 static void fn_child_ready_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute, int cid, int pid,
+			      uint64_t us_elapsed_absolute UNUSED,
+			      int cid, int pid,
 			      const char *ready, uint64_t us_elapsed_child)
 {
 	const char *event_name = "child_ready";
@@ -409,7 +411,7 @@ static void fn_child_ready_fl(const char *file, int line,
 }
 
 static void fn_thread_start_fl(const char *file, int line,
-			       uint64_t us_elapsed_absolute)
+			       uint64_t us_elapsed_absolute UNUSED)
 {
 	const char *event_name = "thread_start";
 	struct json_writer jw = JSON_WRITER_INIT;
@@ -423,7 +425,7 @@ static void fn_thread_start_fl(const char *file, int line,
 }
 
 static void fn_thread_exit_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute,
+			      uint64_t us_elapsed_absolute UNUSED,
 			      uint64_t us_elapsed_thread)
 {
 	const char *event_name = "thread_exit";
@@ -439,7 +441,8 @@ static void fn_thread_exit_fl(const char *file, int line,
 	jw_release(&jw);
 }
 
-static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
+static void fn_exec_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute UNUSED,
 		       int exec_id, const char *exe, const char **argv)
 {
 	const char *event_name = "exec";
@@ -460,8 +463,8 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 }
 
 static void fn_exec_result_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute, int exec_id,
-			      int code)
+			      uint64_t us_elapsed_absolute UNUSED,
+			      int exec_id, int code)
 {
 	const char *event_name = "exec_result";
 	struct json_writer jw = JSON_WRITER_INIT;
@@ -511,7 +514,7 @@ static void fn_repo_fl(const char *file, int line,
 }
 
 static void fn_region_enter_printf_va_fl(const char *file, int line,
-					 uint64_t us_elapsed_absolute,
+					 uint64_t us_elapsed_absolute UNUSED,
 					 const char *category,
 					 const char *label,
 					 const struct repository *repo,
@@ -538,7 +541,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 }
 
 static void fn_region_leave_printf_va_fl(
-	const char *file, int line, uint64_t us_elapsed_absolute,
+	const char *file, int line, uint64_t us_elapsed_absolute UNUSED,
 	uint64_t us_elapsed_region, const char *category, const char *label,
 	const struct repository *repo, const char *fmt, va_list ap)
 {
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index d25ea13164..38d5ebddf6 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -86,7 +86,7 @@ static void fn_version_fl(const char *file, int line)
 }
 
 static void fn_start_fl(const char *file, int line,
-			uint64_t us_elapsed_absolute, const char **argv)
+			uint64_t us_elapsed_absolute UNUSED, const char **argv)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
@@ -215,7 +215,7 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 }
 
 static void fn_child_start_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute,
+			      uint64_t us_elapsed_absolute UNUSED,
 			      const struct child_process *cmd)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
@@ -243,7 +243,8 @@ static void fn_child_start_fl(const char *file, int line,
 }
 
 static void fn_child_exit_fl(const char *file, int line,
-			     uint64_t us_elapsed_absolute, int cid, int pid,
+			     uint64_t us_elapsed_absolute UNUSED,
+			     int cid, int pid,
 			     int code, uint64_t us_elapsed_child)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
@@ -256,7 +257,8 @@ static void fn_child_exit_fl(const char *file, int line,
 }
 
 static void fn_child_ready_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute, int cid, int pid,
+			      uint64_t us_elapsed_absolute UNUSED,
+			      int cid, int pid,
 			      const char *ready, uint64_t us_elapsed_child)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
@@ -268,7 +270,8 @@ static void fn_child_ready_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
-static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
+static void fn_exec_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute UNUSED,
 		       int exec_id, const char *exe, const char **argv)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
@@ -284,8 +287,8 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 }
 
 static void fn_exec_result_fl(const char *file, int line,
-			      uint64_t us_elapsed_absolute, int exec_id,
-			      int code)
+			      uint64_t us_elapsed_absolute UNUSED,
+			      int exec_id, int code)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
@@ -321,7 +324,8 @@ static void fn_repo_fl(const char *file, int line,
 }
 
 static void fn_printf_va_fl(const char *file, int line,
-			    uint64_t us_elapsed_absolute, const char *fmt,
+			    uint64_t us_elapsed_absolute UNUSED,
+			    const char *fmt,
 			    va_list ap)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
-- 
2.42.0.528.g7950723a09

