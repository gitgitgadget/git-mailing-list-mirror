Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BD31F404
	for <e@80x24.org>; Fri,  7 Sep 2018 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIGUdN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 16:33:13 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33271 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGUdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 16:33:12 -0400
Received: by mail-lf1-f48.google.com with SMTP id m26-v6so12444059lfb.0
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5imX6hRM+ganpLiJlzYRROETUKOAf8ca55Y3nvbF964=;
        b=bj7Bgt1FV60djubaCKQxSVmBExyLHEFxA++oOUubNYlUiuuNla/ey6bHOPuwjE8mRI
         bPMvbNqnR6pTHURaNIzijauYVllInRuL+4m8f1d4gI4J/lrLGn596hJVnD69daEFSzQQ
         YAGz6b0WbBxczRFPYCM3h4InXkpH6FzlIpiSwGsHHtn8lfp2lz3Yow+E6aMOmr1pKYR9
         RbAWY1O/M1lQBLpgp8YOvJjWDMq2JoizFvz85WEeeriy7x8KkDnYuiBbnSR0ODE0vaTA
         4iv+Nd2kvio7CnDjHdTt9dBXpPEFBeBvIse59N4rsQoDXj6gQfLxsOC3vyDieb1Y/B48
         2IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5imX6hRM+ganpLiJlzYRROETUKOAf8ca55Y3nvbF964=;
        b=oH/7sPL7uNllE8BBRKMyCDSYi5AA/K+/1JMjTb8VxDV+5M5EoQn7CP9TFLjoWDctSc
         d8Iuxj8KEbfYOIOwSWvBJ07hKfz/Y0c9GXQltLSWiYBfSgGivZy2X1D39IGS+1yVbzaw
         Wxk3pbAXMenozMzPFNM644GAgoMZaLCPP1Ibvv2JbKfeNAIPvXNiANdJJQ9Q4mywj5EC
         SgXp4QaMSPW/Vt8P+BGJ9M9NuTeUdByUjtUjVD8OiB8t4cXpQXuPyDO2iA5JEnBfXJbf
         OyN1ZzlJijJZ42oVOp+uT58yzICWVgtd2uSIr6iw+VR1GCLcWyu0M6hpk3LsdCLwcM+S
         rRgA==
X-Gm-Message-State: APzg51DMMeuY1hWfHbq08tC5upeK0YHeZStoRKiwxu0CqRmjQS1xh3Ad
        WgGcOzSDrTA1da55bR3DZ+Vs+2n+
X-Google-Smtp-Source: ANB0VdZbSwMhT2sMtMoyVA2PivmfjiUJGo24jmYCHyDNSRwZKVyWdaa7WDl46rWmMaaLc/J2xDHa1A==
X-Received: by 2002:a19:9bcc:: with SMTP id d195-v6mr5859183lfe.123.1536335498526;
        Fri, 07 Sep 2018 08:51:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k4-v6sm1361468ljc.6.2018.09.07.08.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:51:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] status: show progress bar if refreshing the index takes too long
Date:   Fri,  7 Sep 2018 17:51:33 +0200
Message-Id: <20180907155133.27737-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refreshing the index is usually very fast, but it can still take a
long time sometimes. Cold cache is one, or something else silly (*).
In this case, it's good to show something to let the user know "git
status" is not hanging, it's just busy doing something.

(*) I got called by my colleague because her "git status" took very
    long and looked pretty much like hanging. After a bit of strace,
    it looks to me that git was trying to rehash every single file,
    and this was a big repository. This process could take minutes.

    In this case, I think it was probably because she copied this
    repository to a new place and stat data did not match anymore. So
    git fell back to hashing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I need to get this out of my head before I forget. I obviously think
 this is a good idea and could be done in more places, even just to
 deal with cold cache. The hint about "git status -uno" for example,
 could be accompanied by a progress bar for scanning for untracked
 files...

 Another note about rehashing files as part of refresh. We probably
 could do better by hashing in parallel. Or perhaps not because having
 a big lock around object database pretty much kills performance, and
 if I remember correctly none of my core was 100% consumed (i.e. CPU
 bottleneck as an indication that multithread is a good idea...)

 Anyway that's it! Weekend after a long week! I'll read mails and
 respond tomorrow.

 builtin/am.c     |  2 +-
 builtin/commit.c |  6 ++++--
 cache.h          |  7 +++++--
 preload-index.c  | 44 +++++++++++++++++++++++++++++++++++++++-----
 read-cache.c     | 10 ++++++++++
 sequencer.c      |  2 +-
 6 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5e866d17c7..22a93cfef3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2324,7 +2324,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	/* Ensure a valid committer ident can be constructed */
 	git_committer_info(IDENT_STRICT);
 
