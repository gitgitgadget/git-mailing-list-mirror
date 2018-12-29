Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303021F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeL2QFS (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45369 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeL2QFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so19653237edb.12
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEr7bNTT0j/MAoIX/O9FAGI7DQZ/e0MtUie1I49P4MA=;
        b=W2tTU8iDVqvI99gSi4CfH3fwcw4UMQnz9fmC8EDuyfqv9bpUoqozMYg16WEDL+DF4G
         BxsS5/kfwNIWd8VaIVPeaZgykOGj1wigcMhWbOpHrHoWy3Fmv1RdW+0suT46R9ZfT8HT
         /TvsmzW+zbZ/vpW5CdFA5wZhhgg1y7n8kld0+0TZ3aUO0QVtysYNJ1D+scB2Us+1opGo
         lItyj6PeXsmMC14gZuL/bLV2526IyFIBhfQSnEJ+OIRVoFtVf4pAcmgEzTaeXFs4uzHy
         DIPyupckHmt4PpetxzxnY40FofavCng037Iq05MJ4bqhqbQc3rniYMwS7KCDthQjrr4G
         5Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEr7bNTT0j/MAoIX/O9FAGI7DQZ/e0MtUie1I49P4MA=;
        b=oa2t6lOmjS6DH+mRN2tjKm86BpI8ZW+F63indF0j3G0AYB8gwQekTAsMo0cFEYxzaq
         bKsUGQS7RHiJJhuQUh/9tGIgUWuIvP+Zw4UVO9SwC5LR94hKl4Gs8M+z3LueQikJdBF9
         9JHwb1+Iea6Cq7YR+s3ml9fXkqSkJLdX/EtO+VMeTTyYKC8nhTyNJTTHJaWR+51XYJ6r
         bZsAwgFy90asE/C4odvQCJbL1PkJJYuOe3LDSeDIdmv2yzLDKuPKz7uvNQJIprQYM2mK
         c025efWPnknEw6lex8IA7aCT1zpZTHosBiR4EpmY0sTw6RRdbVVPNmhRnaBAMBDn4LGf
         4SoA==
X-Gm-Message-State: AA+aEWZqiPLVQyFlDjOyo5U5S05hnlzlyYBR5qDmC9bULdcIjJGQ3gEN
        CL3P0HT5RYOw+HnnUDM+DvyDzxCr
X-Google-Smtp-Source: AFSGD/USMGbN0EXmm566YdSlREh6U2dpaXnco5ac0EQQ7O8dntflGcw3tREqf+CBOH2VIosfUKhsEw==
X-Received: by 2002:a50:9665:: with SMTP id y92mr25386314eda.282.1546099513179;
        Sat, 29 Dec 2018 08:05:13 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:12 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 09/16] sequencer: make sequencer_make_script() write its script to a strbuf
Date:   Sat, 29 Dec 2018 17:04:06 +0100
Message-Id: <20181229160413.19333-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
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
Changes due to conflicts with nd/the-index.

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
index 931ad9848e..f6527fb418 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4154,7 +4154,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 }
 
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, FILE *out,
+				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
@@ -4299,7 +4299,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 * gathering commits not yet shown, reversing the list on the fly,
 	 * then outputting that list (labeling revisions as needed).
 	 */
-	fprintf(out, "%s onto\n", cmd_label);
+	strbuf_addf(out, "%s onto\n", cmd_label);
 	for (iter = tips; iter; iter = iter->next) {
 		struct commit_list *list = NULL, *iter2;
 
@@ -4309,9 +4309,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			fprintf(out, "\n");
+			strbuf_addch(out, '\n');
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
@@ -4324,8 +4324,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s %s\n", cmd_reset,
-				rebase_cousins ? "onto" : "[new root]");
+			strbuf_addf(out, "%s %s\n", cmd_reset,
+				    rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
@@ -4338,12 +4338,12 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4352,11 +4352,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
 
@@ -4378,13 +4378,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
@@ -4427,16 +4425,13 @@ int sequencer_make_script(struct repository *r, FILE *out,
 
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
index e680fe2daa..d75049c15f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -140,9 +140,8 @@ int sequencer_remove_state(struct replay_opts *opts);
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

