Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D12831F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 13:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdAUNQp (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 08:16:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAUNQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 08:16:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so13534352wmr.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qcdpse1GaZ74bNoS/92NsMAv5E7DFfvMlZI0FyxJ/tw=;
        b=eZ9cAwK6T4EFr7TyzaKeOOmzzHd/D05jqHo/7OSxZ9VWAyo9fUWqWU0UFmCd8Wsq98
         Fvxs8VmwDrwwGMQQuJaA37HpVcrg32PUbDnN9bMhWXcgNOGzb4uF/b2YKRAmZ65QjQ5x
         4N1EFAqQOuTlQSPY5ZvPsLji2+WGL929/+ctzmuPDeoiHDuy5ohphvV6fvNXh8KW75za
         Ulr4Swm+QQquy6xqd5bm8Pav1MewlN+SJX7W3vgYgk5mtHur7BCUZCqIlgS1V6gLsgTq
         KcuPYJEKEoIUDC3QmqCIu1PD2PD8ltEEak+DVpfMcK26hKujtI/QhowuAtItMjt9amz7
         +puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qcdpse1GaZ74bNoS/92NsMAv5E7DFfvMlZI0FyxJ/tw=;
        b=VZXQWkoLMr9MTQe+iWRf5DBoxB6N1pdMK/AjZ21o+UTZ1cKdewXskGtAk3HtVz6tgw
         eUjbvo6KIvoiYt3SZ/sWs1oaZdicfqedSPDOiLgQlghGq7K55lSm2Te9S49a5aChWrFw
         bG6E7tgwMdVYP5dD7qNKxbWG1iG8HNcIgn7B02p/vlue9LeJRPxUnl8HQQ61S1QimZq6
         M7Wups53cfikK8dbAs47pQ+5M6CQqfc6g8uzw3lBIz/kscCMFqagJ4ssGICSLJhaIiZz
         e9iYDKAKSTYn7RaCbxLLddWq6Odx0/+RjqnRehJ3X7Gty3hp/uoLiA9rnf3AYRz926Wr
         g9IA==
X-Gm-Message-State: AIkVDXJez/pFf2dLIkdov596PTSTuiVULenW3Zi5Sqty22VEOuLVy6OITeGukWUlQubYIg==
X-Received: by 10.223.149.39 with SMTP id 36mr8907971wrs.125.1485004601938;
        Sat, 21 Jan 2017 05:16:41 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id e16sm4481237wra.36.2017.01.21.05.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 05:16:40 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC PATCH] Option to allow cherry-pick to skip empty commits
Date:   Sat, 21 Jan 2017 14:16:29 +0100
Message-Id: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.585.g56041942c3.dirty
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


I would like to add to cherry-pick the ability to skip patches. To this
end, I'm working on two options: a general `--skip-empty` option to
handle redundant and empty commits by simply skipping them (no user
intervention), and a `--skip` option as an alternative form to
`--continue` to skip the ongoing (conflicting or empty) commit.

The patch here presents my implementation of the `--skip-empty` option,
including documentation. Comments welcome.

However, it has been some time since I dwelved into git internals and
I'm having issues with the `--skip` option. My idea was to rely on the
existing implementation for `--continue`, and have it run the rollback
instead of the commit. However, I'm finding that after the rollback is
done (I'm using the existing rollback function in sequencer, which calls
`git reset --merge`, but I've also tried a `reset --hard`) the sequencer
does not continue because e.g. if the cherry-pick had stopped due to a
conflict, it still finds unmerged paths, and I can't find a way to tell
the sequencer to just re-read the index from scratch. Opinions welcome
(I can provide my WIP patch to make discussion easier).

On the same note, I've noticed that `git reset` clears CHERRY_PICK_HEAD.
I find this a little confusing, both for humans for the code itself
(since it doesn't really abort an ongoing cherry-pick, yet the sequencer
will think there is no running cherry-pick). This is particularly bad
because `git reset` is one of the strategies proposed to solve conflicts
in cherry-picking. So I was wondering if this was intentional or a side
effect of something else that I might look into cleaning up during this
patch series.


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
index 9adb7bbf1d..72962fd2fa 100644
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
 
@@ -983,6 +997,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
 		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.skip-empty"))
+		opts->skip_empty = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
@@ -1231,6 +1247,8 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
+	if (opts->skip_empty)
+		res |= git_config_set_in_file_gently(opts_file, "options.skip-empty", "true");
 	if (opts->allow_ff)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
@@ -1306,6 +1324,14 @@ int sequencer_continue(struct replay_opts *opts)
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
@@ -1317,6 +1343,7 @@ int sequencer_continue(struct replay_opts *opts)
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
2.11.0.585.g56041942c3.dirty

