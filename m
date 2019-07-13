Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7DC1F461
	for <e@80x24.org>; Sat, 13 Jul 2019 05:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfGMFSg (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 01:18:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33031 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfGMFSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 01:18:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so8106562vsj.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 22:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJRlPxM8TOWR8hZB0KRDNq6OpXs/Oam72hypbhKQzFI=;
        b=fInNwVwOdMwbcKSMUYMa8BvS7iN+eN8WPDr7SGIExgV4OIA53H6JjZImom7dGbT0TC
         YbS1m4e5J+1r3XJP3Pp2eC+ZiFrDPFtp/FvIBgmVbR9SV1pdRNq55LvWS9oSYSYqS1zn
         nYizWBgVWxhrW1g8ebEV7aC2ucxpZXUpl1scHIJOJvgKfrd7evo/PBGH/veIUp7D4wFA
         LLKKQvuUtunA6dYf1sg4j+9b6NqYKm2KKMm2r8fhQwBEx2Z/K/9ZdTyEk8DzTo5r6o2v
         rI1m9rZF0Cze2M8OeR3/UoOBv7nkaUlywtLEIzfOZquwc8j3kv7gDu93Sreu/YsygHQY
         Jn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJRlPxM8TOWR8hZB0KRDNq6OpXs/Oam72hypbhKQzFI=;
        b=Oce48P/EbWJa0n1RTjoPoK2NVWtPKxddNmoz8kflbx8IKjjMefH+/yWQJz8DurAvAq
         Q/R7g5SxlPbGHQnlIsTizP846zoLMupQgaTA8Fgif9kjr3AxFJlMSvZeIkNAfnvn3ggw
         4Gt7nysMw3h9cOCJ45vh/CnvjUtbHiDuhA+tOvMncxxThTMc/PYj7wBFqtvgZ24Exv3I
         Aim10PMmx+rc10C3CmtRUpYO0Q4DklRWLL/3kYpxgNTOM0OhzQ1HeemBtDDg+X2bh5dy
         PC7AnT7/pr6o9UBesNK9U+rZM4g2tSVEIiDF1MjzJBsxZTXUeiwdNOTjE+6t6zq5sJlR
         4FEA==
X-Gm-Message-State: APjAAAWZQ1EilNA0dDcES54Q7it7YBZ+muaq4CD8uO+vZN1RGS/vtOq4
        9D4dxzMgAO5u2nD7bP9W/YPMmWTFAsY=
X-Google-Smtp-Source: APXvYqwo8XKbmmVeWON/32NLIrg6y8n5GsVyCVshVHA143DrQHXlpGqLCAW2935fVpBcJYFlI2nzsw==
X-Received: by 2002:a67:7987:: with SMTP id u129mr11022489vsc.192.1562995114916;
        Fri, 12 Jul 2019 22:18:34 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id j13sm4073555vkc.26.2019.07.12.22.18.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 22:18:34 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] builtin/merge: allow --squash to commit if there are no conflicts
Date:   Fri, 12 Jul 2019 23:18:04 -0600
Message-Id: <20190713051804.12893-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using --squash made git stop regardless of conflicts so that the
user could finish the operation with a later call to git-commit.

Now --squash allows for the operation to finish with the new revision
if there are no conflicts (can still be controlled with --no-commit).

