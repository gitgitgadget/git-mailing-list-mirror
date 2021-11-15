Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A17C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E61E61882
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350380AbhKOXbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbhKOXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C1C03E03D
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso389373wmr.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEHSboMxClUKkYoSWh+04xm7gAhp4B3OLnO7suCT5sg=;
        b=LV2m+OOSTYCP7D/OVLZoVrezC155PC3qiX49d8FJCoWCUxNBLxkGWXXjyIK5rlpBS9
         RvacITpzeVBBbm/8F5ZmC2Flx7TWwR+5A0MPHrivoCfwJZPB2oCrxY8j785EBely0J+w
         aGV6mePmu0M1t/mzlTaCAl7vgHVR5a55I/GZsMTP1RQR9LbUSvJ/D3krzzOHeXypI+ol
         YZSCmWa5+1HVqka3qzVSE4/dTjWtPM0EEM4x+wgbDDIJt4AjMLRLwmv+DB5s/e8MeFaP
         aWsjFjd9uYob3VPfFqAU3WFd4IAqfPUUCtv8McwKdFOU+2BV0uE3Fztfm8p8z+en9c+n
         +zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEHSboMxClUKkYoSWh+04xm7gAhp4B3OLnO7suCT5sg=;
        b=vNebAQ9EBjk/EO52fKmibT5cuS4j4UujVV/3+QaBQPGOIb4hsrBOvgH3xLldfz1XX2
         bkOD6uDHadXfNtxP2skVnIh3SzAYh1e3OMkGxr7IFBoq5RE0wBNY91nHpqhT9j+UWJNb
         crtaBDjmvcxAyKXfTn46TjhOo80NnNENRKTfOoi1jQSlAu1D72o71jMijBau/g7y2NBC
         l9T3QM7xBcJOmFC04SKvbpllbOH9Q1neJ27/DgV6NolLTQ2ao6BMff2sVTSfDvb5yOBo
         b7VrC0G+GsTss5A8zN/I8H9wKi92IjwiCBLzD59k4Gl0X1D/orpaqrQjzwj+Q2NxbJ4C
         zzIQ==
X-Gm-Message-State: AOAM531L8FCKx3hWIXDAZRzbtvsThHZLBcUz/v0j+/aCtQ35N3XEae7I
        O/4aCqO49orhoJCFgjeNewR6HuhtXRZIyg==
X-Google-Smtp-Source: ABdhPJzKU29O6IokuAd8qamrCfxPyYL9o6/WV6G1fVJpDhGsryoi2wYJxCmqLafQHQ2TL6EZmxDS7g==
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr66763901wml.159.1637014725528;
        Mon, 15 Nov 2021 14:18:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 16/21] usage.[ch] API: rename "warn" vars functions to "warning"
Date:   Mon, 15 Nov 2021 23:18:26 +0100
Message-Id: <RFC-patch-16.21-43e8bec1724-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a warning() routine, not warn(), but parts of the function
interface confusingly used "warn". Let's rename these for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c       |  6 +++---
 apply.h       |  4 ++--
 run-command.c |  8 ++++----
 usage.c       | 16 ++++++++--------
 usage.h       |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4ee..5c9872f8c10 100644
--- a/apply.c
+++ b/apply.c
@@ -160,9 +160,9 @@ int check_apply_state(struct apply_state *state, int force_apply)
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		state->saved_error_routine = get_error_routine();
-		state->saved_warn_routine = get_warn_routine();
+		state->saved_warning_routine = get_warning_routine();
 		set_error_routine(mute_routine);
-		set_warn_routine(mute_routine);
+		set_warning_routine(mute_routine);
 	}
 
 	return 0;
@@ -4999,7 +4999,7 @@ int apply_all_patches(struct apply_state *state,
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		set_error_routine(state->saved_error_routine);
-		set_warn_routine(state->saved_warn_routine);
+		set_warning_routine(state->saved_warning_routine);
 	}
 
 	if (res > -1)
