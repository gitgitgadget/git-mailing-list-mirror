Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DA01F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKCR7t (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45170 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCR7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so3700180ljc.12
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aT/1Iyw/Y6Bb7szL7iGILMKcKxPK4N5wgY8m72IgqVY=;
        b=bRYGJMCqr7fko8CLpdNGGf9M/9uLyJQ7ACjujAFMorLgiA3v2SNFhK89NlQyD5EVS4
         u1lzKUwBhuuCxd32N2ihIqXH/35WOrYUam8XsAAuCNBuAgfznnjO7qVpuqRCA7jlAueW
         OaLxcklc9GF/aJr7djYDaH8cmaSY+DPfUbZ+De99WguLo7w32LjHHyPLdOZvdNG7YZ3h
         kK2KwQIi7dXtH2jHzgPT/d64ZiYQ+cKCeBs/GWaP55KPVwwKAgXZe0AKevZWYHUJTUJu
         uPKdA9PP8/vtWaxsLIjlIUzyx6MoXr5+GdFhHEz5jC5IxrTv6HDh86bzCoGfcxCQGK4r
         NcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aT/1Iyw/Y6Bb7szL7iGILMKcKxPK4N5wgY8m72IgqVY=;
        b=flghB6b+oFKGQQvrsS4MaWQLgpAew331iADCuDyLUsFpI7bUpX6EjgKPvSnefZIqxu
         nk3c6gGGlDfb6dvT3Gg9Ku96G3WCx+0ZDrP1wG+EliRF2Gd1jiNbW93yjtwxjod76juU
         dbfVN12Z704kitNfWoyK+dlhkzAgQ3CSExqokUbDAyIuZhrqfEgRFuf8g4kHJNyUnK5o
         iUrDPUE0H8Bj1Ui4Fkuf2BuH4z5OyaMf+Z91YMsnPUUCdOfhtCXCrg2Ac4Oy7OwN1smY
         4ViFNtIlk8TkLa4mgPIqNojOSF9mIEFFi/gsrA30YJHjcc6aMQGNi3Gb09pplbLsoBHw
         IODA==
X-Gm-Message-State: AGRZ1gJOJCtepJ3ct1cu9FgsfonWpHFTsEF1x/RfFUHqjDSLh5BZZayq
        DpY7CnILmxoO1AIYUkC/6b0=
X-Google-Smtp-Source: AJdET5clyiATPrpvoPtL+6vlh+Ky9IGKlcPgeC+VNk166mc8K4dATZ78vVzOJJzJtrqpjy+N8E0GYA==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr9380791lja.19.1541234950790;
        Sat, 03 Nov 2018 01:49:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 08/14] grep: clean up num_threads handling
Date:   Sat,  3 Nov 2018 09:48:44 +0100
Message-Id: <20181103084850.9584-9-pclouds@gmail.com>
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

When NO_PTHREADS is still used in this file, we have two separate code
paths for thread and no thread support. The latter will always have
num_threads remain zero while the former uses num_threads zero as
"default number of threads".

With recent changes blur the line between thread and no-thread
support, this num_threads handling becomes a bit strange so let's
redefine it like this:

- num_threads == 0 means default number of threads and should become
  positive after all configuration and option parsing is done if
  multithread is supported.

- num_threads <= 1 runs no threads. It does not matter if the platform
  supports threading or not.

- num_threads > 1 will run multiple threads and is invalid if
  HAVE_THREADS is false. pthread API is only used in this case.

PS. a new warning is also added when num_threads is forced back to one
because a thread-incompatible option is specified.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 58 +++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6dd15dbaa2..de3f568cee 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -69,13 +69,11 @@ static pthread_mutex_t grep_mutex;
 
 static inline void grep_lock(void)
 {
-	assert(num_threads);
 	pthread_mutex_lock(&grep_mutex);
 }
 
 static inline void grep_unlock(void)
 {
-	assert(num_threads);
 	pthread_mutex_unlock(&grep_mutex);
 }
 
@@ -234,7 +232,7 @@ static int wait_all(void)
 	int i;
 
 	if (!HAVE_THREADS)
-		return 0;
+		BUG("Never call this function unless you have started threads");
 
 	grep_lock();
 	all_work_added = 1;
@@ -279,14 +277,14 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
-		else if (!HAVE_THREADS && num_threads && num_threads != 1) {
+		else if (!HAVE_THREADS && num_threads > 1) {
 			/*
 			 * TRANSLATORS: %s is the configuration
 			 * variable for tweaking threads, currently
 			 * grep.threads
 			 */
 			warning(_("no threads support, ignoring %s"), var);
-			num_threads = 0;
+			num_threads = 1;
 		}
 	}
 
@@ -323,7 +321,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
-	if (HAVE_THREADS && num_threads) {
+	if (num_threads > 1) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
@@ -353,7 +351,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
-	if (HAVE_THREADS && num_threads) {
+	if (num_threads > 1) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
@@ -1025,36 +1023,34 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-	if (HAVE_THREADS) {
-		if (list.nr || cached || show_in_pager)
-			num_threads = 0;
-		else if (num_threads == 0)
-			num_threads = GREP_NUM_THREADS_DEFAULT;
-		else if (num_threads < 0)
-			die(_("invalid number of threads specified (%d)"), num_threads);
-		if (num_threads == 1)
-			num_threads = 0;
+	if (list.nr || cached || show_in_pager) {
+		if (num_threads > 1)
+			warning(_("invalid option combination, ignoring --threads"));
+		num_threads = 1;
+	} else if (!HAVE_THREADS && num_threads > 1) {
+		warning(_("no threads support, ignoring --threads"));
+		num_threads = 1;
+	} else if (num_threads < 0)
+		die(_("invalid number of threads specified (%d)"), num_threads);
+	else if (num_threads == 0)
+		num_threads = HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT : 1;
+
+	if (num_threads > 1) {
+		if (!HAVE_THREADS)
+			BUG("Somebody got num_threads calculation wrong!");
+		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
+		    && (opt.pre_context || opt.post_context ||
+			opt.file_break || opt.funcbody))
+			skip_first_line = 1;
+		start_threads(&opt);
 	} else {
-		if (num_threads)
-			warning(_("no threads support, ignoring --threads"));
-		num_threads = 0;
-	}
-
-	if (!num_threads)
 		/*
 		 * The compiled patterns on the main path are only
 		 * used when not using threading. Otherwise
-		 * start_threads() below calls compile_grep_patterns()
+		 * start_threads() above calls compile_grep_patterns()
 		 * for each thread.
 		 */
 		compile_grep_patterns(&opt);
-
-	if (HAVE_THREADS && num_threads) {
-		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
-		    && (opt.pre_context || opt.post_context ||
-			opt.file_break || opt.funcbody))
-			skip_first_line = 1;
-		start_threads(&opt);
 	}
 
 	if (show_in_pager && (cached || list.nr))
@@ -1106,7 +1102,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
-	if (num_threads)
+	if (num_threads > 1)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
-- 
2.19.1.1005.gac84295441

