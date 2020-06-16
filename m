Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EACC433E2
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8E20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0K/15GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgFPTVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbgFPTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC9C0613EF
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so3943783wmj.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pOs6eMd+RC2vCLBLhB9pmRACQnnoM2tWyOisjR62G7U=;
        b=Y0K/15GEq/E/KNi8WBLzEVVQndn8bCpsZ3fokHlNSX9UJOnkHDTnPuE9uvPVjgC+Pg
         73yA7eBg+YKbAeX58aTxZJyefg8+cehZDg4Rh3YZE2bM+a2TMEnvIiB/cq5FB8K78YEB
         U8rJqoYRnM5gaqFQ03L5ZbToFbA/eKo4XtR4Osb+MGPzrvuLo5MpSscxLhQXfeGgyvFL
         tTbmWxJhAMxDDxLPKjGy6qRdbqOkXrYGZ0dnAQMqPyX2mbVHcMS7ycQiMAxPhd+hlp1e
         f6PIc/NLyRirupFIyBkc4wxCcX6um3Ldr6rJymST5A577RhNViG54G8iZdKeg1R6ZW85
         XXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pOs6eMd+RC2vCLBLhB9pmRACQnnoM2tWyOisjR62G7U=;
        b=NT/6HsBUMQmsFroPoUrZtwqMTSAranHEGWsMFr4nOdKtYCg0LThK3Wtp+yYWu5Rg9F
         RaGJiqpwKPJhDr0EH4UodERx5nkEy4jgLUZcUgd9wvUt6uIeY2A/YeJY2jmUUbim14RR
         4KbimuBShf7RBDeWlKR8lLPoWhtT8QFVaBhSSfBUmyeHc1d1tDcLpxjFRhG1u3k6XSBA
         nQE/tcZn7JGenEoKkwcjlMrpeUKjvxxlAs+UrcXrFQYc1eeihZSr303NAoKjUpfg+uVI
         JD2sh6SYq2jFcU+6l0hTGIY713BUE3gGJYzbndAN2M73LseGsbw1SFKCyKFU1EwOTOkV
         ILFg==
X-Gm-Message-State: AOAM5329BxrGMVakGrZ6T0FTCr8/zap3leALPG3NwE1U0b/p8xbZDNTE
        gIJ9POtQ/wdvPW/Hey7Bd2LWaSN8
X-Google-Smtp-Source: ABdhPJwOEfF58g5/nwKc18JonSB7UjXvi+m73hO+i3pTs5e98lkF4XSifqRPes9HZGlOJuX/1fO7KQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr4839183wmj.67.1592335250768;
        Tue, 16 Jun 2020 12:20:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n204sm5577597wma.5.2020.06.16.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:50 -0700 (PDT)
Message-Id: <3f18475d0d37f9771146d49ba409bf99af2fd358.1592335242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:32 +0000
Subject: [PATCH v17 07/17] Treat REVERT_HEAD as a pseudo ref
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
index 26286ec8d08..25ef9fc773d 100644
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

