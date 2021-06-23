Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB1C49EA6
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DDF60FE9
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWWAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWWAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21CCC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f15so4267298wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TFPr+taUrhBqz7w7op2Gu//3WbBy++kpegIkMffUcA=;
        b=NIIrDCh/X2DP8O3p0VJi4o+yboL0KuyTAq358DNCXLwX4Il3T8V4NyWQYVYd6rzDEY
         pKwJxYEEIn850ktmGN6exdIg2PxhRodC/ykpQKBpOZCD51FRf++y/9F1Uzw+O1zDoPEU
         /K0UsJoeq1E/AYV38QhuDtHcBYm21Am9HkWNJpllpWeoMgXqQin/j42FRt8Cu4vxlMvv
         4D2EKS+CBDpjdfEhrR37eTS7glXHTXMefvlyf9rdCxDMM6yDGUKQ47IW3vinq+vQUDE0
         LZY36R61jQ4bL8Yx+4ENf7a4jint9czskSWAaxT4935MbkXSITL/asnxEXpFhga5fvyy
         da3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TFPr+taUrhBqz7w7op2Gu//3WbBy++kpegIkMffUcA=;
        b=Wy9ly40CrhyLxu17tIx0f4Lssyv32v1DOQbh0p7R/nxL6509/HvMksvFJJ5xt21/xD
         FUL8eM/VUvsa0ZrUNoO+4qA05kFmieFT5Uu2trdixCK+PXqckMeMjDlWbXNyFS7VJ1EZ
         ieQCCtO7HLMYmbYbmDHc2YMxkC9iB7+J0KMdml/o2JguZzdI8KLm4Kybtt5iZskRDW8N
         czK71vNvxK9t8KOaT7mE3ddjFd2P1+NxE9Xt1QQsAcFCJvMInvpkCiJY3NsYffMotx+d
         uIZ9s/x9BueIm4g6+wivHsjx/eLTDxZ7IcswC7v/4N4yeHfEGEkaubb9w5KW8jBdqF9L
         VEQQ==
X-Gm-Message-State: AOAM530/Au8DcKCRCq7B2UQ2HBEBK2/0uOgMkVVBs89YNDZaAs4iek0S
        JkIwApTNt3wgQbNtCX730wYgnwC+GvY=
X-Google-Smtp-Source: ABdhPJxZiWcBYHzwftLYNcuYYjAk/JmwIOrC8dRxok2WOpNN4k/Pa+bSmRGPvjvO4mRL1DlM7lHzIA==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr296033wrm.143.1624485464300;
        Wed, 23 Jun 2021 14:57:44 -0700 (PDT)
Received: from localhost.localdomain (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id q11sm1192348wrx.80.2021.06.23.14.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:57:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] WIP progress, isatty(2), hidden progress lnies for GIT_TEST_CHECK_PROGRESS
Date:   Wed, 23 Jun 2021 23:57:33 +0200
Message-Id: <20210623215736.8279-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210623215736.8279-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/blame.c          |  6 ++----
 builtin/fsck.c           | 10 +++-------
 builtin/index-pack.c     | 18 +++++++++---------
 builtin/log.c            |  4 ++--
 builtin/prune.c          |  5 +----
 builtin/unpack-objects.c |  6 +++---
 preload-index.c          |  7 +++----
 progress.c               | 26 +++++++++++++++++++-------
 progress.h               |  6 ++++--
 read-cache.c             |  6 +++---
 10 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9a..5efb920dd4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -944,8 +944,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		if (show_progress > 0)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
 		show_progress = 0;
-	} else if (show_progress < 0)
-		show_progress = isatty(2);
+	}
 
 	if (0 < abbrev && abbrev < hexsz)
 		/* one more abbrev length is needed for the boundary commit */
@@ -1153,8 +1152,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
-	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
+	pi.progress = start_delayed_progress_if_tty(_("Blaming lines"), sb.num_lines, show_progress);
 
 	assign_blame(&sb, opt);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f..78e799f748 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -185,8 +185,7 @@ static int traverse_reachable(void)
 	struct progress *progress = NULL;
 	unsigned int nr = 0;
 	int result = 0;
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	progress = start_delayed_progress_if_tty(_("Checking connectivity"), 0, show_progress);
 	while (pending.nr) {
 		result |= traverse_one_object(object_array_pop(&pending));
 		display_progress(progress, ++nr);
@@ -653,8 +652,7 @@ static void fsck_object_dir(const char *path)
 	if (verbose)
 		fprintf_ln(stderr, _("Checking object directory"));
 
-	if (show_progress)
-		progress = start_progress(_("Checking object directories"), 256);
+	progress = start_progress_if_tty(_("Checking object directories"), 256, show_progress);
 
 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
 				      progress);
