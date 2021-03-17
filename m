Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864BC43332
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C8064F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhCQV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhCQV2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBECC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z2so3308472wrl.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnhiuQV/2Wc+3z93qURlauJEUrKVi/jU9n84Rplg354=;
        b=idINbWmy/vqaK2gzqcCZPoNf0zEchlmLVFq86fJpMQ4AaucN3K4Dbcq+F8tSohxFPv
         gIagFWGvB+ukh6bag6fk5spH5GzkxNl8+sGM+knD6Sql5LnknI4JsmmP9EIwh6+rF6AY
         BhbMjasmafuVGvnB/nxI8rfrqp27Bus4V4QUoRpQ5Ld6uzg4Xx7Sy1KtZL5FToObQDyF
         mc/WJAFoAxI2A4gx3DhYu3FKP3AtVXQEMIQK6HU5xJf0eqTO6aNvEi+xlb0aoCbdmhqJ
         cEhVJdfxzGrC1q2om4j4j+b+V50n/JaXFwhQRWr62Hk9yiNZE/5T1JMEM8ibAzKAjq1r
         PQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnhiuQV/2Wc+3z93qURlauJEUrKVi/jU9n84Rplg354=;
        b=DEn7g95QgZUb7s1mtlkuUlnKr9XnVcHTVjoLSHHAhZKwvcCppMnFfJe9e+MNlI5H2T
         ffbQAgZrwgTjyAeH2U9fWN3eSkt9c7A5BaM+xaJv+5g1en1RAnkJmgQesfsq8J9qQfMy
         p8G8sLB+Z1PSBYFZmdvdhGgJOFhkSfJYb4G7rVQc51OhoYJuGdr2H1txkua6DMnwlVaJ
         IXdYii39dmwIVCe/EZqoycfys4q0/GB1a+a1fQxFTjRaBUWfs2+jB8C1YtPIbSKxgh/C
         2E6/pzZKNAYaM/j3tnoCsiTeMBTQjVqn9/JWWyxznRhntqesY61bM+p07BWWt2yRrWwq
         jRDg==
X-Gm-Message-State: AOAM530Qy4snO1hhZy34NxU8lnUZvMe/IRHGHDqBaYIKYJCI2J8pbHB3
        eZ5P2Ziv/+sDQa6QIUz7XdDAL6OAPac=
X-Google-Smtp-Source: ABdhPJwo4tGE36BFcdCpE8pKNc/zn/kgsKuceJ6cnp2cgoJbYu9vs/jLcAp4RIj5dEVPUiRg61LJeg==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr6033016wrr.319.1616016492063;
        Wed, 17 Mar 2021 14:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v189sm110243wme.39.2021.03.17.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:11 -0700 (PDT)
Message-Id: <4a79e61346919291f49885298da4b8c714ee00ff.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:28:01 +0000
Subject: [PATCH v2 09/13] merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit
 a conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are a variety of questions users might ask while resolving
conflicts:
  * What changes have been made since the previous (first) parent?
  * What changes are staged?
  * What is still unstaged? (or what is still conflicted?)
  * What changes did I make to resolve conflicts so far?
The first three of these have simple answers:
  * git diff HEAD
  * git diff --cached
  * git diff
There was no way to answer the final question previously.  Adding one
is trivial in merge-ort, since it works by creating a tree representing
what should be written to the working copy complete with conflict
markers.  Simply write that tree to .git/AUTO_MERGE, allowing users to
answer the fourth question with
  * git diff AUTO_MERGE

I avoided using a name like "MERGE_AUTO", because that would be
merge-specific (much like MERGE_HEAD, REBASE_HEAD, REVERT_HEAD,
CHERRY_PICK_HEAD) and I wanted a name that didn't change depending on
which type of operation the merge was part of.

Ensure that paths which clean out other temporary operation-specific
files (e.g. CHERRY_PICK_HEAD, MERGE_MSG, rebase-merge/ state directory)
also clean out this AUTO_MERGE file.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 branch.c         |  1 +
 builtin/rebase.c |  1 +
 merge-ort.c      | 10 ++++++++++
 path.c           |  1 +
 path.h           |  2 ++
 sequencer.c      |  5 +++++
 6 files changed, 20 insertions(+)

diff --git a/branch.c b/branch.c
index 9c9dae1eae32..b71a2de29dbe 100644
--- a/branch.c
+++ b/branch.c
@@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
+	unlink(git_path_auto_merge(r));
 	save_autostash(git_path_merge_autostash(r));
 }
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 840dbd7eb777..6c252d62758c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -737,6 +737,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	unlink(git_path_auto_merge(the_repository));
 	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
diff --git a/merge-ort.c b/merge-ort.c
index 303e89414274..e8f1a435f99a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3496,6 +3496,9 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
+		const char *filename;
+		FILE *fp;
+
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3514,6 +3517,13 @@ void merge_switch_to_result(struct merge_options *opt,
 		}
 		opt->priv = NULL;
 		trace2_region_leave("merge", "record_conflicted", opt->repo);
+
+		trace2_region_enter("merge", "write_auto_merge", opt->repo);
+		filename = git_path_auto_merge(opt->repo);
+		fp = xfopen(filename, "w");
+		fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid));
+		fclose(fp);
+		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 
 	if (display_update_msgs) {
diff --git a/path.c b/path.c
index 7b385e5eb282..9e883eb52446 100644
--- a/path.c
+++ b/path.c
@@ -1534,5 +1534,6 @@ REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
 REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
 REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
+REPO_GIT_PATH_FUNC(auto_merge, "AUTO_MERGE")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index e7e77da6aaa5..251c78d98000 100644
--- a/path.h
+++ b/path.h
@@ -176,6 +176,7 @@ struct path_cache {
 	const char *merge_mode;
 	const char *merge_head;
 	const char *merge_autostash;
+	const char *auto_merge;
 	const char *fetch_head;
 	const char *shallow;
 };
@@ -191,6 +192,7 @@ const char *git_path_merge_rr(struct repository *r);
 const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
 const char *git_path_merge_autostash(struct repository *r);
+const char *git_path_auto_merge(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
diff --git a/sequencer.c b/sequencer.c
index d2332d3e1787..472cdd8c620d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2096,6 +2096,7 @@ static int do_pick_commit(struct repository *r,
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
 				NULL, 0);
 		unlink(git_path_merge_msg(r));
+		unlink(git_path_auto_merge(r));
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
@@ -2451,6 +2452,8 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 		need_cleanup = 1;
 	}
 
+	unlink(git_path_auto_merge(r));
+
 	if (!need_cleanup)
 		return;
 
@@ -4111,6 +4114,7 @@ static int pick_commits(struct repository *r,
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
 			unlink(git_path_merge_head(r));
+			unlink(git_path_auto_merge(r));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
@@ -4505,6 +4509,7 @@ static int commit_staged_changes(struct repository *r,
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
 	unlink(git_path_merge_head(r));
+	unlink(git_path_auto_merge(r));
 	if (final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
-- 
gitgitgadget