diff --git a/apply.h b/apply.h
index 8dca3703d3b..496cd6f0083 100644
--- a/apply.h
+++ b/apply.h
@@ -103,11 +103,11 @@ struct apply_state {
 
 	/*
 	 * This is to save reporting routines before using
-	 * set_error_routine() or set_warn_routine() to install muting
+	 * set_error_routine() or set_warning_routine() to install muting
 	 * routines when in verbosity_silent mode.
 	 */
 	report_fn saved_error_routine;
-	report_fn saved_warn_routine;
+	report_fn saved_warning_routine;
 
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
diff --git a/run-command.c b/run-command.c
index 4792d170be7..48b5fe19a80 100644
--- a/run-command.c
+++ b/run-command.c
@@ -346,9 +346,9 @@ static void child_error_fn(const char *err, va_list params)
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
-static void child_warn_fn(const char *err, va_list params)
+static void child_warning_fn(const char *err, va_list params)
 {
-	const char msg[] = "warn() should not be called in child\n";
+	const char msg[] = "warning() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
@@ -778,12 +778,12 @@ int start_command(struct child_process *cmd)
 	if (!cmd->pid) {
 		int sig;
 		/*
-		 * Ensure the default die/error/warn routines do not get
+		 * Ensure the default die/error/warning routines do not get
 		 * called, they can take stdio locks and malloc.
 		 */
 		set_die_routine(child_die_fn);
 		set_error_routine(child_error_fn);
-		set_warn_routine(child_warn_fn);
+		set_warning_routine(child_warning_fn);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
diff --git a/usage.c b/usage.c
index b411dfb5641..b41f8618f34 100644
--- a/usage.c
+++ b/usage.c
@@ -81,7 +81,7 @@ static void error_builtin(const char *err, va_list params)
 	vreportf("error: ", err, params);
 }
 
-static void warn_builtin(const char *warn, va_list params)
+static void warning_builtin(const char *warn, va_list params)
 {
 	trace2_cmd_error_va(warn, params);
 
@@ -116,7 +116,7 @@ static NORETURN_PTR report_fn usage_routine = usage_builtin;
 static NORETURN_PTR report_fn die_routine = die_builtin;
 static report_fn die_message_routine = die_message_builtin;
 static report_fn error_routine = error_builtin;
-static report_fn warn_routine = warn_builtin;
+static report_fn warning_routine = warning_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
 void set_die_routine(NORETURN_PTR report_fn routine)
@@ -139,14 +139,14 @@ report_fn get_error_routine(void)
 	return error_routine;
 }
 
-void set_warn_routine(report_fn routine)
+void set_warning_routine(report_fn routine)
 {
-	warn_routine = routine;
+	warning_routine = routine;
 }
 
-report_fn get_warn_routine(void)
+report_fn get_warning_routine(void)
 {
-	return warn_routine;
+	return warning_routine;
 }
 
 void set_die_is_recursing_routine(int (*routine)(void))
@@ -274,7 +274,7 @@ void warning_errno(const char *warn, ...)
 	va_list params;
 
 	va_start(params, warn);
-	warn_routine(fmt_with_err(buf, sizeof(buf), warn), params);
+	warning_routine(fmt_with_err(buf, sizeof(buf), warn), params);
 	va_end(params);
 }
 
@@ -283,7 +283,7 @@ void warning(const char *warn, ...)
 	va_list params;
 
 	va_start(params, warn);
-	warn_routine(warn, params);
+	warning_routine(warn, params);
 	va_end(params);
 }
 
diff --git a/usage.h b/usage.h
index a2567a609fc..df02fe9bcaf 100644
--- a/usage.h
+++ b/usage.h
@@ -140,8 +140,8 @@ void set_die_routine(NORETURN_PTR report_fn routine);
 report_fn get_die_message_routine(void);
 void set_error_routine(report_fn routine);
 report_fn get_error_routine(void);
-void set_warn_routine(report_fn routine);
-report_fn get_warn_routine(void);
+void set_warning_routine(report_fn routine);
+report_fn get_warning_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 /*
-- 
2.34.0.rc2.809.g11e21d44b24

