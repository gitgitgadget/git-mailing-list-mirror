Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbhLTPVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhLTPTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62771C0698DE
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so54947wmd.5
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fmuAR23vn0muTJnRwZFEptByUNRxtXxaI7t+NusI72o=;
        b=JbVmMkw05VZ+95j5tjQXZedzHBHn+M2sBEop3Onliaxs/C7IIGh9Hfzybz2WMXd+/P
         MvNu8hW/YLDV7WVz9ZTyYfaHD9DILUbZOYzBMUy8VfmJ2h1twXwrXYTaKng9Ah20SAJn
         RpY8bfGraT5WFnf3fa544JEPqT+DsrUiVBopMa366cRgaDOkbZNbxIymrbsvC6lsDtqn
         aSV0cZsS55iKze4LcClHzRAHs6abjuPW3W3/AjJNROij/7TlN4tMkzVOeGCoU/8Ks/ZL
         iAck8jkNADx5MAZ/MaHdHVS0BUUp38sTajsAIYGET577hz0e04HjRpLtg37yLVZ0xUh5
         QsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fmuAR23vn0muTJnRwZFEptByUNRxtXxaI7t+NusI72o=;
        b=2YrBWL0g+XFU23sMl7gvVkyI6hFMQhb/h0JFWPR945YF1NWjLsuqDJYMb9YaLjg8le
         SSdO+SSucotahvc4eaVcXEiKb1+VYDBFHeKi524bioihzVE4Witw8zLTkq6RMepsx/bC
         6HlPN0KHNYgQypBLyNhzIpG1tjAppyC76FO5QvZ73e3r90xTEj/+vG6ARLnPcNaoQ7rf
         mXU34Jo2uTQrMv6h3OK+mbwe2UQ7QcfuZZD7UvhRwQfjQMyf9jXTDXxcmcrHjmQ1+/em
         hGEY2i4xqMgE6oDujjnLf0mVsU5RRCALtsXbMm07Ns4nBwIil1mzNTJQ+z9CGEOlT7PT
         ggTQ==
X-Gm-Message-State: AOAM530GcEUGvG/tJu7penzH8L6QkE17abrD9A8VSbnkNZoUyxl+9pnp
        oAVbnPoyPN2Md1lS5iJuskypNRt3xnM=
X-Google-Smtp-Source: ABdhPJznNgQmf2clzE0pBoJEQZf3CkyB1kEEkYczTU2xXVralhYsuJeHLTE1QPcUVQthQ1vMKHzh0A==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr14490898wmh.12.1640012473510;
        Mon, 20 Dec 2021 07:01:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm4083467wms.41.2021.12.20.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:13 -0800 (PST)
Message-Id: <51f536338890dfe930e8f23f13c221d3f80e1404.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:05 +0000
Subject: [PATCH 5/9] trace2: add thread-name override to perf target
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the Trace2 perf target to allow the thread-name field be
specified rather than always inherited from the TLS CTX.

This will be used in a future commit for global events that should
not be tied to a particular thread, such as a global stopwatch timer.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 64 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index c3e57fcb3c0..47293e99d4b 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -64,9 +64,14 @@ static void perf_fmt_prepare(const char *event_name,
 			     int line, const struct repository *repo,
 			     uint64_t *p_us_elapsed_absolute,
 			     uint64_t *p_us_elapsed_relative,
-			     const char *category, struct strbuf *buf)
+			     const char *category, struct strbuf *buf,
+			     const char *thread_name_override)
 {
 	int len;
+	const char *thread_name =
+		((thread_name_override && *thread_name_override)
+		 ? thread_name_override
+		 : ctx->thread_name);
 
 	strbuf_setlen(buf, 0);
 
@@ -106,7 +111,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
+		    thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
 		    event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
@@ -140,14 +145,15 @@ static void perf_io_write_fl(const char *file, int line, const char *event_name,
 			     uint64_t *p_us_elapsed_absolute,
 			     uint64_t *p_us_elapsed_relative,
 			     const char *category,
-			     const struct strbuf *buf_payload)
+			     const struct strbuf *buf_payload,
+			     const char *thread_name_override)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	struct strbuf buf_line = STRBUF_INIT;
 
 	perf_fmt_prepare(event_name, ctx, file, line, repo,
 			 p_us_elapsed_absolute, p_us_elapsed_relative, category,
-			 &buf_line);
+			 &buf_line, thread_name_override);
 	strbuf_addbuf(&buf_line, buf_payload);
 	tr2_dst_write_line(&tr2dst_perf, &buf_line);
 	strbuf_release(&buf_line);
@@ -161,7 +167,7 @@ static void fn_version_fl(const char *file, int line)
 	strbuf_addstr(&buf_payload, git_version_string);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -174,7 +180,7 @@ static void fn_start_fl(const char *file, int line,
 	sq_append_quote_argv_pretty(&buf_payload, argv);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -187,7 +193,7 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addf(&buf_payload, "code:%d", code);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -199,7 +205,7 @@ static void fn_signal(uint64_t us_elapsed_absolute, int signo)
 	strbuf_addf(&buf_payload, "signo:%d", signo);
 
 	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
+			 &us_elapsed_absolute, NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -211,7 +217,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 	strbuf_addf(&buf_payload, "code:%d", code);
 
 	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
+			 &us_elapsed_absolute, NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -237,7 +243,7 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 	maybe_append_string_va(&buf_payload, fmt, ap);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -249,7 +255,7 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	strbuf_addstr(&buf_payload, pathname);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -264,7 +270,7 @@ static void fn_command_ancestry_fl(const char *file, int line, const char **pare
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -279,7 +285,7 @@ static void fn_command_name_fl(const char *file, int line, const char *name,
 		strbuf_addf(&buf_payload, " (%s)", hierarchy);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -291,7 +297,7 @@ static void fn_command_mode_fl(const char *file, int line, const char *mode)
 	strbuf_addstr(&buf_payload, mode);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -306,7 +312,7 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -342,7 +348,7 @@ static void fn_child_start_fl(const char *file, int line,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -356,7 +362,7 @@ static void fn_child_exit_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "[ch%d] pid:%d code:%d", cid, pid, code);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
+			 &us_elapsed_child, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -370,7 +376,7 @@ static void fn_child_ready_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "[ch%d] pid:%d ready:%s", cid, pid, ready);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
+			 &us_elapsed_child, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -381,7 +387,7 @@ static void fn_thread_start_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -393,7 +399,7 @@ static void fn_thread_exit_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_thread, NULL, &buf_payload);
+			 &us_elapsed_thread, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -414,7 +420,7 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -430,7 +436,7 @@ static void fn_exec_result_fl(const char *file, int line,
 		strbuf_addf(&buf_payload, " err:%s", strerror(code));
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -443,7 +449,7 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	strbuf_addf(&buf_payload, "%s:%s", param, value);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -457,7 +463,7 @@ static void fn_repo_fl(const char *file, int line,
 	sq_quote_buf_pretty(&buf_payload, repo->worktree);
 
 	perf_io_write_fl(file, line, event_name, repo, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -479,7 +485,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 NULL, category, &buf_payload);
+			 NULL, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -499,7 +505,7 @@ static void fn_region_leave_printf_va_fl(
 	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -514,7 +520,7 @@ static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addf(&buf_payload, "%s:%s", key, value);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -530,7 +536,7 @@ static void fn_data_json_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -544,7 +550,7 @@ static void fn_printf_va_fl(const char *file, int line,
 	maybe_append_string_va(&buf_payload, fmt, ap);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
-- 
gitgitgadget

