Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC8C41535
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56B861A8D
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbhKOXTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbhKOXQf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:16:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EDC03E030
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so33599015wrb.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mac39U8Oj7LE3ejlW+nUzfJFsax5Hk3aCxbs9hJadg=;
        b=OKhR3Px41lNcQpJmGt08LaX31vqaVjZitVQBwLRGyfVU5+RwAHoVJyJSRZOsXapbgw
         kn/ckZbQz4AtdsnfH7u1VP22YjbY5K/e0JIbzi717SDVE6cYMPbjLoN58ZLY8bsJxrl1
         HvILQtb6vF7lXQvhbz10G1p2OYcQGGpwHZF3aO06/rFMKdyIHd59RaBBl+vDjfsEX/32
         L5ouWef7r796eqr/M4NVz04IxWKiqJGYRRN4wLkZtBpFwNsekD4RxK+szLkZhmAwV7PM
         giT/KhULIz6ONJLZvaxgSrKSKQZsvkXTYgs6vxuuaNWjUjANZDjKxMBQ4YnjyoZ7DbKP
         NBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mac39U8Oj7LE3ejlW+nUzfJFsax5Hk3aCxbs9hJadg=;
        b=qzjlDr2ALeyP5sqKt5W6O4vLcdwX384zxuw1QrflKie/ddbjMWEJ9Eo0nycJ73ZMgT
         jMnXNtz9tnOQbl0bUZvPfYlRZJ5WoLxDoqvz62eom/aESvzzaZvtbUIhES3FrZhAe8U6
         5+eD9cl3k3yQ3XKxRBt69xeFWref8os8AsY2VuHT0tTX+15QxcyPKUxqRT3/i32AscfT
         T8XkLu6T5UD0BhRu94EY8u8Wy08oBfJPU+MopZdJ+CWXRMwXEu67OQk+MHTzuQPN0mYk
         3kzGwSu265ZDaxKIHZM8jJ9K6yz/BO5ua0XUA3OMzd4HWwu1d+BuT/FQU/+F7GhqMs1D
         H2TA==
X-Gm-Message-State: AOAM531DIlXjqaYluWFnUphk/alopD1miPfy8Hi7TBLJ4BeVTOy8SlUu
        jOMeetOYl2ifGZeBq5YmqEzQNHADFZLDXQ==
X-Google-Smtp-Source: ABdhPJyQhAI8y+mfaajXXSjCtzGJAaIkXe9UFvo/az6d1GrB4fPpynaeooKjsBDMJimsVJiLn0H0tQ==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr2972270wrv.163.1637014716267;
        Mon, 15 Nov 2021 14:18:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:35 -0800 (PST)
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
Subject: [RFC PATCH 03/21] usage.c: add a die_message() routine
Date:   Mon, 15 Nov 2021 23:18:13 +0100
Message-Id: <RFC-patch-03.21-ae05d2398fb-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
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
this function over to it, for now we're just adding the routine and
making die_builtin() in usage.c itself use it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h |  1 +
 usage.c           | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index aec64261a96..2c780825f9e 100644
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
diff --git a/usage.c b/usage.c
index 1128cf000d5..f6a539cade9 100644
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
@@ -62,10 +68,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
  */
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	trace2_cmd_error_va(err, params);
-
-	vreportf("fatal: ", err, params);
-
+	die_message_builtin(err, params);
 	exit(128);
 }
 
@@ -211,6 +214,17 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef die_message
+int die_message(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	die_message_builtin(err, params);
+	va_end(params);
+	return 128;
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
-- 
2.34.0.rc2.809.g11e21d44b24

