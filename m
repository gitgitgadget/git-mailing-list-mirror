Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB52A20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdK0Ezl (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:41 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36030 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdK0Ezj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:39 -0500
Received: by mail-io0-f193.google.com with SMTP id 79so27360639ioi.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t8rHhlLiMRJN0O6SQZXQh3BvnQXSCLbvRG9SasP9SwI=;
        b=HRl5HhdDTxbiUHq02ikd2TWHFOFO5sSK35+kOaFV8cxPhAgVzLJlz0Vh5EWAkLeQle
         8WwFg13ZYxfWduczAaxFo+g8pIlfLlW19SCY4PwmdvVg40fhuxGv7LHMxtqIAbt2nVPx
         kZFuZk++4HDqrrZ3AQ7j/kv3WbqXeT+DP/5fOeHYNoHN6unwafqrpXvItS4tZwGB+AVp
         EVvR1DYbeNoQOoDC/AHx9MIAPL1AtBevy2s+IX+ZVpXfhXBvC7B3rf9UaYKD1B87H6o0
         cCh1rEJics4fhNphFAGPscWYR1ejnbxNXN40K5bEjvk978/FtgzTEW6TeIGXUsm25Otp
         g3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t8rHhlLiMRJN0O6SQZXQh3BvnQXSCLbvRG9SasP9SwI=;
        b=diOWnjmUAZ1yQQ0/672Dh7CWHilC8oQ9sYlmQJI5zRBYfAe1fNarbtIHf+QxJGk3rM
         NjlJ1Cfn866IALuC/x8bpwqU6AZLZwfgthKeudDggwQl5gG3cYM8Bdu/jqAUvbQRJGZ5
         hZ0Y5jpXr/x17phsLgss1KmghM0QJeeEa2UcG4FmmjPlINazwOJNJL2H0t2NMLjnMq6n
         tXXVmXlFIXpOShdhykGziOYS83CpUJ9MJf2fmAnZyAzt4flzDjkXUmpQnmkwTaIHfHKj
         x7d1s4oLRhIK7mv4rBKoc1kGQOX62vWGE5qb/xPRDeDpNg/AeagttG6QQjICKF/Pnr2M
         097g==
X-Gm-Message-State: AJaThX7zPN88rKaACg+E5q/+ImY0MCESJgHNkZhXBCyN7f9BjtNGZINX
        885tkYyfwo36mN0FKZRGQ5UIp4Ap
X-Google-Smtp-Source: AGs4zMbeKNlVvurc9k1cSUOxVuq/NENz14+Fq8RizOgS9AlaatnXwJADnyjp4JVKXTRaQPmPdin/yA==
X-Received: by 10.107.16.86 with SMTP id y83mr44441784ioi.107.1511758538670;
        Sun, 26 Nov 2017 20:55:38 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:38 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
Date:   Sun, 26 Nov 2017 23:55:12 -0500
Message-Id: <20171127045514.25647-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent work on `git-rebase--interactive` aim to convert shell code to C.
Even if this is most likely not a big performance enhacement, let's
convert it too since a comming change to abbreviate command names requires
it to be updated.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 23 +----------------------
 sequencer.c                | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f8519363a393..9d94c874c5bb 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -15,7 +15,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
+		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
+		ADD_EXEC
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -36,6 +37,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
 		OPT_CMDMODE(0, "rearrange-squash", &command,
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
+		OPT_CMDMODE(0, "add-exec", &command,
+			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_END()
 	};
 
@@ -64,5 +67,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!skip_unnecessary_picks();
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
+	if (command == ADD_EXEC && argc == 2)
+		return !!add_exec_commands(argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 437815669f00..760334d3a8b3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -722,27 +722,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Add commands after a pick or after a squash/fixup series
-# in the todo list.
-add_exec_commands () {
-	{
-		first=t
-		while read -r insn rest
-		do
-			case $insn in
-			pick)
-				test -n "$first" ||
-				printf "%s" "$cmd"
-				;;
-			esac
-			printf "%s %s\n" "$insn" "$rest"
-			first=
-		done
-		printf "%s" "$cmd"
-	} <"$1" >"$1.new" &&
-	mv "$1.new" "$1"
-}
-
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
@@ -982,7 +961,7 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-test -n "$cmd" && add_exec_commands "$todo"
+test -n "$cmd" && git rebase--helper --add-exec "$cmd"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
 todocount=${todocount##* }
diff --git a/sequencer.c b/sequencer.c
index fa94ed652d2c..810b7850748e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
 	return 0;
 }
 
+int add_exec_commands(const char *command)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int fd, res, i, first = 1;
+	FILE *out;
+
+	strbuf_reset(&todo_list.buf);
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("could not read '%s'."), todo_file);
+	}
+	close(fd);
+
+	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	if (res) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	out = fopen(todo_file, "w");
+	if (!out) {
+		todo_list_release(&todo_list);
+		return error(_("unable to open '%s' for writing"), todo_file);
+	}
+	for (i = 0; i < todo_list.nr; i++) {
+		struct todo_item *item = todo_list.items + i;
+		int bol = item->offset_in_buf;
+		const char *p = todo_list.buf.buf + bol;
+		int eol = i + 1 < todo_list.nr ?
+			todo_list.items[i + 1].offset_in_buf :
+			todo_list.buf.len;
+
+		if (item->command == TODO_PICK && !first)
+			fputs(command, out);
+		fwrite(p, eol - bol, 1, out);
+		first = 0;
+	}
+	fputs(command, out);
+	fclose(out);
+	todo_list_release(&todo_list);
+	return 0;
+}
 
 int transform_todo_ids(int shorten_ids)
 {
diff --git a/sequencer.h b/sequencer.h
index 6f3d3df82c0a..a2715e6c7589 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
+int add_exec_commands(const char *command);
 int transform_todo_ids(int shorten_ids);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
-- 
2.15.0.321.g19bf2bb99cee.dirty

