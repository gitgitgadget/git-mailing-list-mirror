Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937D71F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBJN13 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51093 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBJN1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id z5so12198839wmf.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfzLf/bBYUiUtgxa7x3u7/Y9hQyZpK5GQX3yufor5MA=;
        b=lVbZ87ikC6i2y2q17+80oYBq/yS86fPIhGFGIrn47zS3SiImfHGl01YPT+PzemQTjz
         pfiGBLZUDM1ML0RenS9OD7wEhEPnHQ3H6CD/fSc6wpIxCiTxr118rrbmBDm5JnNaM18+
         zD6qVrDZ2gmkPpzIPQt746+WwNX1dxmeOnoECgcFPGQEGjGbFQ8Cer/QLNUDvLRFmckp
         tipD/Ni5Jan2UgQk2LATDve7GETHBg3ZdNmZkX9bIs6Jhzq0LRN7qXJ8O6p7m6cadbQx
         GkqEYfZ//70Ugy2ZwtttQPHXse6JCGcJdbMcHQLR9mAyd4lpmQUcvtKj8F+5j/YGsGj8
         FBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfzLf/bBYUiUtgxa7x3u7/Y9hQyZpK5GQX3yufor5MA=;
        b=TPN0WG0Jc+PQ0bzWO0AHVGTgPKeZ/OrGJXduY+7XQ08AFVsauf9zBr3ecIbCf2XhaF
         6fh0xp2d2Bwjb3DJO4GCJTtK3B+tnapxKX1JJnHZwYiLFnqatiuNWT9pyLjA2qZrcjvv
         IDANMZiFDGQb5ZxmtYB0mRkRIEEZLFrhXqSWjFrPNdbAvX/ajxNaMcMVS9LzAvpwmVaF
         pZYARTwPtC0tQVhr0KNy47uAmnWwEk2dxJ0M64Xzr7vVTO+uX/zlTGUj0/OxLdHOS7uv
         Oim5RvEwvN0KpdT1iLLXv3gVIXsO144Mgrnrqj0BCsvYCNlph4xWtl5/pXJzUkio2Dz1
         x7Wg==
X-Gm-Message-State: AHQUAuYOtnL/CKyz6IQDQkRfFYG3G+b9nurYqgdkA4g7s1guhukzxRyN
        O2trsFz/XR2ydqSz8IBYAhU3CQZ+
X-Google-Smtp-Source: AHgI3IZc4+oDwMVCC0/b80RJLh5FEE/B22Irmmlmxmt8Lw+6cR+CYJ4e2UZvvpyV2cW/yyJPZrbIcg==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr15731224wrx.296.1549805237097;
        Sun, 10 Feb 2019 05:27:17 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:16 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 09/16] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Sun, 10 Feb 2019 14:26:41 +0100
Message-Id: <20190210132648.12821-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
No changes since v6.

 builtin/rebase--interactive.c | 13 ++++++-----
 sequencer.c                   | 41 +++++++++++++++--------------------
 sequencer.h                   |  5 ++---
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 74ebe7a10e..506154b5e2 100644
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
 
-	ret = sequencer_make_script(the_repository, todo_list,
+	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fclose(todo_list);
+	fputs(todo_list.buf.buf, todo_list_file);
+	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
@@ -121,6 +123,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 
 	free(revisions);
 	free(shortrevisions);
+	todo_list_release(&todo_list);
 	argv_array_clear(&make_script_args);
 
 	return ret;
diff --git a/sequencer.c b/sequencer.c
index ffa4c4da1a..dbef2547f7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4215,7 +4215,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 }
 
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, FILE *out,
+				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4360,7 +4360,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 * gathering commits not yet shown, reversing the list on the fly,
 	 * then outputting that list (labeling revisions as needed).
 	 */
-	fprintf(out, "%s onto\n", cmd_label);
+	strbuf_addf(out, "%s onto\n", cmd_label);
 	for (iter = tips; iter; iter = iter->next) {
 		struct commit_list *list = NULL, *iter2;
 
@@ -4370,9 +4370,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			fprintf(out, "\n");
+			strbuf_addch(out, '\n');
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
@@ -4385,8 +4385,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s %s\n", cmd_reset,
-				rebase_cousins ? "onto" : "[new root]");
+			strbuf_addf(out, "%s %s\n", cmd_reset,
+				    rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
@@ -4399,12 +4399,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4413,11 +4413,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4439,13 +4439,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	return 0;
 }
 
-int sequencer_make_script(struct repository *r, FILE *out,
-			  int argc, const char **argv,
-			  unsigned flags)
+int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
+			  const char **argv, unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
-	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4488,16 +4486,13 @@ int sequencer_make_script(struct repository *r, FILE *out,
 
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
index add50f04f1..e25f5151d3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -142,9 +142,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)
 
-int sequencer_make_script(struct repository *r, FILE *out, int argc,
-			  const char **argv,
-			  unsigned flags);
+int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
+			  const char **argv, unsigned flags);
 
 int sequencer_add_exec_commands(struct repository *r,
 				struct string_list *commands);
-- 
2.20.1

