Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6947F20560
	for <e@80x24.org>; Fri, 27 Oct 2017 22:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbdJ0W3I (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 18:29:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:48522 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbdJ0W3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 18:29:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id v78so6281469pgb.5
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nXPWqfstNdlxE2lUVYQuVeQOOKO6JW7YyCt1PewOOo4=;
        b=mTiecWQj61FepRGrg918S+5xgc0SsCp3uTRTA9uBcbN9BBdBz1b/+ndyCfOXqkdkrz
         SuosYm4NzxPM2Abkx6O8wWGQrsyjHql5nswpdBuOXPNKsC1CVxZFMPJOPKvIcrdT/qpK
         WV7NQqnEeqjk43t5Q8egINDaRACYG2hw1hXycYa3tSYNMxIw7q0Jpo91t5KkTjBg4GTC
         /V3fV9VqpcsGr92lO3vuwxflCpt5afssyBB0cjZfHOeSAnQqhC6dqWiqkoJERewPKjvX
         p49ljhE4RqZLX6Ane0dQ7IKemRfuHRFvxBuANj6Ba/JLhtw6cYWBgdeGtNYJKh6BdHid
         7PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nXPWqfstNdlxE2lUVYQuVeQOOKO6JW7YyCt1PewOOo4=;
        b=DM3G9K37b8E2W/WO9vd2I11YX9Qp0t3JyRytfFu0vtATMkLvWOIzUfOq3zzbW/N9vr
         I9g7JNFPStwXvAl4Tzeja92fIfNPT4r46tJbWwsLog5w6t4yBRRVVzJUGnIPpbFLXawN
         abMS+1XQMA3ZDmhf8glDFcPSxl2cv1RKOk/tHl7csjI8ZaO9WnShTL6cbwGk+BhDSwJx
         gXaEwU7mlbXUHqDRETjHQ4ZOMaPFWnIA+CteiChPLFNpuYgeCX0iUAhyJKVaUm3s2vQ+
         v/oZgG/LRc5ydRth7yjSGHaRVcn17hiKgDmOXT1W4MDXz0dCDwKGjYkPdB6E7htJ6xBz
         R4Ng==
X-Gm-Message-State: AMCzsaXhGtyRE1eRbpYTVt8MTEDG7OKMA40u7TMD+9cUjHrUAIcFkKnj
        xbdI+EfN1HrjUGVdohocb24KVJEujUE=
X-Google-Smtp-Source: ABhQp+Q21Taf1rUtLkfW26PzqaVZanU0vd7G+Z3f+7XMZDCSOh9iYhL4PnGpQFFKBQV1V+O0GJtrNQ==
X-Received: by 10.84.217.30 with SMTP id o30mr1394885pli.351.1509143341549;
        Fri, 27 Oct 2017 15:29:01 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id c127sm16486842pga.34.2017.10.27.15.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 15:29:00 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/3] diff: convert flags to be stored in bitfields
Date:   Fri, 27 Oct 2017 15:28:53 -0700
Message-Id: <20171027222853.180981-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404-goog
In-Reply-To: <20171027222853.180981-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have have reached the limit of the number of flags that can be stored
in a single unsigned int.  In order to allow for more flags to be added
to the diff machinery in the future this patch converts the flags to be
stored in bitfields in 'struct diff_flags'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/commit.c |  7 +++--
 builtin/log.c    |  2 +-
 diff-lib.c       |  6 ++--
 diff.c           |  3 +-
 diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
 sequencer.c      |  5 +--
 6 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d75b3805e..de08c2594 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -912,11 +912,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			 * submodules which were manually staged, which would
 			 * be really confusing.
 			 */
