Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723EC3F68F
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA5B206D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyyjeI5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfLUV5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45201 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfLUV5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so11986333edw.12
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WYR0FT8tMhQ2ro83AmSmAPcLKr/Vi9JdT6d1JFdHN0c=;
        b=YyyjeI5SZIlAMisvZ9NBU1mwmdf4AWSmi6pE5SbUQ/N3OvSwpXAiJyL42MKk/17a+t
         XnH5FH6inpPsWBKcxq4AADjW6w26yqihreKygX5WC83Fp+WBSP+B1Er4BnTHb1/j6GvD
         RopxVEczW7jYNZEZUybYtJBMBtTTCRSkFgoXa3gYpACBmxC8xY7sPPp9RsA4QCtvRrxy
         YAN/Nlb7eTX8xcmEX7hts4Puaj/h/k5B7uDWwvWjeaw8LYExsRppF5PscDoimou+8d8a
         3Ib/+P6nr4wwu1gzLSTJFKOUWuqLCp3T6MchpmK9EWnS7KHsXySzd9HJpskVx1Y5FCCP
         bpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WYR0FT8tMhQ2ro83AmSmAPcLKr/Vi9JdT6d1JFdHN0c=;
        b=pSI24YAhZc0p43mtnL3J2P2rqO6HLI3Qu3oxfFkDmZo6gaEQCJC58Gq6mlSqZBT1LL
         VSSUOAqRGapqnEOxkWfqtU9vvrohUuD9bTeJeYMLUg6tuRVoI3MXcuWlbtNl6UAUIlDS
         91q+/lqjdBaTZwnewiUqCrgIE3r3njwhYbX0jhISeYQ6qnJjkw+RCLmXPps2pJ0uN7RP
         zCEzjFROsU0Fbdvjr0lsjKKkAiB+kLocc4z3BI0YoXqC91YnWAnfblS7Op2KW7R2OnR0
         p0mv/cSCQUzwt5C9LuccEkhOYz08vajhIMLa49QazIQrT+vvqhrw3yDc+RxjF42EAWx4
         hACQ==
X-Gm-Message-State: APjAAAV7ypqr57MSuvNiATsKDdkBNsKW8Jdif4oWX/rRXUmH8ZuXfgtN
        Pq7LGyUVYjU1yqn7Gczqn8rGkdeD
X-Google-Smtp-Source: APXvYqyTdjp5h6YnetPa9C7JYXCMnJcu+5wUDYdvEeVUekRdH0cJhHBdev+RYOQ9Z3PYDBnPvTCGdw==
X-Received: by 2002:a17:906:138d:: with SMTP id f13mr24315270ejc.211.1576965438782;
        Sat, 21 Dec 2019 13:57:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id br7sm1648977ejb.13.2019.12.21.13.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:18 -0800 (PST)
Message-Id: <d894f8f427a14fc9ceb5b64c1c5d8a508e261d59.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:10 +0000
Subject: [PATCH v2 1/7] built-in add -p: prepare for patch modes other than
 "stage"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl script backing `git add -p` is used not only for that command,
but also for `git stash -p`, `git reset -p` and `git checkout -p`.

In preparation for teaching the C version of `git add -p` to support
also the latter commands, let's abstract away what is "stage" specific
into a dedicated data structure describing the differences between the
patch modes.

Finally, please note that the Perl version tries to make sure that the
diffs are only generated for the modified files. This is not actually
necessary, as the calls to Git's diff machinery already perform that
work, and perform it well. This makes it unnecessary to port the
`FILTER` field of the `%patch_modes` struct, as well as the
`get_diff_reference()` function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  2 +-
 add-interactive.h |  8 +++-
 add-patch.c       | 95 ++++++++++++++++++++++++++++++++++-------------
 builtin/add.c     | 10 ++++-
 4 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6a5048c83e..a5bb14f2f4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -924,7 +924,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.argv);
