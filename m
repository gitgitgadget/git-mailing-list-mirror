Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EB31F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGJMRY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeGJMRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so14377309wrd.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/PmT7tCRCH4Mwz38Gjh83SPf8AwRhxlaSqIDB9WjcAk=;
        b=jb1bLBrC1IyKa/UhpPgspZOVTdeLfzKJBkmnURD3lJgTMmqGwUKU+R51+PawLU2DnE
         eg6XrkWD9AK9XkHlBPYK//fvqwCU32PRpB9q9KvPrn5xGB4UDQft3jMzqqwQ6UFoADi8
         TC8bKm/NNbSmCUo1XZ6c1hqzcrBOjh/KBi3lMtZFtX4ydW4CNwkVpNDoF3UnxNJYOKJd
         N+0csA6fXmBaRHszx6ubfwG/RCc2lPxhopPwOfNk9SHvNVcjsF7Dk5NymU2G+GmIADwk
         sXB4GSaVNLLnHUWh9krCNvlFDnnRlvnoX1mEA3DtwUU3+pDQpiqGYYLOeCsIiiWY9hRE
         x0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/PmT7tCRCH4Mwz38Gjh83SPf8AwRhxlaSqIDB9WjcAk=;
        b=b3mO9yEsGlk+6+5kfPmPtNRXQ7Miss5oep6YVbwRt0Q184excr5rGBcnY1JSEQjuWl
         xtIxlsH1wLAkQ2YmQEE6pHWGHOKMhjaMey2mTNE/j+m5NU9m3FTaqwBp0OFi+fQFPGk6
         u6IFqdZCX617TXgaretBdNBb0v1+5EikaieJr6n/C98Xtm6WQGaVGUxwDMuzTtins6m7
         H54Aecs8SAchorDY6PM2nyM7BNcS9ol0cird5xWqIeRyCB0qer1s5ORiErMS2imhIVu8
         WviHIXbTRY7wBiXupJNH32PLneljB55l+UAf2k1hCfv8Eo3L2J+tN8pvl3uq13dxjmeK
         Cb2g==
X-Gm-Message-State: AOUpUlE6ZiD8m3dZ73+32rcQqFckOocJw5poQf7y0lQqDt9J6Rl+e58u
        AOZmofbI+14kMwAtZWB8sNsq0TeA
X-Google-Smtp-Source: AAOMgpfZDmqlImBao5YoD0XgEsSTqxmzMQq+UK5J8eLXEWF6BJMkvA4zfqoEfZZfN+SF8x14aJx8CQ==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr11308881wrg.203.1531225039481;
        Tue, 10 Jul 2018 05:17:19 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:18 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 05/13] sequencer: add a new function to silence a command, except if it fails
Date:   Tue, 10 Jul 2018 14:15:49 +0200
Message-Id: <20180710121557.6698-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
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
index 57fd58bc1..1b5d50298 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -768,6 +768,23 @@ N_("you have staged changes in your working tree\n"
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
@@ -822,18 +839,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
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
@@ -863,21 +873,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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