-			int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+			struct diff_flags flags = DIFF_FLAGS_INIT;
+			flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
-				diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
-			commitable = index_differs_from(parent, diff_flags, 1);
+				flags.IGNORE_SUBMODULES = 1;
+			commitable = index_differs_from(parent, flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
diff --git a/builtin/log.c b/builtin/log.c
index d81a09051..780975ed4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -134,7 +134,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
-	rev->diffopt.touched_flags = 0;
+	rev->diffopt.touched_flags = diff_flags_cleared;
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff-lib.c b/diff-lib.c
index 4e0980caa..7375ef71d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -71,7 +71,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 {
 	int changed = ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
-		unsigned orig_flags = diffopt->flags;
+		struct diff_flags orig_flags = diffopt->flags;
 		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
 		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
@@ -534,7 +534,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	return 0;
 }
 
-int index_differs_from(const char *def, int diff_flags,
+int index_differs_from(const char *def, struct diff_flags flags,
 		       int ita_invisible_in_index)
 {
 	struct rev_info rev;
@@ -546,7 +546,7 @@ int index_differs_from(const char *def, int diff_flags,
 	setup_revisions(0, NULL, &rev, &opt);
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
-	rev.diffopt.flags |= diff_flags;
+	rev.diffopt.flags = diff_flags_or(rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
diff --git a/diff.c b/diff.c
index 6fd288420..6f1050d42 100644
--- a/diff.c
+++ b/diff.c
@@ -46,6 +46,7 @@ static int diff_no_prefix;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
+const struct diff_flags diff_flags_cleared = DIFF_FLAGS_INIT;
 static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
 
@@ -5899,7 +5900,7 @@ int diff_can_quit_early(struct diff_options *opt)
 static int is_submodule_ignored(const char *path, struct diff_options *options)
 {
 	int ignored = 0;
-	unsigned orig_flags = options->flags;
+	struct diff_flags orig_flags = options->flags;
 	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
 		set_diffopt_flags_from_submodule_config(options, path);
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
diff --git a/diff.h b/diff.h
index aca150ba2..d58f06106 100644
--- a/diff.h
+++ b/diff.h
@@ -60,42 +60,59 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FORMAT_CALLBACK	0x1000
 
-#define DIFF_OPT_RECURSIVE           (1 <<  0)
-#define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
-#define DIFF_OPT_BINARY              (1 <<  2)
-#define DIFF_OPT_TEXT                (1 <<  3)
-#define DIFF_OPT_FULL_INDEX          (1 <<  4)
-#define DIFF_OPT_SILENT_ON_REMOVE    (1 <<  5)
-#define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
-#define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
-#define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
-#define DIFF_OPT_HAS_CHANGES         (1 << 10)
-#define DIFF_OPT_QUICK               (1 << 11)
-#define DIFF_OPT_NO_INDEX            (1 << 12)
-#define DIFF_OPT_ALLOW_EXTERNAL      (1 << 13)
-#define DIFF_OPT_EXIT_WITH_STATUS    (1 << 14)
-#define DIFF_OPT_REVERSE_DIFF        (1 << 15)
-#define DIFF_OPT_CHECK_FAILED        (1 << 16)
-#define DIFF_OPT_RELATIVE_NAME       (1 << 17)
-#define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
-#define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
-#define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
-#define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
-#define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
-#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
-#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
-#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
-#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
-#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
-#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
-#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
-#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
-
-#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
-#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
+#define DIFF_FLAGS_INIT { 0 }
+extern const struct diff_flags diff_flags_cleared;
+struct diff_flags {
+	unsigned RECURSIVE:1;
+	unsigned TREE_IN_RECURSIVE:1;
+	unsigned BINARY:1;
+	unsigned TEXT:1;
+	unsigned FULL_INDEX:1;
+	unsigned SILENT_ON_REMOVE:1;
+	unsigned FIND_COPIES_HARDER:1;
+	unsigned FOLLOW_RENAMES:1;
+	unsigned RENAME_EMPTY:1;
+	unsigned HAS_CHANGES:1;
+	unsigned QUICK:1;
+	unsigned NO_INDEX:1;
+	unsigned ALLOW_EXTERNAL:1;
+	unsigned EXIT_WITH_STATUS:1;
+	unsigned REVERSE_DIFF:1;
+	unsigned CHECK_FAILED:1;
+	unsigned RELATIVE_NAME:1;
+	unsigned IGNORE_SUBMODULES:1;
+	unsigned DIRSTAT_CUMULATIVE:1;
+	unsigned DIRSTAT_BY_FILE:1;
+	unsigned ALLOW_TEXTCONV:1;
+	unsigned DIFF_FROM_CONTENTS:1;
+	unsigned DIRTY_SUBMODULES:1;
+	unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
+	unsigned IGNORE_DIRTY_SUBMODULES:1;
+	unsigned OVERRIDE_SUBMODULE_CONFIG:1;
+	unsigned DIRSTAT_BY_LINE:1;
+	unsigned FUNCCONTEXT:1;
+	unsigned PICKAXE_IGNORE_CASE:1;
+	unsigned DEFAULT_FOLLOW_RENAMES:1;
+};
+
+static inline struct diff_flags diff_flags_or(struct diff_flags a,
+					      struct diff_flags b)
+{
+	char *tmp_a = (char *)&a;
+	char *tmp_b = (char *)&b;
+	int i;
+
+	for (i = 0; i < sizeof(struct diff_flags); i++)
+		tmp_a[i] |= tmp_b[i];
+
+	return a;
+}
+
+#define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
+#define DIFF_OPT_TOUCHED(opts, flag)	((opts)->touched_flags.flag)
+#define DIFF_OPT_SET(opts, flag)	(((opts)->flags.flag = 1),((opts)->touched_flags.flag = 1))
+#define DIFF_OPT_CLR(opts, flag)	(((opts)->flags.flag = 0),((opts)->touched_flags.flag = 1))
+
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
@@ -122,8 +139,8 @@ struct diff_options {
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
 	size_t line_prefix_length;
-	unsigned flags;
-	unsigned touched_flags;
+	struct diff_flags flags;
+	struct diff_flags touched_flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
@@ -388,7 +405,8 @@ extern int diff_result_code(struct diff_options *, int);
 
 extern void diff_no_index(struct rev_info *, int, const char **);
 
-extern int index_differs_from(const char *def, int diff_flags, int ita_invisible_in_index);
+extern int index_differs_from(const char *def, struct diff_flags flags,
+			      int ita_invisible_in_index);
 
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f..cf9bec716 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -959,7 +959,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
 			oidcpy(&head, &empty_tree_oid);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
+		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
+				       diff_flags_cleared, 0))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -2279,7 +2280,7 @@ int sequencer_continue(struct replay_opts *opts)
 			if (res)
 				goto release_todo_list;
 		}
-		if (index_differs_from("HEAD", 0, 0)) {
+		if (index_differs_from("HEAD", diff_flags_cleared, 0)) {
 			res = error_dirty_index(opts);
 			goto release_todo_list;
 		}
-- 
2.15.0.rc2.357.g7e34df9404-goog