-	if (read_index_preload(&the_index, NULL) < 0)
+	if (read_index_preload(&the_index, NULL, 0) < 0)
 		die(_("failed to read the index"));
 
 	if (in_progress) {
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..eaf639ece6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1355,8 +1355,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
-	read_cache_preload(&s.pathspec);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
+	read_index_preload(&the_index, &s.pathspec, REFRESH_PROGRESS);
+	refresh_index(&the_index,
+		      REFRESH_QUIET|REFRESH_UNMERGED|REFRESH_PROGRESS,
+		      &s.pathspec, NULL, NULL);
 
 	if (use_optional_locks())
 		fd = hold_locked_index(&index_lock, 0);
diff --git a/cache.h b/cache.h
index 4d014541ab..35da02be90 100644
--- a/cache.h
+++ b/cache.h
@@ -410,7 +410,7 @@ void validate_cache_entries(const struct index_state *istate);
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
-#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
+#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec), 0)
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
@@ -659,7 +659,9 @@ extern int daemonize(void);
 /* Initialize and use the cache information */
 struct lock_file;
 extern int read_index(struct index_state *);
-extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
+extern int read_index_preload(struct index_state *,
+			      const struct pathspec *pathspec,
+			      unsigned int refresh_flags);
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path,
@@ -814,6 +816,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..bf7dbed779 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,10 +5,12 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "progress.h"
 
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec)
+			  const struct pathspec *pathspec,
+			  unsigned int refresh_flags)
 {
 	; /* nothing */
 }
@@ -25,16 +27,23 @@ static void preload_index(struct index_state *index,
 #define MAX_PARALLEL (20)
 #define THREAD_COST (500)
 
+struct progress_data {
+	unsigned long n;
+	struct progress *progress;
+	pthread_mutex_t mutex;
+};
+
 struct thread_data {
 	pthread_t pthread;
 	struct index_state *index;
 	struct pathspec pathspec;
+	struct progress_data *progress;
 	int offset, nr;
 };
 
 static void *preload_thread(void *_data)
 {
-	int nr;
+	int nr, last_nr;
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_entry **cep = index->cache + p->offset;
@@ -43,6 +52,7 @@ static void *preload_thread(void *_data)
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
 		nr = index->cache_nr - p->offset;
+	last_nr = nr;
 
 	do {
 		struct cache_entry *ce = *cep++;
@@ -58,6 +68,15 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
+		if (p->progress && !(nr & 31)) {
+			struct progress_data *pd = p->progress;
+
+			pthread_mutex_lock(&pd->mutex);
+			pd->n += last_nr - nr;
+			display_progress(pd->progress, pd->n);
+			pthread_mutex_unlock(&pd->mutex);
+			last_nr = nr;
+		}
 		if (!ce_path_match(index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
@@ -74,11 +93,13 @@ static void *preload_thread(void *_data)
 }
 
 static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec)
+			  const struct pathspec *pathspec,
+			  unsigned int refresh_flags)
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
 	uint64_t start = getnanotime();
+	struct progress_data pd;
 
 	if (!core_preload_index)
 		return;
@@ -93,6 +114,13 @@ static void preload_index(struct index_state *index,
 	offset = 0;
 	work = DIV_ROUND_UP(index->cache_nr, threads);
 	memset(&data, 0, sizeof(data));
+
+	memset(&pd, 0, sizeof(pd));
+	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
+		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
+		pthread_mutex_init(&pd.mutex, NULL);
+	}
+
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
 		p->index = index;
@@ -100,6 +128,8 @@ static void preload_index(struct index_state *index,
 			copy_pathspec(&p->pathspec, pathspec);
 		p->offset = offset;
 		p->nr = work;
+		if (pd.progress)
+			p->progress = &pd;
 		offset += work;
 		if (pthread_create(&p->pthread, NULL, preload_thread, p))
 			die("unable to create threaded lstat");
@@ -109,15 +139,19 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	if (pd.progress)
+		stop_progress(&pd.progress);
+
 	trace_performance_since(start, "preload index");
 }
 #endif
 
 int read_index_preload(struct index_state *index,
-		       const struct pathspec *pathspec)
+		       const struct pathspec *pathspec,
+		       unsigned int refresh_flags)
 {
 	int retval = read_index(index);
 
-	preload_index(index, pathspec);
+	preload_index(index, pathspec, refresh_flags);
 	return retval;
 }
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..e8725a5162 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#include "progress.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1477,6 +1478,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *added_fmt;
 	const char *unmerged_fmt;
 	uint64_t start = getnanotime();
+	struct progress *progress = NULL;
+
+	if (flags & REFRESH_PROGRESS && isatty(2))
+		progress = start_delayed_progress(_("Refresh index"),
+						  istate->cache_nr);
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1516,6 +1522,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
 		if (new_entry == ce)
 			continue;
+		if (progress)
+			display_progress(progress, i);
 		if (!new_entry) {
 			const char *fmt;
 
@@ -1547,6 +1555,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new_entry);
 	}
+	if (progress)
+		stop_progress(&progress);
 	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..e0cd17df70 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1909,7 +1909,7 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL) < 0) {
+	if (read_index_preload(&the_index, NULL, 0) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));
-- 
2.19.0.rc0.337.ge906d732e7

