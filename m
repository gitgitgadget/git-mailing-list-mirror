Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34591F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeGJMRc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53671 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeGJMR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so24461411wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zw0RUDplkFJwKZEVUy86HFfSE/+SAXwhSEA7QJj6hss=;
        b=trna+AtFncHYgCN7iV3t//En7eEr9baczn/RY+baQmZ+7yF0TzzYzBXRQK90+Qqw/9
         2pTo1wSEOrmaXNPSzJbacwaM/Z7yzhtNZdidLRD/1T2uw0NUzLyiGTlNiQJW21R+o5Ag
         cfq3I7S313xd9Q2HNmj+2k3bgC4hBV1FFzE4ySlBeXwYFHNd1AJ3RpLuLyRjnB68x3Ua
         vrIFBoq8gWJDDvwu6X6j2sWlkKSAvi2+Je71jDYerALCwWLl4fOoEQqM93hQPHR64ALd
         g+aO5RX/FMNDiWuFAO1Hm+9ISLgsHRYOin3Pj/Cp5J/fje32LeghFpqb+Wq+AFBzRLpX
         sj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zw0RUDplkFJwKZEVUy86HFfSE/+SAXwhSEA7QJj6hss=;
        b=qDfPVwiXzXtznUT+9zTNDuJYVeUVDyC/ZCeqhpQsDiRuov1VhrPL7TvC+VhUq6jpFa
         h3nt414UVY1sx34pv44A5lhJD6O8tDBfzW7xfppaWiO44yDDTqAUeD8hrRFBYT5KmeEK
         /KnBoq7xz06s9Fo3FPVc7RpGCpJLV+p4R8kRtpz+r5FRuJaJ5f9u12ieZxp3MO5k0CeX
         SzEk7OZ8u6dHHbPUXP7GpQ8ofJShEKJCOiQaNWF7rMzWl4nzEtIb7ZNdcJdfQEm7L9OM
         4APkiBZbsKu16qypDefDnnkcVN+VqrwDihElyiIBt0TZfSLa8TFQ7GRREkZESQGf6Lkx
         vq2g==
X-Gm-Message-State: APt69E0y8byCHpfNImIvetiyU2AHMUnDODYgk0mI6EkmLc0od1XBxIMc
        GT8JLykn1hXMHhnd1qHV4hm/Ghsx
X-Google-Smtp-Source: AAOMgpeCU9x+7J+/gZ0TZ6midg4w+en12La9TCJOfoJseWjDo313Gj23IPTBcWIRrVTKoPUl8ufs3w==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr14118268wmz.23.1531225047695;
        Tue, 10 Jul 2018 05:17:27 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 10/13] rebase--interactive: rewrite complete_action() in C
Date:   Tue, 10 Jul 2018 14:15:54 +0200
Message-Id: <20180710121557.6698-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites complete_action() from shell to C.

A new mode is added to rebase--helper (`--complete-action`), as well as
a new flag (`--autosquash`).

Finally, complete_action() is stripped from git-rebase--interactive.sh.

The original complete_action() checked twice that the todo-list had at
least one operations (the first check took place after the help message
was inserted, the second after the user edited the todo-list).  If there
are no actions, complete_action() would return with the code 2.  This is
a special case for rebase -i and -p; git-rebase.sh would then apply the
autostash, delete the state directory, and die with the message "nothing
to do".  This rewrite remove the first check (because a noop is added to
the todo-list if it is empty).  For the second case, the cleanup is
rewritten in C instead of returning 2.

As rebase -i no longer returns 2, the comment describing this behaviour
in git-rebase.sh is updated to reflect this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 13 +++++-
 git-rebase--interactive.sh | 53 ++---------------------
 git-rebase.sh              |  2 +-
 sequencer.c                | 89 ++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  4 ++
 5 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index d4cfe43e7..bb3698dba 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,14 +13,15 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0,
+		autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1, ret;
 	const char *oid = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
 		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO
+		CHECKOUT_ONTO, COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -30,6 +31,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits thas begin with squash!/fixup!")),
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
@@ -58,6 +61,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "checkout-onto", &command,
 			    N_("checkout a commit"), CHECKOUT_ONTO),