-		res = run_add_p(s->r, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
 		argv_array_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
diff --git a/add-interactive.h b/add-interactive.h
index 062dc3646c..e29a769aba 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -22,6 +22,12 @@ void init_add_i_state(struct add_i_state *s, struct repository *r);
 struct repository;
 struct pathspec;
 int run_add_i(struct repository *r, const struct pathspec *ps);
-int run_add_p(struct repository *r, const struct pathspec *ps);
+
+enum add_p_mode {
+	ADD_P_ADD,
+};
+
+int run_add_p(struct repository *r, enum add_p_mode mode,
+	      const char *revision, const struct pathspec *ps);
 
 #endif
diff --git a/add-patch.c b/add-patch.c
index 2c46fe5b33..71356fbd9a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -8,13 +8,41 @@
 #include "diff.h"
 
 enum prompt_mode_type {
-	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
+	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
+	PROMPT_MODE_MAX, /* must be last */
 };
 
-static const char *prompt_mode[] = {
-	N_("Stage mode change [y,n,a,q,d%s,?]? "),
-	N_("Stage deletion [y,n,a,q,d%s,?]? "),
-	N_("Stage this hunk [y,n,a,q,d%s,?]? ")
+struct patch_mode {
+	/*
+	 * The magic constant 4 is chosen such that all patch modes
+	 * provide enough space for three command-line arguments followed by a
+	 * trailing `NULL`.
+	 */
+	const char *diff_cmd[4], *apply_args[4], *apply_check_args[4];
+	unsigned is_reverse:1, apply_for_checkout:1;
+	const char *prompt_mode[PROMPT_MODE_MAX];
+	const char *edit_hunk_hint, *help_patch_text;
+};
+
+static struct patch_mode patch_mode_add = {
+	.diff_cmd = { "diff-files", NULL },
+	.apply_args = { "--cached", NULL },
+	.apply_check_args = { "--cached", NULL },
+	.prompt_mode = {
+		N_("Stage mode change [y,n,q,a,d%s,?]? "),
+		N_("Stage deletion [y,n,q,a,d%s,?]? "),
+		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for staging."),
+	.help_patch_text =
+		N_("y - stage this hunk\n"
+		   "n - do not stage this hunk\n"
+		   "q - quit; do not stage this hunk or any of the remaining "
+			"ones\n"
+		   "a - stage this hunk and all later hunks in the file\n"
+		   "d - do not stage this hunk or any of the later hunks in "
+			"the file\n")
 };
 
 struct hunk_header {
@@ -47,6 +75,10 @@ struct add_p_state {
 		unsigned deleted:1, mode_change:1,binary:1;
 	} *file_diff;
 	size_t file_diff_nr;
+
+	/* patch mode */
+	struct patch_mode *mode;
+	const char *revision;
 };
 
 static void err(struct add_p_state *s, const char *fmt, ...)
@@ -162,9 +194,18 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	struct hunk *hunk = NULL;
 	int res;
 
+	argv_array_pushv(&args, s->mode->diff_cmd);
+	if (s->revision) {
+		struct object_id oid;
+		argv_array_push(&args,
+				/* could be on an unborn branch */
+				!strcmp("HEAD", s->revision) &&
+				get_oid("HEAD", &oid) ?
+				empty_tree_oid_hex() : s->revision);
+	}
+	color_arg_index = args.argc;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	argv_array_pushl(&args, "diff-files", "-p", "--no-color", "--", NULL);
-	color_arg_index = args.argc - 2;
+	argv_array_pushl(&args, "--no-color", "-p", "--", NULL);
 	for (i = 0; i < ps->nr; i++)
 		argv_array_push(&args, ps->items[i].original);
 
@@ -382,7 +423,10 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				- header->colored_extra_start;
 		}
 
-		new_offset += delta;
+		if (s->mode->is_reverse)
+			old_offset -= delta;
+		else
+			new_offset += delta;
 
 		strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
 			    old_offset, header->old_count,
@@ -805,11 +849,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"(context).\n"
 				"To remove '%c' lines, delete them.\n"
 				"Lines starting with %c will be removed.\n"),
-			      '-', '+', comment_line_char);
-	strbuf_commented_addf(&s->buf,
-			      _("If the patch applies cleanly, the edited hunk "
-				"will immediately be\n"
-				"marked for staging.\n"));
+			      s->mode->is_reverse ? '+' : '-',
+			      s->mode->is_reverse ? '-' : '+',
+			      comment_line_char);
+	strbuf_commented_addf(&s->buf, "%s", _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
@@ -890,7 +933,8 @@ static int run_apply_check(struct add_p_state *s,
 	reassemble_patch(s, file_diff, 1, &s->buf);
 
 	setup_child_process(s, &cp,
-			    "apply", "--cached", "--check", NULL);
+			    "apply", "--check", NULL);
+	argv_array_pushv(&cp.args, s->mode->apply_check_args);
 	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
 		return error(_("'git apply --cached' failed"));
 
@@ -1005,13 +1049,6 @@ static size_t display_hunks(struct add_p_state *s,
 	return end_index;
 }
 
-static const char help_patch_text[] =
-N_("y - stage this hunk\n"
-   "n - do not stage this hunk\n"
-   "q - quit; do not stage this hunk or any of the remaining ones\n"
-   "a - stage this and all the remaining hunks\n"
-   "d - do not stage this hunk nor any of the remaining hunks\n");
-
 static const char help_patch_remainder[] =
 N_("j - leave this hunk undecided, see next undecided hunk\n"
    "J - leave this hunk undecided, see next hunk\n"
@@ -1097,7 +1134,8 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)file_diff->hunk_nr);
 		color_fprintf(stdout, s->s.prompt_color,
-			      _(prompt_mode[prompt_mode_type]), s->buf.buf);
+			      _(s->mode->prompt_mode[prompt_mode_type]),
+			      s->buf.buf);
 		fflush(stdout);
 		if (strbuf_getline(&s->answer, stdin) == EOF)
 			break;
