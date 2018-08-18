Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B515E1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRRth (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44136 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeHRRtg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so8479771ljq.11
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mfKCekqtFCLDnI48QPSIkJiOip8DJ08EugOBV0fpj4=;
        b=FEbviuIqoYfBq3cuM7Qz5LOhAAOyT72sKmbgvXdNCmALweJg0I9f0lsg97EnOqBlOJ
         EcQ//vbheeXuAoh92BtUgsD+WmMB0OHh7YuzkwwL5JotM2uo/jqFG33Ep4kHq0igBDAk
         JIcCU2rlSDFZzXUDSv6ezjsGlK/R4WLZBfXXdNUQObi+ib5HGxgaIPmpqZsFZ+UMZlpe
         PuDU8UfcOPoMFcr2Asymkr92mhx3L9vzeHAtqT7j+t/p4ZAgShtoPSUE8nGXgrOG8KFC
         3SKKAGZeWVbLKeh0f0ZxJCyHqLbo5aKYBbnbhabypDHDW3AGBD4gd1E7dVYfCeRLdc8c
         Kiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mfKCekqtFCLDnI48QPSIkJiOip8DJ08EugOBV0fpj4=;
        b=UsGsivBZg+ClrdfJuUt0843a0+MUx884P8bMLwDu4igaKKaf9Zzg/Oxq3A/4lNBNjU
         tPNcmJcDIVTZMApqmIGe/fJR2bJiitxMeH5G2vNgMNhTskWp2ke58oM74vty8Bjmg4dU
         DVnS+0osWJMjIUMDXdhXvpVEJ+pW4n/uPPPcDDB/WRqNpi8q+5sx4DcDFC9N5v/iVMjc
         8tFOwJGNXIDT/fjwyYySZtjBcIJNkwzwCPRTSmwxLDkQI498Y2NATnRtyqvs0fRlRcML
         jS3AAUlo72o0WM38ZffEv6WIx4RJthz7maxKDYx4A5OlvbulZuyfD5G+2erpthib5HXA
         nN1Q==
X-Gm-Message-State: AOUpUlF7+5WbLwXo5Pg6XMK0HHuM0jbzogmlPiXu165fZHcWEiZBzVpK
        h48IOPUGOFKCKxVjsgTL0pA=
X-Google-Smtp-Source: AA+uWPwAQjDyj3Dbwt2jB5JZaFSuNzLKVHan9d7Ntr3hBqmwQdUQIjOgYCbyzF9abIwT2zclEZTR5g==
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr26403234ljj.143.1534603298850;
        Sat, 18 Aug 2018 07:41:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 1/7] trace.h: support nested performance tracing
Date:   Sat, 18 Aug 2018 16:41:22 +0200
Message-Id: <20180818144128.19361-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Performance measurements are listed right now as a flat list, which is
fine when we measure big blocks. But when we start adding more and
more measurements, some of them could be just part of a bigger
measurement and a flat list gives a wrong impression that they are
executed at the same level instead of nested.

Add trace_performance_enter() and trace_performance_leave() to allow
indent these nested measurements. For now it does not help much
because the only nested thing is (lazy) name hash initialization
(e.g. called in diff-index from "git status"). This will help more
because I'm going to add some more tracing that's actually nested.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c      |  4 +--
 dir.c           |  9 ++++---
 name-hash.c     |  4 +--
 preload-index.c |  4 +--
 read-cache.c    | 11 ++++----
 trace.c         | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 trace.h         | 15 +++++++++++
 7 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 732f684a49..d5bbb7ea50 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -518,11 +518,11 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
-	uint64_t start = getnanotime();
 
 	if (revs->pending.nr != 1)
 		BUG("run_diff_index must be passed exactly one tree");
 
+	trace_performance_enter();
 	ent = revs->pending.objects;
 	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
 		exit(128);
@@ -531,7 +531,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	diffcore_fix_diff_index(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	trace_performance_since(start, "diff-index");
+	trace_performance_leave("diff-index");
 	return 0;
 }
 
diff --git a/dir.c b/dir.c
index 32f5f72759..18b57b94cc 100644
--- a/dir.c
+++ b/dir.c
@@ -2263,10 +2263,13 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
-	uint64_t start = getnanotime();
 
