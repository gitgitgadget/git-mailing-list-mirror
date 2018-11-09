Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6340E1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKIRsI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44410 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so857618wrq.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGA0Voc/LBpFxSlce1ASno+oE0vRB2vj5XiQGb1FR/0=;
        b=occzwVl0pI20SW1XIpS7bU5msrAuZu6/ltE1GGTVKjyFFh6Z1iDvBY+PQBf4rlneg7
         dPEp7o49AeuxsDvr5opfsxZ/NffWTsn0wpD7+GhmHw4OgMILjV+qD5hzUOnMoJf2fqFx
         ijVS2BhUsg3VQQzXSjOHb3r1dnsHFRR+2DdskyshRt0WS9al/YiAHRKAxZYywW+caQ+5
         Tk/lFSHOclnrg1Y655Ssgk+cnyYYU2kSJEIGZLcvTG9M77ejgz4MHPhsp9rbyCwZ0fqY
         7cooCjXoe4t0P7Hhihu4oJeFSeYjjoYuLbUhsoho1YQChX4PooBlkpc+QngCyM3O/3ua
         0fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGA0Voc/LBpFxSlce1ASno+oE0vRB2vj5XiQGb1FR/0=;
        b=Q+zWgF/6hua/HbdqffbtXftGmxtE35xAmrkuHDFtkrDKpXnrLHloUZ1MinLh6CC51+
         C9H3iKY9IaxSvStp458+GBsmxGh5Ry3KPtIO715+KvH3GB3ovj5HrFXHmSjK1j/TipnK
         03RSJZIWUyO7JceBQbSa8HR0liOk9H7d4Yq33Hsc4p/EMZuzRSC/TFy8iG7YfCHLeQ16
         yWWglIYPkeCPUODHWMTCD+/UXodY+J2hrmLzvPqomUN6vYh9ppNFc6dnphbQhuXf4NRq
         k0l/xeT5AYwz171rMWImkQN5jTlt34nxpRu6vyxSpErA2QvVNre+b/qtvxVfZ0H/XW4J
         4zRw==
X-Gm-Message-State: AGRZ1gL9XPbl+fhLOowxiGw/mMvuX6ROo4YrgmCTEYQtga3yk5/YTHnM
        cu7YnreXqW526vYkvKIO+40DkzLr
X-Google-Smtp-Source: AJdET5feMjaWmNUBLLj0hm77R03DQPlDdtzEzyCWTjiJSf6u29Ad3WgcLXUpzWTaiji72tv8Y2453A==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr1822272wrp.219.1541750920051;
        Fri, 09 Nov 2018 00:08:40 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 08/16] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Fri,  9 Nov 2018 09:07:57 +0100
Message-Id: <20181109080805.6350-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
index a6d83a684e..c740a7dd5d 100644
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
index fce97e5f11..3389a753b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4109,7 +4109,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 }
 
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, FILE *out,
+				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4254,7 +4254,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 * gathering commits not yet shown, reversing the list on the fly,
 	 * then outputting that list (labeling revisions as needed).
 	 */
-	fprintf(out, "%s onto\n", cmd_label);
+	strbuf_addf(out, "%s onto\n", cmd_label);
 	for (iter = tips; iter; iter = iter->next) {
 		struct commit_list *list = NULL, *iter2;
 
@@ -4264,9 +4264,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			fprintf(out, "\n");
+			strbuf_addch(out, '\n');
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
@@ -4279,8 +4279,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s %s\n", cmd_reset,
-				rebase_cousins ? "onto" : "[new root]");
+			strbuf_addf(out, "%s %s\n", cmd_reset,
+				    rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
@@ -4293,12 +4293,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4307,11 +4307,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4333,12 +4333,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
@@ -4381,16 +4380,13 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
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
index 1cd9d7f1e2..fcde6e739d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -137,7 +137,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)
 
-int sequencer_make_script(FILE *out, int argc, const char **argv,
+int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(struct string_list *commands);
-- 
2.19.1.872.ga867da739e

