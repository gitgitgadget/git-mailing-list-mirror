Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D491F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeKCR7r (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35901 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id h192so2866812lfg.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyWAAjGjlEN1T+6JeoB0reBdgnJUZzl736tZAXd5FJk=;
        b=OH3wRy/VEZAkaoTqnXv8DKdyAx3c0hbSbUrHUnQN3oGK1liDLlxRyodEDcRD5Fw3MH
         X1NvGN+QiuVCEDSHCmGotfZjepL0YuduJj9uXRe1TIqjg0LB7OirUe7yYhkTmcD4eBHp
         alGNteuKZ0nNZO3qpdlBilSrK6XHNljLDIOMW+ueMHhU+i94MzVtXRMZjKZDYAw90rSi
         4strUy7y/PbIlgYQTPbRGbPTYdy1le0V6mes5XA6g7y+oQeOvL/LZScN9entYOOpjYII
         lMV81dByc0nekNk8j+AfIB5h+HS8GX+9g2lsGSY+JlQhlMRVPEg8G9WOkJIpyhHPVNyQ
         rtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyWAAjGjlEN1T+6JeoB0reBdgnJUZzl736tZAXd5FJk=;
        b=K5qa6jjNOCTYs/7MVTFg6pIHss70pWOcz01Hoie2UNhndi4ZxjVmCab+7ZgWFzYN7G
         aLXn6kzYA2vUw3XIrgi9uFHwvLCnze1jdTZdOTZ4bR/wFd17t5nuxtM8JJbGIoXT7w08
         u2V3wzs7JxRqBefnBT0vomjrqJbL94/cpAvcPr0dtc8U3FohJtJGETNLWe/5mvmb3H4y
         PjnmIss4KrRHZwZd9ZJWKpoNhPL6CLOX50U72Kh2NTh8uDOun/xmYeam/3l5E44bVYd7
         WgDGtOr2dPLqHFutFb+P7ehIOYHWEBQpg4XqHbg/vQ7ctkE0w7QtEBGVX/k0atT0lEI7
         wYXA==
X-Gm-Message-State: AGRZ1gL9XtudSK3qECW0oxOTHe0K3aWp9w9A1OJTpH9lsgx400Ka38Qi
        LKQr+5vywIsKJlzGEtG2eoo=
X-Google-Smtp-Source: AJdET5cS2U9PFBiIzjwCTPQTwGQ47UNqRA2cBZyUXfj4NrUm04OqlhxobsaRgw/kLh/CWhl1liTn7w==
X-Received: by 2002:a19:2203:: with SMTP id i3mr9217346lfi.2.1541234949619;
        Sat, 03 Nov 2018 01:49:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 07/14] grep: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:43 +0100
Message-Id: <20181103084850.9584-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a faithful conversion without attempting to improve
anything. That comes later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 59 +++++++++++++++++++-------------------------------
 grep.c         |  6 -----
 grep.h         |  6 -----
 3 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..6dd15dbaa2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -34,7 +34,6 @@ static int recurse_submodules;
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
-#ifndef NO_PTHREADS
 static pthread_t *threads;
 
 /* We use one producer thread and THREADS consumer
@@ -234,6 +233,9 @@ static int wait_all(void)
 	int hit = 0;
 	int i;
 
+	if (!HAVE_THREADS)
+		return 0;
+
 	grep_lock();
 	all_work_added = 1;
 
@@ -265,13 +267,6 @@ static int wait_all(void)
 
 	return hit;
 }
-#else /* !NO_PTHREADS */
-
-static int wait_all(void)
-{
-	return 0;
-}
-#endif
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
@@ -284,8 +279,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
-#ifdef NO_PTHREADS
-		else if (num_threads && num_threads != 1) {
+		else if (!HAVE_THREADS && num_threads && num_threads != 1) {
 			/*
 			 * TRANSLATORS: %s is the configuration
 			 * variable for tweaking threads, currently
@@ -294,7 +288,6 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 			warning(_("no threads support, ignoring %s"), var);
 			num_threads = 0;
 		}
-#endif
 	}
 
 	if (!strcmp(var, "submodule.recurse"))
@@ -330,17 +323,14 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -363,17 +353,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -1038,20 +1025,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-#ifndef NO_PTHREADS
-	if (list.nr || cached || show_in_pager)
-		num_threads = 0;
-	else if (num_threads == 0)
-		num_threads = GREP_NUM_THREADS_DEFAULT;
-	else if (num_threads < 0)
-		die(_("invalid number of threads specified (%d)"), num_threads);
-	if (num_threads == 1)
+	if (HAVE_THREADS) {
+		if (list.nr || cached || show_in_pager)
+			num_threads = 0;
+		else if (num_threads == 0)
+			num_threads = GREP_NUM_THREADS_DEFAULT;
+		else if (num_threads < 0)
+			die(_("invalid number of threads specified (%d)"), num_threads);
+		if (num_threads == 1)
+			num_threads = 0;
+	} else {
+		if (num_threads)
+			warning(_("no threads support, ignoring --threads"));
 		num_threads = 0;
-#else
-	if (num_threads)
-		warning(_("no threads support, ignoring --threads"));
-	num_threads = 0;
-#endif
+	}
 
 	if (!num_threads)
 		/*
@@ -1062,15 +1049,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		 */
 		compile_grep_patterns(&opt);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
 		    && (opt.pre_context || opt.post_context ||
 			opt.file_break || opt.funcbody))
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#endif
 
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
diff --git a/grep.c b/grep.c
index f6bd89e40b..4db1510d16 100644
--- a/grep.c
+++ b/grep.c
@@ -1513,7 +1513,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	}
 }
 
-#ifndef NO_PTHREADS
 int grep_use_locks;
 
 /*
@@ -1539,11 +1538,6 @@ static inline void grep_attr_unlock(void)
  */
 pthread_mutex_t grep_read_mutex;
 
-#else
-#define grep_attr_lock()
-#define grep_attr_unlock()
-#endif
-
 static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
diff --git a/grep.h b/grep.h
index 1a57d12b90..fb04893721 100644
--- a/grep.h
+++ b/grep.h
@@ -229,7 +229,6 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs);
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
-#ifndef NO_PTHREADS
 /*
  * Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers!
@@ -250,9 +249,4 @@ static inline void grep_read_unlock(void)
 		pthread_mutex_unlock(&grep_read_mutex);
 }
 
-#else
-#define grep_read_lock()
-#define grep_read_unlock()
-#endif
-
 #endif
-- 
2.19.1.1005.gac84295441