-	if (has_symlink_leading_path(path, len))
+	trace_performance_enter();
+
+	if (has_symlink_leading_path(path, len)) {
+		trace_performance_leave("read directory %.*s", len, path);
 		return dir->nr;
+	}
 
 	untracked = validate_untracked_cache(dir, len, pathspec);
 	if (!untracked)
@@ -2302,7 +2305,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		dir->nr = i;
 	}
 
-	trace_performance_since(start, "read directory %.*s", len, path);
+	trace_performance_leave("read directory %.*s", len, path);
 	if (dir->untracked) {
 		static int force_untracked_cache = -1;
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
diff --git a/name-hash.c b/name-hash.c
index 163849831c..1fcda73cb3 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -578,10 +578,10 @@ static void threaded_lazy_init_name_hash(
 
 static void lazy_init_name_hash(struct index_state *istate)
 {
-	uint64_t start = getnanotime();
 
 	if (istate->name_hash_initialized)
 		return;
+	trace_performance_enter();
 	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
 
@@ -602,7 +602,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	}
 
 	istate->name_hash_initialized = 1;
-	trace_performance_since(start, "initialize name hash");
+	trace_performance_leave("initialize name hash");
 }
 
 /*
diff --git a/preload-index.c b/preload-index.c
index 4d08d44874..d7f7919ba2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -78,7 +78,6 @@ static void preload_index(struct index_state *index,
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
-	uint64_t start = getnanotime();
 
 	if (!core_preload_index)
 		return;
@@ -88,6 +87,7 @@ static void preload_index(struct index_state *index,
 		threads = 2;
 	if (threads < 2)
 		return;
+	trace_performance_enter();
 	if (threads > MAX_PARALLEL)
 		threads = MAX_PARALLEL;
 	offset = 0;
@@ -109,7 +109,7 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
-	trace_performance_since(start, "preload index");
+	trace_performance_leave("preload index");
 }
 #endif
 
diff --git a/read-cache.c b/read-cache.c
index c5fabc844a..1c9c88c130 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1476,8 +1476,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
-	uint64_t start = getnanotime();
 
+	trace_performance_enter();
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
 	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
@@ -1547,7 +1547,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new_entry);
 	}
-	trace_performance_since(start, "refresh index");
+	trace_performance_leave("refresh index");
 	return has_errors;
 }
 
@@ -2002,7 +2002,6 @@ static void freshen_shared_index(const char *shared_index, int warn)
 int read_index_from(struct index_state *istate, const char *path,
 		    const char *gitdir)
 {
-	uint64_t start = getnanotime();
 	struct split_index *split_index;
 	int ret;
 	char *base_oid_hex;
@@ -2012,8 +2011,9 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	trace_performance_enter();
 	ret = do_read_index(istate, path, 0);
-	trace_performance_since(start, "read cache %s", path);
+	trace_performance_leave("read cache %s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_oid(&split_index->base_oid)) {
@@ -2021,6 +2021,7 @@ int read_index_from(struct index_state *istate, const char *path,
 		return ret;
 	}
 
+	trace_performance_enter();
 	if (split_index->base)
 		discard_index(split_index->base);
 	else
@@ -2037,8 +2038,8 @@ int read_index_from(struct index_state *istate, const char *path,
 	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
-	trace_performance_since(start, "read cache %s", base_path);
 	free(base_path);
+	trace_performance_leave("read cache %s", base_path);
 	return ret;
 }
 
diff --git a/trace.c b/trace.c
index fc623e91fd..fa4a2e7120 100644
--- a/trace.c
+++ b/trace.c
@@ -176,10 +176,30 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 	strbuf_release(&buf);
 }
 
+static uint64_t perf_start_times[10];
+static int perf_indent;
+
+uint64_t trace_performance_enter(void)
+{
+	uint64_t now;
+
+	if (!trace_want(&trace_perf_key))
+		return 0;
+
+	now = getnanotime();
+	perf_start_times[perf_indent] = now;
+	if (perf_indent + 1 < ARRAY_SIZE(perf_start_times))
+		perf_indent++;
+	else
+		BUG("Too deep indentation");
+	return now;
+}
+
 static void trace_performance_vprintf_fl(const char *file, int line,
 					 uint64_t nanos, const char *format,
 					 va_list ap)
 {
+	static const char space[] = "          ";
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!prepare_trace_line(file, line, &trace_perf_key, &buf))
@@ -188,7 +208,10 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	strbuf_addf(&buf, "performance: %.9f s", (double) nanos / 1000000000);
 
 	if (format && *format) {
-		strbuf_addstr(&buf, ": ");
+		if (perf_indent >= strlen(space))
+			BUG("Too deep indentation");
+
+		strbuf_addf(&buf, ":%.*s ", perf_indent, space);
 		strbuf_vaddf(&buf, format, ap);
 	}
 
@@ -244,6 +267,24 @@ void trace_performance_since(uint64_t start, const char *format, ...)
 	va_end(ap);
 }
 
+void trace_performance_leave(const char *format, ...)
+{
+	va_list ap;
+	uint64_t since;
+
+	if (perf_indent)
+		perf_indent--;
+
+	if (!format) /* Allow callers to leave without tracing anything */
+		return;
+
+	since = perf_start_times[perf_indent];
+	va_start(ap, format);
+	trace_performance_vprintf_fl(NULL, 0, getnanotime() - since,
+				     format, ap);
+	va_end(ap);
+}
+
 #else
 
 void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
