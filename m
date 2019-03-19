Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5F520248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCSTEF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34785 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSTEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id o10so17385122wmc.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=XpoqFgKKnMe+l2bSolUYuxAi0+tQ0b4loA5Ly4MNhWk=;
        b=qp67vm7v1OGCgzBecck7Z49Lo72/WOBSWI+RiUtM+F1OYzkPsn1zVCBIC6g0Y6PjAm
         iiI3tz7llxAloXZsPSNQp1DotcPRMfoUQ1PpH5wyXfN1AeRTh92kJg6BUGAcEG5rF9ZL
         hRFRwhNZF0uUO8ddaJT4OrShv/QkjvcMqqknVEsizGl616VZMrOjvhZ+vPBr/7v6sGV4
         e8phADQe8GBDmUyFebJhmR6P15ay8irWcAm/mI9F1uJ1HBVSG9ziEH6NJvAlOXenGP8X
         0SC6jiup2BGRHVymHo7GQSAqrVQH7+EVqtdssx4yklZYHU2u0G2RNspSc/5811JggDBa
         VUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=XpoqFgKKnMe+l2bSolUYuxAi0+tQ0b4loA5Ly4MNhWk=;
        b=sQKxrSbVdRLHFrR4H8DNQSWs0RkTcptm8o2SbJa6St7BeGSTy3qumfIupIfY7XVZgx
         Xc7xEOzfz0Veoh/S/YurRTfQcGHfJUJMqSh2L6OpXd4PlXYgmg5bwUcOqTUkUCQGAbqF
         05fGkV0QHnerb2gN6u4gkBlask0FVTAvuV+yQy2drf9heY8Ma0ZHslC+czSxYD4PGWo2
         s8Y5a/lv+o8nXMkhcJSasiZIlg8eyN4/vlWNBvuG516AsFwH9jmHABgrwEJJFx08gcV2
         8hYdo8jmaYF/x7/U3SKN169vXet8Lddf3y+w7sFZURX5+4kyDsZQCLPsrn7HhDi0Facz
         yvnA==
X-Gm-Message-State: APjAAAXr56TmCmzd+O2UPsUwbXL+dNVdVuG3HZLSICN8smA1VElBhLp5
        BLGHlyGXPSZkbvzbf0z3nndbHECFYjI=
X-Google-Smtp-Source: APXvYqyhLsgMy2ECjAA9wAEnZLGMTMcbbPC8OF/BuUHyCAdzF6w/GdQgtriCIkJZYNeznvHBoHI5Lw==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr4805223wmh.19.1553022242108;
        Tue, 19 Mar 2019 12:04:02 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:01 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 06/11] rebase -i: use struct commit when parsing options
Date:   Tue, 19 Mar 2019 19:03:12 +0000
Message-Id: <20190319190317.6632-7-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is in preparation for using `struct rebase_options` when parsing
options in cmd_rebase__interactive(). Using a string for onto,
restrict_revision and upstream, was a hangover from the scripted version
of rebase. The functions that use these variables are updated to take a
`struct commit`.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I'm not sure if parse_opt_commit() should be in parse-options-cb.c or
    not, it depends if it is going to be useful elsewhere.

 builtin/rebase.c   | 42 ++++++++++++++++++++++++------------------
 parse-options-cb.c | 17 +++++++++++++++++
 parse-options.h    |  1 +
 sequencer.c        | 21 +++++++++++----------
 sequencer.h        |  4 ++--
 5 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e55bd0348a..0584b331bf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -147,27 +147,28 @@ static int edit_todo_file(unsigned flags)
 	return res;
 }
 
-static int get_revision_ranges(const char *upstream, const char *onto,
+static int get_revision_ranges(struct commit *upstream, struct commit *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
 {
-	const char *base_rev = upstream ? upstream : onto, *shorthead;
+	struct commit *base_rev = upstream ? upstream : onto;
+	const char *shorthead;
 	struct object_id orig_head;
 
 	if (get_oid("HEAD", &orig_head))
 		return error(_("no HEAD?"));
 
 	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
-	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
+						   *head_hash);
 
 	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
 
 	if (upstream) {
 		const char *shortrev;
-		struct object_id rev_oid;
 
-		get_oid(base_rev, &rev_oid);
-		shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
+		shortrev = find_unique_abbrev(&base_rev->object.oid,
+					      DEFAULT_ABBREV);
 
 		*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
 	} else
@@ -177,7 +178,7 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 }
 
 static int init_basic_state(struct replay_opts *opts, const char *head_name,
-			    const char *onto, const char *orig_head)
+			    struct commit *onto, const char *orig_head)
 {
 	FILE *interactive;
 
@@ -195,10 +196,10 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 }
 
 static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
-				 const char *switch_to, const char *upstream,
-				 const char *onto, const char *onto_name,
+				 const char *switch_to, struct commit *upstream,
+				 struct commit *onto, const char *onto_name,
 				 const char *squash_onto, const char *head_name,
