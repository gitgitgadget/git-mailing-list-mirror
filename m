Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1FDC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbiCGLjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiCGLjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:39:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BB2253D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:38:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n15so8642371wra.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1/SLWK0P/LJGLM6LOGHrdf4a7IXTgX6LFMYgzXJqXU=;
        b=NmMaxQ0JobWgiZIjfp2ksohlwEnLYtOAvZSTcN68lxRBudYAv5JqKbJGzU2RokJQBl
         qC4fOur1BLnBhQuGFArQLmh1FeRP/k+fl3zC8/Bl+2jISCtpH4mA1HSwfLf4z9fVht75
         wGMu/N3SbofwczjGlKkA1a+PXqc+/oZPXS55AYYsXTUbmD68NlbNs86DqJgfzujnnDDZ
         lfEOg8S84VtAU6uCfa2yYq97Dlpr96euLzm46rm9YMH1mEuzjY4xFQe4Mb31dC/HNOP1
         aDtey9x8uy0GbtWdD1NtbuhXSfOdsAvNzEtk3FGIEL7KKyE1Gu0q2fkCw4yrCJ/IGj1J
         R4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1/SLWK0P/LJGLM6LOGHrdf4a7IXTgX6LFMYgzXJqXU=;
        b=dIBMl17oKDCFT9cErfYIExNIISbvBO6Ca15mdcGqTF6wFZmfqtUKmx47k60kW3b2oM
         glQg3uN25I1f71rZAzgoIkyQ30jBGrFAecppqjXAmgCnwHQtW9yCWo7X04AnNou7bZtd
         L5+XGdEPMVEaI2YtuakqIres+JSKH/mDizW71Cy1fZO698BGNdo6ABhzIVLcPXq775zP
         +wGGZnNMrDPMDlV+Nssk9Yw2sXwSQ6NlmYQ0su6/PytyS9dUV7E745tchO2URTiXe4ls
         2tgXepon5bZTQzzAagJXIHDvCWnSKPgXSozr3PeVeAubs+jnKeCsG0rcZ3LsJnI3tErc
         aVVg==
X-Gm-Message-State: AOAM530gJzeeZYS3fN5m6DrF7WAyIuwGkhBbsYB6KOqNiMbmMllMEH6E
        fkFWQqGX8qiPVX/IN8g4ltSiqMhvMZ6zzw==
X-Google-Smtp-Source: ABdhPJy/WNU0n+qtDl/GpHv+qUVs7GowCt0y9Fa0NOjz4g0hpOF4T5h7wHI/2sytSqjsyX6pKl2gRA==
X-Received: by 2002:adf:f94a:0:b0:1ef:9485:e43d with SMTP id q10-20020adff94a000000b001ef9485e43dmr7736151wrr.552.1646653097213;
        Mon, 07 Mar 2022 03:38:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm1809074wmq.4.2022.03.07.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:38:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] string-list API: change "nr" and "alloc" to "size_t"
Date:   Mon,  7 Mar 2022 12:38:01 +0100
Message-Id: <patch-2.2-398682c07aa-20220307T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1241.gd8d69a17521
In-Reply-To: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "nr" and "alloc" members of "struct string_list" to use
"size_t" instead of "nr". On some platforms the size of an "unsigned
int" will be smaller than a "size_t", e.g. a 32 bit unsigned v.s. 64
bit unsigned. As "struct string_list" is a generic API we use in a lot
of places this might cause overflows.

As one example: code in "refs.c" keeps track of the number of refs
with a "size_t", and auxiliary code in builtin/remote.c in
get_ref_states() appends those to a "struct string_list".

While we're at it split the "nr" and "alloc" in string-list.h across
two lines, which is the case for most such struct member
declarations (e.g. in "strbuf.h" and "strvec.h").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c      |  9 +++++----
 builtin/shortlog.c          | 10 +++++-----
 bundle.c                    | 12 ++++++------
 commit-graph.c              |  8 ++++----
 mailmap.c                   |  7 ++++---
 merge-ort.c                 |  4 ++--
 string-list.h               |  3 ++-
 t/helper/test-run-command.c |  7 ++++---
 wt-status.c                 | 16 ++++++++--------
 9 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d10aeb7e78f..fc948a27c4f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -813,13 +813,14 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.trace2_hook_name = hook_name;
 
 	if (feed_state->push_options) {
-		int i;
+		size_t i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
 			strvec_pushf(&proc.env_array,
-				     "GIT_PUSH_OPTION_%d=%s", i,
+				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
+				     (uintmax_t)i,
 				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
-			     feed_state->push_options->nr);
+		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
+			     (uintmax_t)feed_state->push_options->nr);
 	} else
 		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 228d782754a..26c5c0cf935 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -435,7 +435,7 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 
 void shortlog_output(struct shortlog *log)
 {
-	int i, j;
+	size_t i, j;
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
@@ -448,10 +448,10 @@ void shortlog_output(struct shortlog *log)
 				(int)UTIL_TO_INT(item), item->string);
 		} else {
 			struct string_list *onelines = item->util;
-			fprintf(log->file, "%s (%d):\n",
-				item->string, onelines->nr);
-			for (j = onelines->nr - 1; j >= 0; j--) {
-				const char *msg = onelines->items[j].string;
+			fprintf(log->file, "%s (%"PRIuMAX"):\n",
+				item->string, (uintmax_t)onelines->nr);
+			for (j = onelines->nr; j >= 1; j--) {
+				const char *msg = onelines->items[j - 1].string;
 
 				if (log->wrap_lines) {
 					strbuf_reset(&sb);
diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..0ebc8733679 100644
--- a/bundle.c
+++ b/bundle.c
@@ -255,18 +255,18 @@ int verify_bundle(struct repository *r,
 
 		r = &header->references;
 		printf_ln(Q_("The bundle contains this ref:",
-			     "The bundle contains these %d refs:",
-			     r->nr),
-			  r->nr);
+			     "The bundle contains these %"PRIuMAX" refs:",
+			     (unsigned long)r->nr),
+			  (uintmax_t)r->nr);
 		list_refs(r, 0, NULL);
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
 		} else {
 			printf_ln(Q_("The bundle requires this ref:",
-				     "The bundle requires these %d refs:",
-				     r->nr),
-				  r->nr);
+				     "The bundle requires these %"PRIuMAX" refs:",
+				     (unsigned long)r->nr),
+				  (uintmax_t)r->nr);
 			list_refs(r, 0, NULL);
 		}
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..c7584f802b0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1690,10 +1690,10 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
-			    Q_("Finding commits for commit graph in %d pack",
-			       "Finding commits for commit graph in %d packs",
-			       pack_indexes->nr),
-			    pack_indexes->nr);
+			    Q_("Finding commits for commit graph in %"PRIuMAX" pack",
+			       "Finding commits for commit graph in %"PRIuMAX" packs",
+			       (unsigned long)pack_indexes->nr),
+			    (uintmax_t)pack_indexes->nr);
 		ctx->progress = start_delayed_progress(progress_title.buf, 0);
 		ctx->progress_done = 0;
 	}
