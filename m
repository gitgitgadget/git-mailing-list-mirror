Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9440C1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 05:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGSFkJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 01:40:09 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:41474 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfGSFkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 01:40:09 -0400
Received: by mail-vs1-f53.google.com with SMTP id 2so20758392vso.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGCkm3DzsEWQDru3qiCxPmv6BvhWSVdenCWXa8CGXJA=;
        b=RctKN9xZEfk3Q5EpbCCOcGyLvCRtZTYKF+LNbZUpZe9kWLIBSgkcdD4cBIQTuGrJMR
         1SYMfv7hjiBgE+WuRC9M0FPLwS//tgle3A+C7Rx4yd3RPKzo+0VBIsjZjZjxvofJMDfh
         DN2Oe697LJru/o0T7gOECkTlJj0a/pHcarz9aWQeKhJSEFhBktpFJVnWXH5AIgFoWwNv
         gxEreFz1qDaYBG/LySakxFf89CL8V6olNfWjEic5H3q73DcC5GmY9NPdMCLc2ItPDmFB
         6JkSNuf908MTjFqFvB76v6ZdR5H640rwDJYJBxAn1laRAaofE1KtYzx88WeunbJ4qhXH
         APsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGCkm3DzsEWQDru3qiCxPmv6BvhWSVdenCWXa8CGXJA=;
        b=tVVyH7vGRbsEkDdAnevQOBAtyRyOnT6eaVEHdvKVvsUX9u+/udKCc0DIJBD80ie+2v
         /DWJbOzFEUoWfU5Nri5njyoAviXvkNP6fEu1xpxrIjEt2wi+qesVXT+HyJ1ZugVygc+1
         MLvqz+FTqSjelOkLPDrBUBv2K8yDfHO4gL8Wudw97lDjkBttctIRftU0/+3xAMvxT5kx
         cDTRHrfp6jNYfCqR0lV74EUhPsyfdHeAZg9puX5tiwRZ0nCfJ+D0dqlMW/LZHDy68x59
         sX+soR9YaKwXvh6KMepcayVdw3aH+CHU7Qq9mC9tlBb4B8aR3PIkyseyPwEZ73YBFhP6
         Cgxg==
X-Gm-Message-State: APjAAAWAYDAjrP6Kgy0EVMsec4s8MGcLeuhVdSLw5pxrULP+DNrItPrV
        9/ayq3d+y6u/78kjrdtTU04bSE40aFg=
X-Google-Smtp-Source: APXvYqzNAKJggBDicgENfpMOv11hnd6XMMjVXF450e4d+NvWLiNeHpLSzpWwXQJyaP8H2Hy4zugTeA==
X-Received: by 2002:a67:ee16:: with SMTP id f22mr31952763vsp.191.1563514807463;
        Thu, 18 Jul 2019 22:40:07 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id l184sm14275876vsl.8.2019.07.18.22.40.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 22:40:06 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v3] builtin/merge: support --squash --commit
Date:   Thu, 18 Jul 2019 23:39:52 -0600
Message-Id: <20190719053952.13516-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using --squash made git stop regardless of conflicts so that the
user could finish the operation with a later call to git-commit.

Now --squash --commit allows for the operation to finish with the
new revision if there are no conflicts. If the user does not use
--commit, then --no-commit is used as default so that it doesn't
break previous git behavior.

Function squash_message() now saves the value in merge_msg so that
the message with the squashed revisions is readily available when
calling finish_automerge() to create new revision object.

Function finish() used to skip execution paths if using --squash
because there would be no new revision object created. Also, it
now makes sure to skip reflog update if using --squash _without_
--commit.

