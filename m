Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71287C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C020888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdDJ/cLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHSPP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHSPPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:15:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1FDC061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so21913256wra.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JVkcrNkHn5N5zbWK87SPiCDfzN15XxBwL82x0K4dR3Q=;
        b=JdDJ/cLPinloIWcxZz71dWAr9ahVp+OHqyKjQyiB2pqCKAm8t2Z1IBhnK0LJ98wHQU
         ee9A2sJ456UZ+oJ1SWG8D9Lac7Pg0yr1esc0S0YfJEfcWn0ILt5xHcS0LAiQW1Cgs9TJ
         1ZTrLarBSQRlSZdWKw1TNKrJRYMxMPha1oxHF5Vc6odIv1Qrucwd1feo95edQWpayJsy
         EpLJTEi+I3JHBjORoOQFnegOgnkHo9WElqOzcGi+Eh4z8m5Gx9zrJiDP2KNNKrdoYjdj
         6tloBNbBYZeTMy0W92jhqZQxToTU3KdoahEDnkSNiqYxIHtZO+Sm1I3KWprISnhvtjri
         nL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JVkcrNkHn5N5zbWK87SPiCDfzN15XxBwL82x0K4dR3Q=;
        b=fR8wYjhFII75HeL8rU0QWG+Qvou1Hh4uLRZcZSoqciii9qqe/eums/0gdi6AyTeQPY
         focJALz8eoWzreyEGD8cek/7AfFFxUIRzz9aZacv04rXlzRMu7ntJK4voPROc2rgCUku
         L3z2tdH4SrM3JQw3OpZb2Jkhgo4Hb06zoYAxEx5vUX3wVCUNnW6nfQNYE99lrHdqhJ3Q
         QICH/Ax4p5wIDl7GYu/SNjwUn+ubGo7Fc7oQnc/5cn9ZGba6pa4162AT8zGjnMCr7qbM
         nI5XZhermwZbIuWCnBsagMiKd2eapzJ0KtAfg7JRrmxJ3wORehCJDHdWogOUaKp8nWG+
         v6zw==
X-Gm-Message-State: AOAM532PQ/E2LVcNSYKJoQgANk5doYS8tIBXJ0dnr1GWlA+H3n3jGZNM
        vumM6SO13lOVItiNGokZCXApI0Q6Zxw=
X-Google-Smtp-Source: ABdhPJx8izmOn8ry5qnJyuBPiyZrHvKaEzbI53DMsLOFUXafBcQlgs4Sclk4qdJEdAZ7IIsg1eU24A==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr24922933wrm.367.1597850137376;
        Wed, 19 Aug 2020 08:15:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm6452677wmf.47.2020.08.19.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:15:36 -0700 (PDT)
Message-Id: <9dcc10f80702754ace48f6aa1915ee7afe5b506e.1597850128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 15:15:27 +0000
Subject: [PATCH v2 4/4] sequencer: treat REVERT_HEAD as a pseudo ref
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
index 09e2ff659e..d116ea69bd 100644
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
index c6abf2f3ca..ecbe570e28 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1678,7 +1678,7 @@ void wt_status_get_state(struct repository *r,
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