+		OPT_CMDMODE(0, "complete-action", &command,
+			    N_("complete the action"), COMPLETE_ACTION),
 		OPT_END()
 	};
 
@@ -110,5 +115,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	if (command == CHECKOUT_ONTO && argc == 4)
 		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
+	if (command == COMPLETE_ACTION && argc == 6)
+		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
+					 argv[4], argv[5], autosquash, keep_empty);
+
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b68f108f2..59dc4888a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -127,54 +127,6 @@ init_revisions_and_shortrevisions () {
 	fi
 }
 
-complete_action() {
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
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
-	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
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
-	git rebase--helper --check-todo-list || {
-		ret=$?
-		git rebase--helper --checkout-onto "$onto_name" "$onto" \
-		    "$orig_head" ${verbose:+--verbose}
-		exit $ret
-	}
-
-	expand_todo_ids
-
-	test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
-	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
-	    ${verbose:+--verbose}
-	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-	     --continue
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -193,5 +145,8 @@ git_rebase__interactive () {
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
-	complete_action
+	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
+		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
+		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
+		${verbose:+--verbose} ${force_rebase:+--no-ff}
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 19bdebb48..de2a9f39f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -219,7 +219,7 @@ run_specific_rebase () {
 	if test $ret -eq 0
 	then
 		finish_rebase
-	elif test $ret -eq 2 # special exit status for rebase -i
+	elif test $ret -eq 2 # special exit status for rebase -p
 	then
 		apply_autostash &&
 		rm -rf "$state_dir" &&
diff --git a/sequencer.c b/sequencer.c
index 676ac1320..da975285d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -29,6 +29,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "rebase-interactive.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -52,6 +53,9 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+static GIT_PATH_FUNC(rebase_path_todo_backup,
+		     "rebase-merge/git-rebase-todo.backup")
+
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4472,6 +4476,91 @@ int skip_unnecessary_picks(const char **output_oid)
 	return 0;
 }
 
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash, unsigned keep_empty)
+{
+	const char *shortonto, *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct strbuf *buf = &(todo_list.buf);
+	struct object_id oid;
+	struct stat st;
+
+	get_oid(onto, &oid);
+	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
+
+	if (!lstat(todo_file, &st) && st.st_size == 0 &&
+	    write_message("noop\n", 5, todo_file, 0))
+		return error_errno(_("could not write '%s'"), todo_file);
+
+	if (autosquash && rearrange_squash())
+		return 0;
+
+	if (cmd && *cmd)
+		sequencer_add_exec_commands(cmd);
+
+	if (strbuf_read_file(buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (parse_insn_buffer(buf->buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	strbuf_addch(buf, '\n');
+	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+				      "Rebase %s onto %s (%d commands)",
+				      todo_list.nr),
+			      shortrevisions, shortonto, todo_list.nr);
+	append_todo_help(0, keep_empty, buf);
+
+	if (write_message(buf->buf, buf->len, todo_file, 0)) {
+		todo_list_release(&todo_list);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	copy_file(rebase_path_todo_backup(), todo_file, 0666);
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+
+	strbuf_reset(buf);
+
+	if (launch_sequence_editor(todo_file, buf, NULL)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("could not execute editor"));
+	}
+
+	strbuf_stripspace(buf, 1);
+	if (buf->len == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("nothing to do"));
+	}
+
+	todo_list_release(&todo_list);
+
+	if (check_todo_list()) {
+		checkout_onto(opts, onto_name, onto, orig_head);
+		return 1;
+	}
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	if (opts->allow_ff && skip_unnecessary_picks(&onto))
+		return error(_("could not skip unnecessary pick commands"));
+
+	checkout_onto(opts, onto_name, onto, orig_head);
+	if (require_clean_work_tree("rebase", "", 1, 1))
+		return 1;
+
+	return sequencer_continue(opts);
+}
+
 struct subject2item_entry {
 	struct hashmap_entry entry;
 	int i;
diff --git a/sequencer.h b/sequencer.h
index 25b50efe2..02772b927 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -89,6 +89,10 @@ int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(const char **output_oid);
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash, unsigned keep_empty);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

