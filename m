Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AEC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0191B61A03
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348148AbhKOXT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbhKOXRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:17:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82660C03E031
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so33599121wrb.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozAXOa53vd+nPQs4+wJlfw/ij35v2rnXv3xXRvlDm3c=;
        b=jgkB7uDbpmQMytmCBCfneOKQrSpHOKZgpwzwVoaZXPijTtv6gqDItPgKlXpRTS/yPY
         hAOE73fgECBrsGrHiOioHird8LbvkVMgFWxNawqwkHYLKEbOlZPh9GhtLzHlQC4mGuhT
         sq1LRog/bu6hSKNdXdQdpcM1/R5LcRAAFBL+KGE+fu3oZMBIoRM1eVwRWJ2VmIgQP+ld
         1fwLQw3S7wm1Y5Bdeyv83i3xo3vFIeWMhAvrhp3qmphtphjGa/LdFmqeyxaZe8KlafqI
         ZtOQg5am3DtKQcISm5AMEwMmrPzCYjAm7UXZXzqLkCa7903glT+0CSrRC/ogiM87oju2
         WS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozAXOa53vd+nPQs4+wJlfw/ij35v2rnXv3xXRvlDm3c=;
        b=Q34rnCjxoRMksboOW3JS/UHZfzk8h0+6yx/Td5MKsF+6xJtHW7X/FxrY9iOdMu3vNK
         Ts4yfw2rBYWHYaERgIKOlKV/EvrdS6i3jEpUtaKzSD7SVx6+WJe1bJzeYGhQw3Y5Qknh
         TSJxLZxKT3V28ZhjYh6fwOS4+BSGM96ActfKVjdjJ7euvSi9I/CNAaVjBWhDivcrkaD1
         M0SAueamPdV/DKEDik1Xym75jYstIdgaxt4VnJXLcO9tsr6smo1lp+YTYN+rUI8l+vl/
         +3ARw50TNXNF0LNyznlleZPuy9ip/r7Heddy6ts6yb1h/JLik14RV4cbSVUbXNfmdQmj
         0Vjw==
X-Gm-Message-State: AOAM532lvIBwCkn2iO9x/i+zFJ7LMU9cDT7PeAdvTCV83jBGQ4ypU60R
        tEeU3FPsiQOZb+j2To29RlAc9zBSAER3ig==
X-Google-Smtp-Source: ABdhPJzXAyGzPfCZBXZs3Ts31yfS9iMY04S7azgqt30qCXs8XYX3tDXvlPzyKtRT9ka6xmjHn2Sqdw==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr3164276wrc.67.1637014716911;
        Mon, 15 Nov 2021 14:18:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:36 -0800 (PST)
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
Subject: [RFC PATCH 04/21] usage.c API users: use die_message() where appropriate
Date:   Mon, 15 Nov 2021 23:18:14 +0100
Message-Id: <RFC-patch-04.21-b4ff6ddf986-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
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
index 2c780825f9e..dd0170e3dd9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -504,6 +504,7 @@ static inline int const_error(void)
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
index f6a539cade9..8ee5c6493fb 100644
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
2.34.0.rc2.809.g11e21d44b24

