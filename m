Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5D92042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbcLMPgP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:36:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:56763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932390AbcLMPgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:36:10 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1F72-1capoH2SpE-00tEPh; Tue, 13
 Dec 2016 16:29:21 +0100
Date:   Tue, 13 Dec 2016 16:29:14 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 01/34] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RpZTu7BNK5P3t17LoXDqj5X/hBJCvaUfEV454zwMFkdTfZVFiAI
 f27wz0xUsUhXAkkM7yBRm7+Qs+WtPLBUR0c3qc0ePWI83H+uE/1B6el2mJsh5LRi7PAptBd
 5c0Z61IpgP+G4lfvISf9jYI8RIHwF4HeWV7+RS3Y84w+gh5oRZ/vkdrF8J+eKwkvxcwLTh9
 Py3fFAzJX79nFwh1a+KOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:25VYBZOo5y4=:T2a0I1rAqMZHFvtBaph2et
 IwSYn35msdImF/YmLCU8e0nZUNFkXFVmVCihz/qwbzXEVMyDGfZdpB4wQ2WGcTWvvkWcNR04l
 IwHld62Xu5Iw2AMhta121Wk0rWLoiau8OGiI3vpVAM5NSE547+5JRZpAyMcs3KKini2WS4bny
 D9RzoswRXHnBS+GX7PKmtRrVhXsz9V4cPQNkWHDODKwKEGGzIAshQkaB3znONGYjY/Ybl9fM8
 YQ4m1WRZhPVix2vIW0o1q77ui/Of3MnWgScDtp/3lp9NanSY95SRVDEsArL0k/Ub5tZ/ppjxn
 QlzRW59fPhhOxd09CUhAPq6QuYyfa5EqOfW4puJPXOeFrDo9o3fdx4u38xN+gCUmF8oiILKvp
 1mVxyMFzBJMWjUXEZFc4irjt5aZQRrAyXFF3VPq5xbEDD4SAOURrsss/uRPSSeYezs+tDBVpp
 0Or9pw4f5jYEuVkRcFC9WTAL50ZVHQnez54sMUSVPgKYToyTKDGujUS2FR8V+nu5eTlf4Txlq
 DF/ZdXuMNNAY70h72S22nUUOHN4+jHi1fkTWk0tgT0PL03Hr93Vw1byT9q1OyEl1OADoVDcdF
 zjf9s/r/LDPaBXaR0AaWdLffkPxEKJR1BoaJVQRDFPUtcwd/OJK2Pv646vLHwpgRZ3n6k60HM
 U8ANLhkJEzFsyf83X9TKIppHJ1w1SBwOcYL7f8bxaXpIuwew2upVypFrSC70B2d+PANRag1B5
 DqsuEu9PbFKydyEx059o9Bz2IPk6LTxGzuXhEu8bpapWIDSR2tR93zsc7UIQMzQnbDowx/yj1
 cqyxQw3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new action for the sequencer. It really does not
do a whole lot of its own right now, but lays the ground work for
patches to come. The intention, of course, is to finally make the
sequencer the work horse of the interactive rebase (the original idea
behind the "sequencer" concept).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 +++++++++++++++++++++++++++++----
 sequencer.h |  3 ++-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 30b10ba143..21cfdacd06 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -28,6 +28,14 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
+static GIT_PATH_FUNC(rebase_path, "rebase-merge")
+/*
+ * The file containing rebase commands, comments, and empty lines.
+ * This file is created by "git rebase -i" then edited by the user. As
+ * the lines are processed, they are removed from the front of this
+ * file and written to the tail of 'done'.
+ */
+static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
@@ -40,19 +48,22 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
-/* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
-	return 0;
+	return opts->action == REPLAY_INTERACTIVE_REBASE;
 }
 
 static const char *get_dir(const struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return rebase_path();
 	return git_path_seq_dir();
 }
 
 static const char *get_todo_path(const struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return rebase_path_todo();
 	return git_path_todo_file();
 }
 
@@ -168,7 +179,15 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		return N_("revert");
+	case REPLAY_PICK:
+		return N_("cherry-pick");
+	case REPLAY_INTERACTIVE_REBASE:
+		return N_("rebase -i");
+	}
+	die(_("Unknown action: %d"), opts->action);
 }
 
 struct commit_message {
@@ -395,7 +414,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		/*
+		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
+		 * "rebase -i".
+		 */
 		return error(_("%s: Unable to write new index file"),
 			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
@@ -1204,6 +1226,9 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	const char *todo_path = get_todo_path(opts);
 	int next = todo_list->current, offset, fd;
 
+	if (is_rebase_i(opts))
+		next++;
+
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
 		return error_errno(_("could not lock '%s'"), todo_path);
diff --git a/sequencer.h b/sequencer.h
index 7a513c576b..cb21cfddee 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,7 +7,8 @@ const char *git_path_seq_dir(void);
 
 enum replay_action {
 	REPLAY_REVERT,
-	REPLAY_PICK
+	REPLAY_PICK,
+	REPLAY_INTERACTIVE_REBASE
 };
 
 struct replay_opts {
-- 
2.11.0.rc3.windows.1


