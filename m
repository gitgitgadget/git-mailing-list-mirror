Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7565BC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B5761181
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhJVSWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhJVSWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86449C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m42so3693723wms.2
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDWnKkrDWdv/bzfdOo+3U33CbMfvef1TXzgmF9vreFU=;
        b=GhBwROt7YAqa+uLqUcpNlAKT5Jkxj4rXT2wBxiSoTlXAO4C2Z21u3gW/Ez4uccOJNb
         NMK5Wfd7pFeMuoOskxuBAS940VMlb8vlv7hLQXRFwoNfSqE7uk/sffAUuSTZqxwwo+FC
         OhrIxF3m/t1UmjWqfYzSliw3bchC6uQeX3NchC52LFIQr4+dHWRdBwLQLXTtD3S+e3rI
         sW+FhLKtJjOAud2E9BsNEE9KTY+AKpxyQOH4QrcF2t4n/MaJA0JMWoWZto7kLtKg7Pnp
         FYsqItP6DBFDc6Lv+C+Q5UwBAPjSfmylCsPnReE6+VzDQbKVqxq6R1D7eVDgTeKRUKel
         cPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDWnKkrDWdv/bzfdOo+3U33CbMfvef1TXzgmF9vreFU=;
        b=5/ClY5dse4E86Ewtq7rVzP7SFE9+mzK0Lg6lrBwn2WzZH5/nefhHhg5erkdVDbHRk4
         yIb/eajWj/c8NO10ijP473fr5L+fnxt3RyYQNIC4v5yrz/Fxq4NJwC2hrvITIVoIq1YG
         av3VHYBMms09hIGsOc+c+gfF3LOGQw7ku7i61SVG5sIxK1FprAlKEdPvNI5T/g9cA2Bm
         ol3gA+6UL9r+vsK3MV/S4BlwIwWjHHTtdt/vw3oJwe9uLrJ0bkir5Xkl4P47ap5dVye7
         r5heVBzAU0xzIZC2DkO513DxacHlFamoUVICAqAZInpoRUZ9ygQHlA9Go0bdssOn9LwK
         YF0g==
X-Gm-Message-State: AOAM533sU8K8wQ0dI5nZ11LyzdzP+umKnh3blnRADlczDtXanUr2znI5
        G5Tj5vhqGQWYesUEv8514SnNUTn1zX9WDw==
X-Google-Smtp-Source: ABdhPJwn65nzdvEFt6EIZGeUSf3ub7mRR/YshyDww1Xvrr6cGWzph8bQ4NbPrB0KgiJU6e41wDSZkQ==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr30803026wmk.51.1634926782831;
        Fri, 22 Oct 2021 11:19:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] usage.c API users: use die_message() where appropriate
Date:   Fri, 22 Oct 2021 20:19:35 +0200
Message-Id: <patch-v3-2.6-dfc3a8fbccb-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that either called error() and proceeded to exit with 128,
or emitted its own "fatal: " messages to use the die_message()
function added in a preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c | 13 ++++++++-----
 builtin/notes.c       |  9 +++++----
 http-backend.c        |  3 ++-
 parse-options.c       |  2 +-
 run-command.c         | 16 +++++-----------
 5 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 20406f67754..11cd5b0c56c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -401,16 +401,19 @@ static void dump_marks(void);
 
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
+	if (!zombie)
+		va_copy(cp, params);
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
 
diff --git a/http-backend.c b/http-backend.c
index e7c0eeab230..bc853356e73 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -661,8 +661,9 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	if (dead <= 1) {
 		struct strbuf hdr = STRBUF_INIT;
+		report_fn die_message_fn = get_die_message_routine();
 
-		vreportf("fatal: ", err, params);
+		die_message_fn(err, params);
 
 		http_status(&hdr, 500, "Internal Server Error");
 		hdr_nocache(&hdr);
diff --git a/parse-options.c b/parse-options.c
index 6e0535bdaad..c892641d9a1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1049,7 +1049,7 @@ void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
-	fprintf(stderr, "fatal: %s\n\n", msg);
+	die_message("%s\n", msg); /* The extra \n is intentional */
 	usage_with_options(usagestr, options);
 }
 
diff --git a/run-command.c b/run-command.c
index 7ef5cc712a9..220cf53deb4 100644
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
2.33.1.1494.g88b39a443e1

