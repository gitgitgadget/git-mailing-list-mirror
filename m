Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7D21F442
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeH1QCc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38140 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1QCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1758815wmi.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1JPkXgc68JV4h06PnD+l4TtgQLxb0Xf9rhqAcCzC3k=;
        b=tpnavgsgbFbpauYBytTM7FOrRQKzQp6CnYC6PA9KfIXXhMgDut54PODQ2/X89NdXJh
         w+IaUL+8M3ad4L2L2HMIyG0pzTi5YnDbtJZ50tVi0gjg/m+l2OXJifjURsE6lf4ppwGF
         Sy7ZHDBuvLA3AsFp27Yw8gRsKJELNFCcRseIPI6xAY3Fub3JqJl9aGFLCt3H4Y2b2Sqc
         GfcZiDzuBwMta/SAIj0PuaZHFlamjGdO6PtsdtEPjQmARq7YxAJUxJd1JAI5pXeLeVuf
         UYkbKUBorWz41c5MdHX5hpqJ22uyH66mJpFRGPpTGf0eTBwZEgXzC0lUiaIkI/Xo3z8H
         jzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1JPkXgc68JV4h06PnD+l4TtgQLxb0Xf9rhqAcCzC3k=;
        b=LvyvW6jC60S1RpE5MGPCMTSA2Di7zl9uA6+MFc6Y3b9lDmE+lnYA735jrzbE0ko7cD
         TUJspI7L2/K7xtjH0SJWJs2pMsrzJU7Kk2Mrqk8CDl/EZ0Qx0KUs0hF2uRRAajADtKnG
         0nFWVTBoxfM4kFjmFAVWzOZ8Uv7wJkWN7ALeC+xnbB3cdX+QOpt4xwD/zkRuFnz+4fqH
         98mpwaXbvo5+NQeyi75/sGZa6laX4MqjSmw9x7jC7BA7KBB8eTbkKUiRleQHf3JokQ3t
         fxNj9Iryrewi9yISsKBNBwPb3pGzBpIrktYlYm1erBwX/O0ub/IvrmVpKO2hlAshQwFk
         ZxQA==
X-Gm-Message-State: APzg51BxnME/+780DEd342Ejo3dPKh+HANSCMFTwjHgHVB4nZceuPzlM
        7dyjINgCNzs4fnwANfsAL8VVy5eP
X-Google-Smtp-Source: ANB0VdagP6QUxRTPizMch4K2LasICdEW03ZZx2R+aCxulnvHl5F0+1ysJEIsirD4hsoopC++We8GMg==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr1113432wmf.25.1535458269022;
        Tue, 28 Aug 2018 05:11:09 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 05/20] sequencer: add a new function to silence a command, except if it fails
Date:   Tue, 28 Aug 2018 14:10:30 +0200
Message-Id: <20180828121045.14933-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
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
No changes since v6.

 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dd1b060863..eaa1aa7deb 100644
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

