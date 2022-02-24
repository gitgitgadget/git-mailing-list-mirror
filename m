Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93595C43217
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiBXJdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBXJdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248326A3AC
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c192so732585wma.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fl8GSYcCIuUW6aKCZj8U7ss4SfvsVsqQf1/rDkD7zjc=;
        b=mMAZdAIfRj2A7p0ajMlSJN1jx9LinofpVQZpvE6zi8fHGsd8EazqitCZUkvQ0fViw3
         Ts3N8RZUExK1VuhQiRuhcuSe5BD32tANnkGLX/ngfd4IQDZAeq+k9ghyszckFepT655F
         RjnlWnZlp7x+gO84Xk6oFDFxKEnhATvahRKMfbftUihdpgEn2KCrXi4mffoS2j+Ljf6s
         0z6oc0cZtNvFV8LBuYIZuwxZ84OoTUnLttsgQ88dOug6kudqOTmb/LgkoxPRff6L+6Ey
         54YU47Y4ca/K/ERW/UpPSEuILqqlIQjdvZEpMk87wLMZb8gHsRanYONudi7qtSLGQFZY
         6BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fl8GSYcCIuUW6aKCZj8U7ss4SfvsVsqQf1/rDkD7zjc=;
        b=1o1PiAhJ73/bkdA9JEHOXNpZvABVvPoUi9IakqVz9MoOMfYfmioazacnzQVLoRm2st
         jfHUej832YwZZSDU0Erym6sdH4fVda8fyc68PSEl7bRFjkA5aeM57+bC/vbwvi4jluFU
         I8xEi32CCNq6RJSCQzBhj7Vd42v0UPEdZjU6RAOk68+n4GX40mROPVtVwqf3MNpToRhF
         UgPSeUgpwazRcqdjIsq0Y06Gjyk81BntNRbz4vox/72+03aQCO1VFdYPDNBv7MYX/3Ta
         NcIuWwMjr/JZ0bx/oXugJaEsFSrljmsXyf37SK0fEtw7FNXzd/EvLUeavEnstjMm/bkn
         y/jA==
X-Gm-Message-State: AOAM533PIXGNJ3oX8mVZWGA4yjfF9U1rPtRy0gYsT7+nyUk1V7T80EQd
        wXz9iQ5o+mxkLl4lS1lkTFFOuCIraqqsxQ==
X-Google-Smtp-Source: ABdhPJym/c5M6ULJznoQZ6g2b8ECF3eBbUSap72JYR6IzR+3uZ7ClIW825PU27/hMAE1rxwQr7fhbg==
X-Received: by 2002:a05:600c:3b02:b0:37c:91fa:c9d3 with SMTP id m2-20020a05600c3b0200b0037c91fac9d3mr10616893wms.70.1645695194319;
        Thu, 24 Feb 2022 01:33:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/12] trace2: use designated initializers for "struct tr2_tgt"
Date:   Thu, 24 Feb 2022 10:32:59 +0100
Message-Id: <patch-04.12-70aac6263e0-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the preceding commit, change another set of file-level struct
assignments to use designated initializers.

