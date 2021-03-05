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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35EC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6EE64FD3
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCEAzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhCEAzq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F5C061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so225887wrx.9
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vjGwdS+uBGI/lu02cnJvieRUbNNmigRK/VGjLMkjBZ4=;
        b=BCc5lwjn28PlEiNDR+FpRJZpKoh+UQTJlVmVBEPE9dsZcl+9k8tXrLT+ONy22X8roK
         2Q1RreQRSogAZK0SGqubteG/5Zhe1jGL1TwEC48SjiupTAiyMur4T8Q8hIjk/jZG5zTR
         4yRoe5bbQAl62YhGskUyLsngyQGlN5E28E8zmv38t7xi3seJsoFTUYPk1keLHwvjVO9E
         d5bco37bxo+uE72aJTcQOWCG+Hq1Alj/wQEn72cD9Q/2IZqUAw/RLSJ0pkV7p5mhHd1E
         vK5mQoexmLiIqJE++3kphSjoFHXfmlBCn9L4xBFE6vKpRgoHi4qKH1t8R2tiFpSldXpA
         Tu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vjGwdS+uBGI/lu02cnJvieRUbNNmigRK/VGjLMkjBZ4=;
        b=SqlhRRR4BuZj7wt0SQz4NOAd/fGp+eBhMFNa5lrwNwHD7yZ3gWrDofA4WTnEo7WS2N
         WQOvKEI3bqxGhj4jQIWfgQyo2hnPYV+riFzeuBDCSY8PdbIW+kForYxgMrCP2xyRGIgM
         4uaMFh1AkJ4tMJj1ybQIip7Lbbm3dHnx3g03+MifpJfsYXnjriIQOVbDijy5FhLEv6BX
         XkAPGl6TRYsYMYKltFkUrmeB/IupO/GryVphDB8toccwd1noXj67DCePYpPOR/lsa59V
         J/zM6ONlc7Cysw1Xbpi5LOImPyqbHDYOR2OAsVfqlrfpJnkikPsYz4BdYKGkSBwHXqyW
         Amyg==
X-Gm-Message-State: AOAM533iWQqiAoQjUZ348H1Fpxf6Fy+l2hpFdWZ0iXD458Q1eXDPjj7H
        mCCEHoUrVID4qrCLq4JZn/16ZvQG1Wo=
X-Google-Smtp-Source: ABdhPJzFul8XkTIvQBlGidfL30kpRS8jM23yfxdTAFpvjddpX4rYhEge8JSUr6/i+3v5GzNxCXIV5w==
X-Received: by 2002:adf:e412:: with SMTP id g18mr6754473wrm.159.1614905744859;
        Thu, 04 Mar 2021 16:55:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm1744230wmc.17.2021.03.04.16.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:44 -0800 (PST)
Message-Id: <d8c6eb39aa7c39263b7f0333ec92a3cc65c367ec.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:36 +0000
Subject: [PATCH 10/11] merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index de400f9a1973..7d9afe118fd4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -739,6 +739,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	unlink(git_path_auto_merge(the_repository));
 	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
diff --git a/merge-ort.c b/merge-ort.c
index 37b69cbe0f9a..cf927cd160e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3362,6 +3362,9 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
+		const char *filename;
+		FILE *fp;
+
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3380,6 +3383,13 @@ void merge_switch_to_result(struct merge_options *opt,
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

