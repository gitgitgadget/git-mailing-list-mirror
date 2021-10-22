Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D5EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9461163
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhJVSWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhJVSWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9818C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r17-20020a7bc091000000b0032ca1d30b30so1305369wmh.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br/X668ExVNUCVD+imCkGkec5xBNUahSkKKpmXCD/bE=;
        b=Yl0JXOizGeIDWV12ECbzTJtx801IObvzCWCksOE2yw7JMK21UFNhtbIDo8l7r8HocW
         BNhVlXzvvR8IHbdyyl7lC4Z40S+GBa4LKl46He36pZhX8mWoTm9zZr9oq8kYY4XKkFtO
         s5i35UM11XN6FbKsaLsB+I9RTREU7EkHRxb7AFgO4hU8m3ts0falN0J5adIbRflNjddv
         EV88EMwdlhZN1EY5IK/9HDJKCTHs/2WQ2w4XNSWohQdmmIyX3paB8Pf8bceoPo9tJuGH
         2SDjkRAjzwmYTchG9eA3d8ERYnx+O7ll/Mo73ywR/CGDAu9f2JIICKvvUYM5dfNZ7+Zh
         N9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br/X668ExVNUCVD+imCkGkec5xBNUahSkKKpmXCD/bE=;
        b=3RBVzxptMbh+eISDxtljh+I1CKqCOcJ8uZmNe0AmEKCr7IEYAEdI+bt8fpNA8q4wAc
         eh3Mrhq3Ww0XfeBA0HXSPguK25Jm8I4338wex5BFqCsGoEpaeGNZxkhp3LZ0+FK/WYeA
         9M+rFMC8o8pbLkzLK7W/EhJhpqg4a++mccpX5ZCBawOVLz2ZxXTcD7W0OAfoj2NVFnI8
         aoS5xSaGQ6fUZzfcHJtDlXh6tiujQ09KTOcArjtrKLlFUhDytf2fv+c2U5SBzC60YeiF
         AsU8CbTg9TwwvQs0FiCAEAoq4io4esYN1COwaNXZARKmFF8pUdcZifN87Lnzglj6dMTp
         5ZFw==
X-Gm-Message-State: AOAM531D14Zx/dIz/hY43cIe2VdeFP6J8TsPDPQoNXh6mTiHGUICn39W
        +PrJ0GdP/n+trBP8vsiJ297ThkkUKJIINA==
X-Google-Smtp-Source: ABdhPJycogyH3lCeAayI10ppdpowV6fRBArk50LnsEMgwUGS/fqlOo+X6grmfNIt7LztuvGfntCmPA==
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr1382826wmg.145.1634926781969;
        Fri, 22 Oct 2021 11:19:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] usage.c: add a die_message() routine
Date:   Fri, 22 Oct 2021 20:19:34 +0200
Message-Id: <patch-v3-1.6-fe8763337ed-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
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
print a "fatal: " prefix, and it will exit with 128 instead of -1,
this is so that caller can pas the return value to exit(128), instead
of having to hardcode "128".

A subsequent commit will migrate various callers that benefit from
this function over to it, for now we're just migrating trivial users
in usage.c itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h |  3 +++
 usage.c           | 46 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 141bb86351e..c1bb32460b6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -471,6 +471,7 @@ NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -505,6 +506,8 @@ static inline int const_error(void)
 typedef void (*report_fn)(const char *, va_list params);
 
 void set_die_routine(NORETURN_PTR report_fn routine);
+void set_die_message_routine(report_fn routine);
+report_fn get_die_message_routine(void);
 void set_error_routine(report_fn routine);
 report_fn get_error_routine(void);
 void set_warn_routine(report_fn routine);
diff --git a/usage.c b/usage.c
index c7d233b0de9..3d4b90bce1f 100644
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
@@ -118,6 +124,16 @@ void set_die_routine(NORETURN_PTR report_fn routine)
 	die_routine = routine;
 }
 
+void set_die_message_routine(report_fn routine)
+{
+	die_message_routine = routine;
+}
+
+report_fn get_die_message_routine(void)
+{
+	return die_message_routine;
+}
+
 void set_error_routine(report_fn routine)
 {
 	error_routine = routine;
@@ -157,14 +173,23 @@ void NORETURN usage(const char *err)
 	usagef("%s", err);
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
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die handler\n", stderr);
-		exit(128);
-	}
+	if (die_is_recursing())
+		exit(die_message("recursion detected in die handler"));
 
 	va_start(params, err);
 	die_routine(err, params);
@@ -200,11 +225,8 @@ void NORETURN die_errno(const char *fmt, ...)
 	char buf[1024];
 	va_list params;
 
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die_errno handler\n",
-			stderr);
-		exit(128);
-	}
+	if (die_is_recursing())
+		exit(die_message("recursion detected in die_errno handler"));
 
 	va_start(params, fmt);
 	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
-- 
2.33.1.1494.g88b39a443e1

