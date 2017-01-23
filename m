Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B3520A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdAWWwp (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33638 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdAWWwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so30038396wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFjQa7dHsSGipCtKMeE/ygFWg4y4JLJUahauBwMFBjY=;
        b=EziyZQbBy3xK1YF/RhG8SZdANfwKZv38+SKXb/0wxNc8kF4T7xiRukMQNUFzTo4S1x
         candMYWdlHEDy7+MUrmpz7UKW37wBcn99nunQiMCTIsyNMfW8S08DwAci0AbKm+zcfRK
         poVltGNl2Dhr19nsXqxk3KnZvkn6daOl96zUwFQ27QkAY5U2Vubvxd2a7UcDw/XSbag2
         y30KdjOXGHmV2ZWYWjPaaUL3ndROtoOquOY4DzVOdM2xZ9zhhzzpCf0T31lrNg2PXY4F
         8CGN0nviivdKa1fpEpAP52q5O+YMegR07Uj4cVmeW5caruCmPq6r9nKxeRVUzDmDT8O5
         UdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFjQa7dHsSGipCtKMeE/ygFWg4y4JLJUahauBwMFBjY=;
        b=Cu3FEROscaEzAnbiRJRgVjlC6jpILZhqGcrc24K2bfyib/lyrwBFfUkUkEWUFTi3EO
         5rh4asK9niC8oBsIuVZQk0igouy/0fU3CBj05E2jMZgm+RoEcnSQOAIIdZy3oOMJ38Yx
         9JpuIooErcrlG/X26lf9nk9oKhVVmALT6czRN8dN0U8q/CDkjevSB5FLfFRCh1m9czyx
         DNeyaptzNUV+Vf829LfDb12lIQtYCfZohfg1DaGzG+Y5s/aiX45eyC490ZIFr8BmKicf
         j+KSEP8Yq6tFSX0wvmHU1LlMJLPZt60/2fM1J7vzBTPLkYoyjlmtgyxCWLyZHKNv2qYh
         78Bg==
X-Gm-Message-State: AIkVDXJp0NH2pVOtUpJ5Bz6eupE+2YnDv1NG7EjZxgxv9cCX7Sumpw1LGvPekUlFB/DDeQ==
X-Received: by 10.28.93.138 with SMTP id r132mr15976261wmb.17.1485211961651;
        Mon, 23 Jan 2017 14:52:41 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id d14sm23422385wmd.19.2017.01.23.14.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:40 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/5] cherry-pick: option to skip empty commits
Date:   Mon, 23 Jan 2017 23:52:19 +0100
Message-Id: <20170123225221.3659-4-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
In-Reply-To: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
References: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows cherry-picking a set of commits, some of which may be
redundant, without stopping to ask for the user intervention.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-cherry-pick.txt |  4 ++++
 builtin/revert.c                  |  1 +
 sequencer.c                       | 45 +++++++++++++++++++++++++++++++--------
 sequencer.h                       |  1 +
 4 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..ffced816d6 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -138,6 +138,10 @@ effect to your index in a row.
 	examine the commit. This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
+--skip-empty::
+	This option causes empty and redundant cherry-picked commits to
+	be skipped without requesting the user intervention.
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 4ca5b51544..ffdd367f99 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -102,6 +102,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "skip-empty", &opts->skip_empty, N_("skip redundant, empty commits")),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
diff --git a/sequencer.c b/sequencer.c
index 3d2f61c979..9c01310162 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -550,22 +550,32 @@ static int is_original_commit_empty(struct commit *commit)
 
 /*
  * Do we run "git commit" with "--allow-empty"?
+ *
+ * Or do we just skip this empty commit?
+ *
+ * Returns 1 if a commit should be done with --allow-empty,
+ *         0 if a commit should be done without --allow-empty,
+ *         2 if no commit should be done at all (skip empty commit)
+ *         negative values in case of error
+ *
  */
-static int allow_empty(struct replay_opts *opts, struct commit *commit)
+static int allow_or_skip_empty(struct replay_opts *opts, struct commit *commit)
 {
 	int index_unchanged, empty_commit;
 
 	/*
-	 * Three cases:
+	 * Four cases:
 	 *
-	 * (1) we do not allow empty at all and error out.
+	 * (1) we do not allow empty at all and error out;
 	 *
-	 * (2) we allow ones that were initially empty, but
+	 * (2) we skip empty commits altogether;
+	 *
+	 * (3) we allow ones that were initially empty, but
 	 * forbid the ones that become empty;
 	 *
-	 * (3) we allow both.
+	 * (4) we allow both.
 	 */
-	if (!opts->allow_empty)
+	if (!opts->allow_empty && !opts->skip_empty)
 		return 0; /* let "git commit" barf as necessary */
 
 	index_unchanged = is_index_unchanged();
@@ -574,6 +584,9 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
+	if (opts->skip_empty)
+		return 2;
+
 	if (opts->keep_redundant_commits)
 		return 1;
 
@@ -612,7 +625,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res = 0, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -771,12 +784,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 
-	allow = allow_empty(opts, commit);
+	allow = allow_or_skip_empty(opts, commit);
 	if (allow < 0) {
 		res = allow;
 		goto leave;
 	}
-	if (!opts->no_commit)
+	/* allow == 2 means skip this commit */
+	if (allow != 2 && !opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
 				     opts, allow, opts->edit, 0, 0);
 
@@ -993,6 +1007,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_empty_message = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.skip-empty"))
+		opts->skip_empty = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -1249,6 +1265,8 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-empty-message", "true");
 	if (opts->keep_redundant_commits)
 		res |= git_config_set_in_file_gently(opts_file, "options.keep-redundant-commits", "true");
+	if (opts->skip_empty)
+		res |= git_config_set_in_file_gently(opts_file, "options.skip-empty", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
@@ -1322,6 +1340,14 @@ int sequencer_continue(struct replay_opts *opts)
 	if ((res = read_populate_todo(&todo_list, opts)))
 		goto release_todo_list;
 
+	/* check if there is something to commit */
+	res = is_index_unchanged();
+	if (res < 0)
+		goto release_todo_list;
+
+	if (res && opts->skip_empty)
+		goto skip_this_commit;
+
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path_cherry_pick_head()) ||
 	    file_exists(git_path_revert_head())) {
@@ -1333,6 +1359,7 @@ int sequencer_continue(struct replay_opts *opts)
 		res = error_dirty_index(opts);
 		goto release_todo_list;
 	}
+skip_this_commit:
 	todo_list.current++;
 	res = pick_commits(&todo_list, opts);
 release_todo_list:
diff --git a/sequencer.h b/sequencer.h
index 7a513c576b..c747cfcfc7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -23,6 +23,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int skip_empty;
 
 	int mainline;
 
-- 
2.11.0.616.gd72966cf44.dirty

