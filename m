Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359101F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeHJTXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34326 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so1961158wme.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gc8UIJBuE2/XJdfEv2TVIkwWFgueJ/4d2+4xpvrYUPU=;
        b=MV3O64KOrScbCYlq04ty6W2WfUMtefQkximEU0tUS6nQp7Fef+uPp8BCzV0ZcC0YXi
         cZS1QvyKLR+5X7XcBZDEtbvZiQG6RqxxDNhQ6KTgKZwagE5aowEQ2bc1PCqCG8dxJ2Wa
         aLxhH/kZByT0Vsk3849/LLvwxVNV/lnIpnW8zWtrYj5M3D0gRb9WmKYAmwqp7zMHKzbk
         +kwVIWXczgGPY85LDAzLzGllDpwxK8ri1veG3er3f6vgs5EsAJ944FyFjfaI6Qw/IB9q
         Scks9UiOYY8zlxkepOl+a01JmEoRtP3xWCmlbo9s97bQE/D/dIMAAXv2hp+bW5kL/L7m
         t76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gc8UIJBuE2/XJdfEv2TVIkwWFgueJ/4d2+4xpvrYUPU=;
        b=V4gKbzTLtOxPDZaQ74b19f2rJlG6XtK7taLAGzSXVd8J306E7rqkFv1f+Ma5gbKbBJ
         Itta5QNiA41uCxPFCzV47yyjheN52HoI0/mdrxLRkkwHX0Z0pBmCFIBpNnzYMvRHDyQ/
         ILjD3FQz36UsuPcwT8WV6+8+QPke128r8LiLUJD9qEoIiN6QOmmFd2qIOj0gQUFaGIGu
         ClKx9kBoo0pAlp61ZTde1GWgxkYYE4ihA6r+aMR8xLicLFfzkVN82qCGZObh/NGPIeyl
         a8mydLfJ3JnOXHuoRvL3MUR0sCIKOLRQ75J4dN2qDo9sTlY13t8Bz3LSU/Xnpy29OsTb
         AuxQ==
X-Gm-Message-State: AOUpUlEYNR9SZ/+IA8Xtp+UveglKeJXKJVnmhI7uhD2Cq9N+dElPZOBu
        MYwfhUZdFPk9lhzhNau6IxBpRpsP
X-Google-Smtp-Source: AA+uWPw/7qHQlm/JSM6KYuYuBTnhkNN4z1MHqlL1Q1mSEnMJo10Ptatrlr8kMKzcgW+Ge+dlv8S/ZQ==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr2082929wmb.29.1533919940600;
        Fri, 10 Aug 2018 09:52:20 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:19 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 04/20] rebase -i: rewrite the edit-todo functionality in C
Date:   Fri, 10 Aug 2018 18:51:31 +0200
Message-Id: <20180810165147.4779-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the edit-todo functionality from shell to C.

To achieve that, a new command mode, `edit-todo`, is added, and the
`write-edit-todo` flag is removed, as the shell script does not need to
write the edit todo help message to the todo list anymore.

The shell version is then stripped in favour of a call to the helper.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 rebase-interactive.c       | 27 +++++++++++++++++++++++++++
 rebase-interactive.h       |  1 +
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 05e73e71d4..731a64971d 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,8 +28,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
-			 N_("append the edit-todo message to the todo-list")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +48,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_CMDMODE(0, "append-todo-help", &command,
 			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
+		OPT_CMDMODE(0, "edit-todo", &command,
+			    N_("edit the todo list during an interactive rebase"),
+			    EDIT_TODO),
 		OPT_END()
 	};
 
@@ -90,6 +91,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(write_edit_todo, keep_empty);
+		return !!append_todo_help(0, keep_empty);
+	if (command == EDIT_TODO && argc == 1)
+		return !!edit_todo_list(flags);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94c23a7af2..2defe607f4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -108,16 +108,7 @@ initiate_action () {
 		     --continue
 		;;
 	edit-todo)
-		git stripspace --strip-comments <"$todo" >"$todo".new
-		mv -f "$todo".new "$todo"
-		collapse_todo_ids
-		git rebase--helper --append-todo-help --write-edit-todo
-
-		git_sequence_editor "$todo" ||
-			die "$(gettext "Could not execute editor")"
-		expand_todo_ids
-
-		exit
+		exec git rebase--helper --edit-todo
 		;;
 	show-current-patch)
 		exec git show REBASE_HEAD --
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d7996bc8d9..3f9468fc69 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -66,3 +66,30 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 
 	return ret;
 }
+
+int edit_todo_list(unsigned flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *todo_file = rebase_path_todo();
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&buf, 1);
+	if (write_message(buf.buf, buf.len, todo_file, 0)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_release(&buf);
+
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	append_todo_help(1, 0);
+
+	if (launch_sequence_editor(todo_file, NULL, NULL))
+		return -1;
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	return 0;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 47372624e0..155219e742 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -2,5 +2,6 @@
 #define REBASE_INTERACTIVE_H
 
 int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.18.0

