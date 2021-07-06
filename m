Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D65C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9A061CA8
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhGFVG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:06:27 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:44562 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhGFVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:06:26 -0400
Received: by mail-ej1-f54.google.com with SMTP id he13so17696950ejc.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6j/rxRs+hIbWM/zrNk2+/0AQPQ0MycbCqMz4xeG/CI=;
        b=rnA+zHxCtyY8OVn2x/QvHvyPbmlYspskmipq5s7zRSD+a4MOyEztaB3Xj/UhTc+Le6
         HsOLkz4yFolgks1ckqsRz6WEW3WTGK1EiOgsJGrg3bxvSN5p+Lk4ZtR7MHxdA/bYTZfZ
         xpFUMEZc231zChKBDF1/cjcojEyF5/P3f9Lue7jg1rT0JIT23BEyI0SjWO6PYkhEue/5
         jjfDb9u0qoAz5Hh0yKsZxJyd9K3NocUcwIq1UrfA8WxMJbYL2p6KmV8/Akf3igNutvSy
         OAT2UIb70JLbjt3i0gS1sHugL49m5DOwZNkx4/bJ7YC/RkUoIk23dJw7c2t4FIh9kVRz
         9whA==
X-Gm-Message-State: AOAM532tEaNJUTyj1qCCjUXaPG5y0fy/F40LTN64IaJsuwaTwtmEx75W
        LrioY27OusPQe1pDJd0szFfxF7kSX08JKw==
X-Google-Smtp-Source: ABdhPJxY7AnWDfzD86eO0RwRwsjrsTYg/Ax0bE5YFcdQizVBKl3xaoGqpEN9863TO90SLJW8qhRyIw==
X-Received: by 2002:a17:907:2da6:: with SMTP id gt38mr19954132ejc.528.1625605425920;
        Tue, 06 Jul 2021 14:03:45 -0700 (PDT)
Received: from localhost.localdomain (IGLD-83-130-17-216.inter.net.il. [83.130.17.216])
        by smtp.gmail.com with ESMTPSA id t6sm7690284edd.3.2021.07.06.14.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:03:45 -0700 (PDT)
From:   Avishay Matayev <me@avishay.dev>
To:     git@vger.kernel.org
Cc:     code@tpope.net, Avishay Matayev <me@avishay.dev>
Subject: [PATCH 1/3] Change isatty's parameter to a *_FILENO define
Date:   Wed,  7 Jul 2021 00:03:16 +0300
Message-Id: <20210706210317.706313-2-me@avishay.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706210317.706313-1-me@avishay.dev>
References: <20210706210317.706313-1-me@avishay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This isn't a functional change.

The next patch in this series will rename all isatty calls anyway so I
figured it is a good time to change the same calls to consistently use
STD[IN|OUT|ERR]_FILENO.

Signed-off-by: Avishay Matayev <me@avishay.dev>
---
 builtin/am.c               | 2 +-
 builtin/bisect--helper.c   | 2 +-
 builtin/blame.c            | 2 +-
 builtin/checkout.c         | 2 +-
 builtin/commit-graph.c     | 4 ++--
 builtin/commit.c           | 2 +-
 builtin/fsck.c             | 2 +-
 builtin/gc.c               | 2 +-
 builtin/log.c              | 2 +-
 builtin/merge.c            | 4 ++--
 builtin/multi-pack-index.c | 2 +-
 builtin/pack-objects.c     | 2 +-
 builtin/pack-redundant.c   | 2 +-
 builtin/prune-packed.c     | 2 +-
 builtin/prune.c            | 2 +-
 builtin/rebase.c           | 2 +-
 builtin/repack.c           | 2 +-
 builtin/send-pack.c        | 2 +-
 builtin/shortlog.c         | 4 ++--
 builtin/sparse-checkout.c  | 2 +-
 builtin/unpack-objects.c   | 2 +-
 column.c                   | 2 +-
 date.c                     | 2 +-
 editor.c                   | 2 +-
 pager.c                    | 4 ++--
 preload-index.c            | 2 +-
 read-cache.c               | 2 +-
 remote-curl.c              | 2 +-
 sequencer.c                | 4 ++--
 sideband.c                 | 2 +-
 transport.c                | 6 +++---
 transport.h                | 2 +-
 32 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..2230c3e94d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2394,7 +2394,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		 *    intend to feed us a patch but wanted to continue
 		 *    unattended.
 		 */
