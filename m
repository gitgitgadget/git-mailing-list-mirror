Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34250C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2EF208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3+BOl0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgGaP1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgGaP13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9952C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so23282043wrs.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8wXWL171/M95NG5VyLUvXmrlR5xUCk3uRRBTklR4JNg=;
        b=D3+BOl0JnFCWTaBpiMWiR4quIGNcWJzMJUFr6/Vlf0MCNDDA76wOzQQB29L/I2R1zL
         CyQx3wuZoAgvv6kt2VO8IFWhsNVGBc+mulN2E1fe9XDVofhBpoWvnYnHBA1DyX4ECGdp
         WUaey0dV/k8qu0Fbgc9rO8TL/9BawkIB8jnoanmvFKbCq0VoiCoB+RSBgZPrVj5CGFJ6
         SlXPtcRGhLFAtwlkRat1KpXaq1Wg2EQRO53OUm4jDgF7RPGmoW3Ac0TUEHbwdFU6d39B
         mLJeq+Cka9pUCQpNdbKq6Kt1BsHCXI//DxBB64GaEorVO4bY7SS4pSbCqPaYPUZwOYp2
         rKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8wXWL171/M95NG5VyLUvXmrlR5xUCk3uRRBTklR4JNg=;
        b=nRZ0wjeZzqE6QfRNGg8yRKpP3Yd4MkfCj2iUV3egIsoNnNyq4H6rPpepjYFbKbL07L
         qR55lWGu4n8C1OAgN23AKz1Kdmza1X3U8wEStt5ldzIGQlDIpozlUGbzKKFijpXJwuLg
         ppLoUl/rUewNNELsxBjs5ZK9nsEYSqeRgxbJb8UbTvJ4LwIwXjfXeZ2gBrNeDdh0Gyk2
         L6hAyClwNd12p07O89+U6uLKHa6NQ0RIw4rTFwUxBW6mJL1PghRhmovXsnpdnaGABTjc
         QeCBYwwSp+yHQLMLJxyb0be17zzHhUZL2IsR8JnrMN3P0mclY04SvrGjoS8L9LvmPRvS
         6bsQ==
X-Gm-Message-State: AOAM532wETLaeh7RiBEzLQIaXBbAEFAUfXrNaGubCeOPkVjUtjhGCmCP
        gwY3u9njcQ1By+I7RO3EX5gRdLwv
X-Google-Smtp-Source: ABdhPJxJ3pCKYs6fLNXv0bgeHT+0hDUGnMkTuwSOkuiU7Y1tIAoAsR6gqILQIsoc9z0PNtGeYBJVRg==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr3831202wrc.194.1596209247416;
        Fri, 31 Jul 2020 08:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm15389056wrx.90.2020.07.31.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
Message-Id: <224f7bf22486f37d43dc2de806b3484c39ed1365.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:04 +0000
Subject: [PATCH v20 08/21] Treat REVERT_HEAD as a pseudo ref
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
 sequencer.c | 16 +++++++++-------
 wt-status.c |  2 +-
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/path.c b/path.c
index 783cc2ae81..7b385e5eb2 100644
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
index 8941c018a9..e7e77da6aa 100644
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
index 601b1cffcd..5e7b1634f3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2317,8 +2317,10 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 		need_cleanup = 1;
 	}
 
-	if (file_exists(git_path_revert_head(r))) {
-		if (!unlink(git_path_revert_head(r)) && verbose)
+	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
+		if (!refs_delete_ref(get_main_ref_store(r), "", "REVERT_HEAD",
+				     NULL, 0) &&
+		    verbose)
 			warning(_("cancelling a revert in progress"));
 		opts.action = REPLAY_REVERT;
 		need_cleanup = 1;
@@ -2677,7 +2679,7 @@ static int create_seq_dir(struct repository *r)
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
 	unsigned int advise_skip =
-		file_exists(git_path_revert_head(r)) ||
+		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
 		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
 
 	if (!sequencer_get_last_command(r, &action)) {
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
index 8fddf65a4b..df81b8d7a7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1679,7 +1679,7 @@ void wt_status_get_state(struct repository *r,
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

