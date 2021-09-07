Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E770C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3259960F45
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbhIGVGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346624AbhIGVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A9C0613C1
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b6so16394333wrh.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=juFCRq72EDckZ4A/rCoXDxkjgsq6NZeWAkvROVpbp7k=;
        b=l8UfvJnIL4KTihNTlMgO4txtqwV13EcJGTcHa1whha9pdogzX8rGd/bhHXgf0k0X++
         w3rBvtFHn1Xz4hpEZyUMu+vXp6BrAX4jytAYJ5xHuLF6TJIwN73SNU9aFyYU/du7k+Dn
         HTAMR/2aaktnJqltQePeuMzW0nBw/8Aeg5O1pH/mZUwrGVAWW91ZUu+VeEYGOhMlY3Rr
         XnLymC7GDXWYeVHfF4kNRZ8bwrqye3B7e2OP2WSDi6AjNlUHYNhf4rEddKgsBGMYipJw
         oWsHPzEYjzWkC96/6gu6JBZYHtVUK2Vqo1xwmGFFx13P7OWBhU8zV/mBnNHyAxNowBSl
         3FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=juFCRq72EDckZ4A/rCoXDxkjgsq6NZeWAkvROVpbp7k=;
        b=KDg4I7Bt74L2azf27+uPAG6+pnSNmzEzkrdJtwk/gvA0i78dOxrAj6+J/XI2RgeVbO
         w914PyWQ6KYXmiRXoFWrGx64AvcdBp4ZrLNRbAjRkDuqmTr2LfPiS0bmPpFf/Al4xfBI
         0rMuy6Oku+Xu3PIANeAj4K2jqkC9AhcqK6L6TFDn7OL+9HlYhqnxs1xF3ooZLLhGiI6f
         ltkNxnBpZr3c0XPweV6HY58f1uZ9+DCEKkWRKg+ghArUicKoNQbepBtEs/XTwD7YR2XA
         yQXFENn0tjG3akplN846rmZMPam1yxCbcc55WZf/X4sFcKAU4Byyt/NK6dUhoCDKRYDy
         BU9Q==
X-Gm-Message-State: AOAM5324LydcGqygZ+MmP3zm6+cknNuGEoWzDJe9U1EsFA00rVolm326
        OJIIBZwElYYv1Met5PzczBxdfQhUY8E=
X-Google-Smtp-Source: ABdhPJxLnIcSs4OMzP11MM4XF5sn1dpQCx75gKCM6YxhaDy29DizIYOpJy04TeaFqO+kgEXlQb0eXQ==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr364535wra.216.1631048717526;
        Tue, 07 Sep 2021 14:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm154893wmc.22.2021.09.07.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:17 -0700 (PDT)
