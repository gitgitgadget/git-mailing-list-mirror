Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18AC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhLGSaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbhLGSaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452AFC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t9so31316072wrx.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4aEyamrW+iuxjMPsSnh2TrRhZAx92x2LARCZYJmXv4=;
        b=efn7ZuypSXq+qMVLyMnrtMsbCHOSAdOEy1cC8mJL5R2DcyhySDbtvh38YEdk5j6Qn0
         jjaf7hGItuf8E3+btXhI3CVCdVO6BttDBHfLEL2f6BLYaJdh63vrSgrEbMh4s9gizLnk
         EnfRk6RUpce/x5Em1kVDcu6HomjNycGSsdHAfSqZbsBYk0cDJtby+TJfE+rNnglGFO+K
         2ApnwJFQdZidjF2YHEHPfIU0p6XoAsKubXtfDXYYXXwSOpGQkqMXYXA6nP+YwQfwCn6P
         qqPM2jGRt7JmqYbaR3kC7gUWMC4uC5K7rgOD6NMB3fL8ykVJpgKdKg4jv89K0fVnTc1c
         GWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4aEyamrW+iuxjMPsSnh2TrRhZAx92x2LARCZYJmXv4=;
        b=FVJvHIcoQTQYwOM7vLYJ80jWOz01dPgVz9TrIVIs+uy5CJUeCdgD4D5fpnzOHfKWlK
         vvzlUp7r6fYQ1oDjgvsRPMy4UDUvtwMFjiTrXzHF16r6pGllsPzZ543emsXXqPYOZshC
         p1xhEly12/4FpuWzr5I8bA3lfLpzV0Ja55buV7ZMjfZLtSXcsG+rTYHiObrakRu0WX+1
         QWsrP6iEyEduQsM/6mbsHGKTQLni4SLYJm4tErIPIcvE5YgUBz6ILw8yA5yC3nEbgV5d
         Y4UQcXRQx3tS9W6+icxgQAJplI5B1WvjnSdg1Fp0BvZPQfIGmU9LLV7p6BVbUSugTjY2
         Y+9A==
X-Gm-Message-State: AOAM530XbGIsH6P2O9ZUj81MUwYTeh3KNeoV9IvjRlrq8BIQDCs11YPf
        4/aBpvjR1TsbsYKAstpEA3LK2ul5weP75g==
X-Google-Smtp-Source: ABdhPJxWBviLpig0Y46lN90l3zvNMwrvXBC/tNuuQXif/beTn01sKKzK717q4vRKDo7LM2smkqq9kw==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr53964734wrv.548.1638901597585;
        Tue, 07 Dec 2021 10:26:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] usage.c: add a die_message() routine
Date:   Tue,  7 Dec 2021 19:26:29 +0100
Message-Id: <patch-v2-1.6-65ae6fe7cbe-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have code in various places that would like to call die(), but
wants to defer the exit(128) it would invoke, e.g. to print an
additional message, or adjust the exit code. Add a die_message()
helper routine to bridge this gap in the API.

Functionally this behaves just like the error() routine, except it'll
print a "fatal: " prefix, and it will return with 128 instead of -1,
this is so that caller can pass the return value to "exit()", instead
of having to hardcode "exit(128)".

Note that as with the other routines the "die_message_builtin" needs
to return "void" and otherwise conform to the "report_fn"
signature.

As we'll see in a subsequent commit callers will want to replace
e.g. their default "die_routine" with a "die_message_routine".

For now we're just adding the routine and making die_builtin() in
usage.c itself use it. In order to do that we need to add a
get_die_message_routine() function, which works like the other
get_*_routine() functions in usage.c. There is no
set_die_message_rotine(), as it hasn't been needed yet. We can add it
if we ever need it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h |  2 ++
 usage.c           | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6bd2a84e55..d5e495529c8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -479,6 +479,7 @@ NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -513,6 +514,7 @@ static inline int const_error(void)
 typedef void (*report_fn)(const char *, va_list params);
 
 void set_die_routine(NORETURN_PTR report_fn routine);
+report_fn get_die_message_routine(void);
 void set_error_routine(report_fn routine);
 report_fn get_error_routine(void);
 void set_warn_routine(report_fn routine);
diff --git a/usage.c b/usage.c
index c7d233b0de9..76399ba8409 100644
--- a/usage.c
+++ b/usage.c
@@ -55,6 +55,12 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 	exit(129);
 }
 
+static void die_message_builtin(const char *err, va_list params)
+{
+	trace2_cmd_error_va(err, params);
+	vreportf("fatal: ", err, params);
+}
+
 /*
  * We call trace2_cmd_error_va() in the below functions first and
  * expect it to va_copy 'params' before using it (because an 'ap' can
@@ -62,10 +68,9 @@ static NORETURN void usage_builtin(const char *err, va_list params)
  */
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	trace2_cmd_error_va(err, params);
-
-	vreportf("fatal: ", err, params);
+	report_fn die_message_fn = get_die_message_routine();
 
+	die_message_fn(err, params);
 	exit(128);
 }
 
@@ -109,6 +114,7 @@ static int die_is_recursing_builtin(void)
  * (ugh), so keep things static. */
 static NORETURN_PTR report_fn usage_routine = usage_builtin;
 static NORETURN_PTR report_fn die_routine = die_builtin;
+static report_fn die_message_routine = die_message_builtin;
 static report_fn error_routine = error_builtin;
 static report_fn warn_routine = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
@@ -118,6 +124,11 @@ void set_die_routine(NORETURN_PTR report_fn routine)
 	die_routine = routine;
 }
 
+report_fn get_die_message_routine(void)
+{
+	return die_message_routine;
+}
+
 void set_error_routine(report_fn routine)
 {
 	error_routine = routine;
@@ -211,6 +222,17 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef die_message
+int die_message(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	die_message_routine(err, params);
+	va_end(params);
+	return 128;
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
-- 
2.34.1.898.g5a552c2e5f0

