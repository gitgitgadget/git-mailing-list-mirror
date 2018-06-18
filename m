Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E291F403
	for <e@80x24.org>; Mon, 18 Jun 2018 13:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeFRNTM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 09:19:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35015 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFRNTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 09:19:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so15600538wme.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfgN0Z/E4y7NLfY4rk++EHapdB4AwyOowIF5EsErtbM=;
        b=txOWjEF89C8TxUV0+oEZEJlhOeUcEkuJ7Qva805FtZFhXBx6xS8zDMNGqOExZpEIb2
         XQELJE/etm5RnD0iaK4nCxjvH7NmD/3pKM8C3v3JMT2qDmWpVua2ntbR6WW/1FWfqd+I
         22igkzPqEwbtzx9+Ijs1O+ZzXa5IYezHu8jD2/c5+oZXqnPS3kQI9EwzkeU8/TQ/Tvcl
         8iLI4pDWK/qIgluwJx+sRqC3GvTZqOw12iPMvt8amGmS2CD/0o6UG+cNuAk7XRWDCnLn
         48Dqg+VnuD3JIpPonMarrAHpgUzIwMOhkxmWPh70+YBor+wHWDOSb9RPuvZzZYYYikRU
         BVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LfgN0Z/E4y7NLfY4rk++EHapdB4AwyOowIF5EsErtbM=;
        b=TK4DvYsVYiqrhXlXItE3o9j/VGTGu3bAykPlq8Rz5e7yvvKZRvuLHwyA8Pevi4zkOi
         T4ezON3Aeuq8QiAqje6uZLjiHDl375w6pKgkiYGGB5Wwgy7d3ScqNyN2rmxuERDglLSO
         0c/l/evlgPFXZdPe5bV5b18z04RZeXSngtATaisHZ/8LsXALCIs33IhmjVY0Q4gyAmf1
         fuPO1PWO2rzbn5v10cs0OLeliFlGIXbTvbU6ZOdc8zqLy89nHIDMLzbY1WiPRnmu66yj
         yE3CuLFAU/9k9yio1QacmNXdnLJl6kLh6zqXV084X/GtF9opsXg8UEus4ejJrbFctLS+
         ba6Q==
X-Gm-Message-State: APt69E3tIFs7qj81Bpo1UL2DqT8Z8cAVojAzBkLkz8mbFKR4RqTs2oz0
        x2vrbgiTegjqT8FQ+NcFS1xWlXZy
X-Google-Smtp-Source: ADUXVKJJfvdmRkqkxq87IKhpz7Kt0hLgN9FpjqfbVTdFvxl1Cnv0eVPiZECQeSy5gMvusvfjpBhHrQ==
X-Received: by 2002:a1c:e8c:: with SMTP id 134-v6mr8924305wmo.51.1529327949442;
        Mon, 18 Jun 2018 06:19:09 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id c10-v6sm14230575wrs.6.2018.06.18.06.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 06:19:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 1/3] sequencer: add a new function to silence a command, except if it fails.
Date:   Mon, 18 Jun 2018 15:18:42 +0200
Message-Id: <20180618131844.13408-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618131844.13408-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new function, run_command_silent_if_successful(), to
redirect the stdout and stderr of a command to a strbuf, and then to run
that command. This strbuf is printed only if the command fails. It is
functionnaly similar to output() from git-rebase.sh.

run_git_commit() is then refactored to use of
run_command_silent_if_successful().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7cc76332e..3437673d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -766,6 +766,25 @@ N_("you have staged changes in your working tree\n"
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
 
+static int run_command_silent_on_success(struct child_process *cmd)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int rc;
+
+	/* hide stderr on success */
+	cmd->stdout_to_stderr = 1;
+	rc = pipe_command(cmd,
+			  NULL, 0,
+			  /* stdout is already redirected */
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
@@ -820,18 +839,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts)) {
-		if (!(flags & EDIT_MSG)) {
-			cmd.stdout_to_stderr = 1;
-			cmd.err = -1;
-		}
+	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
+		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-		if (read_env_script(&cmd.env_array)) {
-			const char *gpg_opt = gpg_sign_opt_quoted(opts);
-
-			return error(_(staged_changes_advice),
-				     gpg_opt, gpg_opt);
-		}
+		return error(_(staged_changes_advice),
+			     gpg_opt, gpg_opt);
 	}
 
 	argv_array_push(&cmd.args, "commit");
@@ -861,21 +873,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
2.16.4

