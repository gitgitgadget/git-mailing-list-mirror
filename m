Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D5EC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjIGPvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjIGPsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:48:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1944B3
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:39:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso1036424f8f.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101122; x=1694705922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ9Eq086cLE75lvhn74irYyePCajQzRVpacKkuDvfCg=;
        b=i84ROzvtpH4pr7kYp6iPrW1v1upPPf3qRD7RbPQTWn5qiJkv0h8+5xVjmGnP9+3EKq
         v7laNSIs0sMW7TSnOxLHNj0h8XjAtWa+TqDuPCX8iMOnbB+AnObTYZ2YFxATa533LCEg
         Tqk5WEntq4uytm5eSWf6Not5aYCPBC4XqDXGs/gMMeUAh3gdgRvEqHMlQApzTzwcuiCC
         7cLSeu7OW6yTORt4kFrs2QKjq/yrbCQ86Qhdf7omI9OenPMcpVHqtA8yDs4p6tnDjBqp
         G0Btz1ZCXsRNIwCpmu3MQAttaneDwCQOrXdeBzMuf8gGkMvLssQ82K+OBPQJCeEpwlHM
         Hq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101122; x=1694705922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZ9Eq086cLE75lvhn74irYyePCajQzRVpacKkuDvfCg=;
        b=b1Z5UcnpEMMtBpVIqoIe4sXjDFuNCd7j33WDS3EzatVFQ2xYVpJHkRXxFwBeJbel6l
         jniK5GwujMBjuDNjyRoPPlu3LXOxzhBRBQaUB1SxxNygKCotWZlRhte3DBvEPyuK836v
         w+pccvbTSKyY72tzpG4fUbH5HtegDtzp8J7J0MUnldmexzZcyXxj4hPMc6Z0SjDmk2t+
         jpBlv4U8lnCBMZtpZVPPRxer/94xhjHHwe3WFeMKNLST/XUM+LJ8XG3oH+bXHIkWMIFd
         Tjws+aohq2AlnIXDxkyzSJgWssS+cRIvWvoLpQCLZNYevjErde4hmS/4EyM3TUoMYu+H
         WflQ==
X-Gm-Message-State: AOJu0YxPWgc5YORS1QNKXnwg87cfD7sk9byijWvgXlrm1LLhaW33z0XX
        MzOVSy8+TcHzf3w783V580h73S365M0=
X-Google-Smtp-Source: AGHT+IHoRYgARinzRVpiuk2pBXhuxTuyq8CAX/zjSgNnJzZ167S45Dqgs9B5UYteVpOR9Axt9O+ZJQ==
X-Received: by 2002:a5d:61c3:0:b0:31a:d551:c2c0 with SMTP id q3-20020a5d61c3000000b0031ad551c2c0mr4038581wrv.57.1694080983805;
        Thu, 07 Sep 2023 03:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020adfe704000000b0031c5e9c2ed7sm22899332wrm.92.2023.09.07.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 03:03:03 -0700 (PDT)
Message-ID: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 10:03:02 +0000
Subject: [PATCH] rebase -i: ignore signals when forking subprocesses
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user presses Ctrl-C to interrupt a program run by a rebase "exec"
command then SIGINT will also be sent to the git process running the
rebase resulting in it being killed. Fortunately the consequences of
this are not severe as all the state necessary to continue the rebase is
saved to disc but it would be better to avoid killing git and instead
report that the command failed. A similar situation occurs when the
sequencer runs "git commit" or "git merge". If the user generates SIGINT
while editing the commit message then the git processes creating the
commit will ignore it but the git process running the rebase will be
killed.

Fix this by ignoring SIGINT and SIGQUIT when forking "exec" commands,
"git commit" and "git merge". This matches what git already does when
running the user's editor and matches the behavior of the standard
library's system() function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: ignore signals when forking subprocesses
    
    Having written this I started thinking about what happens when we fork
    hooks, merge strategies and merge drivers. I now wonder if it would be
    better to change run_command() instead - are there any cases where we
    actually want git to be killed when the user interrupts a child process?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1581%2Fphillipwood%2Fsequencer-subprocesses-ignore-sigint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1581/phillipwood/sequencer-subprocesses-ignore-sigint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1581

 sequencer.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a66dcf8ab26..26d70f68454 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1059,6 +1059,7 @@ static int run_git_commit(const char *defmsg,
 			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	int res;
 
 	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
 		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
@@ -1116,10 +1117,16 @@ static int run_git_commit(const char *defmsg,
 	if (!(flags & EDIT_MSG))
 		strvec_push(&cmd.args, "--allow-empty-message");
 
+	sigchain_push(SIGINT, SIG_IGN);
+	sigchain_push(SIGQUIT, SIG_IGN);
 	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
-		return run_command_silent_on_success(&cmd);
+		res = run_command_silent_on_success(&cmd);
 	else
-		return run_command(&cmd);
+		res = run_command(&cmd);
+	sigchain_pop(SIGINT);
+	sigchain_pop(SIGQUIT);
+
+	return res;
 }
 
 static int rest_is_empty(const struct strbuf *sb, int start)
@@ -3628,10 +3635,14 @@ static int do_exec(struct repository *r, const char *command_line)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int dirty, status;
 
+	sigchain_push(SIGINT, SIG_IGN);
+	sigchain_push(SIGQUIT, SIG_IGN);
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	status = run_command(&cmd);
+	sigchain_pop(SIGINT);
+	sigchain_pop(SIGQUIT);
 
 	/* force re-reading of the cache */
 	discard_index(r->index);
@@ -4111,7 +4122,11 @@ static int do_merge(struct repository *r,
 				NULL, 0);
 		rollback_lock_file(&lock);
 
+		sigchain_push(SIGINT, SIG_IGN);
+		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = run_command(&cmd);
+		sigchain_pop(SIGINT);
+		sigchain_pop(SIGQUIT);
 
 		/* force re-reading of the cache */
 		if (!ret) {

base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
-- 
gitgitgadget
