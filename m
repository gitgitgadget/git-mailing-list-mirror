Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735BEC43217
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhLFRHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347632AbhLFQ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:59:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41963C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:55:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so23934254wra.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RS8g8b1m0rSADL1KI1UkqxXJYX3nHi6MXAdizSUwaB4=;
        b=K1DJAEaaDTKHMg94fdcra454JcRXHGaMNjTQIfEtjojFE86q1YCakNjJmQdDQv51j4
         cHbOgYAaxskRJ9kZFVsIWmUpvkb9QnJZkzy+nlUUF4880AYkWC11qkTSDTByjWuwrsP/
         Fg9Q05fU0WR/WjdR1pohZnZs/ckDTsImXuH16QV/Xg60plJ2cPK/rfEBnsJ8DI9/Dxk1
         9Uu2GyTXJS7tFl9ryHaetXNs/P0e71M+WpBmVWTI9RItkV6hLu2VUZNbumcbdv2lxnGy
         /v+W9kYiSGBWlYP9w6gLHZsaUsQT8mS8eOOAq2/p+UAugDznWJD6yAzsrR1JfBEB7cBO
         bwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RS8g8b1m0rSADL1KI1UkqxXJYX3nHi6MXAdizSUwaB4=;
        b=aLNOYCvRymMxBkMhNs8SDoFC72m9z4tW8/Fltfmhaufe/T8vVJ57T9YbdrAPoMOrFE
         uCDXq98UuzJ3nkpGk2huhEVxlgX4YoiBTdIIb/qbqgRPTZrHp3Dm9kdJ/JCMGHTOrWPa
         8jLE3kznc1pyVAQ0dCnFQ8XaEsiOkUEt9EdjdR0EvLrF+94NlPMD09XSSE0xmqKgvsS8
         MhphW1drvzcUuTVOQSJ2YKyF8aDUvW0uhV+0GCJCz9mgiOWvpEYUQ64VB3G+1xLaJsrh
         ANlu8yBXa3CQZlJuJxUOzkbX46bYllxLtGe4Z4r3UMxQ5v5Byt6x2yK+W98f1J9aImgB
         KxRQ==
X-Gm-Message-State: AOAM530un0CtlnVfSRdd/DJghOyL38JmrbMHeNrSfMy6oQjyepZU07iV
        ki0ClrVy8Y1t0SnCDj4DOT9BkSzDoB1P+g==
X-Google-Smtp-Source: ABdhPJzZE1j0O3VBeuc1TvboWxKCR/iclksa48MGv9hHfX9gc0DXkQ+rPYvX3KfywucHGjdrdf9BQA==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr43920821wrr.497.1638809757592;
        Mon, 06 Dec 2021 08:55:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j40sm11775419wms.16.2021.12.06.08.55.56
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
Subject: [PATCH 2/4] usage.c API users: use die_message() where appropriate
Date:   Mon,  6 Dec 2021 17:55:51 +0100
Message-Id: <patch-2.4-36c050c90c2-20211206T165221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that either called error() and proceeded to exit with 128,
or emitted its own "fatal: " messages to use the die_message()
function added in a preceding commit.

In order to do that we need to add a get_die_message_routine()
function, which works like the other get_*_routine() functions in
usage.c. There is no set_die_message_rotine(), as it hasn't been
needed yet. We can add it if we ever need it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c | 12 +++++++-----
 builtin/notes.c       |  9 +++++----
 git-compat-util.h     |  1 +
 http-backend.c        |  3 ++-
 parse-options.c       |  2 +-
 run-command.c         | 16 +++++-----------
 usage.c               | 12 ++++++++++--
 7 files changed, 31 insertions(+), 24 deletions(-)

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
diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a17..2812d1eac40 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -201,11 +201,12 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 static void write_note_data(struct note_data *d, struct object_id *oid)
 {
 	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
-		error(_("unable to write note object"));
+		int status = die_message(_("unable to write note object"));
+
 		if (d->edit_path)
-			error(_("the note contents have been left in %s"),
-				d->edit_path);
-		exit(128);
+			die_message(_("the note contents have been left in %s"),
+				    d->edit_path);
+		exit(status);
 	}
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index a83fbdf6398..d5e495529c8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -514,6 +514,7 @@ static inline int const_error(void)
 typedef void (*report_fn)(const char *, va_list params);
 
 void set_die_routine(NORETURN_PTR report_fn routine);
+report_fn get_die_message_routine(void);
 void set_error_routine(report_fn routine);
 report_fn get_error_routine(void);
 void set_warn_routine(report_fn routine);
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
diff --git a/usage.c b/usage.c
index 74b43c5db6f..76399ba8409 100644
--- a/usage.c
+++ b/usage.c
@@ -68,7 +68,9 @@ static void die_message_builtin(const char *err, va_list params)
  */
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	die_message_builtin(err, params);
+	report_fn die_message_fn = get_die_message_routine();
+
+	die_message_fn(err, params);
 	exit(128);
 }
 
@@ -112,6 +114,7 @@ static int die_is_recursing_builtin(void)
  * (ugh), so keep things static. */
 static NORETURN_PTR report_fn usage_routine = usage_builtin;
 static NORETURN_PTR report_fn die_routine = die_builtin;
+static report_fn die_message_routine = die_message_builtin;
 static report_fn error_routine = error_builtin;
 static report_fn warn_routine = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
@@ -121,6 +124,11 @@ void set_die_routine(NORETURN_PTR report_fn routine)
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
@@ -220,7 +228,7 @@ int die_message(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	die_message_builtin(err, params);
+	die_message_routine(err, params);
 	va_end(params);
 	return 128;
 }
-- 
2.34.1.898.g5a552c2e5f0

