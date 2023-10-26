Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4D171DF
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="jD50dil2"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4ED1AB
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1378434b3a.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360406; x=1698965206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jpis/aPcpBI1zfIbeqY4n9p1XyHUUNCJMvbE7Bv7CY=;
        b=jD50dil21PxIypULMZBwsprF9bGJI8sSqRvjUi9Fz21DPsNEtqZaqIIeYeVca2hwBJ
         WjoyA93+J+Fhy7VWUJqcDQ0EMuPe9LtsOrCn34+1boiu15bk70Jowialx+8IBDwHjsX2
         AbJoz5yAk2om9TbAnlPYDxrURhExNg4cwbgKQeFdPOI13BPza2Zz2QAOdBVvHL+hXAA2
         U4Q9bALX3RWT+zOGbuR8bPL8799qSBH/PcNGKGXiiN7MPhAhTgG44d0tRhmLQaR8uchI
         8uFMwbXkFCywNHwR//em/w8GiazZ0fMJY8gPyTAU5XcQYhQ06p2ZRoswEA7U0bDmi++f
         tvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360406; x=1698965206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jpis/aPcpBI1zfIbeqY4n9p1XyHUUNCJMvbE7Bv7CY=;
        b=Vl0E0ttmRadgFCA0JwnO5AnZIgBxw2DTMKs3yi/Gt96g3M+DcVkUycuWoRTE5G2Qgu
         eXstw+BwDdMmurlFHYqQLBzjF70JWZLc/wAk0TtRTm76IKUUYNdrQOHy3gbgPeCB5mq/
         4bebp27z+Wg7B1APCoKaVNd2/CZJ/CSze69HC8q8vzAAlKzAGIS5/FUHc0XUvG+Spxdy
         7Il+Gb6/MnhzXaKj3tdMnR6ZRj0jT0roCoZjaDtA2hgOoYeJwmkJLIKs+jqnAFpwN2bV
         oYBvXHTe3UBTpVztwiLZMIhJc7JST9LQDPT6Ji0sbQUe//YqIqClaCY4WWI1Rtlaf2Pd
         Mv7Q==
X-Gm-Message-State: AOJu0YxEhtLHBvLoE9CTsiaHJuT1yInQcZfKuz1PZxi6azyNU5Q6K/f6
	T6DBELkOD5kCcN7L2rFwtzW53fiYnCtCuNB+AUE=
X-Google-Smtp-Source: AGHT+IFPhMnshkjA+k/ew9SOqI6AuKXCdGNKehBNaGR8+G5cqsyV0I62N+U3rkx/8nxelJ5Z7PnTPg==
X-Received: by 2002:a05:6a21:7988:b0:161:7a0c:3c38 with SMTP id bh8-20020a056a21798800b001617a0c3c38mr1184459pzc.32.1698360406344;
        Thu, 26 Oct 2023 15:46:46 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:45 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH v2 5/6] restore: implement noob mode
Date: Thu, 26 Oct 2023 15:46:14 -0700
Message-ID: <20231026224615.675172-6-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/checkout.c | 46 ++++++++++++++++++++++++++++-------
 read-cache-ll.h    |  1 +
 read-cache.c       |  9 ++++++-
 table.c            | 60 +++++++++++++++++++++++++++++++++++++++-------
 wt-status.h        |  1 +
 5 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc15..afc414b0b1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -41,6 +41,7 @@
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "add-interactive.h"
+#include "noob.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -456,7 +457,8 @@ static int checkout_worktree(const struct checkout_opts *opts,
 }
 
 static int checkout_paths(const struct checkout_opts *opts,
-			  const struct branch_info *new_branch_info)
+			  const struct branch_info *new_branch_info,
+			  struct wt_status *status)
 {
 	int pos;
 	static char *ps_matched;
@@ -598,8 +600,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 	for (pos = 0; pos < the_index.cache_nr; pos++) {
 		const struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce))
+			if (!ce_stage(ce)) {
+				string_list_insert(&status->restored, ce->name);
 				continue;
+			}
 			if (opts->ignore_unmerged) {
 				if (!opts->quiet)
 					warning(_("path '%s' is unmerged"), ce->name);
@@ -621,7 +625,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->checkout_worktree)
 		errs |= checkout_worktree(opts, new_branch_info);
 	else
