Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C86F1FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756869AbdDQWIr (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:47 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36694 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdDQWIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:38 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so77635139pge.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OROs9uQ/P4zYRAr+JZrXnnGCdhOrqF5rW+xBO7owR8=;
        b=ETj/aZUrRwln60xYDh9UmJbD/rOdHANMhkwwvwOF3M0VXQlZ8AG2FgJS/3Jsq/fxtN
         TehH+Bk1vX0W96D311J/Aizx8hW8K/OwkPaZIdWa4H0AseAr2SHvQ/o3zCahMPb/XbYP
         Nsjk0EQuTR/D5HsJJZaSgPIqvo8pFgrx+m+FdyW5HvkwXQA36NlhiGmUMBQPlpw6Vr5K
         Zxe3faXGdVIus1O04qrhwn2RIDLJ72Nw3fnY8hvUG3fGeCE+yt5Hf6rm3oomAOYwexGC
         2FPJU1g9/+XohU0AbUhgKUEyOX11/+QZ4dS6kFvwLJ+4/p18ubQbNN2XRbR2tcFEvdRR
         vscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OROs9uQ/P4zYRAr+JZrXnnGCdhOrqF5rW+xBO7owR8=;
        b=kASlGf/9zw8l3suC3eYA5A82xsIUCYkpAPnD4uMJQMn/rOvMyvw3dCqNc6E40ZoUO0
         8dqNIEHXEVkEHVh2JexRRS39VpgHlAfTy125JXzh8ce/uC6jK/6JcVHCxUPMnhuqcDF/
         p9ezajLAvrE24bUHtMgroPt2VZY0dS0g7wtU5EmIb3GquzTz6TkTY9wGu98AF0dmWfAP
         e0ELC+BmRmyDUkJzf4twZsjQP1fwu6Y2jmJHQJ/noRzgeI8N1DKtSXecZ04Nu0lkZJuw
         I9O4DnohkoUb5H3kvOM0mmz2GlmyD4+W3f+zU8YfSuueheEw6WK0qbW/DszFIBAN/qXs
         6orQ==
X-Gm-Message-State: AN3rC/5zKskTvcb24ByZLbcOGehoN1VHLfen7AZ9FTqa2GZLLp90HrSp
        Joh/MidmE+abHruz
X-Received: by 10.98.23.23 with SMTP id 23mr14031878pfx.30.1492466917307;
        Mon, 17 Apr 2017 15:08:37 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 06/10] run-command: don't die in child when duping /dev/null
Date:   Mon, 17 Apr 2017 15:08:14 -0700
Message-Id: <20170417220818.44917-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2fff60a04..3aa8b7112 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,18 +117,6 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
-		die_errno(_("open /dev/null failed"));
-	if (dup2(fd, to) < 0)
-		die_errno(_("dup2(%d,%d) failed"), fd, to);
-	close(fd);
-}
-#endif
-
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
@@ -465,12 +453,20 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
+		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC);
+		if (null_fd < 0)
+			die_errno(_("open /dev/null failed"));
+		set_cloexec(null_fd);
+	}
+
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 
@@ -494,7 +490,7 @@ int start_command(struct child_process *cmd)
 		atexit(notify_parent);
 
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(null_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -504,7 +500,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(null_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
@@ -514,7 +510,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -574,6 +570,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (null_fd >= 0)
+		close(null_fd);
 	argv_array_clear(&argv);
 	free(childenv);
 }
-- 
2.12.2.762.g0e3151a226-goog

