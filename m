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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C2C43333
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCBF652B4
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCIGZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIGYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC90C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w11so13921251wrr.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6n4Nl8Gke8AkyT9T82wL113Sek6nDB+PbOsoWKlUJ6E=;
        b=olk+WEVaD+b+rcyW707YgtzdsuEyueiqVa0Dt5iUoG1D9bR3TtEOuOnDWcLJJhZfGW
         /lZOgnTyHUT/rENdBET8cdpp9YnmtUAjyKffVUaoAWuwmOUFYW+ogh9HPJ9xsUdHxr6Z
         5xWcGZ6bYO6PxfHvQhJqTxM0UsryEWKTNSzWFUEiqrmz8EIYJHSV0VbG9JGqrZ1mvk3c
         mVYi5z2dcvdCGuT5GKmsYdwjaZqtvlLGYnWH0N3SV83dK9rvBn/bJIHSTF87gYAC0H9A
         RnuKsTKiFiNWVPYZwfOx49EBuURrA0AukPqanEMxX3z1siTkc4QEgtZbfB1gbAddyd61
         KCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6n4Nl8Gke8AkyT9T82wL113Sek6nDB+PbOsoWKlUJ6E=;
        b=JtTbUWFGbZ6kz97V8A0Aw9p49TebusrSDp0hIPZ6WFEUjwaXh/S6Kzk3d138j+c2ld
         kfoXOHujgHew7pZTFa3JOuv4uM64K34ZpszAJ6xnBD2cfR8ONQ2O2q81IjRCTQ0g3LBo
         oIqfKotxir/EO3tcpSeFuHGpjdd5HOFHYzBsWsI0+llXxxBVTy4ttAsxsiapmXVwHTQk
         IsF+NAU6Rm7uy4xml6tpKzhx9OExgV/It41bXyI4jZpxb2Q4NiJvVpGT7aw4g8BOu+pr
         5UISGvWK86L7OJUA/i1U8L5OcE3yw4JbtyMOOMRLUKmwTG4CoGGkGsMiGd8Sq9R8zYB3
         EU8Q==
X-Gm-Message-State: AOAM530sJFwjzMm/6tA4e85QkOiLIVvTngF9QNkqvmTl2o/D2loACC4y
        eD7DNIZG+6VKbsIFzfoZlhsEVKG425k=
X-Google-Smtp-Source: ABdhPJyEzLreS1MfWQqz+xf3xAlBkDNJ7A34Xb7YyyU/KUPtgLXAEgRF7SmGyn1S5BTTRzorU4sPlQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr26697711wrd.156.1615271092932;
        Mon, 08 Mar 2021 22:24:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm22733846wrt.70.2021.03.08.22.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:52 -0800 (PST)
Message-Id: <93b241c2f21386bf40496fab6f2e21698835c508.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:44 +0000
Subject: [PATCH v2 09/10] merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit
 a conflict
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
index 040287e3a998..1a07e39d2db4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3361,6 +3361,9 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv == NULL);
 	if (result->clean >= 0 && update_worktree_and_index) {
+		const char *filename;
+		FILE *fp;
+
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -3379,6 +3382,13 @@ void merge_switch_to_result(struct merge_options *opt,
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

