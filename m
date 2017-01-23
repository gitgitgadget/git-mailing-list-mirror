Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1E920AC5
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbdAWWwr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:47 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33233 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdAWWwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:45 -0500
Received: by mail-wj0-f195.google.com with SMTP id un2so2874316wjb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7WO8ljFFBcSUIF7UeEy8L/okOpCi9KgvbVcKFDqMOU=;
        b=cEe+T+58TrWy5OCE163ST5y6t/7O6gi+YtSHylSJDhYbbwRbt++fxYevywTctvi2c7
         8YqbqcEn5HyCNo7Umb06M5Snp9xJXajOUpRsy60yFXgs+TXjhxNiiG4MVFfzfafHDrf6
         BcFWH2heLh8xkF4QTTNuyPPlrUh+CTzWjPRBZK/2sHqUigbZZ+Puua/oJiBC6pbrztAn
         /nTD7r0HuWlOJH2AwXSnbU2F6qS8m0aTypchzWbdcBrIuBLNsHlocNwJAJMAulKxgc8i
         3prJ9eizn5ysFEASMyUUGdyu/ul3/AtWdaj/ycJOF3QJ6elbr6HRwdzTenZm6JTH+VD6
         8FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7WO8ljFFBcSUIF7UeEy8L/okOpCi9KgvbVcKFDqMOU=;
        b=UxqE+zIZ+XQytlvpmn8HXJ44JiJNJuMac5Dl11PXNcerRAe0qPkqpXR9oz+ZFdxrVN
         jRlRV8NdPyi6VD2oCeLIS/NJc8f1S0jox1QXCSiwc27xeRxoa78OAr02h8bo54gDG9qk
         v8URj0aULcZc4TgcCQkoiXNnp7MsNyTDOt7Z1VdJjAjBvyK4mHoNBx7MjSZpyhFz1F0w
         IJvT1gegS/vDFqbw3NHVcDff7/ZUgzNtkpKb6Fh0x8sEwFRMWM+Km7EhP38ba/nfMDLR
         5sT1M0vkFWZac8F0hU55kOYaC6ypROyWw0N8XiAEvXptFWGJLNKHik5LKUZhgkeqood7
         MRyw==
X-Gm-Message-State: AIkVDXKlVFGe16Z45BNEsRU8yqWsKeXI7/BOWR3NTzBLQRcyByEOcpFu5C4Bl5DQ7o7joA==
X-Received: by 10.223.165.17 with SMTP id i17mr30816711wrb.62.1485211963862;
        Mon, 23 Jan 2017 14:52:43 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id a13sm23521421wma.0.2017.01.23.14.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:42 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/5] cherry-pick: allow skipping only redundant commits
Date:   Mon, 23 Jan 2017 23:52:20 +0100
Message-Id: <20170123225221.3659-5-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
In-Reply-To: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
References: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows the preservation of originally empty commits with the
combination of flags --allow-empty --skip-redundant-commits.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-cherry-pick.txt |  8 ++++-
 builtin/revert.c                  | 18 +++++++++++-
 sequencer.c                       | 62 ++++++++++++++++++++++++++++++---------
 sequencer.h                       |  1 +
 4 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index ffced816d6..147e0cde0c 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -138,9 +138,15 @@ effect to your index in a row.
 	examine the commit. This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
+--skip-redundant-commits::
+	Redundant commits will be skipped altogether. This does not
+	influence commits that were originally empty (see
+	`--allow-empty` and `--skip-empty`).
+
 --skip-empty::
 	This option causes empty and redundant cherry-picked commits to
-	be skipped without requesting the user intervention.
+	be skipped without requesting the user intervention. Implies
+	`--skip-redundant-commits`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index ffdd367f99..aca8a1d9d0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -102,7 +102,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
-			OPT_BOOL(0, "skip-empty", &opts->skip_empty, N_("skip redundant, empty commits")),
+			OPT_BOOL(0, "skip-empty", &opts->skip_empty, N_("skip both redundant and initially empty commits")),
+			OPT_BOOL(0, "skip-redundant-commits", &opts->skip_redundant_commits, N_("skip redundant commits")),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
@@ -115,6 +116,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
+	/* implies skip_redundant_commits */
+	if (opts->skip_empty)
+		opts->skip_redundant_commits = 1;
 
 	/* Check for incompatible command line arguments */
 	if (cmd) {
@@ -147,6 +151,18 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--edit", opts->edit,
 				NULL);
 