As before the "= NULL" assignments are redundant, but we're keeping
them for self-documentation purposes. The comments left to explain the
pre-image can now be removed in favor of working code that relays the
same information to the reader.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace2/tr2_tgt_event.c  | 60 ++++++++++++++++++++---------------------
 trace2/tr2_tgt_normal.c | 60 ++++++++++++++++++++---------------------
 trace2/tr2_tgt_perf.c   | 60 ++++++++++++++++++++---------------------
 3 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index bd17ecdc321..b5c63622d1e 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -613,34 +613,34 @@ static void fn_data_json_fl(const char *file, int line,
 }
 
 struct tr2_tgt tr2_tgt_event = {
-	&tr2dst_event,
-
-	fn_init,
-	fn_term,
-
-	fn_version_fl,
-	fn_start_fl,
-	fn_exit_fl,
-	fn_signal,
-	fn_atexit,
-	fn_error_va_fl,
-	fn_command_path_fl,
-	fn_command_ancestry_fl,
-	fn_command_name_fl,
-	fn_command_mode_fl,
-	fn_alias_fl,
-	fn_child_start_fl,
-	fn_child_exit_fl,
-	fn_child_ready_fl,
-	fn_thread_start_fl,
-	fn_thread_exit_fl,
-	fn_exec_fl,
-	fn_exec_result_fl,
-	fn_param_fl,
-	fn_repo_fl,
-	fn_region_enter_printf_va_fl,
-	fn_region_leave_printf_va_fl,
-	fn_data_fl,
-	fn_data_json_fl,
-	NULL, /* printf */
+	.pdst = &tr2dst_event,
+
+	.pfn_init = fn_init,
+	.pfn_term = fn_term,
+
+	.pfn_version_fl = fn_version_fl,
+	.pfn_start_fl = fn_start_fl,
+	.pfn_exit_fl = fn_exit_fl,
+	.pfn_signal = fn_signal,
+	.pfn_atexit = fn_atexit,
+	.pfn_error_va_fl = fn_error_va_fl,
+	.pfn_command_path_fl = fn_command_path_fl,
+	.pfn_command_ancestry_fl = fn_command_ancestry_fl,
+	.pfn_command_name_fl = fn_command_name_fl,
+	.pfn_command_mode_fl = fn_command_mode_fl,
+	.pfn_alias_fl = fn_alias_fl,
+	.pfn_child_start_fl = fn_child_start_fl,
+	.pfn_child_exit_fl = fn_child_exit_fl,
+	.pfn_child_ready_fl = fn_child_ready_fl,
+	.pfn_thread_start_fl = fn_thread_start_fl,
+	.pfn_thread_exit_fl = fn_thread_exit_fl,
+	.pfn_exec_fl = fn_exec_fl,
+	.pfn_exec_result_fl = fn_exec_result_fl,
+	.pfn_param_fl = fn_param_fl,
+	.pfn_repo_fl = fn_repo_fl,
+	.pfn_region_enter_printf_va_fl = fn_region_enter_printf_va_fl,
+	.pfn_region_leave_printf_va_fl = fn_region_leave_printf_va_fl,
+	.pfn_data_fl = fn_data_fl,
+	.pfn_data_json_fl = fn_data_json_fl,
+	.pfn_printf_va_fl = NULL,
 };
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 6e429a3fb9e..c7992650018 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -325,34 +325,34 @@ static void fn_printf_va_fl(const char *file, int line,
 }
 
 struct tr2_tgt tr2_tgt_normal = {
-	&tr2dst_normal,
-
-	fn_init,
-	fn_term,
-
-	fn_version_fl,
-	fn_start_fl,
-	fn_exit_fl,
-	fn_signal,
-	fn_atexit,
-	fn_error_va_fl,
-	fn_command_path_fl,
-	fn_command_ancestry_fl,
-	fn_command_name_fl,
-	fn_command_mode_fl,
-	fn_alias_fl,
-	fn_child_start_fl,
-	fn_child_exit_fl,
-	fn_child_ready_fl,
-	NULL, /* thread_start */
-	NULL, /* thread_exit */
-	fn_exec_fl,
-	fn_exec_result_fl,
-	fn_param_fl,
-	fn_repo_fl,
-	NULL, /* region_enter */
-	NULL, /* region_leave */
-	NULL, /* data */
-	NULL, /* data_json */
-	fn_printf_va_fl,
+	.pdst = &tr2dst_normal,
+
+	.pfn_init = fn_init,
+	.pfn_term = fn_term,
+
+	.pfn_version_fl = fn_version_fl,
+	.pfn_start_fl = fn_start_fl,
+	.pfn_exit_fl = fn_exit_fl,
+	.pfn_signal = fn_signal,
+	.pfn_atexit = fn_atexit,
+	.pfn_error_va_fl = fn_error_va_fl,
+	.pfn_command_path_fl = fn_command_path_fl,
+	.pfn_command_ancestry_fl = fn_command_ancestry_fl,
+	.pfn_command_name_fl = fn_command_name_fl,
+	.pfn_command_mode_fl = fn_command_mode_fl,
+	.pfn_alias_fl = fn_alias_fl,
+	.pfn_child_start_fl = fn_child_start_fl,
+	.pfn_child_exit_fl = fn_child_exit_fl,
+	.pfn_child_ready_fl = fn_child_ready_fl,
+	.pfn_thread_start_fl = NULL,
+	.pfn_thread_exit_fl = NULL,
+	.pfn_exec_fl = fn_exec_fl,
+	.pfn_exec_result_fl = fn_exec_result_fl,
+	.pfn_param_fl = fn_param_fl,
+	.pfn_repo_fl = fn_repo_fl,
+	.pfn_region_enter_printf_va_fl = NULL,
+	.pfn_region_leave_printf_va_fl = NULL,
+	.pfn_data_fl = NULL,
+	.pfn_data_json_fl = NULL,
+	.pfn_printf_va_fl = fn_printf_va_fl,
 };
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 2ff9cf70835..a2a0195e0f4 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -549,34 +549,34 @@ static void fn_printf_va_fl(const char *file, int line,
 }
 
 struct tr2_tgt tr2_tgt_perf = {
-	&tr2dst_perf,
-
-	fn_init,
-	fn_term,
-
-	fn_version_fl,
-	fn_start_fl,
-	fn_exit_fl,
-	fn_signal,
-	fn_atexit,
-	fn_error_va_fl,
-	fn_command_path_fl,
-	fn_command_ancestry_fl,
-	fn_command_name_fl,
-	fn_command_mode_fl,
-	fn_alias_fl,
-	fn_child_start_fl,
-	fn_child_exit_fl,
-	fn_child_ready_fl,
-	fn_thread_start_fl,
-	fn_thread_exit_fl,
-	fn_exec_fl,
-	fn_exec_result_fl,
-	fn_param_fl,
-	fn_repo_fl,
-	fn_region_enter_printf_va_fl,
-	fn_region_leave_printf_va_fl,
-	fn_data_fl,
-	fn_data_json_fl,
-	fn_printf_va_fl,
+	.pdst = &tr2dst_perf,
+
+	.pfn_init = fn_init,
+	.pfn_term = fn_term,
+
+	.pfn_version_fl = fn_version_fl,
+	.pfn_start_fl = fn_start_fl,
+	.pfn_exit_fl = fn_exit_fl,
+	.pfn_signal = fn_signal,
+	.pfn_atexit = fn_atexit,
+	.pfn_error_va_fl = fn_error_va_fl,
+	.pfn_command_path_fl = fn_command_path_fl,
+	.pfn_command_ancestry_fl = fn_command_ancestry_fl,
+	.pfn_command_name_fl = fn_command_name_fl,
+	.pfn_command_mode_fl = fn_command_mode_fl,
+	.pfn_alias_fl = fn_alias_fl,
+	.pfn_child_start_fl = fn_child_start_fl,
+	.pfn_child_exit_fl = fn_child_exit_fl,
+	.pfn_child_ready_fl = fn_child_ready_fl,
+	.pfn_thread_start_fl = fn_thread_start_fl,
+	.pfn_thread_exit_fl = fn_thread_exit_fl,
+	.pfn_exec_fl = fn_exec_fl,
+	.pfn_exec_result_fl = fn_exec_result_fl,
+	.pfn_param_fl = fn_param_fl,
+	.pfn_repo_fl = fn_repo_fl,
+	.pfn_region_enter_printf_va_fl = fn_region_enter_printf_va_fl,
+	.pfn_region_leave_printf_va_fl = fn_region_leave_printf_va_fl,
+	.pfn_data_fl = fn_data_fl,
+	.pfn_data_json_fl = fn_data_json_fl,
+	.pfn_printf_va_fl = fn_printf_va_fl,
 };
-- 
2.35.1.1157.g524e2d5a0db

