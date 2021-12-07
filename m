Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4EC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhLGSaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbhLGSaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA0C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so31289295wrd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnEh0TwdGrUXyCRiSCfLs7Y7+oqFvJkdiHPZAT/231c=;
        b=lGnW/AeMLTpyi4lTqUFCuhs4pxpwpA4wW5IiUjgbIMVkHJCXY3/tO7ib2CMDQyVADD
         d8k67w/4RR/xpEYXRDpTIPAiNv/Z3SC+QH08Dw8YgoI6ji9Wo7zPTynkL7AP0CHmxbbh
         9kifSRxWUX5O8/b0cXzB0uEB5Vq6ij43y2SATF+DLDZOwBYtcFJzJu4hfwDIdPX0u/vL
         usTGN1kICWdyvf/Ngoii4k167zGZzLqmDUQxUTuzqqWEG7bH0jmszZbtI4oYOtK0KK4x
         hbbArHm45YG8q7v3ee7nRx9h6asHJzEqfR6MwcDO5z2rliV8Q2aCcEZc46esNqxh8+AU
         43kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnEh0TwdGrUXyCRiSCfLs7Y7+oqFvJkdiHPZAT/231c=;
        b=m1N6XoGRf3/7XDREYQbU86zULFVqAIuIOG8WU/rTa6EhH2X6lKsPspIEnB/CekQNth
         W1n5cy4oVl/GG1GLQ9tTTtsDT9ZHngZAK+VbxNud8TOHHTNVCKkmKmkVIvB16jiq2mYc
         OU1k7njOcyry91adXsNwoLKgqT4f+5tmP0HvaNwB0A4W6z3Qnuif6XLPEwdpY5wm1Ny4
         cNq5kvVNXRwfyNDivqdtjR8+Op5BR3bkiAFzD0qHlY7EyylxbsXN5Boa6Ql2Yt2BBMQB
         b7qyc4Bnv8QAvTXiN68W+BaM6KLsQC4BEMUvl53NXWah0v2Rls0/4wTqYOMV3CV65K6v
         k+oQ==
X-Gm-Message-State: AOAM532NWYDQKm5j7PHVQz/ff9uSBMPjXQdqMcvzYA7ZJ6n8+lTk3g5J
        xN5YOyzJuNHc7GN/XVv+wzHfrTf8pJ2gdg==
X-Google-Smtp-Source: ABdhPJzqFODis5w0b8VSab/LdB7EvRoxyuRL356kqVtY4nc/7L63OIowqZcZPoWytCHjS3jsAJMSAQ==
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr55329565wrd.420.1638901598457;
        Tue, 07 Dec 2021 10:26:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.37
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
Subject: [PATCH v2 2/6] usage.c API users: use die_message() for "fatal :" + exit 128
Date:   Tue,  7 Dec 2021 19:26:30 +0100
Message-Id: <patch-v2-2.6-f5a98901498-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that printed its own "fatal: " message and exited with a
status code of 128 to use the die_message() function added in a
preceding commit.

This change also demonstrates why the return value of
die_message_routine() needed to be that of "report_fn". We have
callers such as the run-command.c::child_err_spew() which would like
to replace its error routine with the return value of
"get_die_message_routine()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c | 12 +++++++-----
 http-backend.c        |  3 ++-
 parse-options.c       |  2 +-
 run-command.c         | 16 +++++-----------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 20406f67754..2b2e28bad79 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -401,16 +401,18 @@ static void dump_marks(void);
 
 static NORETURN void die_nicely(const char *err, va_list params)
 {
+	va_list cp;
 	static int zombie;
-	char message[2 * PATH_MAX];
+	report_fn die_message_fn = get_die_message_routine();
 
-	vsnprintf(message, sizeof(message), err, params);
-	fputs("fatal: ", stderr);
-	fputs(message, stderr);
-	fputc('\n', stderr);
+	va_copy(cp, params);
+	die_message_fn(err, params);
 
 	if (!zombie) {
+		char message[2 * PATH_MAX];
+
 		zombie = 1;
+		vsnprintf(message, sizeof(message), err, cp);
 		write_crash_report(message);
 		end_packfile();
 		unkeep_all_packs();
diff --git a/http-backend.c b/http-backend.c
index 3d6e2ff17f8..982cb62c7cb 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -659,8 +659,9 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	if (dead <= 1) {
 		struct strbuf hdr = STRBUF_INIT;
+		report_fn die_message_fn = get_die_message_routine();
 
-		vreportf("fatal: ", err, params);
+		die_message_fn(err, params);
 
 		http_status(&hdr, 500, "Internal Server Error");
 		hdr_nocache(&hdr);
diff --git a/parse-options.c b/parse-options.c
index fc5b43ff0b2..8bc0a21f1d7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1075,6 +1075,6 @@ void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
-	fprintf(stderr, "fatal: %s\n\n", msg);
+	die_message("%s\n", msg); /* The extra \n is intentional */
 	usage_with_options(usagestr, options);
 }
diff --git a/run-command.c b/run-command.c
index f40df01c772..a790fe9799d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -340,15 +340,6 @@ static void child_close_pair(int fd[2])
 	child_close(fd[1]);
 }
 
-/*
- * parent will make it look like the child spewed a fatal error and died
- * this is needed to prevent changes to t0061.
- */
-static void fake_fatal(const char *err, va_list params)
-{
-	vreportf("fatal: ", err, params);
-}
-
 static void child_error_fn(const char *err, va_list params)
 {
 	const char msg[] = "error() should not be called in child\n";
@@ -372,9 +363,10 @@ static void NORETURN child_die_fn(const char *err, va_list params)
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
 	static void (*old_errfn)(const char *err, va_list params);
+	report_fn die_message_routine = get_die_message_routine();
 
 	old_errfn = get_error_routine();
-	set_error_routine(fake_fatal);
+	set_error_routine(die_message_routine);
 	errno = cerr->syserr;
 
 	switch (cerr->err) {
@@ -1082,7 +1074,9 @@ static void *run_thread(void *data)
 
 static NORETURN void die_async(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	report_fn die_message_fn = get_die_message_routine();
+
+	die_message_fn(err, params);
 
 	if (in_async()) {
 		struct async *async = pthread_getspecific(async_key);
-- 
2.34.1.898.g5a552c2e5f0

