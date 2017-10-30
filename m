Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDFC202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbdJ3Tq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:46:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:49696 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932873AbdJ3Tq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:46:56 -0400
Received: by mail-io0-f195.google.com with SMTP id n137so29916762iod.6
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5J8JIzhzA7hk9xoNDo/q8nIlajiWBUjfLGIBPx71p9U=;
        b=BMEP5gsplWQ8FdkLuuil7YR4CoocrP6nVDwCh/Vki1BcIYKsyYbct6W8B2oSSRPrla
         CMxwuOoKNdAGLhmH/GbjRK4AxuGD8dWbqCgZU0oNVzhsYfUF8xClABErfgwp+7Jca97g
         pz2H604Hwd/Nb4832I/IRoAQekR+aFg97E8AKdph+XaAoOhVrFILNJUn0RsFObHVlc3r
         3mCnk6t592O1DvabY5yNLRhWHKgIUtoP2vrs+wl5vgiFehN8ZZ3RSOEiRiVsQ8riVjSw
         lsdg757+eut7lRIafVDxfOzg/Q8Od2kp5ldt4O5YILvoxlcYNBTakjRMPZV3rF7xy+cb
         D6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5J8JIzhzA7hk9xoNDo/q8nIlajiWBUjfLGIBPx71p9U=;
        b=EkJ8GeHITjN0fH9qYA/MbVOXioI4gbSv41xLYYYNtSaaXHCaENm7KMJGJ4rTTNLLJl
         KIRpBqYUwS+XzPOwlqbcZETbUS5IzO4QmT8vQ2jFy+Sok5STc3wh0MVvWKZhGd3C18px
         6WiZmujUiBjgxDkz4q6fHPLqdxEOVCn3D8+wnGmRPfvKn9unIdjg5va/vf9r9sOkNg6+
         +npl69DUWtnnnoO+g/INDBg2V9np8yWiE5IY3ucXYXi1YNd3abnU7hMTe64Y1gU6C3mw
         oT/H5WXcRKNjHCD04mp06tU4pefKSCK5H8qhdKt3tz+TH1S9kd4s6PE3nbadAkzLOPoN
         KNqA==
X-Gm-Message-State: AMCzsaVGLW5TVuDs0wL7Ik2E/m/QR9Ls83PxVRMpjmI/28zHvFESrW0M
        DE57VX3S/dnMRO0Dj3H6keRbKNPWjxk=
X-Google-Smtp-Source: ABhQp+T62RjbmLF0MTsWiN+4L1HDGWaZkaWw2VWMT9SINc+uswiBv2G2F1JJ35gGCeB2vSJecgp0Qg==
X-Received: by 10.107.134.31 with SMTP id i31mr12438712iod.237.1509392814575;
        Mon, 30 Oct 2017 12:46:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g195sm2372805itc.14.2017.10.30.12.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:46:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 2/4] diff: convert flags to be stored in bitfields
Date:   Mon, 30 Oct 2017 12:46:44 -0700
Message-Id: <20171030194646.27473-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030194646.27473-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We cannot add many more flags to the diff machinery due to the
limitations of the number of flags that can be stored in a single
unsigned int.  In order to allow for more flags to be added to the diff
machinery in the future this patch converts the flags to be stored in
bitfields in 'struct diff_flags'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/commit.c |  7 ++--
 builtin/log.c    |  3 +-
 diff-lib.c       |  7 ++--
 diff.c           |  2 +-
 diff.h           | 97 +++++++++++++++++++++++++++++++++-----------------------
 sequencer.c      |  5 +--
 6 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d75b3805e..960e7ac08 100644
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
+			commitable = index_differs_from(parent, &flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
diff --git a/builtin/log.c b/builtin/log.c
index d81a09051..dc28d43eb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -134,7 +134,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
-	rev->diffopt.touched_flags = 0;
+
+	memset(&rev->diffopt.touched_flags, 0, sizeof(struct diff_flags));
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff-lib.c b/diff-lib.c
index 4e0980caa..6c1c05c5b 100644
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
+int index_differs_from(const char *def, const struct diff_flags *flags,
 		       int ita_invisible_in_index)
 {
 	struct rev_info rev;
@@ -546,7 +546,8 @@ int index_differs_from(const char *def, int diff_flags,
 	setup_revisions(0, NULL, &rev, &opt);
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
-	rev.diffopt.flags |= diff_flags;
+	if (flags)
+		rev.diffopt.flags = diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
diff --git a/diff.c b/diff.c
index 6fd288420..3ad9c9b31 100644
--- a/diff.c
+++ b/diff.c
@@ -5899,7 +5899,7 @@ int diff_can_quit_early(struct diff_options *opt)
 static int is_submodule_ignored(const char *path, struct diff_options *options)
 {
 	int ignored = 0;
-	unsigned orig_flags = options->flags;
+	struct diff_flags orig_flags = options->flags;
 	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
 		set_diffopt_flags_from_submodule_config(options, path);
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
diff --git a/diff.h b/diff.h
index aca150ba2..47e6d43cb 100644
--- a/diff.h
+++ b/diff.h
@@ -60,42 +60,60 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
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
+static inline struct diff_flags diff_flags_or(const struct diff_flags *a,
+					      const struct diff_flags *b)
+{
+	struct diff_flags out;
+	char *tmp_a = (char *)a;
+	char *tmp_b = (char *)b;
+	char *tmp_out = (char *)&out;
+	int i;
+
+	for (i = 0; i < sizeof(struct diff_flags); i++)
+		tmp_out[i] = tmp_a[i] | tmp_b[i];
+
+	return out;
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
@@ -122,8 +140,8 @@ struct diff_options {
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
 	size_t line_prefix_length;
-	unsigned flags;
-	unsigned touched_flags;
+	struct diff_flags flags;
+	struct diff_flags touched_flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
@@ -388,7 +406,8 @@ extern int diff_result_code(struct diff_options *, int);
 
 extern void diff_no_index(struct rev_info *, int, const char **);
 
-extern int index_differs_from(const char *def, int diff_flags, int ita_invisible_in_index);
+extern int index_differs_from(const char *def, const struct diff_flags *flags,
+			      int ita_invisible_in_index);
 
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f..c0410e491 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -959,7 +959,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
 			oidcpy(&head, &empty_tree_oid);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
+		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
+				       NULL, 0))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -2279,7 +2280,7 @@ int sequencer_continue(struct replay_opts *opts)
 			if (res)
 				goto release_todo_list;
 		}
-		if (index_differs_from("HEAD", 0, 0)) {
+		if (index_differs_from("HEAD", NULL, 0)) {
 			res = error_dirty_index(opts);
 			goto release_todo_list;
 		}
-- 
2.15.0.403.gc27cc4dac6-goog