Function finish_automerge() allows to create a new revision object
for an squashed merge (sets parent to current revision only,
merge_msg will be set to squashed revisions by calling
squash_message()), sets the reflog message to specify that it was
a merge-squash operation and removes the $GIT_DIR/SQUASH_MSG file
if needed.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/merge.c  | 93 +++++++++++++++++++++++++++++-------------------
 t/t7600-merge.sh | 86 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 136 insertions(+), 43 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index aad5a9504c..ad9c6e900a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -390,11 +390,13 @@ static void finish_up_to_date(const char *msg)
 static void squash_message(struct commit *commit, struct commit_list *remoteheads)
 {
 	struct rev_info rev;
-	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
 	struct pretty_print_context ctx = {0};
 
-	printf(_("Squash commit -- not updating HEAD\n"));
+	strbuf_release(&merge_msg);
+
+	if (!option_commit)
+		printf(_("Squash commit -- not updating HEAD\n"));
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.ignore_merges = 1;
@@ -414,15 +416,14 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	ctx.date_mode = rev.date_mode;
 	ctx.fmt = rev.commit_format;
 
-	strbuf_addstr(&out, "Squashed commit of the following:\n");
+	strbuf_addstr(&merge_msg, "Squashed commit of the following:\n");
 	while ((commit = get_revision(&rev)) != NULL) {
-		strbuf_addch(&out, '\n');
-		strbuf_addf(&out, "commit %s\n",
+		strbuf_addch(&merge_msg, '\n');
+		strbuf_addf(&merge_msg, "commit %s\n",
 			oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&ctx, commit, &out);
+		pretty_print_commit(&ctx, commit, &merge_msg);
 	}
-	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
-	strbuf_release(&out);
+	write_file_buf(git_path_squash_msg(the_repository), merge_msg.buf, merge_msg.len);
 }
 
 static void finish(struct commit *head_commit,
@@ -440,22 +441,22 @@ static void finish(struct commit *head_commit,
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
-	if (squash) {
+	if (squash)
 		squash_message(head_commit, remoteheads);
-	} else {
-		if (verbosity >= 0 && !merge_msg.len)
-			printf(_("No merge message -- not updating HEAD\n"));
-		else {
-			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
-			update_ref(reflog_message.buf, "HEAD", new_head, head,
-				   0, UPDATE_REFS_DIE_ON_ERR);
-			/*
-			 * We ignore errors in 'gc --auto', since the
-			 * user should see them.
-			 */
-			close_object_store(the_repository->objects);
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-		}
+	if (verbosity >= 0 && !merge_msg.len)
+		printf(_("No merge message -- not updating HEAD\n"));
+	else if (squash && !option_commit)
+		; /* avoid calling update_ref */
+	else {
+		const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+		update_ref(reflog_message.buf, "HEAD", new_head, head,
+			   0, UPDATE_REFS_DIE_ON_ERR);
+		/*
+		 * We ignore errors in 'gc --auto', since the
+		 * user should see them.
+		 */
+		close_object_store(the_repository->objects);
+		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
@@ -893,17 +894,26 @@ static int finish_automerge(struct commit *head,
 	struct object_id result_commit;
 
 	free_commit_list(common);
-	parents = remoteheads;
-	if (!head_subsumed || fast_forward == FF_NO)
-		commit_list_insert(head, &parents);
-	prepare_to_commit(remoteheads);
+	if (squash) {
+		squash_message(head, remoteheads);
+		parents = commit_list_insert(head, &parents);
+	} else {
+		parents = remoteheads;
+		if (!head_subsumed || fast_forward == FF_NO)
+			commit_list_insert(head, &parents);
+		prepare_to_commit(remoteheads);
+	}
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
-		die(_("failed to write commit object"));
-	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
+		die(squash ? _("failed to write commit object on squash") :
+			_("failed to write commit object"));
+	strbuf_addf(&buf, "Merge made by the '%s' strategy", wt_strategy);
+	strbuf_addstr(&buf, squash ? " (squashed)." : ".");
 	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
 	remove_merge_branch_state(the_repository);
+	if (squash && option_commit)
+		unlink(git_path_squash_msg(the_repository));
 	return 0;
 }
 
@@ -1345,14 +1355,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (squash) {
 		if (fast_forward == FF_NO)
 			die(_("You cannot combine --squash with --no-ff."));
-		if (option_commit > 0)
-			die(_("You cannot combine --squash with --commit."));
+
 		/*
-		 * squash can now silently disable option_commit - this is not
-		 * a problem as it is only overriding the default, not a user
-		 * supplied option.
+		 * In order to not break current behavior for --squash, if the user
+		 * does not specify --commit, we assume it's --no-commit
 		 */
-		option_commit = 0;
+		if (option_commit < 0)
+			option_commit = 0;
 	}
 
 	if (option_commit < 0)
@@ -1510,6 +1519,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
+		if (squash && option_commit) {
+			ret = finish_automerge(head_commit, 1, common,
+					       remoteheads, get_commit_tree_oid(commit),
+					       "Fast-forward");
+			goto done;
+		}
+
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
 		remove_merge_branch_state(the_repository);
 		goto done;
@@ -1682,8 +1698,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 132608879a..c3d824247f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -107,6 +107,10 @@ verify_no_mergehead () {
 	! test -e .git/MERGE_HEAD
 }
 
+verify_no_squash_msg () {
+	! test -e .git/SQUASH_MSG
+}
+
 test_expect_success 'setup' '
 	git add file &&
 	test_tick &&
@@ -246,6 +250,25 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge --squash --commit c3 with c7' '
+	git reset --hard c3 &&
+	test_must_fail git merge --squash --commit c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
+
+	$(git show -s c7)
+
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	git config commit.cleanup scissors &&
 	git reset --hard c3 &&
@@ -294,6 +317,32 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c3 with c7 with --squash --commit commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge --squash --commit c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
+
+	$(git show -s c7)
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_i18ncmp expect actual
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'merge c1 with c2 and c3' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -367,6 +416,26 @@ test_expect_success 'merge c0 with c1 (squash)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (squash --commit)' '
+	git reset --hard c0 &&
+	git merge --squash --commit c1 &&
+	verify_merge file result.1 &&
+	verify_parents $c0 &&
+	verify_no_mergehead &&
+	verify_no_squash_msg &&
+
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
+
+	$(git show -s c1)
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_cmp expect actual
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'merge c0 with c1 (squash, ff-only)' '
 	git reset --hard c0 &&
 	git merge --squash --ff-only c1 &&
@@ -389,6 +458,17 @@ test_expect_success 'merge c1 with c2 (squash)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c1 with c2 (squash --commit)' '
+	git reset --hard c1 &&
+	git merge --squash --commit c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 &&
+	verify_no_mergehead &&
+	verify_no_squash_msg
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'unsuccessful merge of c1 with c2 (squash, ff-only)' '
 	git reset --hard c1 &&
 	test_must_fail git merge --squash --ff-only c2
@@ -570,12 +650,6 @@ test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --no-ff --squash c1
 '
 
-test_expect_success 'combining --squash and --commit is refused' '
-	git reset --hard c0 &&
-	test_must_fail git merge --squash --commit c1 &&
-	test_must_fail git merge --commit --squash c1
-'
-
 test_expect_success 'option --ff-only overwrites --no-ff' '
 	git merge --no-ff --ff-only c1 &&
 	test_must_fail git merge --no-ff --ff-only c2
-- 
2.20.1

