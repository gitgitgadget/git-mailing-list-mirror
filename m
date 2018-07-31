Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB87E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeGaTlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:41:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeGaTly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:41:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so4088909wma.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VJlqXLLaToEZfkz+Ze8HgRnmSA2KUZ5G/3aeQvhkYU=;
        b=Xnp4k3zRifD7EssiTvu+CY/PluuI3JE6TbPODavpQJcvgm04HftdYeEEjyq8er/TvS
         VjtJqwQL+kW0VHXk1NEScWSYJ3sbJREgZjS5EkPS8PW7DW7VevZz4oxGKWU47Q/rWC4c
         WZogj2zWxLAwXA5oXWYzXEzT8UMpc712HPCRDG7vXCIgBp6gGm20zV2btVc+OCH/h0M/
         z5M257h8vywpIui9oH/MLN8pgYzZjHjSTm9penMAUCtmygw6yEol/LzpFuFvugTYTR5P
         RvLccyogH1QEBvjPOSvs8ydYMDOPS+EvnHcEpJQvpBfe6aXk03P//MpzJfU7Ux0LiCj5
         Ijfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VJlqXLLaToEZfkz+Ze8HgRnmSA2KUZ5G/3aeQvhkYU=;
        b=CCtCKBbZ6GytmG/cyqA7EMr7q/qLr0s8WRUAXmSFVHaA4YegVjkN7mGm9qcqDUpluL
         g7vSZ73B7lUMcnkJbhCFezw0d63zrfwsEmU82KruixDwUs+rObp46rfKvD7efwxD0jmK
         ju6VufVpUpLpP4s2u8q4vmnmboe7C9hrSQZny8e+3D/G0CttQdbFt6RWtijiKG212lFA
         AkA4rxyyVdBnpPZEuTY8Z3JndCBwMcEyZaPks7ttMNcqTmXxWGCroJTTuVVYmID3lBnr
         94o308IpqQFzsaOCqXPqhNqmXwCEXkQh0uDIh+kT3nV8dljH0WoTionISOptMrslCPLq
         idLw==
X-Gm-Message-State: AOUpUlHSLm+lnLbgw65sayZhkGdkf4gjvf4Im0MpQoVeSwl6/8LKDsxL
        uWZ9NUdAjG1l4GR/6IHX/DSzgtoZ
X-Google-Smtp-Source: AAOMgpcMiIlk5pIMKpkMXaZ/xL5yyy3usLPT+6l3xsAE9USxgRz3+HBL3E039S5vkBXEz+PkmgU84Q==
X-Received: by 2002:a1c:f611:: with SMTP id w17-v6mr438493wmc.143.1533060026146;
        Tue, 31 Jul 2018 11:00:26 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:25 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 05/20] sequencer: add a new function to silence a command, except if it fails
Date:   Tue, 31 Jul 2018 19:59:48 +0200
Message-Id: <20180731180003.5421-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
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
No changes since v4.

 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8eff526584..6d87f5ae6a 100644
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

