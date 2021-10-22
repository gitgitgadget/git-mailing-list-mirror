Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D7C4332F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5294161183
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhJVSWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhJVSWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59604C061766
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y132-20020a1c7d8a000000b0032ca5765d6cso849236wmc.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rDfPSVhqXlv/xDcaBlCU5lLfZWmah2Ci7F721DJCsQ=;
        b=S572Xch3sIzj7eQeAL/5tQIHjTO5/7Nhu76oE0NByPV5AHlT515xx/n0x4ptzOpyGd
         DT+Gqi8TP1L2c+ped4HI9yJNDGV3fvoKw+LBu9kctF6rneSA3gcLPEWyc1F1wop32Rt1
         HsU8NvCvD80XUHEQC08H9ddKRJdTQ2hg3CT746gXDkTqdU7KmsjzT5oM46MS9vpkks1+
         gg6xkaNE9lcgRqxtR8717bZOVyD0EfHMC9hdtdOMU2ugKrwcGnxvUcolP9wmukaCY6dS
         +it3YeXI6ThA11d19qBYe3ofI2s8YA7lThfmj4jl2PBFsWI8Y8YzYwJdPR1GGHPJmSaz
         BVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rDfPSVhqXlv/xDcaBlCU5lLfZWmah2Ci7F721DJCsQ=;
        b=st1f2VI6wRdDWzKwhfPjrVjdf4Q0FofkWw9GUZxmecVm8/4tkntRs7FeZFFWoq2het
         VZhoA/j1TW/Nc4eXBJB4d+mUYkS70XsFk1jtktyeVztRgCFyYwIrcFxJfQvDI+jGoZlG
         u+1uQnizk6AOSRMDCv1TkNOBTSpf6ni7duIlA++VjWQ1qYfK8ivF5yygpkGh73bW8pW3
         uigvgcIariwi1yzV+9aY7akr1KVFUW7OmzUEv00Q1Jn62eiW03FnM0at5szFWRF8JgEu
         aU2wNv3lb38kWTpe8n702RL9idhNMVZEkb5hWqEPFfh7CytsXRotpw6uA6ZXCj1ZM/Gg
         +2sA==
X-Gm-Message-State: AOAM533RPb2CUzDkDl8k+wvqv/xzqeRdbQwdxdd8p4cg4UvMZoY8xNaD
        bdHHH88RQz7iaABsTLgioGUdA9YsN8ZijA==
X-Google-Smtp-Source: ABdhPJwtCAzaw6bh/K8G7jTSvWty/EDezhUFHPeiC+BQ4l/oVBVaLLqm5d07zrq5zrbtGxizToqxfQ==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr30887327wmi.181.1634926783701;
        Fri, 22 Oct 2021 11:19:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] usage.c + gc: add and use a die_message_errno()
Date:   Fri, 22 Oct 2021 20:19:36 +0200
Message-Id: <patch-v3-3.6-6b33e394b2f-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
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
index 6b3de3dd514..f7deef08974 100644
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
index c1bb32460b6..ea0ac80f7db 100644
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
index 3d4b90bce1f..efc2064dde3 100644
--- a/usage.c
+++ b/usage.c
@@ -233,6 +233,18 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
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
2.33.1.1494.g88b39a443e1

