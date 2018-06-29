Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F001F516
	for <e@80x24.org>; Fri, 29 Jun 2018 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936434AbeF2PPK (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 11:15:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56221 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934241AbeF2PPI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 11:15:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so2570650wmv.5
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9tiL2vVE7tJZ34PgdxwhL5qcFo8FNcq+pbkhcLOU9k=;
        b=B/OraNZB9JTuDKQtvwVJ22WDT/umBuZXVr1EQ8E2O4i7OWqEtB/o9MPNhHrRkqnD2O
         2gZs74cdNYYe1TExFYCHBLux5svNtHR6C7UXMCSN8L2BABOhvDldXn9CT4xKT18V6lIU
         hjrN2NHwXPKwLKDed/vWkHZVNRe5yw5HRTxHNALh4gTSJgucuUI+gs587Sjf/DWOoYc4
         CAQEuotXZ+Ar+VUgNDnZRNrnGPGmSf1TxPcP9o44zNz0owXQ9XvUwFJdqmjBX2pNdIdw
         MjTRp56GMldFOt49/bcrwiyhx9FN/fKOdwo9SOCi7AaispLsJtYPan9iGvCTOb1rGOH9
         3XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9tiL2vVE7tJZ34PgdxwhL5qcFo8FNcq+pbkhcLOU9k=;
        b=HTuHdmpIfFlCeBrPNO8UskqtGdtoOwVUGx/CkynOaacrAkD89aiZemV6EJR/yT/xHd
         M04/zcJlZUgUMqMaUwYHarV27tN904t7kZ1te5686ZBDA8tL3pIFE+4Ji6p1E/B1GAm4
         XTju8I9vRAHHoc7wb4KC4fDVxH30LJiEC105w7r3umsmg0wpzy9F3ZYbYN+E4UoNZCPU
         +O1CE2olGr7nK7cA9+QtfwwmFjo9v6k95pMUFxnRlW81hlDFceOYISe9sM08curttvjr
         Vg5C4uqK+YIQXaSIUTcKf07tIOt6OPIMnpfa8B6a3scEwGudJ24YmimDzboKeRuSuUwD
         y+nQ==
X-Gm-Message-State: APt69E03PCvKRM4cCyXdqceRhicLoED8xYYYnaQ/CiRW6hNtlqZRSXKS
        Oia7CXMM7ytJ0tZVk5AG1eypLeq+
X-Google-Smtp-Source: AAOMgpe4oV+Ud8ltjQuOocAvwLb2eyZwNSxqmXcSZM3E3mdNQOEDEPEahj2shy6tDPUBavV55plj5Q==
X-Received: by 2002:a1c:c541:: with SMTP id v62-v6mr2143926wmf.57.1530285306557;
        Fri, 29 Jun 2018 08:15:06 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id l78-v6sm3301601wmb.39.2018.06.29.08.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 08:15:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 1/3] sequencer: add a new function to silence a command, except if it fails.
Date:   Fri, 29 Jun 2018 17:14:33 +0200
Message-Id: <20180629151435.31868-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629151435.31868-1-alban.gruin@gmail.com>
References: <20180625134419.18435-1-alban.gruin@gmail.com>
 <20180629151435.31868-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new function, run_command_silent_on_success(), to
redirect the stdout and stderr of a command to a strbuf, and then to run
that command. This strbuf is printed only if the command fails. It is
functionnaly similar to output() from git-rebase.sh.

run_git_commit() is then refactored to use of
run_command_silent_on_success().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cb7ec9807..d9545b366 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -769,6 +769,23 @@ N_("you have staged changes in your working tree\n"
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
 
+static int run_command_silent_on_success(struct child_process *cmd)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int rc;
+
+	cmd->stdout_to_stderr = 1;
+	rc = pipe_command(cmd,
+			  NULL, 0,
+			  NULL, 0,
+			  &buf, 0);
+
+	if (rc)
+		fputs(buf.buf, stderr);
+	strbuf_release(&buf);
+	return rc;
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -823,18 +840,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts)) {
-		if (!(flags & EDIT_MSG)) {
-			cmd.stdout_to_stderr = 1;
-			cmd.err = -1;
-		}
-
-		if (read_env_script(&cmd.env_array)) {
-			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
+		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error(_(staged_changes_advice),
-				     gpg_opt, gpg_opt);
-		}
+		return error(_(staged_changes_advice),
+			     gpg_opt, gpg_opt);
 	}
 
 	argv_array_push(&cmd.args, "commit");
@@ -864,21 +874,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&cmd.args, "--allow-empty-message");
 
-	if (cmd.err == -1) {
-		/* hide stderr on success */
-		struct strbuf buf = STRBUF_INIT;
-		int rc = pipe_command(&cmd,
-				      NULL, 0,
-				      /* stdout is already redirected */
-				      NULL, 0,
-				      &buf, 0);
-		if (rc)
-			fputs(buf.buf, stderr);
-		strbuf_release(&buf);
-		return rc;
-	}
-
-	return run_command(&cmd);
+	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
+		return run_command_silent_on_success(&cmd);
+	else
+		return run_command(&cmd);
 }
 
 static int rest_is_empty(const struct strbuf *sb, int start)
-- 
2.18.0

