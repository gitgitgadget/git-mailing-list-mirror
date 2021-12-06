Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C0C4321E
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhLFRHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347645AbhLFQ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:59:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEDCC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:56:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i5so23851252wrb.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPoYF8IYShvXyW7r9gnbj2KhuykwuMvSfW25/s3TRZ0=;
        b=gevC+P3ayT0ZP/mJtCUQ38lWo68SpXg5537pknD8fMy801fumxTE+pG1PL1lycqn0l
         en6q0vT1XZvFYnpIob/csJ9FrG+HMki7L0vcAVyYvYkItvIkEAJ+fXnCGz/fjnC0AQFq
         v4qUwJnPKoa5oNbny5wZcR2KIXNeBdm9jM9osy6n3mlWmapfMRsDUtrxe1nE489bDSBJ
         OkHykOuX1FxgCHLwCwhepuddFXDmpp++f9uvlIsB2nSBnJKoTt4l6qyPvzjqYc8ORIPA
         4xMKqvDFoVxH3pa5HqCT30kxhaRWABMFdy1WoYEZKkjnoiqqtbj0lCyONGrNodkziJpf
         8u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPoYF8IYShvXyW7r9gnbj2KhuykwuMvSfW25/s3TRZ0=;
        b=KZDkdBWmM32EI2npRQOra96c+/waeFBZNyD9T7iFz27tN+qus9Pe69Um6atXFqQnJB
         laUNys2EPN6TKcra1+1O03qxK0TfcblWAcwx2uGEKlUm3pl5jwjbPt6H4VidcKSwwDew
         4GsrQdQCf5t9IGhb2nt4MaN5mSqCs5nzFjETPt+hk7MAZfcKwCJ607/hrnYKEbeOWYuq
         VhUz49HM2R5ItmGqS4kNk59mzwLXZELI3bKCHNdpDDIbaUo0hxAd9uQgRcwd98cKP87F
         NekeIOb9i3cuXfivH2SNL4iEdZ+t0CLHBTxz29lHTN7cJ4Fk85SD0AakYE/X4NR5v7Gk
         wUEg==
X-Gm-Message-State: AOAM5305dPHi1f/+RUyuft7ffOovd2qgpQUbSMQGmxPLCarMw3aoPcJC
        ckpEflpzNh1HXdGdYDumviASEWC/TkYHPQ==
X-Google-Smtp-Source: ABdhPJxMT+D8dosR5iIfXPi4jNX9mDAcjrWZUo4XE0tD1sceexK2rWHIujmvsD7Xqz0nCNAxYMUjuQ==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr44872258wrt.65.1638809758532;
        Mon, 06 Dec 2021 08:55:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j40sm11775419wms.16.2021.12.06.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:55:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] usage.c + gc: add and use a die_message_errno()
Date:   Mon,  6 Dec 2021 17:55:52 +0100
Message-Id: <patch-3.4-8747afecdcd-20211206T165221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code the "error: " output when we exit with 128 due to gc.log
errors to use a "fatal: " prefix instead. This adds a sibling function
to the die_errno() added in a preceding commit.

Since it returns 128 instead of -1 (like die_message()) we'll need to
adjust report_last_gc_error().

Let's adjust it while we're at it to not conflate the "should skip"
and "exit with this non-zero code" conditions, as the caller is no
longer hardcoding "128", but relying on die_errno() to return a
nen-zero exit() status.

Since we're touching this code let's also use "return ret" in place of
an "exit(ret)". This is kinder to any cleanup our our "cmd_main()" in
"git.c" might want to do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c      | 21 ++++++++++++---------
 git-compat-util.h |  1 +
 usage.c           | 12 ++++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..7b451dfeefc 100644
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
+				/* an I/O error occurred, already reported */
+				return ret;
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index d5e495529c8..c6c6f7d6b51 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -480,6 +480,7 @@ NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2))
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/usage.c b/usage.c
index 76399ba8409..3d09e8eea48 100644
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
+	return 128;
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
-- 
2.34.1.898.g5a552c2e5f0

