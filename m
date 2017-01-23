Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B289D20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdAWWwu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33692 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdAWWwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id r144so30038760wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=35M8pdfG7W8zG6ifmssCD/SMdoo5l2cEE75iGFQtkSs=;
        b=ck7FO/+qpyUPp70KNLml5QbtPyB/0QgXbyMYKVqc6wUu5FIwuGmWZQvyjNcMmLqX95
         5XBNXqn4CuQREK1HlfSvF1OCARWyFOzkxhgJGV9O5qQpBR5kVdlDMmgcmzt8Cqf5q+2P
         IfE+XC5pWF8zN0w6M37bJHCGLT6Q2+nAj4SCeIIelCtIWctNfp2r2mPB/5C9Jj2LNg/Z
         RTIX5Reu+vboJnIj1+bwLtUtabNnOTeXHpzowbwQoedcp333gRLuM/ywqTQt3Am9BBmE
         6GQqpHFymAXAEafINLtJkFoikXzI+Gj0XOsaZBh3SgiUBK2zBCK0bhVHm34z75khgfV9
         dnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=35M8pdfG7W8zG6ifmssCD/SMdoo5l2cEE75iGFQtkSs=;
        b=lxQeBTQc+D0l26Sqbh58AHCcsbxJlqrL9GVaSMb+SEBPEJLDjvfCWEX7tY8mt4TybZ
         5I8IxxDZRtYPhZwJB2qxNDr0kuFaIO+jxdCvK1vST/eg8/+ceSaV1tTriW6m/N+9RPnz
         4pnpIGO44k5O3b91UYC9TCxit8I0QWFm4JCSNfH4+2xSv+5XNpQttgbuEBNhbqbFFm5Q
         NXkU1O8GL4523eFGud3HrjqJrei1JkDpDncXIJLm8c9soAh1H5JnM/20I2TTRDn2uilx
         +VkdAF3HDr1S9UPb9vJgjXemhYTO5Sd/X/WvrndyJUtxA3P7hEYu3Mg28Aiqd/UPLp2u
         TXVg==
X-Gm-Message-State: AIkVDXIToEM6aJ0wGk+Z3fXcxNJMjPlc83Z/DNm/lrrZWq44LVFmSOXtzSiInJQ6uf/Q6g==
X-Received: by 10.28.144.66 with SMTP id s63mr16170794wmd.134.1485211966181;
        Mon, 23 Jan 2017 14:52:46 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id y97sm23346777wmh.24.2017.01.23.14.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:44 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 5/5] sequencer: allow to --skip current commit
Date:   Mon, 23 Jan 2017 23:52:21 +0100
Message-Id: <20170123225221.3659-6-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
In-Reply-To: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
References: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a sequencing gets interrupted (by a conflict or an empty commit or
whatever), the user can now opt to just skip it passing the `--skip`
command line option, which acts like a `--continue`, except that the
current commit gets skipped.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/sequencer.txt | 10 +++++++++-
 builtin/revert.c            |  7 +++++--
 sequencer.c                 | 32 ++++++++++++++++++++++++++++----
 sequencer.h                 |  2 +-
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5747f442f2..095d6cd732 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -1,7 +1,15 @@
 --continue::
 	Continue the operation in progress using the information in
 	'.git/sequencer'.  Can be used to continue after resolving
-	conflicts in a failed cherry-pick or revert.
+	conflicts in a failed cherry-pick or revert.  Use `--skip`
+	instead if the current commit should be ignored.
+
+--skip::
+	Skips the current commit, and then continues the operation
+	in progress using the information in '.git/sequencer'.i
+	Can be used to continue to a cherry-pick or rever that was
+	interrupted by an empty commit, or by a commit that conflicts
+	and for which the resolution is to discard the commit.
 
 --quit::
 	Forget about the current operation in progress.  Can be used
diff --git a/builtin/revert.c b/builtin/revert.c
index aca8a1d9d0..dece0bebf7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -79,6 +79,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
+		OPT_CMDMODE(0, "skip", &cmd, N_("resume revert or cherry-pick sequence, skipping this commit"), 's'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
@@ -127,6 +128,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (cmd == 'c')
 			this_operation = "--continue";
+		else if (cmd == 's')
+			this_operation = "--skip";
 		else {
 			assert(cmd == 'a');
 			this_operation = "--abort";
@@ -188,8 +191,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 
 	if (cmd == 'q')
 		return sequencer_remove_state(opts);
-	if (cmd == 'c')
-		return sequencer_continue(opts);
+	if (cmd == 'c' || cmd == 's')
+		return sequencer_continue(opts, cmd);
 	if (cmd == 'a')
 		return sequencer_rollback(opts);
 	return sequencer_pick_revisions(opts);
diff --git a/sequencer.c b/sequencer.c
index 333d9112de..cfe8c06989 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1359,21 +1359,45 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-int sequencer_continue(struct replay_opts *opts)
+/*
+ * Continue the sequencing, after either committing
+ * (cmd == 'c') or skipping (cmd == 's') the current
+ * commit.
+ */
+int sequencer_continue(struct replay_opts *opts, char cmd)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
+	int single, res;
 
 	if (read_and_refresh_cache(opts))
 		return -1;
 
-	if (!file_exists(get_todo_path(opts)))
-		return continue_single_pick();
+	if (!file_exists(get_todo_path(opts))) {
+		if (cmd == 'c') {
+			return continue_single_pick();
+		} else {
+			assert(cmd == 's');
+			/* Skipping the only commit is equivalent to an abort */
+			return sequencer_rollback(opts);
+		}
+	}
 	if (read_populate_opts(opts))
 		return -1;
 	if ((res = read_populate_todo(&todo_list, opts)))
 		goto release_todo_list;
 
+	/* If we were asked to skip this commit, rollback
+	 * and continue with the next */
+	if (cmd == 's') {
+		if ((res = rollback_single_pick()))
+			goto release_todo_list;
+		discard_cache();
+		if ((res = read_cache()) < 0)
+			goto release_todo_list;
+		printf("index unchanged: %d\n", is_index_unchanged());
+		goto skip_this_commit;
+	}
+
 	/* check if there is something to commit */
 	res = is_index_unchanged();
 	if (res < 0)
diff --git a/sequencer.h b/sequencer.h
index f8b8bd0063..afc4bb4e6c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -41,7 +41,7 @@ struct replay_opts {
 #define REPLAY_OPTS_INIT { -1 }
 
 int sequencer_pick_revisions(struct replay_opts *opts);
-int sequencer_continue(struct replay_opts *opts);
+int sequencer_continue(struct replay_opts *opts, char cmd);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-- 
2.11.0.616.gd72966cf44.dirty

