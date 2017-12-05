Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FF920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdLERxJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:09 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36090 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbdLERw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:56 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so3550527itj.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjZrCe235mW6ACkD+7qT8K3GfsiWwYJjGex22gFrvvc=;
        b=cWeTArA8Aepbe5UF6bmdSTPIMiVaajrippajH0nroHY7k8NRvl+TovlileuEBxugyH
         CY4bo52+9Za15lMNSNNNuD3kg6WaXtWyxnlHTplzLw2PsPf9d0hiAs4FO5qtRxoVjjSj
         PpdiTnRXw/L6UpGaohN6JIIX1tmVKLDnF4SFdTxW8tiEE29CES4xheDBkbEjYbmMjjIR
         AjRYSvPzyZjuHFzrnsFj4t/QW2qrXMXP4SBajnSibsaNYafGVsdIN3zE7J5ePrfo+ez/
         u+UmzPKae6y592lrgS8qSaK+q/ln4pxOf1i0E1Hj2mKk02yspHFcEKRDKOCWzznPYySv
         r0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OjZrCe235mW6ACkD+7qT8K3GfsiWwYJjGex22gFrvvc=;
        b=t6KlRn+hWsp82HaBBDJjk/EZr5SwctdeGE4GUDoF+o1i1mXEeGMSbFx6yyqRiHsHXq
         DRgLGfkHJJS+xAv1i6ygmaClglLmMJcLORQRsuUzkpsWID3S5Q01/hF5LtaCbBnKlcTw
         u8NLE+ue20t/oL8ihJQC2n0WcT7hGXyOe8cxsUzIqGU7IOPE0zUlIAdJ86TYjNnOCr3C
         Dj1293cUKiytBRJxGSAFcoHlHScCA6uTypiRq1t3br/jOR3I7bpVcryF/S+rrsqaRWeW
         aPx43d/Dr2Uk8kJnyAR4W60KDnhgHbTr4lmpD6zZ4zAJLOuphnE8JcKbExWBcPbujYHO
         3Y/g==
X-Gm-Message-State: AJaThX5NMrK5nnVJZ1B4zIBOSlYB6C+myviHQuuIrOUANjE7A8YuKwvD
        cMEEBMnV1OlIqLqO/jsAEUcKKgFfiTA=
X-Google-Smtp-Source: AGs4zMZ2D1qPGknh12OEELeYSZZiH1FzWstt5bSkWRrRmcKMBzgu/2T1O0g9z+k7bFxy6avnTrJOAQ==
X-Received: by 10.107.198.84 with SMTP id w81mr30942884iof.151.1512496375916;
        Tue, 05 Dec 2017 09:52:55 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:55 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 7/9] rebase -i -x: add exec commands via the rebase--helper
Date:   Tue,  5 Dec 2017 12:52:33 -0500
Message-Id: <20171205175235.32319-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent work on `git-rebase--interactive` aims to convert shell code to
C. Even if this is most likely not a big performance enhancement, let's
convert it too since a coming change to abbreviate command names
requires it to be updated.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 23 +---------------------
 sequencer.c                | 39 ++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 1102ecb43b67..4229ea0dc122 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -15,7 +15,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0, keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
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
+		OPT_CMDMODE(0, "add-exec-commands", &command,
+			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_END()
 	};
 
@@ -65,5 +68,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!skip_unnecessary_picks();
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
+	if (command == ADD_EXEC && argc == 2)
+		return !!sequencer_add_exec_commands(argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 437815669f00..e3f5a0abf3c7 100644
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
+test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
 todocount=${todocount##* }
diff --git a/sequencer.c b/sequencer.c
index 8b0dd610c881..892d242f6966 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2494,6 +2494,45 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	return 0;
 }
 
+/*
+ * Add commands after pick and (series of) squash/fixup commands
+ * in the todo list.
+ */
+int sequencer_add_exec_commands(const char *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct todo_item *item;
+	struct strbuf *buf = &todo_list.buf;
+	size_t offset = 0, commands_len = strlen(commands);
+	int i, first;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error(_("could not read '%s'."), todo_file);
+
+	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	first = 1;
+	/* insert <commands> before every pick except the first one */
+	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
+		if (item->command == TODO_PICK && !first) {
+			strbuf_insert(buf, item->offset_in_buf + offset,
+				      commands, commands_len);
+			offset += commands_len;
+		}
+		first = 0;
+	}
+
+	/* append final <commands> */
+	strbuf_add(buf, commands, commands_len);
+
+	i = write_message(buf->buf, buf->len, todo_file, 0);
+	todo_list_release(&todo_list);
+	return i;
+}
 
 int transform_todos(unsigned flags)
 {
diff --git a/sequencer.h b/sequencer.h
index 68284e9762c8..212426c44548 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,6 +50,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
+int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
-- 
2.15.1.280.g10402c1f5b5c

