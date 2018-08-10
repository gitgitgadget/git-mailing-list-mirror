Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7541F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHJTXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39117 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so8856682wre.6
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG9U9k/cz7V/trJRMEZkPVkZ4hIAEJcpsg/kgJqFVhQ=;
        b=o17AwAPmvYhTIqSk/ADR0lJ9ZqS2lWSheXy+KkEmtthsWImZ2qGdatw0hz3++hHdVZ
         8Ug9yFRcbGkbGIRhwR7vgjdrfD16hSmIAslqJY1LJATHpgV5p9zgwsWNmLdEgf8ZGkb/
         vCgckHBqJRaie9XhOQHukoqaNefUX1YlsRQ2U0JevIt2efNVSlcTIkyw473KNZZSLAcL
         vFwFwcIdQr/WdZqfDCASqflO5ytTqXFxd1q5FWsFlt7K8fVtT7zXEPBWs/w8hoe8f/vA
         ikxOITQYIm/h7WMLwTBiT5LHTzb3sik6JRw29TpQNe9D8cR/K5du07kktUBkG2iMcm6b
         2zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG9U9k/cz7V/trJRMEZkPVkZ4hIAEJcpsg/kgJqFVhQ=;
        b=a88KWXemz7d/E2l2j028zRruEgMH4YK0QuFYO38ETCU65Isg1h3BOKnMy/0DXg0Zqy
         pOcYXPdWntbwHlHVadKFRcpzVnNP1gYDIw7H8tbe3UeeM2JTV6hQWyZ6Sg8JRbBPI63y
         COdX6/oRLR7zGKcC2fslmnj2lYU/yYFoq51BrxqxAbC96HJ9i02veziSTdNXJCvHygqw
         oW0/2igB+/fyataCsH4jpBXqmwYQC4PXj8YVtb/L3pxKexaqwTmII2gLnwOoIQaUhAL0
         EkTXK6rRaqo2PGvCy0NMKYlKyDQ/FTgH/qI1I+KLrw170HQVcVMls37WRMIU5AQk6stJ
         8M/Q==
X-Gm-Message-State: AOUpUlGNyurcFqFaekrzm2cZBHxvZBfdHxQVz75rglqmrYWLkbNzIYkD
        L3+2fSNAVVweOUFd4/10ZgSTvcNw
X-Google-Smtp-Source: AA+uWPyvnaOYZc8rMe7xWeL3p6lyF7EAP2WhutMCTB/XQ6yOtizNtM8euGQ7j8laO8Z/E5MVXD9ijA==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr4879451wri.205.1533919942165;
        Fri, 10 Aug 2018 09:52:22 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:21 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 05/20] sequencer: add a new function to silence a command, except if it fails
Date:   Fri, 10 Aug 2018 18:51:32 +0200
Message-Id: <20180810165147.4779-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
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
No changes since v5.

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