-				 const char *restrict_revision, char *raw_strategies,
+				 struct commit *restrict_revision, char *raw_strategies,
 				 struct string_list *commands, unsigned autosquash)
 {
 	int ret;
@@ -229,7 +230,8 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (restrict_revision)
-		argv_array_push(&make_script_args, restrict_revision);
+		argv_array_push(&make_script_args,
+				oid_to_hex(&restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
@@ -265,9 +267,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
-	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
-		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
+	const char *onto_name = NULL,
+		*squash_onto = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
+	struct commit *onto = NULL, *upstream = NULL, *restrict_revision = NULL;
 	struct string_list commands = STRING_LIST_INIT_DUP;
 	char *raw_strategies = NULL;
 	enum {
@@ -303,13 +306,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
 			N_("insert exec commands in todo list"), ADD_EXEC),
-		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
-		OPT_STRING(0, "restrict-revision", &restrict_revision,
-			   N_("restrict-revision"), N_("restrict revision")),
+		{ OPTION_CALLBACK, 0, "onto", &onto, N_("onto"), N_("onto"),
+		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
+		{ OPTION_CALLBACK, 0, "restrict-revision", &restrict_revision,
+		  N_("restrict-revision"), N_("restrict revision"),
+		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
 		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
 			   N_("squash onto")),
-		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
-			   N_("the upstream commit")),
+		{ OPTION_CALLBACK, 0, "upstream", &upstream, N_("upstream"),
+		  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
+		  0 },
 		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..2206eb763c 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -96,6 +96,23 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_commit(const struct option *opt, const char *arg, int unset)
+{
+	struct object_id oid;
+	struct commit *commit;
+	struct commit **target = opt->value;
+
+	if (!arg)
+		return -1;
+	if (get_oid(arg, &oid))
+		return error("malformed object name %s", arg);
+	commit = lookup_commit_reference(the_repository, &oid);
+	if (!commit)
+		return error("no such commit %s", arg);
+	*target = commit;
+	return 0;
+}
+
 int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 {
 	struct object_id oid;
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..5a75646618 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -266,6 +266,7 @@ int parse_opt_color_flag_cb(const struct option *, const char *, int);
 int parse_opt_verbosity_cb(const struct option *, const char *, int);
 int parse_opt_object_name(const struct option *, const char *, int);
 int parse_opt_commits(const struct option *, const char *, int);
+int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
diff --git a/sequencer.c b/sequencer.c
index ccc0160800..610b7ece14 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2418,14 +2418,15 @@ static void write_strategy_opts(struct replay_opts *opts)
 }
 
 int write_basic_state(struct replay_opts *opts, const char *head_name,
-		      const char *onto, const char *orig_head)
+		      struct commit *onto, const char *orig_head)
 {
 	const char *quiet = getenv("GIT_QUIET");
 
 	if (head_name)
 		write_file(rebase_path_head_name(), "%s\n", head_name);
 	if (onto)
-		write_file(rebase_path_onto(), "%s\n", onto);
+		write_file(rebase_path_onto(), "%s\n",
+			   oid_to_hex(&onto->object.oid));
 	if (orig_head)
 		write_file(rebase_path_orig_head(), "%s\n", orig_head);
 
@@ -3456,7 +3457,7 @@ int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
-			 const char *onto_name, const char *onto,
+			 const char *onto_name, const struct object_id *onto,
 			 const char *orig_head)
 {
 	struct object_id oid;
@@ -3465,7 +3466,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	if (get_oid(orig_head, &oid))
 		return error(_("%s: not a valid OID"), orig_head);
 
-	if (run_git_checkout(r, opts, onto, action)) {
+	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
@@ -4741,16 +4742,16 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash, struct todo_list *todo_list)
+		    struct commit *onto, const char *orig_head,
+		    struct string_list *commands, unsigned autosquash,
+		    struct todo_list *todo_list)
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
-	struct object_id oid;
+	struct object_id oid = onto->object.oid;
 	int res;
 
-	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
 
 	if (buf->len == 0) {
@@ -4793,7 +4794,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
 	    todo_list_check(todo_list, &new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
-		checkout_onto(r, opts, onto_name, onto, orig_head);
+		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
 		todo_list_release(&new_todo);
 
 		return -1;
@@ -4812,7 +4813,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (checkout_onto(r, opts, onto_name, oid_to_hex(&oid), orig_head))
+	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		return -1;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
diff --git a/sequencer.h b/sequencer.h
index 6c55aa4200..e640ca21f2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -150,7 +150,7 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, struct string_list *commands,
+		    struct commit *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash, struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
@@ -191,4 +191,4 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
-		      const char *onto, const char *orig_head);
+		      struct commit *onto, const char *orig_head);
-- 
2.21.0