diff --git a/mailmap.c b/mailmap.c
index 40ce152024d..7befdc5e483 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -43,8 +43,8 @@ static void free_mailmap_info(void *p, const char *s)
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
-	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
-		 s, me->namemap.nr);
+	debug_mm("mailmap: removing entries for <%s>, with %"PRIuMAX" sub-entries\n",
+		 s, (uintmax_t)me->namemap.nr);
 	debug_mm("mailmap: - simple: '%s' <%s>\n",
 		 debug_str(me->name), debug_str(me->email));
 
@@ -250,7 +250,8 @@ int read_mailmap(struct string_list *map)
 
 void clear_mailmap(struct string_list *map)
 {
-	debug_mm("mailmap: clearing %d entries...\n", map->nr);
+	debug_mm("mailmap: clearing %"PRIuMAX" entries...\n",
+		 (uintmax_t)map->nr);
 	map->strdup_strings = 1;
 	string_list_clear_func(map, free_mailmap_entry);
 	debug_mm("mailmap: cleared\n");
diff --git a/merge-ort.c b/merge-ort.c
index 55decb2587e..bb2be2a2758 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4064,8 +4064,8 @@ static void process_entries(struct merge_options *opt,
 	trace2_region_enter("merge", "process_entries cleanup", opt->repo);
 	if (dir_metadata.offsets.nr != 1 ||
 	    (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
-		printf("dir_metadata.offsets.nr = %d (should be 1)\n",
-		       dir_metadata.offsets.nr);
+		printf("dir_metadata.offsets.nr = %"PRIuMAX" (should be 1)\n",
+		       (uintmax_t)dir_metadata.offsets.nr);
 		printf("dir_metadata.offsets.items[0].util = %u (should be 0)\n",
 		       (unsigned)(uintptr_t)dir_metadata.offsets.items[0].util);
 		fflush(stdout);
diff --git a/string-list.h b/string-list.h
index 267d6e5769d..d5a744e1438 100644
--- a/string-list.h
+++ b/string-list.h
@@ -86,7 +86,8 @@ typedef int (*compare_strings_fn)(const char *, const char *);
  */
 struct string_list {
 	struct string_list_item *items;
-	unsigned int nr, alloc;
+	size_t nr;
+	size_t alloc;
 	unsigned int strdup_strings:1;
 	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 913775a14b7..eabd28defc5 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -180,15 +180,16 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs > suite.tests.nr)
 		max_jobs = suite.tests.nr;
 
-	fprintf(stderr, "Running %d tests (%d at a time)\n",
-		suite.tests.nr, max_jobs);
+	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
+		(uintmax_t)suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
 				     test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
-		fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
+		fprintf(stderr, "%"PRIuMAX" tests failed:\n\n",
+			(uintmax_t)suite.failed.nr);
 		for (i = 0; i < suite.failed.nr; i++)
 			fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
 	}
diff --git a/wt-status.c b/wt-status.c
index 335e723a71e..b3d398d7864 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1374,10 +1374,10 @@ static void show_rebase_information(struct wt_status *s,
 			status_printf_ln(s, color, _("No commands done."));
 		else {
 			status_printf_ln(s, color,
-				Q_("Last command done (%d command done):",
-					"Last commands done (%d commands done):",
-					have_done.nr),
-				have_done.nr);
+				Q_("Last command done (%"PRIuMAX" command done):",
+					"Last commands done (%"PRIuMAX" commands done):",
+					(unsigned long)have_done.nr),
+				(uintmax_t)have_done.nr);
 			for (i = (have_done.nr > nr_lines_to_show)
 				? have_done.nr - nr_lines_to_show : 0;
 				i < have_done.nr;
@@ -1393,10 +1393,10 @@ static void show_rebase_information(struct wt_status *s,
 					 _("No commands remaining."));
 		else {
 			status_printf_ln(s, color,
-				Q_("Next command to do (%d remaining command):",
-					"Next commands to do (%d remaining commands):",
-					yet_to_do.nr),
-				yet_to_do.nr);
+				Q_("Next command to do (%"PRIuMAX" remaining command):",
+					"Next commands to do (%"PRIuMAX" remaining commands):",
+					(unsigned long)yet_to_do.nr),
+				(uintmax_t)yet_to_do.nr);
 			for (i = 0; i < nr_lines_to_show && i < yet_to_do.nr; i++)
 				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
 			if (s->hints)
-- 
2.35.1.1241.gd8d69a17521