@@ -789,8 +787,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
-	if (show_progress == -1)
-		show_progress = isatty(2);
 	if (verbose)
 		show_progress = 0;
 
@@ -825,7 +821,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 					total += p->num_objects;
 				}
 
-				progress = start_progress(_("Checking objects"), total);
+				progress = start_progress_if_tty(_("Checking objects"), total, show_progress);
 			}
 			for (p = get_all_packs(the_repository); p;
 			     p = p->next) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3fbc5d7077..0caabe237e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -258,8 +258,8 @@ static unsigned check_objects(void)
 
 	max = get_max_object_index();
 
-	if (verbose)
-		progress = start_delayed_progress(_("Checking objects"), max);
+	progress = start_delayed_progress_if_tty(_("Checking objects"), max,
+						 verbose ? 1 : 0);
 
 	for (i = 0; i < max; i++) {
 		foreign_nr += check_object(get_indexed_object(i));
@@ -1157,10 +1157,9 @@ static void parse_pack_objects(unsigned char *hash)
 	struct object_id ref_delta_oid;
 	struct stat st;
 
-	if (verbose)
-		progress = start_progress(
-				from_stdin ? _("Receiving objects") : _("Indexing objects"),
-				nr_objects);
+	progress = start_progress_if_tty(
+			from_stdin ? _("Receiving objects") : _("Indexing objects"),
+			nr_objects, verbose ? 1 : 0);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
@@ -1235,9 +1234,10 @@ static void resolve_deltas(void)
 	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry);
 	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
 
-	if (verbose || show_resolving_progress)
-		progress = start_progress(_("Resolving deltas"),
-					  nr_ref_deltas + nr_ofs_deltas);
+	/* TODO: breaks 5309.3 and .4 */
+	progress = start_progress_if_tty(_("Resolving deltas"),
+					 nr_ref_deltas + nr_ofs_deltas,
+					 verbose || show_resolving_progress ? 1 : 0);
 
 	nr_dispatched = 0;
 	base_cache_limit = delta_base_cache_limit * nr_threads;
diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..41bcd4d0fb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2154,8 +2154,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	rev.add_signoff = do_signoff;
 
-	if (show_progress)
-		progress = start_delayed_progress(_("Generating patches"), total);
+	progress = start_delayed_progress_if_tty(_("Generating patches"), total,
+						 show_progress);
 	while (0 <= --nr) {
 		int shown;
 		display_progress(progress, total - nr);
diff --git a/builtin/prune.c b/builtin/prune.c
index 02c6ab7cba..2ee1baf40d 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -41,8 +41,7 @@ static void perform_reachability_traversal(struct rev_info *revs)
 	if (initialized)
 		return;
 
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	progress = start_delayed_progress_if_tty(_("Checking connectivity"), 0, show_progress);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
 	initialized = 1;
@@ -164,8 +163,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			die("unrecognized argument: %s", name);
 	}
 
-	if (show_progress == -1)
-		show_progress = isatty(2);
 	if (exclude_promisor_objects) {
 		fetch_if_missing = 0;
 		revs.exclude_promisor_objects = 1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..8517522a31 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -14,7 +14,7 @@
 #include "decorate.h"
 #include "fsck.h"
 
-static int dry_run, quiet, recover, has_errors, strict;
+static int dry_run, quiet = -1, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
 /* We always read in 4kB chunks. */
@@ -500,8 +500,8 @@ static void unpack_all(void)
 			ntohl(hdr->hdr_version));
 	use(sizeof(struct pack_header));
 