Option -m can be used to defined the message for the revision instead
of the default message that contains all squashed revisions info.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/merge.c | 109 +++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index aad5a9504c..66fd57de02 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -64,6 +64,7 @@ static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
+static struct strbuf squash_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -390,39 +391,38 @@ static void finish_up_to_date(const char *msg)
 static void squash_message(struct commit *commit, struct commit_list *remoteheads)
 {
 	struct rev_info rev;
-	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
 	struct pretty_print_context ctx = {0};
 
-	printf(_("Squash commit -- not updating HEAD\n"));
-
-	repo_init_revisions(the_repository, &rev, NULL);
-	rev.ignore_merges = 1;
-	rev.commit_format = CMIT_FMT_MEDIUM;
-
-	commit->object.flags |= UNINTERESTING;
-	add_pending_object(&rev, &commit->object, NULL);
-
-	for (j = remoteheads; j; j = j->next)
-		add_pending_object(&rev, &j->item->object, NULL);
-
-	setup_revisions(0, NULL, &rev, NULL);
-	if (prepare_revision_walk(&rev))
-		die(_("revision walk setup failed"));
-
-	ctx.abbrev = rev.abbrev;
-	ctx.date_mode = rev.date_mode;
-	ctx.fmt = rev.commit_format;
-
-	strbuf_addstr(&out, "Squashed commit of the following:\n");
-	while ((commit = get_revision(&rev)) != NULL) {
-		strbuf_addch(&out, '\n');
-		strbuf_addf(&out, "commit %s\n",
-			oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&ctx, commit, &out);
+	if (merge_msg.len)
+		squash_msg = merge_msg;
+	else {
+		repo_init_revisions(the_repository, &rev, NULL);
+		rev.ignore_merges = 1;
+		rev.commit_format = CMIT_FMT_MEDIUM;
+
+		commit->object.flags |= UNINTERESTING;
+		add_pending_object(&rev, &commit->object, NULL);
+
+		for (j = remoteheads; j; j = j->next)
+			add_pending_object(&rev, &j->item->object, NULL);
+
+		setup_revisions(0, NULL, &rev, NULL);
+		if (prepare_revision_walk(&rev))
+			die(_("revision walk setup failed"));
+
+		ctx.abbrev = rev.abbrev;
+		ctx.date_mode = rev.date_mode;
+		ctx.fmt = rev.commit_format;
+
+		strbuf_addstr(&squash_msg, "Squashed commit of the following:\n");
+		while ((commit = get_revision(&rev)) != NULL) {
+			strbuf_addch(&squash_msg, '\n');
+			strbuf_addf(&squash_msg, "commit %s\n",
+				oid_to_hex(&commit->object.oid));
+			pretty_print_commit(&ctx, commit, &squash_msg);
+		}
 	}
-	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
-	strbuf_release(&out);
 }
 
 static void finish(struct commit *head_commit,
@@ -440,8 +440,11 @@ static void finish(struct commit *head_commit,
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
-	if (squash) {
+	if (squash && !squash_msg.len) {
 		squash_message(head_commit, remoteheads);
+		write_file_buf(git_path_squash_msg(the_repository), squash_msg.buf, squash_msg.len);
+		if (option_commit > 0)
+			printf(_("Squash conflicts -- not updating HEAD\n"));
 	} else {
 		if (verbosity >= 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
@@ -893,14 +896,23 @@ static int finish_automerge(struct commit *head,
 	struct object_id result_commit;
 
 	free_commit_list(common);
-	parents = remoteheads;
-	if (!head_subsumed || fast_forward == FF_NO)
-		commit_list_insert(head, &parents);
-	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			&result_commit, NULL, sign_commit))
-		die(_("failed to write commit object"));
-	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
+	if (squash) {
+		squash_message(head, remoteheads);
+		parents = commit_list_insert(head, &parents);
+		if (commit_tree(squash_msg.buf, squash_msg.len, result_tree, parents,
+				&result_commit, NULL, sign_commit))
+			die(_("failed to write commit object on squash"));
+	} else {
+		parents = remoteheads;
+		if (!head_subsumed || fast_forward == FF_NO)
+			commit_list_insert(head, &parents);
+		prepare_to_commit(remoteheads);
+		if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
+				&result_commit, NULL, sign_commit))
+			die(_("failed to write commit object"));
+	}
+	strbuf_addf(&buf, "Merge made by the '%s' strategy", wt_strategy);
+	strbuf_addstr(&buf, squash ? " (squashed)." : ".");
 	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
 	remove_merge_branch_state(the_repository);
@@ -1342,18 +1354,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verbosity < 0)
 		show_diffstat = 0;
 
-	if (squash) {
-		if (fast_forward == FF_NO)
-			die(_("You cannot combine --squash with --no-ff."));
-		if (option_commit > 0)
-			die(_("You cannot combine --squash with --commit."));
-		/*
-		 * squash can now silently disable option_commit - this is not
-		 * a problem as it is only overriding the default, not a user
-		 * supplied option.
-		 */
-		option_commit = 0;
-	}
+	if (squash && fast_forward == FF_NO)
+		die(_("You cannot combine --squash with --no-ff."));
 
 	if (option_commit < 0)
 		option_commit = 1;
@@ -1682,8 +1684,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		write_merge_state(remoteheads);
 
 	if (merge_was_ok)
-		fprintf(stderr, _("Automatic merge went well; "
-			"stopped before committing as requested\n"));
+		if (!option_commit)
+			fprintf(stderr, _("Automatic merge went well; "
+				"stopped before committing as requested\n"));
+		else
+			;
 	else
 		ret = suggest_conflicts();
 
-- 
2.20.1