-		remove_marked_cache_entries(&the_index, 1);
+		remove_marked_cache_entries_with_status(&the_index, 1, status);
 
 	/*
 	 * Allow updating the index when checking out from the index.
@@ -1668,7 +1672,8 @@ static char cb_option = 'b';
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 const char * const usagestr[],
-			 struct branch_info *new_branch_info)
+			 struct branch_info *new_branch_info,
+			 struct wt_status *status)
 {
 	int parseopt_flags = 0;
 
@@ -1865,7 +1870,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, new_branch_info);
+		return checkout_paths(opts, new_branch_info, status);
 	else
 		return checkout_branch(opts, new_branch_info);
 }
@@ -1887,6 +1892,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	};
 	int ret;
 	struct branch_info new_branch_info = { 0 };
+	struct wt_status status;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1917,7 +1923,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage, &new_branch_info);
+			    options, checkout_usage,
+			    &new_branch_info, &status);
 	branch_info_release(&new_branch_info);
 	clear_pathspec(&opts.pathspec);
 	free(opts.pathspec_from_file);
@@ -1942,6 +1949,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	};
 	int ret;
 	struct branch_info new_branch_info = { 0 };
+	struct wt_status status;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1961,7 +1969,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	cb_option = 'c';
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage, &new_branch_info);
+			    options, switch_branch_usage,
+			    &new_branch_info, &status);
 	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
@@ -1985,6 +1994,13 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	};
 	int ret;
 	struct branch_info new_branch_info = { 0 };
+	struct wt_status status;
+	unsigned int progress_flag = 0;
+
+	wt_status_prepare(the_repository, &status);
+	git_config(git_status_config, &status);
+	finalize_deferred_config(&status);
+	status.status_format = status_format;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -2000,7 +2016,21 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage, &new_branch_info);
+			    options, restore_usage,
+			    &new_branch_info, &status);
+
+	if (status.status_format == STATUS_FORMAT_NOOB) {
+		/* Read index and populate status */
+		repo_read_index(the_repository);
+		refresh_index(&the_index,
+			      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
+			      &status.pathspec, NULL, NULL);
+		status.show_branch = 0;
+		wt_status_collect(&status);
+		wt_status_print(&status);
+		wt_status_collect_free_buffers(&status);
+	}
+
 	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 302a075714..8bdc157196 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -389,6 +389,7 @@ void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 /* Remove entry, return true if there are more entries to go. */
 int remove_index_entry_at(struct index_state *, int pos);
 
+void remove_marked_cache_entries_with_status(struct index_state *istate, int invalidate, struct wt_status *status);
 void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
diff --git a/read-cache.c b/read-cache.c
index 319415430a..1c1a3290c0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -558,7 +558,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
-void remove_marked_cache_entries(struct index_state *istate, int invalidate)
+void remove_marked_cache_entries_with_status(struct index_state *istate, int invalidate, struct wt_status *status)
 {
 	struct cache_entry **ce_array = istate->cache;
 	unsigned int i, j;
@@ -570,6 +570,7 @@ void remove_marked_cache_entries(struct index_state *istate, int invalidate)
 							   ce_array[i]->name);
 				untracked_cache_remove_from_index(istate,
 								  ce_array[i]->name);
+				string_list_insert(&status->restored, ce_array[i]->name);
 			}
 			remove_name_hash(istate, ce_array[i]);
 			save_or_free_index_entry(istate, ce_array[i]);
@@ -583,6 +584,12 @@ void remove_marked_cache_entries(struct index_state *istate, int invalidate)
 	istate->cache_nr = j;
 }
 
+void remove_marked_cache_entries(struct index_state *istate, int invalidate)
+{
+	struct wt_status status;
+	remove_marked_cache_entries_with_status(istate, invalidate, &status);
+}
+
 int remove_file_from_index(struct index_state *istate, const char *path)
 {
 	int pos = index_name_pos(istate, path, strlen(path));
diff --git a/table.c b/table.c
index d29b311440..3602def17a 100644
--- a/table.c
+++ b/table.c
@@ -66,7 +66,7 @@ static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2);
 }
 
