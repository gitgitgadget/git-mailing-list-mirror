Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F754C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhLGSaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhLGSaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B395C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q3so31324371wru.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZPqS/MWhrV9poFkUrbZUBV7i+iE0vnEk04BxJ/bwLc=;
        b=Vs7KaTO9b+Kx3Razmw196PiPx+dXeJYPh+8jJInWsAIj7igdxJYYfIuq2w4PgXR7Ws
         NTyMCbYoIWoZNAlx0kzMOK8c+vv2VZXWKC057aqaM5t43Mfj3gK/IXm/m76vC95st3WJ
         YzgWiVyeQmleODaf6T4L5ImkCSm0P6+MxcxmgTcDn2+oTGRdXDjg5x+zEMYyEtpStqzT
         MCGDr0QRKU+eZDd5AjDhj9xWQQxrzAvTIZ4oSQ9Fp3q6AbJV9toU6rkvOIfgt9IC01Me
         x+4LZg1WaExHHRS/fvWv1trmZMar3AVxQSEExdaOnOPlFvbDiLr6WBwRSxv0QJU4Rr21
         +2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZPqS/MWhrV9poFkUrbZUBV7i+iE0vnEk04BxJ/bwLc=;
        b=wCJeXRdvHAEU4JvuMQNUGNNXYB4V0J9QHnt9E8ZP9ItH0bHIeLgwyzOqVb0hJ7BwjQ
         64EtdrQcIphhGecHtqXHYVjTNwgWLS9nHfQ04oBqiIdoBM99TFhg9Oh6g6Qz2PcJDIdH
         VzNLtEQ5/uMX0Dl7WIHJ5nl0w2rVWYYBNifcP29Aa4uhW56o1NuTHdFeWgfRcmv0QfQI
         0Nf1W7yf+tTnkHEboCnycqHpRBezAECovdr0lVI/0PzY3t0zbrjXInOwOIJz92z3Ft3N
         jlLevE+38TZHoUr7/ofW3uIlXJnQFOt16H3jIs7d9Kv004ZPzBgn815hDSyDb0H08RuV
         Lxrw==
X-Gm-Message-State: AOAM531thtV3K/mf4tuaz2stVyKXcHAmD8L+dSVbqMjWy5xHkgnJEM2h
        H0H36OGQDyn5uRvszhlIfVm1//mAaTUgnw==
X-Google-Smtp-Source: ABdhPJz7OA79S+itSqfsHJC4vNDLqrkyo/gxkRgNVwErb7evjkqktP02UhYl2jYijf2R6SzMiLqM+Q==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr52789857wri.322.1638901601617;
        Tue, 07 Dec 2021 10:26:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] usage.c + gc: add and use a die_message_errno()
Date:   Tue,  7 Dec 2021 19:26:33 +0100
Message-Id: <patch-v2-5.6-2b4a3910654-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "error: " output when we exit with 128 due to gc.log errors
to use a "fatal: " prefix instead. To do this add a
die_message_errno() a sibling function to the die_errno() added in a
preceding commit.

Before this we'd expect report_last_gc_error() to return -1 from
error_errno() in this case. It already treated a status of 0 and 1
specially. Let's just document that anything that's not 0 or 1 should
be returned.

We could also retain the "ret < 0" behavior here without hardcoding
128 by returning -128, and having the caller do a "return -ret", but I
think this makes more sense, and preserves the path from
die_message*()'s return value to the "return" without hardcoding
"128".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c      | 13 +++++++------
 git-compat-util.h |  1 +
 usage.c           | 12 ++++++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 900ccfb8d48..8e60ef1eaba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -470,7 +470,8 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 /*
  * Returns 0 if there was no previous error and gc can proceed, 1 if
  * gc should not proceed due to an error in the last run. Prints a
- * message and returns -1 if an error occurred while reading gc.log
+ * message and returns with a non-[01] status code if an error occurred
+ * while reading gc.log
  */
 static int report_last_gc_error(void)
 {
@@ -484,7 +485,7 @@ static int report_last_gc_error(void)
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
@@ -612,12 +613,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (detach_auto) {
 			int ret = report_last_gc_error();
 
-			if (ret < 0)
-				/* an I/O error occurred, already reported */
-				return 128;
 			if (ret == 1)
 				/* Last gc --auto failed. Skip this one. */
 				return 0;
+			else if (ret)
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

