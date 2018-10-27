Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A62B1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJ1GMY (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37312 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GMX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so4414445wmc.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1OTV2eGl8iMDhc3lIUYPtqoNqiqHM1e5HY1RQE/RIo=;
        b=UdX1fPdemtPhry4gynmjZc388I3Jh7tzRJRDipfGXCM3PiHnexLGA6Oqf6r5WguJf8
         WsH82ysvFdL+V2LTEnD2Y26jsPIaU/ZinQIORIdt/J3TNlPMe5lm08KM4Wi9/M1V5YOw
         or1JATvqBvR3RTcPU3G3FEwGx0cw3DPA87sXyD2qIY1sAEwZSOVAnw/iVGjTDC7nN6Du
         yYrbBfNL+PuXXAlNBDl/jyoinWuidcwAdgxRcuRtWn41VPWV3TXkzS82wBbevnlm21bG
         AULcGkuJ5U7edqM3rLZ3tPIhuYwGmK4YGAxB+bsGQOTe8dBgiHZWAeIIOspTGN20bnso
         h1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1OTV2eGl8iMDhc3lIUYPtqoNqiqHM1e5HY1RQE/RIo=;
        b=YUDFuQoW8o6zNCdHhEGMlo6T99+qm0IqFm7GDLjUglpS7kcp/W+ZF5mjoowE8BW3TL
         4cNViP30ubHop1I3tsREs7GDRhB5YvNtJAofrhS9AU7fb4FPQVeQiljWzteyg+vUvcpx
         b7Qr7PGZHWsqxGdZYlB30EN0loHTx0rXo9W2awqmcnYXz1MRwxQfGEdOdhGad+sTJiP7
         rjYG9CeHWWQc9cOI64gPicQWX1GRecwsBrn2mafWAEnPW8dxkBbVMCnYcEZZiPX6Yfsx
         SNwigma88SJkJKxZlgfsolk/Rzt5t3A1YTUFiDhGw2tWdqZKt6FVK96WSAVhrLNHKdZi
         N3iQ==
X-Gm-Message-State: AGRZ1gIvRwNAdGcGCtLlZjoCuDTMRXR950JwT7rYTEXe3IzkDnd0RM/u
        37PHjdIeB9klmkupw1JBVBZpuX6M
X-Google-Smtp-Source: AJdET5d3jQDHGosfV7ldyfPdXAw0Nxu7cN6FOMfjp5JDL2dQs1+JXpbED0isklOmKZzegOpVtGHi0g==
X-Received: by 2002:a1c:d105:: with SMTP id i5-v6mr8930800wmg.69.1540675802491;
        Sat, 27 Oct 2018 14:30:02 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:01 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 08/16] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Sat, 27 Oct 2018 23:29:22 +0200
Message-Id: <20181027212930.9303-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sequencer_make_script() write its script to a strbuf (ie. the
buffer of a todo_list) instead of a FILE.  This reduce the amount of
read/write made by rebase interactive.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 13 +++++++-----
 sequencer.c                   | 38 ++++++++++++++++-------------------
 sequencer.h                   |  2 +-
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index f827e53f05..eef1ff2e83 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -71,7 +71,8 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
-	FILE *todo_list;
+	FILE *todo_list_file;
+	struct todo_list todo_list = TODO_LIST_INIT;
 
 	if (prepare_branch_to_be_rebased(opts, switch_to))
 		return -1;
@@ -93,8 +94,8 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	if (!upstream && squash_onto)
 		write_file(path_squash_onto(), "%s\n", squash_onto);
 
-	todo_list = fopen(rebase_path_todo(), "w");
-	if (!todo_list) {
+	todo_list_file = fopen(rebase_path_todo(), "w");
+	if (!todo_list_file) {
 		free(revisions);
 		free(shortrevisions);
 
@@ -105,10 +106,11 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	if (restrict_revision)
 		argv_array_push(&make_script_args, restrict_revision);
 
-	ret = sequencer_make_script(todo_list,
+	ret = sequencer_make_script(&todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fclose(todo_list);
+	fputs(todo_list.buf.buf, todo_list_file);
+	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
@@ -120,6 +122,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 
 	free(revisions);
 	free(shortrevisions);
+	todo_list_release(&todo_list);
 	argv_array_clear(&make_script_args);
 
 	return ret;
diff --git a/sequencer.c b/sequencer.c
index 09e32f3e5a..94167588a2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3927,7 +3927,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 }
 
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, FILE *out,
+				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4076,7 +4076,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 * gathering commits not yet shown, reversing the list on the fly,
 	 * then outputting that list (labeling revisions as needed).
 	 */
-	fprintf(out, "%s onto\n", cmd_label);
+	strbuf_addf(out, "%s onto\n", cmd_label);
 	for (iter = tips; iter; iter = iter->next) {
 		struct commit_list *list = NULL, *iter2;
 
@@ -4086,9 +4086,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n# Branch %s\n", entry->string);
+			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			fprintf(out, "\n");
+			strbuf_addch(out, '\n');
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
@@ -4101,8 +4101,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s %s\n", cmd_reset,
-				rebase_cousins ? "onto" : "[new root]");
+			strbuf_addf(out, "%s %s\n", cmd_reset,
+				    rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
@@ -4115,12 +4115,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 					       &state);
 
 			if (!to || !strcmp(to, "onto"))
-				fprintf(out, "%s onto\n", cmd_reset);
+				strbuf_addf(out, "%s onto\n", cmd_reset);
 			else {
 				strbuf_reset(&oneline);
 				pretty_print_commit(pp, commit, &oneline);
-				fprintf(out, "%s %s # %s\n",
-					cmd_reset, to, oneline.buf);
+				strbuf_addf(out, "%s %s # %s\n",
+					    cmd_reset, to, oneline.buf);
 			}
 		}
 
@@ -4129,11 +4129,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			entry = oidmap_get(&commit2todo, oid);
 			/* only show if not already upstream */
 			if (entry)
-				fprintf(out, "%s\n", entry->string);
+				strbuf_addf(out, "%s\n", entry->string);
 			entry = oidmap_get(&state.commit2label, oid);
 			if (entry)
-				fprintf(out, "%s %s\n",
-					cmd_label, entry->string);
+				strbuf_addf(out, "%s %s\n",
+					    cmd_label, entry->string);
 			oidset_insert(&shown, oid);
 		}
 
@@ -4155,12 +4155,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	return 0;
 }
 
-int sequencer_make_script(FILE *out, int argc, const char **argv,
+int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
-	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4203,16 +4202,13 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 		if (!is_empty && (commit->object.flags & PATCHSAME))
 			continue;
-		strbuf_reset(&buf);
 		if (!keep_empty && is_empty)
-			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "%s %s ", insn,
+			strbuf_addf(out, "%c ", comment_line_char);
+		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&pp, commit, &buf);
-		strbuf_addch(&buf, '\n');
-		fputs(buf.buf, out);
+		pretty_print_commit(&pp, commit, out);
+		strbuf_addch(out, '\n');
 	}
-	strbuf_release(&buf);
 	return 0;
 }
 
diff --git a/sequencer.h b/sequencer.h
index 0c8074cab0..5af96723e6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -129,7 +129,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  * commits should be rebased onto the new base, this flag needs to be passed.
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
-int sequencer_make_script(FILE *out, int argc, const char **argv,
+int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-- 
2.19.1

