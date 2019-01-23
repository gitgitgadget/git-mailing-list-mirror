Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68451F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAWU7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfAWU7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so4140902wrp.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjxVxcscXnuEiMjkYfAJSWH+K427KDcc5uPRkdnpPok=;
        b=r5bwu94WyVSFXFNSOKi4C9CMBE0eq6xdAmPOB3/JJVI+yzGsqN6cTg5jF/2isAub8b
         +rIBmNAVVUWayaM/wcbLmd0fSk0AQJeCUuer/Q+n7lczyuWxmAinumDIrvicTs31dTq+
         DuFyV20TmDwhxyfBBbjUXws7NwGaEk1hBI/DxzIH4myuVzfW/s1X2v5XIQqZybVpNI57
         Pgy9obl1eTUii05zg0qvvKOd5/+jThHnueymPqcMt8xTIogAOo6y/7v+6cOC+hsB8V2s
         OBdAo66oB22bMvJRtf/2TyCIuC+PT0TSHuDhhriCrRTjjue6ulpvNNq2mJzCZCxatDlm
         nu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjxVxcscXnuEiMjkYfAJSWH+K427KDcc5uPRkdnpPok=;
        b=Iu+EElYdPtTOmqY4QERBO+zJue50LoaABTY73dvVcZuIC5c7NJLPZ+2JZjZ0Tmbtfr
         G8+y2VOG4oswB1yg7ylGhA82g60ayFbp1a2LhRdP5UMLlCm/F9SRw9aPv6D/iGExA4xq
         I8BFxm/KPtw9csakAqwJn40atQf3ua4bFnX0HxLGPH+bV1+0Dk9UM1dMZhUD8258tmsg
         6S+2shHHHXqSiBRkUjcx8Q++hhdATb6fXGgvLAefrogmAcRtwkF3Km0Uc7TGqoZUJDYX
         97PSNXA6YOFtxKizY7OXzft5mhylL/+DmZcurvcYabcUeOgxN9ip37hIJgHVKKzCcouy
         m4kQ==
X-Gm-Message-State: AJcUukefkhVwr+JOY5XN86DlMqiZU43Lrhteigvb17uZ5uO50dDPs8iE
        cNv94voeRAh/jAxMBuI4dIF2Zl6P
X-Google-Smtp-Source: ALg8bN44MQ4yUJJUP+L6EfToGXue9NQyWoKAjWE+YDe8UCojM7Zzw2omf3U9UL2qsLKVuSXeJve/oA==
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr4252213wrv.207.1548277173517;
        Wed, 23 Jan 2019 12:59:33 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:33 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 09/16] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Wed, 23 Jan 2019 21:58:14 +0100
Message-Id: <20190123205821.27459-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
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
Unchanged since v4.

 builtin/rebase--interactive.c | 13 ++++++-----
 sequencer.c                   | 41 +++++++++++++++--------------------
 sequencer.h                   |  5 ++---
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 4f0eae9239..92026739c9 100644
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
index 11456be5cc..f1c62c5960 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4160,7 +4160,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 }
 
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, FILE *out,
+				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4305,7 +4305,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 * gathering commits not yet shown, reversing the list on the fly,
 	 * then outputting that list (labeling revisions as needed).
 	 */
-	fprintf(out, "%s onto\n", cmd_label);
+	strbuf_addf(out, "%s onto\n", cmd_label);
 	for (iter = tips; iter; iter = iter->next) {
 		struct commit_list *list = NULL, *iter2;
 
@@ -4315,9 +4315,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			fprintf(out, "\n");
+			strbuf_addch(out, '\n');
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
@@ -4330,8 +4330,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s %s\n", cmd_reset,
-				rebase_cousins ? "onto" : "[new root]");
+			strbuf_addf(out, "%s %s\n", cmd_reset,
+				    rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
@@ -4344,12 +4344,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4358,11 +4358,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4384,13 +4384,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
@@ -4433,16 +4431,13 @@ int sequencer_make_script(struct repository *r, FILE *out,
 
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
index c7bb38d6df..9b8edd7df6 100644
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