+	if (opts->keep_redundant_commits)
+		verify_opt_compatible(me, "--keep-redundant-commits",
+				"--skip-empty", opts->skip_empty,
+				"--skip-redundant-commits", opts->skip_redundant_commits,
+				NULL);
+
+	if (opts->keep_redundant_commits)
+		verify_opt_compatible(me, "--skip-empty",
+				"--allow-empty", opts->allow_empty,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
+				NULL);
+
 	if (cmd) {
 		opts->revs = NULL;
 	} else {
diff --git a/sequencer.c b/sequencer.c
index 9c01310162..333d9112de 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -563,40 +563,70 @@ static int allow_or_skip_empty(struct replay_opts *opts, struct commit *commit)
 {
 	int index_unchanged, empty_commit;
 
-	/*
-	 * Four cases:
+	/* We have four options:
 	 *
-	 * (1) we do not allow empty at all and error out;
+	 * --allow-empty (AE)
+	 * --keep-redundant-commits (KR)
+	 * --skip-empty (SE)
+	 * --skip-redundant-commits (SR)
 	 *
-	 * (2) we skip empty commits altogether;
+	 * Additionally, if KR, then AE. And if SE, then SR.
+	 * 
+	 * We have three possible states:
+	 * Not Empty (NE)
+	 * Originally Empty (OE)
+	 * made REdundant (RE) (originally not empty)
 	 *
-	 * (3) we allow ones that were initially empty, but
-	 * forbid the ones that become empty;
+	 * NE always gets committed. The other two depend on the combination
+	 * of flags.
 	 *
-	 * (4) we allow both.
+	 *              OE outcome | RE outcome | AE  KR  SE  SR
+	 *     Case 0:  0 (error)    0 (error)     0   0   0   0
+	 *     Case 1:  1 (allow)    0 (error)     1   0   0   0
+	 * N/A Case 2:  2 (skip)     0 (error)     0   0   1   0
+	 * N/A Case 3:  0 (error)    1 (keep)      0   1   0   0
+	 *     Case 4:  1 (allow)    1 (keep)      1   1   0   0
+	 * N/A Case 5:  2 (skip)     1 (keep)      0   1   1   0
+	 *     Case 6:  0 (error)    2 (skip)      0   0   0   1
+	 *     Case 7:  1 (allow)    2 (skip)      1   0   0   1
+	 *     Case 8:  2 (skip )    2 (skip)      0   0   1   1
+	 *
+	 * TODO should we allow Case 2? If so, how?
 	 */
-	if (!opts->allow_empty && !opts->skip_empty)
+
+	/* Case 0 */
+	if (!opts->allow_empty && !opts->skip_redundant_commits)
 		return 0; /* let "git commit" barf as necessary */
 
 	index_unchanged = is_index_unchanged();
 	if (index_unchanged < 0)
 		return index_unchanged;
+
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
-	if (opts->skip_empty)
-		return 2;
+	/* Here we know that the commit is either OE or RE */
 
+	/* Case 4, we don't care, result is 'allow' for both cases */
 	if (opts->keep_redundant_commits)
 		return 1;
 
+	/* Case 8, we don't care, result is 'skip' for both cases */
+	if (opts->skip_empty)
+		return 2;
+
+	/* Now we must differentiate between OE and RE,
+	 * for Case 1, 6, 7 */
 	empty_commit = is_original_commit_empty(commit);
 	if (empty_commit < 0)
 		return empty_commit;
-	if (!empty_commit)
-		return 0;
-	else
-		return 1;
+
+	/* An OE will return 1 if AE, 0 otherwise */
+	if (empty_commit)
+		return opts->allow_empty;
+
+	/* An RE will return 2 if SR, 0 otherwise */
+	return 2*opts->skip_redundant_commits;
 }
 
 enum todo_command {
@@ -1009,6 +1039,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->keep_redundant_commits = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.skip-empty"))
 		opts->skip_empty = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.skip-redundant-commits"))
+		opts->skip_redundant_commits = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -1267,6 +1299,8 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.keep-redundant-commits", "true");
 	if (opts->skip_empty)
 		res |= git_config_set_in_file_gently(opts_file, "options.skip-empty", "true");
+	if (opts->skip_redundant_commits)
+		res |= git_config_set_in_file_gently(opts_file, "options.skip-redundant-commits", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
diff --git a/sequencer.h b/sequencer.h
index c747cfcfc7..f8b8bd0063 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int skip_empty;
+	int skip_redundant_commits;;
 
 	int mainline;
 
-- 
2.11.0.616.gd72966cf44.dirty

