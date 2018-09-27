Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627331F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeI1EVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39486 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeI1EVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so4237644wrw.6
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrWKJ00avjOFxOx2Jk3/29KD0ikKkDwS6VhnJqhxvcA=;
        b=NDgrxjhEAg6FhipN5yznZFF+HSt3DAXPbQ1+/QxZAFX8cNU0+2ohUEx7PzZEV+j1ar
         5YOXvFlkTNkbQdcJe4e+x1QY77+ml68uFwAgXTYhVqtJ6Gy9w/3gi1B3f+L/m4IFk1Hu
         mzAhen8HRJVynpSYt8aB8Jh8Cp6HPg8oIugg0q1GUUC3PuVedUPDKB9Amr2Dxofz51O1
         2xbW2uDXQIgCB4qG//OGQoYKWJxGheRpwiDdfzyIZQnYRUfjPZibkvf7q9DdvNIvpFsr
         Vbk0n1E5tlAxat1KXCwWs4Qi+7oXPEoZoFE+bIoHwrk/s/CB+3yscPS1pQS2kN7bzAh3
         wrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrWKJ00avjOFxOx2Jk3/29KD0ikKkDwS6VhnJqhxvcA=;
        b=NAyd4lUKd0l4ldw/D5Yl9U4NIv9LgafAwQx2a7Py1GuyZ4k0pvoJkAscACdi35Iuoz
         yhBz80IljCE3OjpE1rwovpBI13duLyhqWAs+v441oqF3Ae2tm2oW/ObBWJBB6CpbNz9n
         j4cyYXjePKtVXRQYnUz7d6wn5O7MQQBSmH3XlT9kUgO60gUP5Uz2PbX4NIdo84Dljshr
         6HsIH3W07EpcDZVpQtV6aQeIQXuBDij3CQsqukWKNGc45FIoMpmaldfLlp9uoOKGT4zX
         TTS8havWh3YCXn9LWtSvMDo+HpxZGUl32XiY8d1r22GrkJGoP2+HjyjKobkngqWss1d4
         m5dQ==
X-Gm-Message-State: ABuFfoiXv+db/lknJWr4hiVtLUP8pb5dYv2isgFzkmgUFfaxXeNhTBhA
        S/4OSBxjLTtDcja3S5In5YpPjzhZ
X-Google-Smtp-Source: ACcGV600/fKvq0vVb6mk2ceM4pQMfkO9ZcyPooclUtqpeci2uGh4E9ft4JoxqmdSGrrdsivjG3FMcw==
X-Received: by 2002:adf:f4ce:: with SMTP id h14-v6mr10582533wrp.259.1538085641318;
        Thu, 27 Sep 2018 15:00:41 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:40 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 11/20] rebase -i: rewrite complete_action() in C
Date:   Thu, 27 Sep 2018 23:56:01 +0200
Message-Id: <20180927215610.32210-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites complete_action() from shell to C.

A new mode is added to rebase--helper (`--complete-action`), as well as
a new flag (`--autosquash`).

Finally, complete_action() is stripped from git-rebase--interactive.sh.

The original complete_action() would return the code 2 when the todo
list contained no actions.  This was a special case for rebase -i and
-p; git-rebase.sh would then apply the autostash, delete the state
directory, and die with the message "Nothing to do".  This cleanup is
rewritten in C instead of returning 2.  As rebase -i no longer returns
2, the comment describing this behaviour in git-rebase.sh is updated to
reflect this change.

The message "Nothing to do" is now printed with error(), and so becomes
"error: nothing to do".  Some tests in t3404 check this value, so they
are updated to fit this change.

The first check might seem useless as we write "noop" to the todo list
if it is empty.  Actually, the todo list might contain commented
commands (ie. empty commits).  In this case, complete_action() won’t
write "noop", and will abort without starting the editor.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
The changes are due to conflict resolution, no real changes otherwise.

 builtin/rebase--helper.c      |  12 +++-
 git-rebase--interactive.sh    |  53 ++---------------
 git-rebase.sh                 |   2 +-
 sequencer.c                   | 104 ++++++++++++++++++++++++++++++++++
 sequencer.h                   |   4 ++
 t/t3404-rebase-interactive.sh |   2 +-
 6 files changed, 124 insertions(+), 53 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index bed3dd2b95..01b3333958 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,13 +13,13 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
 		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO
+		CHECKOUT_ONTO, COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -29,6 +29,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits that begin with squash!/fixup!")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
@@ -57,6 +59,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "checkout-onto", &command,
 			    N_("checkout a commit"), CHECKOUT_ONTO),
+		OPT_CMDMODE(0, "complete-action", &command,
+			    N_("complete the action"), COMPLETE_ACTION),
 		OPT_END()
 	};
 
@@ -110,5 +114,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	if (command == CHECKOUT_ONTO && argc == 4)
 		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
+	if (command == COMPLETE_ACTION && argc == 6)
+		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
+					 argv[4], argv[5], autosquash);
+
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b68f108f28..59dc4888a6 100644
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
index 7973447645..51a6db7daa 100755
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
index f2cda5593d..0104c0ad01 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -31,6 +31,7 @@
 #include "commit-slab.h"
 #include "alias.h"
 #include "commit-reach.h"
+#include "rebase-interactive.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -54,6 +55,9 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+static GIT_PATH_FUNC(rebase_path_todo_backup,
+		     "rebase-merge/git-rebase-todo.backup")
+
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4672,6 +4676,106 @@ int skip_unnecessary_picks(struct object_id *output_oid)
 	return 0;
 }
 
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash)
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
+		return -1;
+
+	if (autosquash && rearrange_squash())
+		return -1;
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
+	if (count_commands(&todo_list) == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("nothing to do"));
+	}
+
+	strbuf_addch(buf, '\n');
+	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+				      "Rebase %s onto %s (%d commands)",
+				      count_commands(&todo_list)),
+			      shortrevisions, shortonto, count_commands(&todo_list));
+	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
+
+	if (write_message(buf->buf, buf->len, todo_file, 0)) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
+		return error(_("could not copy '%s' to '%s'."), todo_file,
+			     rebase_path_todo_backup());
+
+	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+		return error(_("could not transform the todo list"));
+
+	strbuf_reset(buf);
+
+	if (launch_sequence_editor(todo_file, buf, NULL)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return -1;
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
+		return -1;
+	}
+
+	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+		return error(_("could not transform the todo list"));
+
+	if (opts->allow_ff && skip_unnecessary_picks(&oid))
+		return error(_("could not skip unnecessary pick commands"));
+
+	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
+		return -1;
+;
+	if (require_clean_work_tree("rebase", "", 1, 1))
+		return -1;
+
+	return sequencer_continue(opts);
+}
+
 struct subject2item_entry {
 	struct hashmap_entry entry;
 	int i;
diff --git a/sequencer.h b/sequencer.h
index 6b0885db57..d51fe2c576 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -97,6 +97,10 @@ int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(struct object_id *output_oid);
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a7fc3cd5be..d60e59ecdb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -76,7 +76,7 @@ test_expect_success 'rebase --keep-empty' '
 '
 
 cat > expect <<EOF
-Nothing to do
+error: nothing to do
 EOF
 
 test_expect_success 'rebase -i with empty HEAD' '
-- 
2.19.0