-		if (argc || (resume.mode == RESUME_FALSE && !isatty(0)))
+		if (argc || (resume.mode == RESUME_FALSE && !isatty(STDIN_FILENO)))
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9d9540a0ab..5d42c75a46 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -346,7 +346,7 @@ static int decide_next(const struct bisect_terms *terms,
 		 * although this is less optimum.
 		 */
 		warning(_("bisecting only with a %s commit"), terms->term_bad);
-		if (!isatty(0))
+		if (!isatty(STDIN_FILENO))
 			return 0;
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9a..1b674b2f52 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -945,7 +945,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
 		show_progress = 0;
 	} else if (show_progress < 0)
-		show_progress = isatty(2);
+		show_progress = isatty(STDERR_FILENO);
 
 	if (0 < abbrev && abbrev < hexsz)
 		/* one more abbrev length is needed for the boundary commit */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d3..e3bd31449b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1607,7 +1607,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (opts->quiet)
 			opts->show_progress = 0;
 		else
-			opts->show_progress = isatty(2);
+			opts->show_progress = isatty(STDERR_FILENO);
 	}
 
 	if (opts->conflict_style) {
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd86315221..461f1a2a65 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -87,7 +87,7 @@ static int graph_verify(int argc, const char **argv)
 
 	trace2_cmd_mode("verify");
 
-	opts.progress = isatty(2);
+	opts.progress = isatty(STDERR_FILENO);
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_verify_options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -236,7 +236,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	opts.progress = isatty(2);
+	opts.progress = isatty(STDERR_FILENO);
 	opts.enable_changed_paths = -1;
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..d364ce6a39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -754,7 +754,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
-		if (isatty(0))
+		if (isatty(STDIN_FILENO))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die_errno(_("could not read log from standard input"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f..4e65c823e4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -790,7 +790,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_obj_options.strict = 1;
 
 	if (show_progress == -1)
-		show_progress = isatty(2);
+		show_progress = isatty(STDERR_FILENO);
 	if (verbose)
 		show_progress = 0;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1a..4566754427 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1425,7 +1425,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	};
 	memset(&opts, 0, sizeof(opts));
 
-	opts.quiet = !isatty(2);
+	opts.quiet = !isatty(STDERR_FILENO);
 
 	for (i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..5bb9f4194a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -69,7 +69,7 @@ struct line_opt_callback_data {
 
 static int session_is_interactive(void)
 {
-	return isatty(1) || pager_in_use();
+	return isatty(STDOUT_FILENO) || pager_in_use();
 }
 
 static int auto_decoration_style(void)
diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..88f53c03b5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -734,7 +734,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			o.subtree_shift = "";
 
 		o.show_rename_progress =
-			show_progress == -1 ? isatty(2) : show_progress;
+			show_progress == -1 ? isatty(STDERR_FILENO) : show_progress;
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
@@ -1073,7 +1073,7 @@ static int default_edit_option(void)
 	/* Use editor if stdin and stdout are the same and is a tty */
 	return (!fstat(0, &st_stdin) &&
 		!fstat(1, &st_stdout) &&
-		isatty(0) && isatty(1) &&
+		isatty(STDIN_FILENO) && isatty(STDOUT_FILENO) &&
 		st_stdin.st_dev == st_stdout.st_dev &&
 		st_stdin.st_ino == st_stdout.st_ino &&
 		st_stdin.st_mode == st_stdout.st_mode);
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5d3ea445fd..8e329b8b22 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -154,7 +154,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	if (isatty(2))
+	if (isatty(STDERR_FILENO))
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e..74536fa5a4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4016,7 +4016,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
 		pack_idx_opts.flags |= WRITE_REV;
 
-	progress = isatty(2);
+	progress = isatty(STDERR_FILENO);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 8bf5c0acad..acf1edba3a 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -621,7 +621,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 
 	/* ignore objects given on stdin */
 	llist_init(&ignore);
-	if (!isatty(0)) {
+	if (!isatty(STDIN_FILENO)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
 			oid = xmalloc(sizeof(*oid));
 			if (get_oid_hex(buf, oid))
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index b7b9281a8c..5d476316a5 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -9,7 +9,7 @@ static const char * const prune_packed_usage[] = {
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
+	int opts = isatty(STDERR_FILENO) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
 		OPT_BIT('n', "dry-run", &opts, N_("dry run"),
 			PRUNE_PACKED_DRY_RUN),
diff --git a/builtin/prune.c b/builtin/prune.c
index 02c6ab7cba..36b9fed1bf 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -165,7 +165,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_progress == -1)
-		show_progress = isatty(2);
+		show_progress = isatty(STDERR_FILENO);
 	if (exclude_promisor_objects) {
 		fetch_if_missing = 0;
 		revs.exclude_promisor_objects = 1;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..97e8c8cbf8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1745,7 +1745,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
-	if (isatty(2) && options.flags & REBASE_NO_QUIET)
+	if (isatty(STDERR_FILENO) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
 	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..4eb21e8e98 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -710,7 +710,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && isatty(2))
+		if (!po_args.quiet && isatty(STDERR_FILENO))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index a7e01667b0..c168c03a26 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -261,7 +261,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress == -1)
-		progress = !args.quiet && isatty(2);
+		progress = !args.quiet && isatty(STDERR_FILENO);
 	args.progress = progress;
 
 	if (args.stateless_rpc) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3e7ab1ca82..a3612e3f72 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -406,10 +406,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	string_list_sort(&log.trailers);
 
 	/* assume HEAD if from a tty */
-	if (!nongit && !rev.pending.nr && isatty(0))
+	if (!nongit && !rev.pending.nr && isatty(STDIN_FILENO))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
-		if (isatty(0))
+		if (isatty(STDIN_FILENO))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		read_from_stdin(&log);
 	}
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a4bdd7c494..63e79c7520 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -114,7 +114,7 @@ static int update_working_directory(struct pattern_list *pl)
 	r->index->sparse_checkout_patterns = pl;
 
 	memset(&o, 0, sizeof(o));
-	o.verbose_update = isatty(2);
+	o.verbose_update = isatty(STDERR_FILENO);
 	o.update = 1;
 	o.head_idx = -1;
 	o.src_index = r->index;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..1a86e2e606 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -522,7 +522,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	quiet = !isatty(2);
+	quiet = !isatty(STDERR_FILENO);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/column.c b/column.c
index 1261e18a72..375869e848 100644
--- a/column.c
+++ b/column.c
@@ -211,7 +211,7 @@ int finalize_colopts(unsigned int *colopts, int stdout_is_tty)
 {
 	if ((*colopts & COL_ENABLE_MASK) == COL_AUTO) {
 		if (stdout_is_tty < 0)
-			stdout_is_tty = isatty(1);
+			stdout_is_tty = isatty(STDOUT_FILENO);
 		*colopts &= ~COL_ENABLE_MASK;
 		if (stdout_is_tty || pager_in_use())
 			*colopts |= COL_ENABLED;
diff --git a/date.c b/date.c
index f9ea807b3a..6dd6c37c22 100644
--- a/date.c
+++ b/date.c
@@ -969,7 +969,7 @@ void parse_date_format(const char *format, struct date_mode *mode)
 
 	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
 	if (skip_prefix(format, "auto:", &p)) {
-		if (isatty(1) || pager_in_use())
+		if (isatty(STDOUT_FILENO) || pager_in_use())
 			format = p;
 		else
 			format = "default";
diff --git a/editor.c b/editor.c
index 6303ae0ab0..13521f05cf 100644
--- a/editor.c
+++ b/editor.c
@@ -58,7 +58,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
-		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);
+		int print_waiting_for_editor = advice_waiting_for_editor && isatty(STDERR_FILENO);
 
 		if (print_waiting_for_editor) {
 			/*
diff --git a/pager.c b/pager.c
index 3d37dd7ada..3c4664ebed 100644
--- a/pager.c
+++ b/pager.c
@@ -101,7 +101,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
-	const char *pager = git_pager(isatty(1));
+	const char *pager = git_pager(isatty(STDOUT_FILENO));
 
 	if (!pager)
 		return;
@@ -128,7 +128,7 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(STDERR_FILENO))
 		dup2(pager_process.in, 2);
 	close(pager_process.in);
 
diff --git a/preload-index.c b/preload-index.c
index e5529a5863..28707d9bee 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -121,7 +121,7 @@ void preload_index(struct index_state *index,
 	memset(&data, 0, sizeof(data));
 
 	memset(&pd, 0, sizeof(pd));
-	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
+	if (refresh_flags & REFRESH_PROGRESS && isatty(STDERR_FILENO)) {
 		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
 		pthread_mutex_init(&pd.mutex, NULL);
 	}
diff --git a/read-cache.c b/read-cache.c
index 77961a3885..a8063fefe6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1568,7 +1568,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_lstat = 0;
 	int t2_sum_scan = 0;
 
-	if (flags & REFRESH_PROGRESS && isatty(2))
+	if (flags & REFRESH_PROGRESS && isatty(STDERR_FILENO))
 		progress = start_delayed_progress(_("Refresh index"),
 						  istate->cache_nr);
 
diff --git a/remote-curl.c b/remote-curl.c
index 9d432c299a..843a287680 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1483,7 +1483,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	options.verbosity = 1;
-	options.progress = !!isatty(2);
+	options.progress = !!isatty(STDERR_FILENO);
 	options.thin = 1;
 	string_list_init(&options.deepen_not, 1);
 	string_list_init(&options.push_options, 1);
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..d1311eecc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2040,7 +2040,7 @@ static int should_edit(struct replay_opts *opts) {
 		 * commits; continue_single_pick() handles the conflicted
 		 * commits itself instead of calling this function.
 		 */
-		return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
+		return (opts->action == REPLAY_REVERT && isatty(STDIN_FILENO)) ? 1 : 0;
 	return opts->edit;
 }
 
@@ -4589,7 +4589,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 	 * we want to edit if the user asked for it, or if they didn't specify
 	 * and stdin is a tty.
 	 */
-	if (!opts->edit || (opts->edit < 0 && !isatty(0)))
+	if (!opts->edit || (opts->edit < 0 && !isatty(STDIN_FILENO)))
 		/*
 		 * Include --cleanup=strip as well because we don't want the
 		 * "# Conflicts:" messages.
diff --git a/sideband.c b/sideband.c
index 6f9e026732..a5dcb971f5 100644
--- a/sideband.c
+++ b/sideband.c
@@ -126,7 +126,7 @@ int demultiplex_sideband(const char *me, int status,
 	int band;
 
 	if (!suffix) {
-		if (isatty(2) && !is_terminal_dumb())
+		if (isatty(STDERR_FILENO) && !is_terminal_dumb())
 			suffix = ANSI_SUFFIX;
 		else
 			suffix = DUMB_SUFFIX;
diff --git a/transport.c b/transport.c
index 50f5830eb6..ab8f297afa 100644
--- a/transport.c
+++ b/transport.c
@@ -1051,7 +1051,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
-	ret->progress = isatty(2);
+	ret->progress = isatty(STDERR_FILENO);
 	string_list_init(&ret->pack_lockfiles, 1);
 
 	if (!remote)
@@ -1168,12 +1168,12 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	 *   . Report progress, if force_progress is 1 (ie. --progress).
 	 *   . Don't report progress, if force_progress is 0 (ie. --no-progress).
 	 *   . Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
-	 *   . Report progress if isatty(2) is 1.
+	 *   . Report progress if isatty(STDERR_FILENO) is 1.
 	 **/
 	if (force_progress >= 0)
 		transport->progress = !!force_progress;
 	else
-		transport->progress = verbosity >= 0 && isatty(2);
+		transport->progress = verbosity >= 0 && isatty(STDERR_FILENO);
 }
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
diff --git a/transport.h b/transport.h
index 1cbab11373..4630d42755 100644
--- a/transport.h
+++ b/transport.h
@@ -110,7 +110,7 @@ struct transport {
 	signed verbose : 3;
 	/**
 	 * Transports should not set this directly, and should use this
-	 * value without having to check isatty(2), -q/--quiet
+	 * value without having to check isatty(STDERR_FILENO), -q/--quiet
 	 * (transport->verbose < 0), etc. - checking has already been done
 	 * in transport_set_verbosity().
 	 **/
-- 
2.25.1

