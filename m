Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6084F1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932809AbeGBK6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51897 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeGBK6J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id u22-v6so1267261wmc.1
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yc8XEGtHwY1fbb5GqaF9zh1kNv3GnhhlAZ7YsUGGHv8=;
        b=DK/pP8j/mDT4iCbxvfROLVf/qwMNQihMZzWOBSYadOO60xg+xEc07sHT/UMaeT+ZY4
         gYjX8lnK0VcNsb4czTHfIdIdcqD9L87D7V2vyVRLk2TwBv37Pmq6SGONONagc6dnlcmS
         d0+jwbA3iE8gBkXa/0qeZ/+l3sStu35PubNqA1J74RxK8RH/1mqiYf27e9kYvEO5Oo7E
         kK0qKbX06dNvD3E11tIyJtGPI4uQqI0ArNpPLytcT94W0F4jc8poiCV/MMw0g+NCIQmR
         8LOg1dTbmJqEUws6EA29McZvFeiZY4xpy+yn8MtU9yfxyB3pvhREE52AIHQ5tB8Nimf/
         TwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yc8XEGtHwY1fbb5GqaF9zh1kNv3GnhhlAZ7YsUGGHv8=;
        b=cMBP2Vp8RFMaJOmUFH17Sfn6aqBbFo8BI5NOOeIlljl7uegm3ACr8WMd2eCAsmTPbo
         5ZWPm7FsCaSAIRDNjZXU9YLrNSDsB4u+k8uLBClJKsIi1mE77OPp5oHF53utaftAdwV1
         DrETd9pxZF/Sai+IX0cfj+jJN+GWPRbFH7qVSogZwk7UgbISpI3ltClp25Ol5CpslvZC
         Jdk4QnpOsKSiFP/NfoJszFFzQUjiE71ugTavgCiHEOA1dgLlVnQQjl4sZJIOEfNvgVH2
         Iv9/OAJ1xV3gzcY7lSS3wUxoqpAiaN6u+8rnmve0jZ1a5eK8yUfRJ4rC2lUuofLG3+BO
         cqyg==
X-Gm-Message-State: APt69E0RSK+5FtivNv3DfLILTbXONueUrwn7yFz3Yoc9ntWGzLtEixxx
        KF7Uz5Julm+goZZXC+CNOrjfNNo+
X-Google-Smtp-Source: AAOMgpfvVrpeQW7qYTcFWzVwA0umx5Szx0yQtB87L43Ie7pefXsTA3xyOpJT5F34za+d0/gEQvHMYQ==
X-Received: by 2002:a1c:9788:: with SMTP id z130-v6mr8326259wmd.88.1530529087724;
        Mon, 02 Jul 2018 03:58:07 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:58:06 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 5/7] sequencer: add a new function to silence a command, except if it fails.
Date:   Mon,  2 Jul 2018 12:57:15 +0200
Message-Id: <20180702105717.26386-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
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
index 57fd58bc1..9e2b34a49 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -768,6 +768,24 @@ N_("you have staged changes in your working tree\n"
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
@@ -822,18 +840,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
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
@@ -863,20 +874,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
2.18.0

