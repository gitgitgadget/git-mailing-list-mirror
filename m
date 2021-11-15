Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442EC433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F361A03
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350990AbhKOXUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352703AbhKOXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012CC03E032
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so33499955wra.10
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oW/ah7N+mP+Kgz2nZAMheWQF9hVYC5lG7wN+eSgoBzk=;
        b=FI2/HSZSEuXPhSOmhkPfXr1N5JErwtjQFC5aqlT2wgp8hmySiMVzj4jUScOl8qffQv
         gmRCRF81ysnrGzsg0ajeUqsaqVD8B30fB6hFgRrxETfFiAJUsvW1seYedzqRF+7434G6
         I773Y1NF+9q0qkfUM4wWBVfVOogLpAHgh6eCLiHYJkUjahQv3wRgmc7aw9nwV7pMPkAN
         NBViqpF6LhMECh30e5c9ZzLNNnVxjC13FDZpBkXTUxmlPi4ImCHIUDA4w/yYYiTQvNmj
         Ktu2FmnYYaSvy7BeGiH5LhGCiftnrqnGZOZ0txRhkJ5cIX+YkZzkSCYjLAiTDxTID2CE
         DwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oW/ah7N+mP+Kgz2nZAMheWQF9hVYC5lG7wN+eSgoBzk=;
        b=eKp5foy3k4eV5g/hce8F3gvgri1Gp71gL0lZf1BMHQ/kcEzigXirLrYBiImy24rGox
         M1BvvLp3SyNKxyw/L9JoqvLtCEv7bA7ZnCJUPLhvmjfMLjJvGo1nR32YEX01Av/4bjyW
         ot+EELAcuqRKQ1y1+9T0hWt4X8mbdw9wBVhBizW1/9XOIYCflSvh0FxCM6hKv/KUq4UQ
         RoqQ4BFBQWdPl48gJXmlIVelE4aiL0EPmoBjI8T8xTtZa+I4m6makbaLJcQIX+AJur1H
         yd4Kgsubn9Z0tVxpkqrdi/fvx5Y3llOWJMeP/Yxqd0Hf9GkFTQs6NjQtaTwg9Er+vbPZ
         vjxQ==
X-Gm-Message-State: AOAM531inPqMXyIAcwyBGKdIVLVBce3nVQicfDnJfGh49r9aq5e2UAbH
        CN6D3gP6S7pbrImIJ/Fi+aq2aub1fu17eA==
X-Google-Smtp-Source: ABdhPJxwpsuEFhzmMu/B0rxJlTpH8h17rUn0/VfbM3xOHdNljlVoKtuRkKaPhul9eCYlr0hS+BX5rA==
X-Received: by 2002:a5d:6e82:: with SMTP id k2mr3160257wrz.147.1637014717666;
        Mon, 15 Nov 2021 14:18:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:37 -0800 (PST)
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
Subject: [RFC PATCH 05/21] usage.c + gc: add and use a die_message_errno()
Date:   Mon, 15 Nov 2021 23:18:15 +0100
Message-Id: <RFC-patch-05.21-f93d95ab288-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code the "error: " output when we exit with 128 due to gc.log
errors to use a "fatal: " prefix instead. This adds a sibling function
to the die_errno() added in a preceding commit.

Since it returns 128 instead of -1 we'll need to adjust
report_last_gc_error(). Let's adjust it while we're at it to not
conflate the "should skip" and "exit with this non-zero code"
conditions, as the caller is no longer hardcoding "128", but relying
on die_errno() to return a nen-zero exit() status.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c      | 21 ++++++++++++---------
 git-compat-util.h |  1 +
 usage.c           | 12 ++++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..a70a935dab3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -472,19 +472,20 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
  * gc should not proceed due to an error in the last run. Prints a
  * message and returns -1 if an error occurred while reading gc.log
  */
-static int report_last_gc_error(void)
+static int report_last_gc_error(int *skip)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 	ssize_t len;
 	struct stat st;
 	char *gc_log_path = git_pathdup("gc.log");
+	*skip = 0;
 
 	if (stat(gc_log_path, &st)) {
 		if (errno == ENOENT)
 			goto done;
 
-		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
+		ret = die_message_errno(_("cannot stat '%s'"), gc_log_path);
 		goto done;
 	}
 
@@ -493,7 +494,7 @@ static int report_last_gc_error(void)
 
 	len = strbuf_read_file(&sb, gc_log_path, 0);
 	if (len < 0)
-		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+		ret = die_message_errno(_("cannot read '%s'"), gc_log_path);
 	else if (len > 0) {
 		/*
 		 * A previous gc failed.  Report the error, and don't
@@ -507,7 +508,7 @@ static int report_last_gc_error(void)
 			       "until the file is removed.\n\n"
 			       "%s"),
 			    gc_log_path, sb.buf);
-		ret = 1;
+		*skip = 1;
 	}
 	strbuf_release(&sb);
 done:
@@ -610,13 +611,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			int ret = report_last_gc_error();
-			if (ret < 0)
-				/* an I/O error occurred, already reported */
-				exit(128);
-			if (ret == 1)
+			int skip;
+			int ret = report_last_gc_error(&skip);
+
+			if (skip)
 				/* Last gc --auto failed. Skip this one. */
 				return 0;
+			if (ret)
+				/* an error occurred, already reported */
+				exit(ret);
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index dd0170e3dd9..d56f416af8a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -472,6 +472,7 @@ NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2))
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/usage.c b/usage.c
index 8ee5c6493fb..a39d7aa330b 100644
--- a/usage.c
+++ b/usage.c
@@ -233,6 +233,18 @@ int die_message(const char *err, ...)
 	return 128;
 }
 
+#undef die_message_errno
+int die_message_errno(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	va_start(params, fmt);
+	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_end(params);
+	return -1;
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
-- 
2.34.0.rc2.809.g11e21d44b24

