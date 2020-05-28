Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B8C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE043207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc7ExPEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406688AbgE1Trn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406540AbgE1TrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:47:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF62C08C5CB
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so304449wmh.5
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3pkU8M4QPYPwfJ++SGxzKJiuRIP+/jX4KSe6dxT5eFg=;
        b=kc7ExPEfEdGYEapl4Y5h6+1Edv2sEIPDcUDYKeShqe2Hft+983AyUb/i+HDmgEMr/g
         Qui+GG9PSyLwI05d+97oVvRBZ4ZHXVKB3X0PfE8kJtk3NBJ0S351x4ni4RUm+KNvMCMs
         qdJxnrEezNL1lGExSRpPdjFhRWSGMibXBEwS/6BYTuxBtvWo0OOpimQUP0KbKrhgabNL
         u5baau2E2Je8fPfcJlJF5klfqgFsW+ezBK0vSgBpVqrHqLzxzA8hmkvImeNjVlXQNbe8
         Dfhl1yfKd+uDWYvj3iZduNgzZPmLFudzeCmhGbJSGPYNFTBWTToBvM7OR1EdKtE1FBY0
         IRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3pkU8M4QPYPwfJ++SGxzKJiuRIP+/jX4KSe6dxT5eFg=;
        b=Tqhe1NDcCjBIduuV6Ouw8eCG/6pddHRsO6BV2db1LC2BrborxAsZCqNzQNUZCp8gLr
         W7t/G3PL4oKU+Ox98I+6ESEIEut0O+hcZiJPJmoP1BtqODUdYJE3vtgYee0UocOhgPMg
         AoFeGFKbC+Yy8tnKy3cPYyhPOJfTsdGEOKsOGexcrqiTVKMTGxhf4rV10XEpmbmVDTDJ
         w/5kmtOXbibC1VvpZvOFPE3hjw5UZ/JIFWqgf5xry5PfS1Caff2y/zBP298pQL0hIjL5
         0epAqNLMXM1xPSK31dsAHYuVVlJaKLp91FDWf83/n4I1T2fRFRa9pbZygTinWZFDQBr7
         fFPw==
X-Gm-Message-State: AOAM531XfeqtGDS9KOlVsPT5Kco9r5DHS0av//mxClbk88Sxe/iKqq1f
        1szFIHEyymrbmBPscrcredGq7q+c
X-Google-Smtp-Source: ABdhPJzGHKXiTuvpNou0SfE1N3qdPac1gIpkpg69W3fJJ9YLDu3+Iih4rDEnaIgXdJpnLHARg4HEWw==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr3237911wmj.35.1590695216450;
        Thu, 28 May 2020 12:46:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm7179860wrn.11.2020.05.28.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:56 -0700 (PDT)
Message-Id: <8f2ebf65b90b403a680335e7aec239ddde4d9bdf.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:41 +0000
Subject: [PATCH v15 05/13] Treat REVERT_HEAD as a pseudo ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 path.c      |  1 -
 path.h      |  8 +++-----
 sequencer.c | 18 ++++++++++--------
 wt-status.c |  2 +-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/path.c b/path.c
index 783cc2ae819..7b385e5eb28 100644
--- a/path.c
+++ b/path.c
@@ -1528,7 +1528,6 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
-REPO_GIT_PATH_FUNC(revert_head, "REVERT_HEAD")
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 8941c018a99..e7e77da6aaa 100644
--- a/path.h
+++ b/path.h
@@ -170,7 +170,6 @@ void report_linked_checkout_garbage(void);
 	}
 
 struct path_cache {
-	const char *revert_head;
 	const char *squash_msg;
 	const char *merge_msg;
 	const char *merge_rr;
@@ -181,12 +180,11 @@ struct path_cache {
 	const char *shallow;
 };
 
-#define PATH_CACHE_INIT                                              \
-	{                                                            \
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL \
+#define PATH_CACHE_INIT                                        \
+	{                                                      \
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL \
 	}
 
-const char *git_path_revert_head(struct repository *r);
 const char *git_path_squash_msg(struct repository *r);
 const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
diff --git a/sequencer.c b/sequencer.c
index 188488cb40b..a41913455ec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2317,8 +2317,10 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 		need_cleanup = 1;
 	}
 
-	if (file_exists(git_path_revert_head(r))) {
-		if (!unlink(git_path_revert_head(r)) && verbose)
+	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
+		if (!refs_delete_pseudoref(get_main_ref_store(r), "REVERT_HEAD",
+					   NULL) &&
+		    verbose)
 			warning(_("cancelling a revert in progress"));
 		opts.action = REPLAY_REVERT;
 		need_cleanup = 1;
@@ -2677,8 +2679,8 @@ static int create_seq_dir(struct repository *r)
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
 	unsigned int advise_skip =
-		file_exists(git_path_revert_head(r)) ||
-		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
+		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD");
+	refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
 
 	if (!sequencer_get_last_command(r, &action)) {
 		switch (action) {
@@ -2778,7 +2780,7 @@ static int rollback_single_pick(struct repository *r)
 	struct object_id head_oid;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
-	    !file_exists(git_path_revert_head(r)))
+	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -2872,7 +2874,7 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 	 */
 	switch (opts->action) {
 	case REPLAY_REVERT:
-		if (!file_exists(git_path_revert_head(r))) {
+		if (!refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 			if (action != REPLAY_REVERT)
 				return error(_("no revert in progress"));
 			if (!rollback_is_safe())
@@ -4210,7 +4212,7 @@ static int continue_single_pick(struct repository *r)
 	const char *argv[] = { "commit", NULL };
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
-	    !file_exists(git_path_revert_head(r)))
+	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -4390,7 +4392,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		/* Verify that the conflict has been resolved */
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") ||
-		    file_exists(git_path_revert_head(r))) {
+		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 			res = continue_single_pick(r);
 			if (res)
 				goto release_todo_list;
diff --git a/wt-status.c b/wt-status.c
index 96302be030b..81b768504a1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1642,7 +1642,7 @@ void wt_status_get_state(struct repository *r,
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
-	if (!stat(git_path_revert_head(r), &st) &&
+	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
-- 
gitgitgadget

