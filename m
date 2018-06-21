Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EAB1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeFUOaz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:30:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36850 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbeFUOax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:30:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so3460770wrm.3
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4EfTbNuxWPp0W5PIrCmCci8Xy/FD4Wv+Ts2OrZwNYw8=;
        b=KR4mxk3Kn1HTj++95Am0nUs9eWNickUMXQZ7r/yTMZvugECXtjWztQ00IfYUCI+qd+
         BrMfpMawig+ogkvufjY6mhleYW9tqPETKGUQ4jDiKDjR+64Ui5iUqsRN+Xf6ihhdvafE
         jPQtPphLPGcAVfMTzs63YVH3ctClW+x2VK5A7S74jIMPJEZOKeMV3gWzvCf5zL3u2gq1
         tD3PtXHHJGky6U8+w70yJhMjK7tGlQwutX1X5PDzHhYo7K4NhojxrrHOQ2O54eKjbJP1
         sgb034QLXu7oYXChNEevvpmAyJomBJsej9ELClmd5InZafbvS70F0XMSYFzEZJgT8Wbb
         wpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4EfTbNuxWPp0W5PIrCmCci8Xy/FD4Wv+Ts2OrZwNYw8=;
        b=YJHvGTHpd8fcW5FJFnN1Y+iv54uQgS4Xo7NzNsLdmwgE6oYo0bW7z+tJb7DOFe3wO7
         N/w3WrmE/V8p4M1Jh7DxrGQZAOfXehfwS+/kS6igQswYTqtZnCPf8LZZHyDaqHhjzgCC
         0KGS0S+kVxSsBWaHEninGG0kx/sPsx23cbNK+SRuzII6yrKZB4HhPBgy3DXQGZBvYlU5
         awY02l3BIub+INMZGnTwyLJ5XXrzsbt92vi/3b9jW2E0gOs2Md76V9iuohJXt25nbdSm
         UMj/yORgA0MddPRhvOA5oaYeUIRyT/G98d2/6ArBrlZzIWev08RFT0LO3mGIRLJjbfOa
         LUXQ==
X-Gm-Message-State: APt69E3YomPw6x7wIi7XKq555/Lg7kKX7ZIXorwo94jXi8+YbBxvVqYi
        lLSkwnet/RTTg/WKifpBw2Ans1+J
X-Google-Smtp-Source: ADUXVKLzJX8wk1jQhymbuAAi5H1zom7YPzqHEqHRjVPh3/gIVApgqTsOgQJc3WY/cV4ZE/H4eUJD6Q==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr22421075wrc.40.1529591452086;
        Thu, 21 Jun 2018 07:30:52 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm1333591wrj.73.2018.06.21.07.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:30:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 1/3] sequencer: add a new function to silence a command, except if it fails.
Date:   Thu, 21 Jun 2018 16:17:30 +0200
Message-Id: <20180621141732.19952-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621141732.19952-1-alban.gruin@gmail.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com>
 <20180621141732.19952-1-alban.gruin@gmail.com>
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
 sequencer.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7cc76332e..51c8ab7ac 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -766,6 +766,24 @@ N_("you have staged changes in your working tree\n"
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
@@ -820,18 +838,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
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
@@ -861,20 +872,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
+	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
+		return run_command_silent_on_success(&cmd);
 	return run_command(&cmd);
 }
 
-- 
2.17.1

