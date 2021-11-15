Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79DC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EBB610A8
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352132AbhKOXVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353014AbhKOXSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA4C09CE5D
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso691896wmh.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWiiAfRIxfPGyAUWKGZ4CInLa154RcsVWQhGIHvMFhA=;
        b=JuStXWmwFJKBTvfFgzii9tBsvQdND1/tz3emyP/8Bbl7POekOwszSA8EDjtn/9pEns
         Xl5Z6bHGWCDbipz6QH0JfT/5QmRbWJiDIi52hneDHQ+4mYpbcTmyq9cA/ffP9o9y0j8Z
         ypsji0J1p59/FRbG9xtlAm4AV+ZP6zAIw9zNFYFdCcBS5gs/beExY67Aqmik+hFlyAzq
         0MduuAtb5rvH9hvmZp1sJzdLbf/mZ030UvPcrfx9bnVIQQ7UyWy8ut+NgrWU9m2jVd3T
         IWDgoJrcMxVcrp0sPp8sfZzyF9wTVyi85lOF5HjkMPI0h+jyGhXqMiGZk672jpaLYVSL
         KZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWiiAfRIxfPGyAUWKGZ4CInLa154RcsVWQhGIHvMFhA=;
        b=d0szuNXl1jWTRABJaiKnTwz4K4+8AF5OwpKejtzJoQLpI29VJpk++e1m7jOQRB07d8
         glhHxHAZoth0WOmwgM8gQLuIOFo0KLTrWPF937hAJsZ5BoKMpoFO8rT+3BlUS/AkweT2
         bwegk9p3DbfvaKFVMlXJGBZl2MwdN+OJ/AcoT+8VcVLSDHzkG9FXfAqQUQjFXWNEHJz4
         bwwG3hoHQiOOepeaEY46YMNnkEFqz2wn0bSgB4sdhEYVWWGdA8+7hV0BzqCgyQbRnA00
         P1wVaI9wHiAPwY7UAz6LysgHCYWjLpFAQ5OpJGJAF54cgrNudf/c6k1Q8OjYc1CFAuS+
         gRiQ==
X-Gm-Message-State: AOAM532GvAQsL0lHxQFmyuQdV4dMwM/O+ZuDUJ5SM2Tz+AjHbxaDCVeh
        BH2fceS6gIdlWXqus5T/+8frXi8Cvv/nAA==
X-Google-Smtp-Source: ABdhPJyDIBjm8gpBqg1qMVw5IJCU4DY1/Y6c/VukNOUIpedLqhhM2+2AFQDLuK/nUXJMXGgWNrH4/w==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr65926258wmk.66.1637014728818;
        Mon, 15 Nov 2021 14:18:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:48 -0800 (PST)
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
Subject: [RFC PATCH 20/21] usage API: make the "{usage,fatal,error,warning,BUG}: " translatable
Date:   Mon, 15 Nov 2021 23:18:30 +0100
Message-Id: <RFC-patch-20.21-69426ddb992-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the vreportf() function was made static, so we
know it's only being called with a limited set of fixed prefixes. Pass
an enum indicating the kind of usage message we're emitting instead,
which means that we can fold the BUG_vfl_common() functionality
directly into it.

Since we've now got one place were we're emitting these usage messages
we can make them translatable.

We need to be careful with this function to not malloc() anything, as
a failure in say a use of strbuf_vaddf() would call xmalloc(), which
would in turn call die(), but here we're using static strings, either
from libintl or not.

I was on the fence about making the "BUG: " message translatable, but
let's do it for consistency. Someone who doesn't speak a word of
English may not know what "BUG" means, but if it's translated they
might have an easier time knowing that they have to report a bug
upstream. Since we'll always emit the line number it's unlikely that
we're going to be confused by such a report.

As we've moved the BUG_vfl_common() code into vsnprintf() we can do
away with one of the two checks for buffer sizes added in
116d1fa6c69 (vreportf(): avoid relying on stdio buffering, 2019-10-30)
and ac4896f007a (fmt_with_err: add a comment that truncation is OK,
2018-05-18).

I.e. we're being overly paranoid if we define the fixed-size "prefix"
and "msg" buffers, are OK with the former being truncated, and then
effectively check if our 256-byte buffer is larger than our 4096-byte
buffer. I wondered about adding a:

    assert(sizeof(prefix) < sizeof(msg)); /* overly paranoid much? */

