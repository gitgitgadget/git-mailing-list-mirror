Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4D420248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCETSo (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCETSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so10733466wre.10
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvhdmrDIMmyQ5jRBsEjGVxsaIevKKpMf17dW0+SD+pw=;
        b=m0YDatNQJzl2XtapGb45jhwQPSEH5Sm2YigV/DyXv5/6bIpYqClmnJVCoiZIQqwaWY
         FRVzwGBJJZdSUmlX2v/RjecGJPhs2hLYAk6NsM3Szg8FZUEEC5n+YoV4bZ05rp0HlpS4
         cbC21loHxDDeVHblN+RkEOhvJp8rmCRHAtZTr6El2HBbc/S4Sa+cmVAgxlSmxhnHIy00
         whOOOeBVJ0ttkS6MM/LcqoDFPOCoFKmi+HmG4J0q9x5sRPxEpyqpwBDNF36hgYl6Gn8/
         sOppquGcfJ5vyHtq2/Fj/fLqLJm0ZXkZDG0X7AQejrVa9QBpIZ8S8LkDhHh5soGXnJ4D
         v76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvhdmrDIMmyQ5jRBsEjGVxsaIevKKpMf17dW0+SD+pw=;
        b=JDeRVVSLeY/EM5xWmDgu8z8y4GPVj2LIL8G9R0/s/L/31YMGtcI3wH+0Bc1/sHUWhr
         i/KRVFZjcpUGog91ZATBzfmh0yBBhdQxrhMnZ/wdp5AzVYk2zUF41PGwIGjm1L4GqRRP
         /xFwWWJ1TabNmThtvQUaXdPiRDGSFsKWOsmmUPdU97WKbT7XdHQDNDjLgaef84ZvXVFc
         5pq1p6nvbokxP7j9caOZc6Z0ChcpLqYspUYsknHbzaAwwrwGQiCR7Y+jD403wUO4PyGE
         b315AN8I5KTS/Un9KxN5L3G9GaPGQae1ak96Uwuq4Pb0FHO81Dpd0OYd6LQaEFYG2Nfp
         9aOQ==
X-Gm-Message-State: APjAAAWsLCfMnM7UeUp8rQSpb18k8EWzE6xORIG/NhBfi1/af46doSHb
        Z0UF+N+uyVKyRhYGEmPYXQhPG3CX
X-Google-Smtp-Source: APXvYqydnRazYka7d3U2d/7ioHmGVU/XXlE23/8S1ZIOXV4gwuzhKh5kfAR5O8D8dc+HXNlhN6gcXg==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr325468wre.68.1551813520410;
        Tue, 05 Mar 2019 11:18:40 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 09/18] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Tue,  5 Mar 2019 20:17:56 +0100
Message-Id: <20190305191805.13561-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
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
No changes since v7.

 builtin/rebase--interactive.c | 13 ++++++-----
 sequencer.c                   | 41 +++++++++++++++--------------------
 sequencer.h                   |  5 ++---
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 60b15f9693..b4190e58e1 100644
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
index 7798f93b23..cf716fa5b8 100644
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