Message-Id: <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:06 +0000
Subject: [PATCH v3 05/11] rebase: drop support for `--preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This option was deprecated in favor of `--rebase-merges` some time ago,
and now we retire it.

To assist users to transition away, we do not _actually_ remove the
option, but now we no longer implement the functionality. Instead, we
offer a helpful error message suggesting which option to use.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                     |    1 -
 Documentation/git-rebase.txt   |   51 --
 Makefile                       |    2 -
 builtin/rebase.c               |  138 +----
 git-rebase--preserve-merges.sh | 1057 --------------------------------
 5 files changed, 11 insertions(+), 1238 deletions(-)
 delete mode 100644 git-rebase--preserve-merges.sh

diff --git a/.gitignore b/.gitignore
index 311841f9bed..98d6275b20d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,7 +125,6 @@
 /git-range-diff
 /git-read-tree
 /git-rebase
-/git-rebase--preserve-merges
 /git-receive-pack
 /git-reflog
 /git-remote
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e2..1382dc6f005 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -525,29 +525,12 @@ i.e. commits that would be excluded by linkgit:git-log[1]'s
 the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
 +
-The `--rebase-merges` mode is similar in spirit to the deprecated
-`--preserve-merges` but works with interactive rebases,
-where commits can be reordered, inserted and dropped at will.
-+
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
--p::
---preserve-merges::
-	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
-	instead of flattening the history by replaying commits a merge commit
-	introduces. Merge conflict resolutions or manual amendments to merge
-	commits are not preserved.
-+
-This uses the `--interactive` machinery internally, but combining it
-with the `--interactive` option explicitly is generally not a good
-idea unless you know what you are doing (see BUGS below).
-+
-See also INCOMPATIBLE OPTIONS below.
-
 -x <cmd>::
 --exec <cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
@@ -579,9 +562,6 @@ See also INCOMPATIBLE OPTIONS below.
 	the root commit(s) on a branch.  When used with --onto, it
 	will skip changes already contained in <newbase> (instead of
 	<upstream>) whereas without --onto it will operate on every change.
-	When used together with both --onto and --preserve-merges,
-	'all' root commits will be rewritten to have <newbase> as parent
-	instead.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -643,7 +623,6 @@ are incompatible with the following options:
  * --allow-empty-message
  * --[no-]autosquash
  * --rebase-merges
- * --preserve-merges
  * --interactive
  * --exec
  * --no-keep-empty
@@ -654,13 +633,6 @@ are incompatible with the following options:
 
 In addition, the following pairs of options are incompatible:
 
- * --preserve-merges and --interactive
- * --preserve-merges and --signoff
- * --preserve-merges and --rebase-merges
- * --preserve-merges and --empty=
- * --preserve-merges and --ignore-whitespace
- * --preserve-merges and --committer-date-is-author-date
- * --preserve-merges and --ignore-date
  * --keep-base and --onto
  * --keep-base and --root
  * --fork-point and --root
@@ -1274,29 +1246,6 @@ CONFIGURATION
 include::config/rebase.txt[]
 include::config/sequencer.txt[]
 
-BUGS
-----
-The todo list presented by the deprecated `--preserve-merges --interactive`
-does not represent the topology of the revision graph (use `--rebase-merges`
-instead).  Editing commits and rewording their commit messages should work
-fine, but attempts to reorder commits tend to produce counterintuitive results.
-Use `--rebase-merges` in such scenarios instead.
-
-For example, an attempt to rearrange
-------------
-1 --- 2 --- 3 --- 4 --- 5
-------------
-to
-------------
-1 --- 2 --- 4 --- 3 --- 5
-------------
-by moving the "pick 4" line will result in the following history:
-------------
-	3
-       /
-1 --- 2 --- 4 --- 5
-------------
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 9573190f1d7..43f93f61660 100644
--- a/Makefile
+++ b/Makefile
@@ -616,7 +616,6 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
-SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-i18n
 SCRIPT_LIB += git-sh-setup
 
@@ -2649,7 +2648,6 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
-LOCALIZED_SH += git-rebase--preserve-merges.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33e09619005..5f8d9f89ba4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -48,8 +48,7 @@ static GIT_PATH_FUNC(merge_dir, "rebase-merge")
 enum rebase_type {
 	REBASE_UNSPECIFIED = -1,
 	REBASE_APPLY,
-	REBASE_MERGE,
-	REBASE_PRESERVE_MERGES
+	REBASE_MERGE
 };
 
 enum empty_type {
@@ -571,8 +570,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 static int is_merge(struct rebase_options *opts)
 {
-	return opts->type == REBASE_MERGE ||
-		opts->type == REBASE_PRESERVE_MERGES;
+	return opts->type == REBASE_MERGE;
 }
 
 static void imply_merge(struct rebase_options *opts, const char *option)
@@ -582,7 +580,6 @@ static void imply_merge(struct rebase_options *opts, const char *option)
 		die(_("%s requires the merge backend"), option);
 		break;
 	case REBASE_MERGE:
-	case REBASE_PRESERVE_MERGES:
 		break;
 	default:
 		opts->type = REBASE_MERGE; /* implied */
@@ -773,17 +770,6 @@ static struct commit *peel_committish(const char *name)
 	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
 }
 
-static void add_var(struct strbuf *buf, const char *name, const char *value)
-{
-	if (!value)
-		strbuf_addf(buf, "unset %s; ", name);
-	else {
-		strbuf_addf(buf, "%s=", name);
-		sq_quote_buf(buf, value);
-		strbuf_addstr(buf, "; ");
-	}
-}
-
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
@@ -940,10 +926,7 @@ static int run_am(struct rebase_options *opts)
 
 static int run_specific_rebase(struct rebase_options *opts, enum action action)
 {
-	const char *argv[] = { NULL, NULL };
-	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
 	int status;
-	const char *backend, *backend_func;
 
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
@@ -960,87 +943,11 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 		}
 
 		status = run_sequencer_rebase(opts, action);
-		goto finished_rebase;
-	}
-
-	if (opts->type == REBASE_APPLY) {
+	} else if (opts->type == REBASE_APPLY)
 		status = run_am(opts);
-		goto finished_rebase;
-	}
-
-	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
-	add_var(&script_snippet, "state_dir", opts->state_dir);
-
-	add_var(&script_snippet, "upstream_name", opts->upstream_name);
-	add_var(&script_snippet, "upstream", opts->upstream ?
-		oid_to_hex(&opts->upstream->object.oid) : NULL);
-	add_var(&script_snippet, "head_name",
-		opts->head_name ? opts->head_name : "detached HEAD");
-	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
-	add_var(&script_snippet, "onto", opts->onto ?
-		oid_to_hex(&opts->onto->object.oid) : NULL);
-	add_var(&script_snippet, "onto_name", opts->onto_name);
-	add_var(&script_snippet, "revisions", opts->revisions);
-	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
-		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	sq_quote_argv_pretty(&buf, opts->git_am_opts.v);
-	add_var(&script_snippet, "git_am_opt", buf.buf);
-	strbuf_release(&buf);
-	add_var(&script_snippet, "verbose",
-		opts->flags & REBASE_VERBOSE ? "t" : "");
-	add_var(&script_snippet, "diffstat",
-		opts->flags & REBASE_DIFFSTAT ? "t" : "");
-	add_var(&script_snippet, "force_rebase",
-		opts->flags & REBASE_FORCE ? "t" : "");
-	if (opts->switch_to)
-		add_var(&script_snippet, "switch_to", opts->switch_to);
-	add_var(&script_snippet, "action", opts->action ? opts->action : "");
-	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
-	add_var(&script_snippet, "allow_rerere_autoupdate",
-		opts->allow_rerere_autoupdate ?
-			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
-			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
-	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
-	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
-	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
-	add_var(&script_snippet, "cmd", opts->cmd);
-	add_var(&script_snippet, "allow_empty_message",
-		opts->allow_empty_message ?  "--allow-empty-message" : "");
-	add_var(&script_snippet, "rebase_merges",
-		opts->rebase_merges ? "t" : "");
-	add_var(&script_snippet, "rebase_cousins",
-		opts->rebase_cousins ? "t" : "");
-	add_var(&script_snippet, "strategy", opts->strategy);
-	add_var(&script_snippet, "strategy_opts", opts->strategy_opts);
-	add_var(&script_snippet, "rebase_root", opts->root ? "t" : "");
-	add_var(&script_snippet, "squash_onto",
-		opts->squash_onto ? oid_to_hex(opts->squash_onto) : "");
-	add_var(&script_snippet, "git_format_patch_opt",
-		opts->git_format_patch_opt.buf);
-
-	if (is_merge(opts) &&
-	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
-		strbuf_addstr(&script_snippet,
-			      "GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR; ");
-		opts->autosquash = 0;
-	}
-
-	switch (opts->type) {
-	case REBASE_PRESERVE_MERGES:
-		backend = "git-rebase--preserve-merges";
-		backend_func = "git_rebase__preserve_merges";
-		break;
-	default:
+	else
 		BUG("Unhandled rebase type %d", opts->type);
-		break;
-	}
-
-	strbuf_addf(&script_snippet,
-		    ". git-sh-setup && . %s && %s", backend, backend_func);
-	argv[0] = script_snippet.buf;
 
-	status = run_command_v_opt(argv, RUN_USING_SHELL);
-finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
 	else if (opts->type == REBASE_MERGE)
@@ -1058,8 +965,6 @@ finished_rebase:
 		die("Nothing to do");
 	}
 
-	strbuf_release(&script_snippet);
-
 	return status ? -1 : 0;
 }
 
@@ -1313,6 +1218,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	int preserve_merges_selected = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1377,10 +1283,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("let the user edit the list of commits to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive),
-		OPT_SET_INT_F('p', "preserve-merges", &options.type,
+		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
 			      N_("(DEPRECATED) try to recreate merges instead of "
 				 "ignoring them"),
-			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
+			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
 			       N_("how to handle commits that become empty"),
@@ -1448,8 +1354,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
 		if (is_directory(buf.buf)) {
-			options.type = REBASE_PRESERVE_MERGES;
-			options.flags |= REBASE_INTERACTIVE_EXPLICIT;
+			die("`rebase -p` is no longer supported");
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
@@ -1470,6 +1375,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (preserve_merges_selected)
+		die(_("--preserve-merges was replaced by --rebase-merges"));
+
 	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
@@ -1479,10 +1387,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
-	if (options.type == REBASE_PRESERVE_MERGES)
-		warning(_("git rebase --preserve-merges is deprecated. "
-			  "Use --rebase-merges instead."));
-
 	if (keep_base) {
 		if (options.onto_name)
 			die(_("cannot combine '--keep-base' with '--onto'"));
@@ -1728,7 +1632,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		case REBASE_APPLY:
 			die(_("--strategy requires --merge or --interactive"));
 		case REBASE_MERGE:
-		case REBASE_PRESERVE_MERGES:
 			/* compatible */
 			break;
 		case REBASE_UNSPECIFIED:
@@ -1780,7 +1683,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	switch (options.type) {
 	case REBASE_MERGE:
-	case REBASE_PRESERVE_MERGES:
 		options.state_dir = merge_dir();
 		break;
 	case REBASE_APPLY:
@@ -1805,28 +1707,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.reschedule_failed_exec = reschedule_failed_exec;
 
 	if (options.signoff) {
-		if (options.type == REBASE_PRESERVE_MERGES)
-			die("cannot combine '--signoff' with "
-			    "'--preserve-merges'");
 		strvec_push(&options.git_am_opts, "--signoff");
 		options.flags |= REBASE_FORCE;
 	}
 
-	if (options.type == REBASE_PRESERVE_MERGES) {
-		/*
-		 * Note: incompatibility with --signoff handled in signoff block above
-		 * Note: incompatibility with --interactive is just a strong warning;
-		 *       git-rebase.txt caveats with "unless you know what you are doing"
-		 */
-		if (options.rebase_merges)
-			die(_("cannot combine '--preserve-merges' with "
-			      "'--rebase-merges'"));
-
-		if (options.reschedule_failed_exec)
-			die(_("error: cannot combine '--preserve-merges' with "
-			      "'--reschedule-failed-exec'"));
-	}
-
 	if (!options.root) {
 		if (argc < 1) {
 			struct branch *branch;
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
deleted file mode 100644
index b9c71d2a71b..00000000000
--- a/git-rebase--preserve-merges.sh
+++ /dev/null
@@ -1,1057 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement its
-# preserve-merges mode.
-#
-# Copyright (c) 2006 Johannes E. Schindelin
-#
-# The file containing rebase commands, comments, and empty lines.
-# This file is created by "git rebase -i" then edited by the user.  As
-# the lines are processed, they are removed from the front of this
-# file and written to the tail of $done.
-todo="$state_dir"/git-rebase-todo
-
-# The rebase command lines that have already been processed.  A line
-# is moved here when it is first handled, before any associated user
-# actions.
-done="$state_dir"/done
-
-# The commit message that is planned to be used for any changes that
-# need to be committed following a user interaction.
-msg="$state_dir"/message
-
-# The file into which is accumulated the suggested commit message for
-# squash/fixup commands.  When the first of a series of squash/fixups
-# is seen, the file is created and the commit message from the
-# previous commit and from the first squash/fixup commit are written
-# to it.  The commit message for each subsequent squash/fixup commit
-# is appended to the file as it is processed.
-#
-# The first line of the file is of the form
-#     # This is a combination of $count commits.
-# where $count is the number of commits whose messages have been
-# written to the file so far (including the initial "pick" commit).
-# Each time that a commit message is processed, this line is read and
-# updated.  It is deleted just before the combined commit is made.
-squash_msg="$state_dir"/message-squash
-
-# If the current series of squash/fixups has not yet included a squash
-# command, then this file exists and holds the commit message of the
-# original "pick" commit.  (If the series ends without a "squash"
-# command, then this can be used as the commit message of the combined
-# commit without opening the editor.)
-fixup_msg="$state_dir"/message-fixup
-
-# $rewritten is the name of a directory containing files for each
-# commit that is reachable by at least one merge base of $head and
-# $upstream. They are not necessarily rewritten, but their children
-# might be.  This ensures that commits on merged, but otherwise
-# unrelated side branches are left alone. (Think "X" in the man page's
-# example.)
-rewritten="$state_dir"/rewritten
-
-dropped="$state_dir"/dropped
-
-end="$state_dir"/end
-msgnum="$state_dir"/msgnum
-
-# A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
-# GIT_AUTHOR_DATE that will be used for the commit that is currently
-# being rebased.
-author_script="$state_dir"/author-script
-
-# When an "edit" rebase command is being processed, the SHA1 of the
-# commit to be edited is recorded in this file.  When "git rebase
-# --continue" is executed, if there are any staged changes then they
-# will be amended to the HEAD commit, but only provided the HEAD
-# commit is still the commit to be edited.  When any other rebase
-# command is processed, this file is deleted.
-amend="$state_dir"/amend
-
-# For the post-rewrite hook, we make a list of rewritten commits and
-# their new sha1s.  The rewritten-pending list keeps the sha1s of
-# commits that have been processed, but not committed yet,
-# e.g. because they are waiting for a 'squash' command.
-rewritten_list="$state_dir"/rewritten-list
-rewritten_pending="$state_dir"/rewritten-pending
-
-# Work around Git for Windows' Bash whose "read" does not strip CRLF
-# and leaves CR at the end instead.
-cr=$(printf "\015")
-
-resolvemsg="
-$(gettext 'Resolve all conflicts manually, mark them as resolved with
-"git add/rm <conflicted_files>", then run "git rebase --continue".
-You can instead skip this commit: run "git rebase --skip".
-To abort and get back to the state before "git rebase", run "git rebase --abort".')
-"
-
-write_basic_state () {
-	echo "$head_name" > "$state_dir"/head-name &&
-	echo "$onto" > "$state_dir"/onto &&
-	echo "$orig_head" > "$state_dir"/orig-head &&
-	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
-	test t = "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
-		"$state_dir"/allow_rerere_autoupdate
-	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
-	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
-	test -n "$reschedule_failed_exec" && : > "$state_dir"/reschedule-failed-exec
-}
-
-apply_autostash () {
-	if test -f "$state_dir/autostash"
-	then
-		stash_sha1=$(cat "$state_dir/autostash")
-		if git stash apply $stash_sha1 >/dev/null 2>&1
-		then
-			echo "$(gettext 'Applied autostash.')" >&2
-		else
-			git stash store -m "autostash" -q $stash_sha1 ||
-			die "$(eval_gettext "Cannot store \$stash_sha1")"
-			gettext 'Applying autostash resulted in conflicts.
-Your changes are safe in the stash.
-You can run "git stash pop" or "git stash drop" at any time.
-' >&2
-		fi
-	fi
-}
-
-output () {
-	case "$verbose" in
-	'')
-		output=$("$@" 2>&1 )
-		status=$?
-		test $status != 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
-
-strategy_args=${strategy:+--strategy=$strategy}
-test -n "$strategy_opts" &&
-eval '
-	for strategy_opt in '"$strategy_opts"'
-	do
-		strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
-	done
-'
-
-GIT_CHERRY_PICK_HELP="$resolvemsg"
-export GIT_CHERRY_PICK_HELP
-
-comment_char=$(git config --get core.commentchar 2>/dev/null)
-case "$comment_char" in
-'' | auto)
-	comment_char="#"
-	;;
-?)
-	;;
-*)
-	comment_char=$(echo "$comment_char" | cut -c1)
-	;;
-esac
-
-warn () {
-	printf '%s\n' "$*" >&2
-}
-
-# Output the commit message for the specified commit.
-commit_message () {
-	git cat-file commit "$1" | sed "1,/^$/d"
-}
-
-orig_reflog_action="$GIT_REFLOG_ACTION"
-
-comment_for_reflog () {
-	case "$orig_reflog_action" in
-	''|rebase*)
-		GIT_REFLOG_ACTION="rebase -i ($1)"
-		export GIT_REFLOG_ACTION
-		;;
-	esac
-}
-
-last_count=
-mark_action_done () {
-	sed -e 1q < "$todo" >> "$done"
-	sed -e 1d < "$todo" >> "$todo".new
-	mv -f "$todo".new "$todo"
-	new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
-	echo $new_count >"$msgnum"
-	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
-	echo $total >"$end"
-	if test "$last_count" != "$new_count"
-	then
-		last_count=$new_count
-		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
-		test -z "$verbose" || echo
-	fi
-}
-
-append_todo_help () {
-	gettext "
-Commands:
-p, pick <commit> = use commit
-r, reword <commit> = use commit, but edit the commit message
-e, edit <commit> = use commit, but stop for amending
-s, squash <commit> = use commit, but meld into previous commit
-f, fixup <commit> = like \"squash\", but discard this commit's log message
-x, exec <commit> = run command (the rest of the line) using shell
-d, drop <commit> = remove commit
-l, label <label> = label current HEAD with a name
-t, reset <label> = reset HEAD to a label
-m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
-.       create a merge commit using the original merge commit's
-.       message (or the oneline, if no original merge commit was
-.       specified). Use -c <commit> to reword the commit message.
-
-These lines can be re-ordered; they are executed from top to bottom.
-" | git stripspace --comment-lines >>"$todo"
-
-	if test $(get_missing_commit_check_level) = error
-	then
-		gettext "
-Do not remove any line. Use 'drop' explicitly to remove a commit.
-" | git stripspace --comment-lines >>"$todo"
-	else
-		gettext "
-If you remove a line here THAT COMMIT WILL BE LOST.
-" | git stripspace --comment-lines >>"$todo"
-	fi
-}
-
-make_patch () {
-	sha1_and_parents="$(git rev-list --parents -1 "$1")"
-	case "$sha1_and_parents" in
-	?*' '?*' '?*)
-		git diff --cc $sha1_and_parents
-		;;
-	?*' '?*)
-		git diff-tree -p "$1^!"
-		;;
-	*)
-		echo "Root commit"
-		;;
-	esac > "$state_dir"/patch
-	test -f "$msg" ||
-		commit_message "$1" > "$msg"
-	test -f "$author_script" ||
-		get_author_ident_from_commit "$1" > "$author_script"
-}
-
-die_with_patch () {
-	echo "$1" > "$state_dir"/stopped-sha
-	git update-ref REBASE_HEAD "$1"
-	make_patch "$1"
-	die "$2"
-}
-
-exit_with_patch () {
-	echo "$1" > "$state_dir"/stopped-sha
-	git update-ref REBASE_HEAD "$1"
-	make_patch $1
-	git rev-parse --verify HEAD > "$amend"
-	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-	warn "$(eval_gettext "\
-You can amend the commit now, with
-
-	git commit --amend \$gpg_sign_opt_quoted
-
-Once you are satisfied with your changes, run
-
-	git rebase --continue")"
-	warn
-	exit $2
-}
-
-die_abort () {
-	apply_autostash
-	rm -rf "$state_dir"
-	die "$1"
-}
-
-has_action () {
-	test -n "$(git stripspace --strip-comments <"$1")"
-}
-
-is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) || {
-		sha1=$1
-		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
-	}
-	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-	test "$tree" = "$ptree"
-}
-
-is_merge_commit()
-{
-	git rev-parse --verify --quiet "$1"^2 >/dev/null 2>&1
-}
-
-# Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
-# GIT_AUTHOR_DATE exported from the current environment.
-do_with_author () {
-	(
-		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-		"$@"
-	)
-}
-
-git_sequence_editor () {
-	if test -z "$GIT_SEQUENCE_EDITOR"
-	then
-		GIT_SEQUENCE_EDITOR="$(git config sequence.editor)"
-		if [ -z "$GIT_SEQUENCE_EDITOR" ]
-		then
-			GIT_SEQUENCE_EDITOR="$(git var GIT_EDITOR)" || return $?
-		fi
-	fi
-
-	eval "$GIT_SEQUENCE_EDITOR" '"$@"'
-}
-
-pick_one () {
-	ff=--ff
-
-	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
-	case "$force_rebase" in '') ;; ?*) ff= ;; esac
-	output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
-
-	if is_empty_commit "$sha1"
-	then
-		empty_args="--allow-empty"
-	fi
-
-	pick_one_preserving_merges "$@"
-}
-
-pick_one_preserving_merges () {
-	fast_forward=t
-	case "$1" in
-	-n)
-		fast_forward=f
-		sha1=$2
-		;;
-	*)
-		sha1=$1
-		;;
-	esac
-	sha1=$(git rev-parse $sha1)
-
-	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
-	then
-		while read current_commit
-		do
-			git rev-parse HEAD > "$rewritten"/$current_commit
-		done <"$state_dir"/current-commit
-		rm "$state_dir"/current-commit ||
-			die "$(gettext "Cannot write current commit's replacement sha1")"
-	fi
-
-	echo $sha1 >> "$state_dir"/current-commit
-
-	# rewrite parents; if none were rewritten, we can fast-forward.
-	new_parents=
-	pend=" $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)"
-	if test "$pend" = " "
-	then
-		pend=" root"
-	fi
-	while [ "$pend" != "" ]
-	do
-		p=$(expr "$pend" : ' \([^ ]*\)')
-		pend="${pend# $p}"
-
-		if test -f "$rewritten"/$p
-		then
-			new_p=$(cat "$rewritten"/$p)
-
-			# If the todo reordered commits, and our parent is marked for
-			# rewriting, but hasn't been gotten to yet, assume the user meant to
-			# drop it on top of the current HEAD
-			if test -z "$new_p"
-			then
-				new_p=$(git rev-parse HEAD)
-			fi
-
-			test $p != $new_p && fast_forward=f
-			case "$new_parents" in
-			*$new_p*)
-				;; # do nothing; that parent is already there
-			*)
-				new_parents="$new_parents $new_p"
-				;;
-			esac
-		else
-			if test -f "$dropped"/$p
-			then
-				fast_forward=f
-				replacement="$(cat "$dropped"/$p)"
-				test -z "$replacement" && replacement=root
-				pend=" $replacement$pend"
-			else
-				new_parents="$new_parents $p"
-			fi
-		fi
-	done
-	case $fast_forward in
-	t)
-		output warn "$(eval_gettext "Fast-forward to \$sha1")"
-		output git reset --hard $sha1 ||
-			die "$(eval_gettext "Cannot fast-forward to \$sha1")"
-		;;
-	f)
-		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-
-		if [ "$1" != "-n" ]
-		then
-			# detach HEAD to current parent
-			output git checkout $first_parent 2> /dev/null ||
-				die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
-		fi
-
-		case "$new_parents" in
-		' '*' '*)
-			test "a$1" = a-n && die "$(eval_gettext "Refusing to squash a merge: \$sha1")"
-
-			# redo merge
-			author_script_content=$(get_author_ident_from_commit $sha1)
-			eval "$author_script_content"
-			msg_content="$(commit_message $sha1)"
-			# No point in merging the first parent, that's HEAD
-			new_parents=${new_parents# $first_parent}
-			merge_args="--no-log --no-ff"
-			if ! do_with_author output eval \
-				git merge ${gpg_sign_opt:+$(git rev-parse \
-					--sq-quote "$gpg_sign_opt")} \
-				$allow_rerere_autoupdate "$merge_args" \
-				"$strategy_args" \
-				-m "$(git rev-parse --sq-quote "$msg_content")" \
-				"$new_parents"
-			then
-				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
-				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
-			fi
-			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
-			;;
-		*)
-			output eval git cherry-pick $allow_rerere_autoupdate \
-				$allow_empty_message \
-				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-				"$strategy_args" "$@" ||
-				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
-			;;
-		esac
-		;;
-	esac
-}
-
-this_nth_commit_message () {
-	n=$1
-	eval_gettext "This is the commit message #\${n}:"
-}
-
-skip_nth_commit_message () {
-	n=$1
-	eval_gettext "The commit message #\${n} will be skipped:"
-}
-
-update_squash_messages () {
-	if test -f "$squash_msg"; then
-		mv "$squash_msg" "$squash_msg".bak || exit
-		count=$(($(sed -n \
-			-e "1s/^$comment_char[^0-9]*\([0-9][0-9]*\).*/\1/p" \
-			-e "q" < "$squash_msg".bak)+1))
-		{
-			printf '%s\n' "$comment_char $(eval_ngettext \
-				"This is a combination of \$count commit." \
-				"This is a combination of \$count commits." \
-				$count)"
-			sed -e 1d -e '2,/^./{
-				/^$/d
-			}' <"$squash_msg".bak
-		} >"$squash_msg"
-	else
-		commit_message HEAD >"$fixup_msg" ||
-		die "$(eval_gettext "Cannot write \$fixup_msg")"
-		count=2
-		{
-			printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"
-			printf '%s\n' "$comment_char $(gettext "This is the 1st commit message:")"
-			echo
-			cat "$fixup_msg"
-		} >"$squash_msg"
-	fi
-	case $1 in
-	squash)
-		rm -f "$fixup_msg"
-		echo
-		printf '%s\n' "$comment_char $(this_nth_commit_message $count)"
-		echo
-		commit_message $2
-		;;
-	fixup)
-		echo
-		printf '%s\n' "$comment_char $(skip_nth_commit_message $count)"
-		echo
-		# Change the space after the comment character to TAB:
-		commit_message $2 | git stripspace --comment-lines | sed -e 's/ /	/'
-		;;
-	esac >>"$squash_msg"
-}
-
-peek_next_command () {
-	git stripspace --strip-comments <"$todo" | sed -n -e 's/ .*//p' -e q
-}
-
-# A squash/fixup has failed.  Prepare the long version of the squash
-# commit message, then die_with_patch.  This code path requires the
-# user to edit the combined commit message for all commits that have
-# been squashed/fixedup so far.  So also erase the old squash
-# messages, effectively causing the combined commit to be used as the
-# new basis for any further squash/fixups.  Args: sha1 rest
-die_failed_squash() {
-	sha1=$1
-	rest=$2
-	mv "$squash_msg" "$msg" || exit
-	rm -f "$fixup_msg"
-	cp "$msg" "$GIT_DIR"/MERGE_MSG || exit
-	warn
-	warn "$(eval_gettext "Could not apply \$sha1... \$rest")"
-	die_with_patch $sha1 ""
-}
-
-flush_rewritten_pending() {
-	test -s "$rewritten_pending" || return
-	newsha1="$(git rev-parse HEAD^0)"
-	sed "s/$/ $newsha1/" < "$rewritten_pending" >> "$rewritten_list"
-	rm -f "$rewritten_pending"
-}
-
-record_in_rewritten() {
-	oldsha1="$(git rev-parse $1)"
-	echo "$oldsha1" >> "$rewritten_pending"
-
-	case "$(peek_next_command)" in
-	squash|s|fixup|f)
-		;;
-	*)
-		flush_rewritten_pending
-		;;
-	esac
-}
-
-do_pick () {
-	sha1=$1
-	rest=$2
-	if test "$(git rev-parse HEAD)" = "$squash_onto"
-	then
-		# Set the correct commit message and author info on the
-		# sentinel root before cherry-picking the original changes
-		# without committing (-n).  Finally, update the sentinel again
-		# to include these changes.  If the cherry-pick results in a
-		# conflict, this means our behaviour is similar to a standard
-		# failed cherry-pick during rebase, with a dirty index to
-		# resolve before manually running git commit --amend then git
-		# rebase --continue.
-		git commit --allow-empty --allow-empty-message --amend \
-			   --no-post-rewrite -n -q -C $sha1 $signoff &&
-			pick_one -n $sha1 &&
-			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $sha1 $signoff \
-				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				   die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
-	else
-		pick_one $sha1 ||
-			die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
-	fi
-}
-
-do_next () {
-	rm -f "$msg" "$author_script" "$amend" "$state_dir"/stopped-sha || exit
-	read -r command sha1 rest < "$todo"
-	case "$command" in
-	"$comment_char"*|''|noop|drop|d)
-		mark_action_done
-		;;
-	"$cr")
-		# Work around CR left by "read" (e.g. with Git for Windows' Bash).
-		mark_action_done
-		;;
-	pick|p)
-		comment_for_reflog pick
-
-		mark_action_done
-		do_pick $sha1 "$rest"
-		record_in_rewritten $sha1
-		;;
-	reword|r)
-		comment_for_reflog reword
-
-		mark_action_done
-		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} \
-			$allow_empty_message || {
-			warn "$(eval_gettext "\
-Could not amend commit after successfully picking \$sha1... \$rest
-This is most likely due to an empty commit message, or the pre-commit hook
-failed. If the pre-commit hook failed, you may need to resolve the issue before
-you are able to reword the commit.")"
-			exit_with_patch $sha1 1
-		}
-		record_in_rewritten $sha1
-		;;
-	edit|e)
-		comment_for_reflog edit
-
-		mark_action_done
-		do_pick $sha1 "$rest"
-		sha1_abbrev=$(git rev-parse --short $sha1)
-		warn "$(eval_gettext "Stopped at \$sha1_abbrev... \$rest")"
-		exit_with_patch $sha1 0
-		;;
-	squash|s|fixup|f)
-		case "$command" in
-		squash|s)
-			squash_style=squash
-			;;
-		fixup|f)
-			squash_style=fixup
-			;;
-		esac
-		comment_for_reflog $squash_style
-
-		test -f "$done" && has_action "$done" ||
-			die "$(eval_gettext "Cannot '\$squash_style' without a previous commit")"
-
-		mark_action_done
-		update_squash_messages $squash_style $sha1
-		author_script_content=$(get_author_ident_from_commit HEAD)
-		echo "$author_script_content" > "$author_script"
-		eval "$author_script_content"
-		if ! pick_one -n $sha1
-		then
-			git rev-parse --verify HEAD >"$amend"
-			die_failed_squash $sha1 "$rest"
-		fi
-		case "$(peek_next_command)" in
-		squash|s|fixup|f)
-			# This is an intermediate commit; its message will only be
-			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-				die_failed_squash $sha1 "$rest"
-			;;
-		*)
-			# This is the final command of this squash/fixup group
-			if test -f "$fixup_msg"
-			then
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die_failed_squash $sha1 "$rest"
-			else
-				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
-				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die_failed_squash $sha1 "$rest"
-			fi
-			rm -f "$squash_msg" "$fixup_msg"
-			;;
-		esac
-		record_in_rewritten $sha1
-		;;
-	x|"exec")
-		read -r command rest < "$todo"
-		mark_action_done
-		eval_gettextln "Executing: \$rest"
-		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
-		status=$?
-		# Run in subshell because require_clean_work_tree can die.
-		dirty=f
-		(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t
-		if test "$status" -ne 0
-		then
-			warn "$(eval_gettext "Execution failed: \$rest")"
-			test "$dirty" = f ||
-				warn "$(gettext "and made changes to the index and/or the working tree")"
-
-			warn "$(gettext "\
-You can fix the problem, and then run
-
-	git rebase --continue")"
-			warn
-			if test $status -eq 127		# command not found
-			then
-				status=1
-			fi
-			exit "$status"
-		elif test "$dirty" = t
-		then
-			# TRANSLATORS: after these lines is a command to be issued by the user
-			warn "$(eval_gettext "\
-Execution succeeded: \$rest
-but left changes to the index and/or the working tree
-Commit or stash your changes, and then run
-
-	git rebase --continue")"
-			warn
-			exit 1
-		fi
-		;;
-	*)
-		warn "$(eval_gettext "Unknown command: \$command \$sha1 \$rest")"
-		fixtodo="$(gettext "Please fix this using 'git rebase --edit-todo'.")"
-		if git rev-parse --verify -q "$sha1" >/dev/null
-		then
-			die_with_patch $sha1 "$fixtodo"
-		else
-			die "$fixtodo"
-		fi
-		;;
-	esac
-	test -s "$todo" && return
-
-	comment_for_reflog finish &&
-	newhead=$(git rev-parse HEAD) &&
-	case $head_name in
-	refs/*)
-		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
-		git update-ref -m "$message" $head_name $newhead $orig_head &&
-		git symbolic-ref \
-		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
-		  HEAD $head_name
-		;;
-	esac && {
-		test ! -f "$state_dir"/verbose ||
-			git diff-tree --stat $orig_head..HEAD
-	} &&
-	{
-		test -s "$rewritten_list" &&
-		git notes copy --for-rewrite=rebase < "$rewritten_list" ||
-		true # we don't care if this copying failed
-	} &&
-	hook="$(git rev-parse --git-path hooks/post-rewrite)"
-	if test -x "$hook" && test -s "$rewritten_list"; then
-		"$hook" rebase < "$rewritten_list"
-		true # we don't care if this hook failed
-	fi &&
-		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
-
-	return 1 # not failure; just to break the do_rest loop
-}
-
-# can only return 0, when the infinite loop breaks
-do_rest () {
-	while :
-	do
-		do_next || break
-	done
-}
-
-expand_todo_ids() {
-	git rebase--interactive --expand-ids
-}
-
-collapse_todo_ids() {
-	git rebase--interactive --shorten-ids
-}
-
-# Switch to the branch in $into and notify it in the reflog
-checkout_onto () {
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
-	git update-ref ORIG_HEAD $orig_head
-}
-
-get_missing_commit_check_level () {
-	check_level=$(git config --get rebase.missingCommitsCheck)
-	check_level=${check_level:-ignore}
-	# Don't be case sensitive
-	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
-}
-
-# Initiate an action. If the cannot be any
-# further action it  may exec a command
-# or exit and not return.
-#
-# TODO: Consider a cleaner return model so it
-# never exits and always return 0 if process
-# is complete.
-#
-# Parameter 1 is the action to initiate.
-#
-# Returns 0 if the action was able to complete
-# and if 1 if further processing is required.
-initiate_action () {
-	case "$1" in
-	continue)
-		# do we have anything to commit?
-		if git diff-index --cached --quiet HEAD --
-		then
-			# Nothing to commit -- skip this commit
-
-			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
-			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
-			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
-		else
-			if ! test -f "$author_script"
-			then
-				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-				die "$(eval_gettext "\
-You have staged changes in your working tree.
-If these changes are meant to be
-squashed into the previous commit, run:
-
-  git commit --amend \$gpg_sign_opt_quoted
-
-If they are meant to go into a new commit, run:
-
-  git commit \$gpg_sign_opt_quoted
-
-In both cases, once you're done, continue with:
-
-  git rebase --continue
-")"
-			fi
-			. "$author_script" ||
-				die "$(gettext "Error trying to find the author identity to amend commit")"
-			if test -f "$amend"
-			then
-				current_head=$(git rev-parse --verify HEAD)
-				test "$current_head" = $(cat "$amend") ||
-				die "$(gettext "\
-You have uncommitted changes in your working tree. Please commit them
-first and then run 'git rebase --continue' again.")"
-				do_with_author git commit --amend --no-verify -F "$msg" -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die "$(gettext "Could not commit staged changes.")"
-			else
-				do_with_author git commit --no-verify -F "$msg" -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die "$(gettext "Could not commit staged changes.")"
-			fi
-		fi
-
-		if test -r "$state_dir"/stopped-sha
-		then
-			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
-		fi
-
-		require_clean_work_tree "rebase"
-		do_rest
-		return 0
-		;;
-	skip)
-		git rerere clear
-		do_rest
-		return 0
-		;;
-	edit-todo)
-		git stripspace --strip-comments <"$todo" >"$todo".new
-		mv -f "$todo".new "$todo"
-		collapse_todo_ids
-		append_todo_help
-		gettext "
-You are editing the todo file of an ongoing interactive rebase.
-To continue rebase after editing, run:
-    git rebase --continue
-
-" | git stripspace --comment-lines >>"$todo"
-
-		git_sequence_editor "$todo" ||
-			die "$(gettext "Could not execute editor")"
-		expand_todo_ids
-
-		exit
-		;;
-	show-current-patch)
-		exec git show REBASE_HEAD --
-		;;
-	*)
-		return 1 # continue
-		;;
-	esac
-}
-
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
-init_basic_state () {
-	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
-
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-	write_basic_state
-}
-
-init_revisions_and_shortrevisions () {
-	shorthead=$(git rev-parse --short $orig_head)
-	shortonto=$(git rev-parse --short $onto)
-	if test -z "$rebase_root"
-		# this is now equivalent to ! -z "$upstream"
-	then
-		shortupstream=$(git rev-parse --short $upstream)
-		revisions=$upstream...$orig_head
-		shortrevisions=$shortupstream..$shorthead
-	else
-		revisions=$onto...$orig_head
-		shortrevisions=$shorthead
-		test -z "$squash_onto" ||
-		echo "$squash_onto" >"$state_dir"/squash-onto
-	fi
-}
-
-complete_action() {
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--interactive --rearrange-squash || exit
-	test -n "$cmd" && git rebase--interactive --add-exec-commands --cmd "$cmd"
-
-	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-	todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-	append_todo_help
-	gettext "
-However, if you remove everything, the rebase will be aborted.
-
-" | git stripspace --comment-lines >>"$todo"
-
-	if test -z "$keep_empty"
-	then
-		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-	fi
-
-
-	has_action "$todo" ||
-		return 2
-
-	cp "$todo" "$todo".backup
-	collapse_todo_ids
-	git_sequence_editor "$todo" ||
-		die_abort "$(gettext "Could not execute editor")"
-
-	has_action "$todo" ||
-		return 2
-
-	git rebase--interactive --check-todo-list || {
-		ret=$?
-		checkout_onto
-		exit $ret
-	}
-
-	expand_todo_ids
-	checkout_onto
-	do_rest
-}
-
-git_rebase__preserve_merges () {
-	initiate_action "$action"
-	ret=$?
-	if test $ret = 0; then
-		return 0
-	fi
-
-	setup_reflog_action
-	init_basic_state
-
-	if test -z "$rebase_root"
-	then
-		mkdir "$rewritten" &&
-		for c in $(git merge-base --all $orig_head $upstream)
-		do
-			echo $onto > "$rewritten"/$c ||
-				die "$(gettext "Could not init rewritten commits")"
-		done
-	else
-		mkdir "$rewritten" &&
-		echo $onto > "$rewritten"/root ||
-			die "$(gettext "Could not init rewritten commits")"
-	fi
-
-	init_revisions_and_shortrevisions
-
-	format=$(git config --get rebase.instructionFormat)
-	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-	git rev-list --format="%m%H ${format:-%s}" \
-		--reverse --left-right --topo-order \
-		$revisions ${restrict_revision+^$restrict_revision} | \
-		sed -n "s/^>//p" |
-	while read -r sha1 rest
-	do
-		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-		then
-			comment_out="$comment_char "
-		else
-			comment_out=
-		fi
-
-		if test -z "$rebase_root"
-		then
-			preserve=t
-			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
-			do
-				if test -f "$rewritten"/$p
-				then
-					preserve=f
-				fi
-			done
-		else
-			preserve=f
-		fi
-		if test f = "$preserve"
-		then
-			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-		fi
-	done
-
-	# Watch for commits that been dropped by --cherry-pick
-	mkdir "$dropped"
-	# Save all non-cherry-picked changes
-	git rev-list $revisions --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
-	# Now all commits and note which ones are missing in
-	# not-cherry-picks and hence being dropped
-	git rev-list $revisions |
-	while read rev
-	do
-		if test -f "$rewritten"/$rev &&
-		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
-		then
-			# Use -f2 because if rev-list is telling us this commit is
-			# not worthwhile, we don't want to track its multiple heads,
-			# just the history of its first-parent for others that will
-			# be rebasing on top of it
-			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-			sha1=$(git rev-list -1 $rev)
-			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
-			rm "$rewritten"/$rev
-		fi
-	done
-
-	complete_action
-}
-- 
gitgitgadget