@@ -273,6 +314,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 	va_end(ap);
 }
 
+void trace_performance_leave_fl(const char *file, int line,
+				uint64_t nanos, const char *format, ...)
+{
+	va_list ap;
+	uint64_t since;
+
+	if (perf_indent)
+		perf_indent--;
+
+	if (!format) /* Allow callers to leave without tracing anything */
+		return;
+
+	since = perf_start_times[perf_indent];
+	va_start(ap, format);
+	trace_performance_vprintf_fl(file, line, nanos - since, format, ap);
+	va_end(ap);
+}
+
 #endif /* HAVE_VARIADIC_MACROS */
 
 
@@ -411,13 +470,11 @@ uint64_t getnanotime(void)
 	}
 }
 
-static uint64_t command_start_time;
 static struct strbuf command_line = STRBUF_INIT;
 
 static void print_command_performance_atexit(void)
 {
-	trace_performance_since(command_start_time, "git command:%s",
-				command_line.buf);
+	trace_performance_leave("git command:%s", command_line.buf);
 }
 
 void trace_command_performance(const char **argv)
@@ -425,10 +482,10 @@ void trace_command_performance(const char **argv)
 	if (!trace_want(&trace_perf_key))
 		return;
 
-	if (!command_start_time)
+	if (!command_line.len)
 		atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
 	sq_quote_argv_pretty(&command_line, argv);
-	command_start_time = getnanotime();
+	trace_performance_enter();
 }
diff --git a/trace.h b/trace.h
index 2b6a1bc17c..171b256d26 100644
--- a/trace.h
+++ b/trace.h
@@ -23,6 +23,7 @@ extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
 extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
+uint64_t trace_performance_enter(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
@@ -45,6 +46,9 @@ extern void trace_performance(uint64_t nanos, const char *format, ...);
 __attribute__((format (printf, 2, 3)))
 extern void trace_performance_since(uint64_t start, const char *format, ...);
 
+__attribute__((format (printf, 1, 2)))
+void trace_performance_leave(const char *format, ...);
+
 #else
 
 /*
@@ -118,6 +122,14 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 					     __VA_ARGS__);		    \
 	} while (0)
 
+#define trace_performance_leave(...)					    \
+	do {								    \
+		if (trace_pass_fl(&trace_perf_key))			    \
+			trace_performance_leave_fl(TRACE_CONTEXT, __LINE__, \
+						   getnanotime(),	    \
+						   __VA_ARGS__);	    \
+	} while (0)
+
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
 extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
@@ -130,6 +142,9 @@ extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 __attribute__((format (printf, 4, 5)))
 extern void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
+__attribute__((format (printf, 4, 5)))
+extern void trace_performance_leave_fl(const char *file, int line,
+				       uint64_t nanos, const char *fmt, ...);
 static inline int trace_pass_fl(struct trace_key *key)
 {
 	return key->fd || !key->initialized;
-- 
2.18.0.1004.g6639190530

