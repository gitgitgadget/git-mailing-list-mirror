Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8DB1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeI1EVA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeI1EU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id o16so4254538wrx.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulBQn0Qgz+jm9nkPoH4X42WhO3aAuit6ZT3I3xAj8ns=;
        b=FxzDS2kdxxeQP17VTnTTsdJ9ZztG7nKUiLHKrkdyzB6/3v6MoT/acZz9MSQYMaanKk
         mjYtQFqx8RVCKU6UetyvsS+ZZAbRvdN9gF+AP3whr4CXCI5ATfl0nqeTVKB0DQ+1suOW
         cfPat2Qm42FKKFFbLI4fHXX/CodwixJXKI74ABvA0ZgcyX4TQofC5xGQeD0IzdFktVC5
         h40hZKd4XJHor0Xuy4JB6oK2A9xqabtmaNoEDDJAqmjOqeULYhD6CX8Ul/AhRcQ5a1DX
         2zat6mvXB7S91/ss+dJFzKb+pXWIVELqgRmEscN07oxmha0A8lh3MXGmkDx9r+C9IUkI
         68NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulBQn0Qgz+jm9nkPoH4X42WhO3aAuit6ZT3I3xAj8ns=;
        b=imX0CHSAUk8BRaQEelcS3c3u6mDEzmkSHFCXzIka6wQbyqXa7Tpkd/pABiW+YjvxQR
         Ucsw5sS3L3nmkyPpiEt5ocdH7TwGkwB5tLJkG/fNN/Sq4gP6KdQ3ICMaDjmoqdTAX3NU
         Kk8cizJr9+hCJ1LJujOprE3/ITFX4sY761HLVGlKgqdyp0xOjgkMOgZlLOT/3xrpqYcd
         UP7FFXbx4iU84kfyKKpLYMDTT2K0L4SbYtg1DGkQh8i0zrMenAiq98Q9X/9Rt/7P9Ke8
         671A6IHu8y54K56Nbq/7Y45s+CUlofYt/t9fzJlTaWZqysi3laejzOiQmt0AA4W5zTQv
         riEg==
X-Gm-Message-State: ABuFfogQcqnoH7rb0mAfAmyZsY2ER7FqhD9d+wV28HFdadGGskkyLOTt
        2ZqD91UMyU+qdfQ1b1BVidME525a
X-Google-Smtp-Source: ACcGV60R5Gpkn7AfoWpHR+swpJXjt5XihIu0fvbqXT8JXKx+Vhd+To4rgp7/LZWHTg4ne7w85hcT0g==
X-Received: by 2002:a5d:4791:: with SMTP id w17-v6mr2196081wrq.319.1538085633794;
        Thu, 27 Sep 2018 15:00:33 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 05/20] sequencer: add a new function to silence a command, except if it fails
Date:   Thu, 27 Sep 2018 23:55:55 +0200
Message-Id: <20180927215610.32210-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
The changes are due to the rebase, no real changes otherwise.

 sequencer.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c24d37dfb1..5919ad312e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -804,6 +804,23 @@ N_("you have staged changes in your working tree\n"
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
@@ -865,18 +882,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
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
@@ -906,21 +916,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (!(flags & EDIT_MSG))
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
2.19.0

