Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337E41F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeGXRlg (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34507 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbeGXRlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so4795625wrt.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uuUjMSxM8yYIc16krVWYQqkBASS4YZx6H6mx/DgJzD8=;
        b=ROJR2CFMSpY09a2Ef5tC0N8DvvUXN9jP3vzAw4g2LmEBNBk44iYoscj7yXzJgSbYti
         /X8dC3yVTqFrYxfw3oq1svoDVFvppmvVUaW/CJ1yGCeHItXEYmWdZ+S/uKZIR0Otu/Bt
         0aqJ9VDrGkFOyrWiMN4NjmLKtfp85In+eUjuZ81HkKtpvPnss7rhq4wAwjsVZhmcwNkh
         U3uSxDfkN74CDuCVfqxJ+gjfS+FCC0NGLJh8jidHZ4Qf+0p3QvHhynRTidbrO6YGx/Fz
         LE3eWEcLDfgorbVbzY+XOJjObteKSSBYu3IsFrED4YH4eZq42CWcGNNs2CD/eFuLXg6q
         haEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uuUjMSxM8yYIc16krVWYQqkBASS4YZx6H6mx/DgJzD8=;
        b=ZYP6HAoJaeENJXDM5y54K1ersCnSwgtwicF8F86o8Nj1gSIHz35e6wLaw+lB9KOEuw
         qLsZ10Fkpo25DjWYaTqesik8Lgr7BillQ2udcsNvlKSeeqLOMMIWKYvWPsL+9zHTL5of
         k7Ygi6qp4UyIJtpvNEwuywf676hQkQiyEK9Z+nCG5c0RsV6pLcSbKirHqQ5QFLB/zaSK
         ByUZC+Vyaay+bnvd4AjMbIKrGX20eqdlCO7L8KoqpA0GPG3/rffRydfke83YotVhbYk7
         /pDvA4A8EJGvlNcaRizHNr6PhutmDmvzBbID4lAeWylIyq8NHklRKSKTCCUpgC/RUXyD
         D2eQ==
X-Gm-Message-State: AOUpUlF6goTPXTlbDAPNrXkBrnAwE5VBmQxvqmaI/jKxVCIFS5ow37mf
        mZSkstWtcBTPioFAPrR1zjxewTAs
X-Google-Smtp-Source: AAOMgpeAkl4mdUZBEx8t02SQ74R7E7PyShHBcxInNsXRhuxI+hjdReIRefGuc5wL3xKlaoE+KbCbdQ==
X-Received: by 2002:adf:d4c4:: with SMTP id w4-v6mr11633957wrk.185.1532450058273;
        Tue, 24 Jul 2018 09:34:18 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 05/20] sequencer: add a new function to silence a command, except if it fails
Date:   Tue, 24 Jul 2018 18:32:06 +0200
Message-Id: <20180724163221.15201-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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
No changes since v3.

 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0fc03dfe48..274cddd13f 100644
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

