Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22381F516
	for <e@80x24.org>; Mon, 25 Jun 2018 13:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755590AbeFYNos (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 09:44:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46840 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbeFYNoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 09:44:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id l14-v6so8686723wrq.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHLAcMxBep0ucJEhBPtn4hOjfc2grF4qfVetfK8mK20=;
        b=XcCf7cgcrAntCgw8etK98/JqelJkZxvXU6JqgD7PUkkiK3hFGIbj/97cTq2eXtYP7j
         Exm43eHsYp/Dn2ol5ZCIiv1paZUDxaf2CRPTzjkw4I7TAaQ7PHUci+xKvnywvldwBHiI
         DXR+EbtvJp+JQd6Mm5Gp5VRABjq/B9hNQ0U1l3vIewjBXk01+30w4Vh8E7KFuLfAMKXM
         G8IdPEh1gPaN/abKtsk8fXtfCxFtPuSpCiB9u735zIhqp1lDEoN68yJ+I/iElTkcByXx
         aNJ24XDL7nX/3f0GR2P1p8wvhIe0wLWI6jszCLpx/iGM9QX1WMdB25OWF33BWE+oLvdy
         TijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHLAcMxBep0ucJEhBPtn4hOjfc2grF4qfVetfK8mK20=;
        b=F625RDCkBFwEzeKKzgw8Q23oXFwXnwI/GCRHcpC2MANKikUeao+iUC3XN9w55irJFK
         2MJBg1Q0JAvUrX+NE85jxmifvdIcrRHOASFz/2bcWJheQp8sajIQSo/dzOj+vGA+98PB
         IicWJtek6GrlZXNzuUeIQkeZWNtr+IURdBLlE2ygOE0NpGeAwx8v4GVuyKwdqzQ3yWj4
         XG4sFwM1grBI+4w5Rsf5fCG1E2/wnqyhxqK8UcfMVcQyyfJJ99cNV0w86V01ahiHStGS
         uzvQb5R6uJNc3Ufh4jYeuPYUJyGA1dcSiTZyyzLVr2yeKgbw8nzG9N7aLVmhmguoV0Ey
         DnWA==
X-Gm-Message-State: APt69E3E/MIp9E1Pnp1vGeWt1ieuZeBfRKeq2ttso9tNzXJrCjFF65hg
        9ZYp5lLnST5AUXGRiwdIVO4pA4WE
X-Google-Smtp-Source: AAOMgpe0q9vu1UgJXBQuGJCbhytRIMS178nAi+23avGNmTYiYKFJAkeih0oQ9yVvejcoWzlDgiV2ig==
X-Received: by 2002:adf:acc3:: with SMTP id o61-v6mr10647789wrc.34.1529934285212;
        Mon, 25 Jun 2018 06:44:45 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id 13-v6sm11020369wmi.2.2018.06.25.06.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:44:44 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 1/3] sequencer: extract a function to silence a command, except if it fails
Date:   Mon, 25 Jun 2018 15:44:17 +0200
Message-Id: <20180625134419.18435-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625134419.18435-1-alban.gruin@gmail.com>
References: <20180621141732.19952-1-alban.gruin@gmail.com>
 <20180625134419.18435-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extracts the part of run_git_commit() that redirects the stdout and
stderr of a command to a strbuf, and prints it if the command fails, to
a helper function: run_command_silent_on_success(). It is intended to
replace output() from git-rebase.sh in the rewrite of
setup_reflog_action() and checkout_onto().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7cc76332e..9a9725e23 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -766,6 +766,23 @@ N_("you have staged changes in your working tree\n"
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
@@ -820,18 +837,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
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
@@ -861,21 +871,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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