@@ -1254,7 +1292,7 @@ static int patch_update_file(struct add_p_state *s,
 			const char *p = _(help_patch_remainder), *eol = p;
 
 			color_fprintf(stdout, s->s.help_color, "%s",
-				      _(help_patch_text));
+				      _(s->mode->help_patch_text));
 
 			/*
 			 * Show only those lines of the remainder that are
@@ -1288,10 +1326,11 @@ static int patch_update_file(struct add_p_state *s,
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
 		discard_index(s->s.r->index);
-		setup_child_process(s, &cp, "apply", "--cached", NULL);
+		setup_child_process(s, &cp, "apply", NULL);
+		argv_array_pushv(&cp.args, s->mode->apply_args);
 		if (pipe_command(&cp, s->buf.buf, s->buf.len,
 				 NULL, 0, NULL, 0))
-			error(_("'git apply --cached' failed"));
+			error(_("'git apply' failed"));
 		if (!repo_read_index(s->s.r))
 			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
@@ -1301,7 +1340,8 @@ static int patch_update_file(struct add_p_state *s,
 	return quit;
 }
 
-int run_add_p(struct repository *r, const struct pathspec *ps)
+int run_add_p(struct repository *r, enum add_p_mode mode,
+	      const char *revision, const struct pathspec *ps)
 {
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -1310,6 +1350,9 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
 
 	init_add_i_state(&s.s, r);
 
+	s.mode = &patch_mode_add;
+	s.revision = revision;
+
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
 	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
 					 NULL, NULL, NULL) < 0 ||
diff --git a/builtin/add.c b/builtin/add.c
index 1deb59a642..006016267e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -194,12 +194,18 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 				    &use_builtin_add_i);
 
 	if (use_builtin_add_i == 1) {
+		enum add_p_mode mode;
+
 		if (!patch_mode)
 			return !!run_add_i(the_repository, pathspec);
-		if (strcmp(patch_mode, "--patch"))
+
+		if (!strcmp(patch_mode, "--patch"))
+			mode = ADD_P_ADD;
+		else
 			die("'%s' not yet supported in the built-in add -p",
 			    patch_mode);
-		return !!run_add_p(the_repository, pathspec);
+
+		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}
 
 	argv_array_push(&argv, "add--interactive");
-- 
gitgitgadget