But I think that would be overdoing it. Anyone modifying this function
will keep these two buffer sizes in mind, so let's just remove one of
the checks instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 usage.c | 68 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/usage.c b/usage.c
index e6f609fe49a..62313862977 100644
--- a/usage.c
+++ b/usage.c
@@ -6,16 +6,49 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-static void vreportf(const char *prefix, const char *err, va_list params)
+enum usage_kind {
+	USAGE_USAGE,
+	USAGE_DIE,
+	USAGE_ERROR,
+	USAGE_WARNING,
+	USAGE_BUG,
+};
+
+static void vreportf(enum usage_kind kind,
+		     const char *file, int line,
+		     const char *err, va_list params)
 {
+	const char *prefix_i18n;
+	char prefix[256];
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
-	size_t prefix_len = strlen(prefix);
-
-	if (sizeof(msg) <= prefix_len) {
-		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
-		abort();
+	size_t prefix_len;
+
+	switch (kind) {
+	case USAGE_USAGE:
+		prefix_i18n =_("usage: ");
+		break;
+	case USAGE_DIE:
+		prefix_i18n =_("fatal: ");
+		break;
+	case USAGE_ERROR:
+		prefix_i18n =_("error: ");
+		break;
+	case USAGE_WARNING:
+		prefix_i18n =_("warning: ");
+		break;
+	case USAGE_BUG:
+		prefix_i18n =_("BUG: ");
+		break;
 	}
+
+	/* truncation via snprintf is OK here */
+	if (kind == USAGE_BUG)
+		snprintf(prefix, sizeof(prefix), "%s%s:%d: ", prefix_i18n, file, line);
+	else
+		snprintf(prefix, sizeof(prefix), "%s", prefix_i18n);
+
+	prefix_len = strlen(prefix);
 	memcpy(msg, prefix, prefix_len);
 	p = msg + prefix_len;
 	if (vsnprintf(p, pend - p, err, params) < 0)
@@ -33,7 +66,7 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *file, int line, const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf(USAGE_USAGE, file, line, err, params);
 
 	/*
 	 * When we detect a usage error *before* the command dispatch in
@@ -58,7 +91,7 @@ static NORETURN void usage_builtin(const char *file, int line, const char *err,
 static void die_message_builtin(const char *file, int line, const char *err, va_list params)
 {
 	trace2_cmd_error_va_fl(file, line, err, params);
-	vreportf("fatal: ", err, params);
+	vreportf(USAGE_DIE, file, line, err, params);
 }
 
 /*
@@ -78,14 +111,14 @@ static void error_builtin(const char *file, int line, const char *err, va_list p
 {
 	trace2_cmd_error_va_fl(file, line, err, params);
 
-	vreportf("error: ", err, params);
+	vreportf(USAGE_ERROR, file, line, err, params);
 }
 
 static void warning_builtin(const char *file, int line, const char *warn, va_list params)
 {
 	trace2_cmd_error_va_fl(file, line, warn, params);
 
-	vreportf("warning: ", warn, params);
+	vreportf(USAGE_WARNING, file, line, warn, params);
 }
 
 static int die_is_recursing_builtin(void)
@@ -283,24 +316,13 @@ void warning_errno_fl(const char *file, int line, const char *fmt, ...)
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
 int BUG_exit_code;
 
-static void BUG_vfl_common(const char *file, int line, const char *fmt,
-			   va_list params)
-{
-	char prefix[256];
-
-	/* truncation via snprintf is OK here */
-	snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
-
-	vreportf(prefix, fmt, params);
-}
-
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
 	va_list params_copy;
 	static int in_bug;
 
 	va_copy(params_copy, params);
-	BUG_vfl_common(file, line, fmt, params);
+	vreportf(USAGE_BUG, file, line, fmt, params);
 
 	if (in_bug)
 		abort();
@@ -330,7 +352,7 @@ int bug_fl(const char *file, int line, const char *fmt, ...)
 
 	va_copy(cp, ap);
 	va_start(ap, fmt);
-	BUG_vfl_common(file, line, fmt, ap);
+	vreportf(USAGE_BUG, file, line, fmt, ap);
 	va_end(ap);
 	trace2_cmd_error_va_fl(file, line, fmt, cp);
 
-- 
2.34.0.rc2.809.g11e21d44b24

