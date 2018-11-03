Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538B11F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKCR7o (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42244 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCR7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so2859087lfh.9
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENhCg1Og5kPXga7lxyDMAm+nbsh1TOY+M2fh2RfDQIM=;
        b=i6RQaoRlZF66BEUL8fccDGxNJckXzQ7fnj0Gy60UaZv6d1Zlrjv2NlgHYz5jmjs859
         Gq7FAx7BPYqzuW3Vyf7VYTOmwfkIcHu2aJWTqvvdks6XDWoortxkO1nOM2jtWiaMz4+o
         fdUNjJFdqOSKi14BksS7f8GLC9zJePyLtXRV1fVn6IFthJN+dNHKG1Kpac4Y1N7QPpqd
         XiGk/a9J14dFelSyXEv2QbTAnTNGT6fkJxGDD8EH9INhjTNtwl+0PFeHkQjqIbA90I7n
         NqTXNNHTKMJGgqpFBzS69AnazV4VSFrWkpM4xD4mo3FxaxfjKfXAZVNU7xnjHDJWaFYN
         Seog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENhCg1Og5kPXga7lxyDMAm+nbsh1TOY+M2fh2RfDQIM=;
        b=Yj8Dr8KWOHGDybK01IvSseidL19OKdZx54WLki4yder1UiilE4fhlmbjz8B51yoJCQ
         r+QkJOuJa0DGN93HjHmCoVH7O0YCfYXIR3OI0DDEZ2NqGuP9lOTVfVBEEBqu0N/RI5Uz
         JXFC256+It4Koojmd5J4QsGmuU4c5MOEzAH4zY2iuha1M8s0nhetWA9BM0i1rFxHF6jq
         DAcpfh9dJq5b1SOFj2NfGkNxSa6orFuh43VnDJaVKfCXH7F2rtpaCs1odnTLdpSw1yaH
         nIu/r5kqaq4qtf5CbEaJlqKHFu4dU3k3XphJ4Ry0OSo961yWAsWn7odNA6OiPnhtDUEr
         bDdw==
X-Gm-Message-State: AGRZ1gL+9vKWZM/ChFxAIMl8ryRQ1J9zClYjdaGvgZ1thTJg82uiN7Eg
        0noU5TzaRzqjC0ym1ooocQM=
X-Google-Smtp-Source: AJdET5culwsu7ks7PBreJKixZuZZ8ffcI9WhRmYwFwNuiwOaMH+J3CsUa35JPF0viwUa9qgUgrVv5g==
X-Received: by 2002:a19:d78c:: with SMTP id q12mr8270019lfi.27.1541234945847;
        Sat, 03 Nov 2018 01:49:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 04/14] index-pack: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:40 +0100
Message-Id: <20181103084850.9584-5-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 63 ++++++++++----------------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..682042579b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -42,9 +42,7 @@ struct base_data {
 };
 
 struct thread_local {
-#ifndef NO_PTHREADS
 	pthread_t thread;
-#endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
@@ -98,8 +96,6 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-#ifndef NO_PTHREADS
-
 static struct thread_local *thread_data;
 static int nr_dispatched;
 static int threads_active;
@@ -179,26 +175,6 @@ static void cleanup_thread(void)
 	free(thread_data);
 }
 
-#else
-
-#define read_lock()
-#define read_unlock()
-
-#define counter_lock()
-#define counter_unlock()
-
-#define work_lock()
-#define work_unlock()
-
-#define deepest_delta_lock()
-#define deepest_delta_unlock()
-
-#define type_cas_lock()
-#define type_cas_unlock()
-
-#endif
-
-
 static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
@@ -364,22 +340,20 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 
 static inline struct thread_local *get_thread_data(void)
 {
-#ifndef NO_PTHREADS
-	if (threads_active)
-		return pthread_getspecific(key);
-	assert(!threads_active &&
-	       "This should only be reached when all threads are gone");
-#endif
+	if (HAVE_THREADS) {
+		if (threads_active)
+			return pthread_getspecific(key);
+		assert(!threads_active &&
+		       "This should only be reached when all threads are gone");
+	}
 	return &nothread_data;
 }
 
-#ifndef NO_PTHREADS
 static void set_thread_data(struct thread_local *data)
 {
 	if (threads_active)
 		pthread_setspecific(key, data);
 }
-#endif
 
 static struct base_data *alloc_base_data(void)
 {
@@ -1092,7 +1066,6 @@ static void resolve_base(struct object_entry *obj)
 	find_unresolved_deltas(base_obj);
 }
 
-#ifndef NO_PTHREADS
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
@@ -1116,7 +1089,6 @@ static void *threaded_second_pass(void *data)
 	}
 	return NULL;
 }
-#endif
 
 /*
  * First pass:
@@ -1213,7 +1185,6 @@ static void resolve_deltas(void)
 		progress = start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
-#ifndef NO_PTHREADS
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
@@ -1229,7 +1200,6 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-#endif
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
@@ -1531,11 +1501,10 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
-#ifdef NO_PTHREADS
-		if (nr_threads != 1)
+		if (!HAVE_THREADS && nr_threads != 1) {
 			warning(_("no threads support, ignoring %s"), k);
-		nr_threads = 1;
-#endif
+			nr_threads = 1;
+		}
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -1723,12 +1692,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
-#ifdef NO_PTHREADS
-				if (nr_threads != 1)
-					warning(_("no threads support, "
-						  "ignoring %s"), arg);
-				nr_threads = 1;
-#endif
+				if (!HAVE_THREADS && nr_threads != 1) {
+					warning(_("no threads support, ignoring %s"), arg);
+					nr_threads = 1;
+				}
 			} else if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1791,14 +1758,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		opts.flags |= WRITE_IDX_STRICT;
 
-#ifndef NO_PTHREADS
-	if (!nr_threads) {
+	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
 		/* An experiment showed that more threads does not mean faster */
 		if (nr_threads > 3)
 			nr_threads = 3;
 	}
-#endif
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-- 
2.19.1.1005.gac84295441