-	if (!quiet)
-		progress = start_progress(_("Unpacking objects"), nr_objects);
+	progress = start_progress_if_tty(_("Unpacking objects"), nr_objects,
+					 quiet ? 0 : -1);
 	CALLOC_ARRAY(obj_list, nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
diff --git a/preload-index.c b/preload-index.c
index e5529a5863..aae6e4a042 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -121,10 +121,9 @@ void preload_index(struct index_state *index,
 	memset(&data, 0, sizeof(data));
 
 	memset(&pd, 0, sizeof(pd));
-	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
-		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
-		pthread_mutex_init(&pd.mutex, NULL);
-	}
+	pd.progress = start_delayed_progress_if_tty(_("Refreshing index"),index->cache_nr,
+						   refresh_flags & REFRESH_PROGRESS ? -1 : 0);
+	pthread_mutex_init(&pd.mutex, NULL);
 
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
diff --git a/progress.c b/progress.c
index 034d50cd6b..99e130f1eb 100644
--- a/progress.c
+++ b/progress.c
@@ -43,6 +43,7 @@ struct progress {
 	struct strbuf counters_sb;
 	int title_len;
 	int split;
+	int hidden;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -123,6 +124,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 
 	progress->last_value = n;
 
+	if (progress->hidden)
+		return;
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
@@ -261,15 +264,23 @@ void display_progress(struct progress *progress, uint64_t n)
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
-					     unsigned delay, unsigned sparse)
+					     unsigned delay, unsigned sparse,
+					     int show)
 {
 	struct progress *progress;
 
 	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
+
+	if (show == -1)
+		show = isatty(STDERR_FILENO);
+
 	if (test_check_progress && current_progress)
 		BUG("progress \"%s\" is still active when starting new progress \"%s\"",
 		    current_progress->title, title);
 
+	if (!show && !test_check_progress)
+		return NULL;
+
 	progress = xmalloc(sizeof(*progress));
 	current_progress = progress;
 	progress->title = title;
@@ -283,6 +294,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
+	progress->hidden = !show;
 	set_progress_signal();
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
@@ -298,14 +310,14 @@ static int get_default_delay(void)
 	return delay_in_secs;
 }
 
-struct progress *start_delayed_progress(const char *title, uint64_t total)
+struct progress *start_delayed_progress_if_tty(const char *title, uint64_t total, int show)
 {
-	return start_progress_delay(title, total, get_default_delay(), 0);
+	return start_progress_delay(title, total, get_default_delay(), 0, show);
 }
 
-struct progress *start_progress(const char *title, uint64_t total)
+struct progress *start_progress_if_tty(const char *title, uint64_t total, int show)
 {
-	return start_progress_delay(title, total, 0, 0);
+	return start_progress_delay(title, total, 0, 0, show);
 }
 
 /*
@@ -319,13 +331,13 @@ struct progress *start_progress(const char *title, uint64_t total)
  */
 struct progress *start_sparse_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0, 1);
+	return start_progress_delay(title, total, 0, 1, 1);
 }
 
 struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total)
 {
-	return start_progress_delay(title, total, get_default_delay(), 1);
+	return start_progress_delay(title, total, get_default_delay(), 1, 1);
 }
 
 static void finish_if_sparse(struct progress *progress)
diff --git a/progress.h b/progress.h
index f1913acf73..7c3bdd3d63 100644
--- a/progress.h
+++ b/progress.h
@@ -13,9 +13,11 @@ void progress_test_force_update(void);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
-struct progress *start_progress(const char *title, uint64_t total);
+#define start_progress(title, total) start_progress_if_tty((title), (total), 1)
+struct progress *start_progress_if_tty(const char *title, uint64_t total, int show);
 struct progress *start_sparse_progress(const char *title, uint64_t total);
-struct progress *start_delayed_progress(const char *title, uint64_t total);
+#define start_delayed_progress(title, total) start_delayed_progress_if_tty((title), (total), 1)
+struct progress *start_delayed_progress_if_tty(const char *title, uint64_t total, int show);
 struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total);
 void stop_progress(struct progress **progress);
diff --git a/read-cache.c b/read-cache.c
index 1b3c2eb408..c3fc797639 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1567,9 +1567,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_lstat = 0;
 	int t2_sum_scan = 0;
 
-	if (flags & REFRESH_PROGRESS && isatty(2))
-		progress = start_delayed_progress(_("Refresh index"),
-						  istate->cache_nr);
+	progress = start_delayed_progress_if_tty(_("Refresh index"),
+						 istate->cache_nr,
+						 flags & REFRESH_PROGRESS ? -1 : 0);
 
 	trace_performance_enter();
 	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
-- 
2.32.0.289.g44fbea0957