-static void build_arrow(struct strbuf *buf, struct strbuf* arrow, int add_after_entry)
+static void build_arrow_(struct strbuf *buf, struct strbuf* arrow, int add_after_entry, int reversed)
 {
 	struct strbuf empty = STRBUF_INIT;
 	struct strbuf trimmed = STRBUF_INIT;
@@ -80,17 +80,38 @@ static void build_arrow(struct strbuf *buf, struct strbuf* arrow, int add_after_
 		strbuf_reset(buf);
 		strbuf_addchars(arrow, '-', len + 1);
 	} else if (add_after_entry) {
-		strbuf_rtrim(buf);
-		strbuf_addchars(arrow, ' ', 1);
-		strbuf_addchars(arrow, '-', len - strlen(buf->buf) + 1);
+		if (!reversed) {
+			strbuf_rtrim(buf);
+			strbuf_addchars(arrow, ' ', 1);
+			strbuf_addchars(arrow, '-', len - strlen(buf->buf) + 1);
+		} else {
+			strbuf_rtrim(buf);
+			strbuf_addchars(arrow, ' ', 1);
+			strbuf_addchars(arrow, '<', 1);
+			strbuf_addchars(arrow, '-', len - strlen(buf->buf) - 3);
+		}
 	} else if (!add_after_entry) {
-		strbuf_ltrim(buf);
-		strbuf_addchars(arrow, '-', len - strlen(buf->buf) - 3);
-		strbuf_addchars(arrow, '>', 1);
-		strbuf_addchars(arrow, ' ', 1);
+		if (!reversed) {
+			strbuf_ltrim(buf);
+			strbuf_addchars(arrow, '-', len - strlen(buf->buf) - 3);
+			strbuf_addchars(arrow, '>', 1);
+			strbuf_addchars(arrow, ' ', 1);
+		} else {
+			strbuf_ltrim(buf);
+			strbuf_addchars(arrow, '-', len - strlen(buf->buf) + 1);
+			strbuf_addchars(arrow, ' ', 1);
+		}
 	}
 }
 
+static void build_arrow(struct strbuf *buf, struct strbuf* arrow, int add_after_entry) {
+	build_arrow_(buf, arrow, add_after_entry, 0);
+}
+
+static void build_reversed_arrow(struct strbuf *buf, struct strbuf* arrow, int add_after_entry) {
+	build_arrow_(buf, arrow, add_after_entry, 1);
+}
+
 static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct strbuf *arrow1, struct strbuf *arrow2, struct strbuf *arrow3, struct wt_status *s, int hide_pipe)
 {
 	printf(_("|"));
@@ -180,6 +201,18 @@ void print_noob_status(struct wt_status *s, int advice)
 			}
 		}
 
+		for_each_string_list_item(item2, &s->restored) {
+			strbuf_reset(&buf_2);
+			strbuf_addstr(&buf_2, item2->string);
+			if (!strbuf_cmp(&buf_1, &buf_2)) {
+				build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+				build_reversed_arrow(&table_col_entry_1, &arrow_1, 1);
+				build_reversed_arrow(&table_col_entry_2, &arrow_2, 0);
+				build_reversed_arrow(&table_col_entry_3, &arrow_3, 0);
+				is_arrow = 1;
+			}
+		}
+
 		if (!is_arrow)
 			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, &arrow_1, &arrow_2, &arrow_3, s, 0);
 		else
@@ -215,6 +248,17 @@ void print_noob_status(struct wt_status *s, int advice)
 					is_arrow = 1;
 				}
 			}
+
+			for_each_string_list_item(item2, &s->restored) {
+				strbuf_reset(&buf_2);
+				strbuf_addstr(&buf_2, item2->string);
+				if (!strbuf_cmp(&buf_1, &buf_2)) {
+					build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+					build_reversed_arrow(&table_col_entry_2, &arrow_2, 1);
+					build_reversed_arrow(&table_col_entry_3, &arrow_3, 0);
+					is_arrow = 1;
+				}
+			}
 		} else if (d->index_status) {
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, "", cols);
diff --git a/wt-status.h b/wt-status.h
index 7b883fd476..c6bce8f74a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -144,6 +144,7 @@ struct wt_status {
 	struct string_list untracked;
 	struct string_list ignored;
 	struct string_list added;
+	struct string_list restored;
 	uint32_t untracked_in_ms;
 };
 
-- 
2.42.0.404.g2bcc23f3db

