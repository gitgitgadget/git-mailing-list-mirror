Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D531207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S948193AbdDYXrP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:47:15 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33651 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033520AbdDYXrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:47:13 -0400
Received: by mail-pg0-f48.google.com with SMTP id 63so35216926pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/Mf66WgYJ6LxRhdPpcLOzWifMeZNv/dOfBgvq4fUYg=;
        b=EaOVDLyvJ5XLFhSrgFUayWfPiekH0ioobHDZYbq8RKy6uFkI/3p7R6/qxnt6zCeWeT
         d6+2Ybdfp+4JYyTFNmlEuUjG+lIdZXkLOZXhauS6SyPxsghmHQQkJ144EGAjaYwL2qXZ
         116Q1Sxn1pLfk/Ge282F1A7Io0aE1Souqv4Z3KNuwgGb+yXSyLNMGuT/JYbweA7ntlA8
         gI8xHy4Ipt+lR+zUHW/dDtWZLVjQkeQBJw94CLhMJEaMHZH0bLucW8kVcX7iwp2bCWyV
         uabCygqV3yjm3tEa3Nqg8lm1KYBft2ESGEFW37h7/OBbgHoXeHYBjvbc2abIoN/9BfPD
         79wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/Mf66WgYJ6LxRhdPpcLOzWifMeZNv/dOfBgvq4fUYg=;
        b=c9v1Sua9tAvPWV5C/INE8EAsTArZNpEmqeJDxJLEKMBfutcYMUi9+fYcurSyIr4oQM
         EYcRSs+bDqRtvmXEQuw1R2RbopP/ubYdYY5FBAkhbtI1YhPIRH4X/wB06VXi0hS/X1qz
         fyIwyxl1YYTEhX/Y1wVV6RBfP1DsVhddprBg0F05vnK4NxCeqDwoRSaBpnJ1UasTaUsc
         ICB2AW4PiHjffGZnNnnGgW/jRp3u1ys6AuhKAQPtOcHcOfb6xkQmpn+6VC2CwktimpbG
         sLY4FxQN/Q/Cv1F/xaoiLnhqeBckb9K2Q9z1E88lupD0/Uu6bPQQPho7HExty+8uBkDx
         8Y6w==
X-Gm-Message-State: AN3rC/5Npa4WXmrjNkyjLN0a7ZrNOkUgX+1gZbM5JUb3koFB8ipKQyDB
        TOdr8bacgjxrrH2d
X-Received: by 10.84.218.142 with SMTP id r14mr39953606pli.54.1493164032200;
        Tue, 25 Apr 2017 16:47:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i30sm8802671pgn.39.2017.04.25.16.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:47:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v8 1/2] run-command: expose is_executable function
Date:   Tue, 25 Apr 2017 16:46:59 -0700
Message-Id: <20170425234700.194277-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170425175446.113553-1-bmwill@google.com>
References: <20170425175446.113553-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic for 'is_executable()' from help.c to run_command.c and
expose it so that callers from outside help.c can access the function.
This is to enable run-command to be able to query if a file is
executable in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 help.c        | 43 +------------------------------------------
 run-command.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 run-command.h |  1 +
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/help.c b/help.c
index bc6cd19cf..0c65a2d21 100644
--- a/help.c
+++ b/help.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
@@ -96,48 +97,6 @@ static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
 	string_list_clear(&list, 0);
 }
 
-static int is_executable(const char *name)
-{
-	struct stat st;
-
-	if (stat(name, &st) || /* stat, not lstat */
-	    !S_ISREG(st.st_mode))
-		return 0;
-
-#if defined(GIT_WINDOWS_NATIVE)
-	/*
-	 * On Windows there is no executable bit. The file extension
-	 * indicates whether it can be run as an executable, and Git
-	 * has special-handling to detect scripts and launch them
-	 * through the indicated script interpreter. We test for the
-	 * file extension first because virus scanners may make
-	 * it quite expensive to open many files.
-	 */
-	if (ends_with(name, ".exe"))
-		return S_IXUSR;
-
-{
-	/*
-	 * Now that we know it does not have an executable extension,
-	 * peek into the file instead.
-	 */
-	char buf[3] = { 0 };
-	int n;
-	int fd = open(name, O_RDONLY);
-	st.st_mode &= ~S_IXUSR;
-	if (fd >= 0) {
-		n = read(fd, buf, 2);
-		if (n == 2)
-			/* look for a she-bang */
-			if (!strcmp(buf, "#!"))
-				st.st_mode |= S_IXUSR;
-		close(fd);
-	}
-}
-#endif
-	return st.st_mode & S_IXUSR;
-}
-
 static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
diff --git a/run-command.c b/run-command.c
index a97d7bf9f..2ffbd7e67 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,6 +117,48 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+int is_executable(const char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) || /* stat, not lstat */
+	    !S_ISREG(st.st_mode))
+		return 0;
+
+#if defined(GIT_WINDOWS_NATIVE)
+	/*
+	 * On Windows there is no executable bit. The file extension
+	 * indicates whether it can be run as an executable, and Git
+	 * has special-handling to detect scripts and launch them
+	 * through the indicated script interpreter. We test for the
+	 * file extension first because virus scanners may make
+	 * it quite expensive to open many files.
+	 */
+	if (ends_with(name, ".exe"))
+		return S_IXUSR;
+
+{
+	/*
+	 * Now that we know it does not have an executable extension,
+	 * peek into the file instead.
+	 */
+	char buf[3] = { 0 };
+	int n;
+	int fd = open(name, O_RDONLY);
+	st.st_mode &= ~S_IXUSR;
+	if (fd >= 0) {
+		n = read(fd, buf, 2);
+		if (n == 2)
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
+				st.st_mode |= S_IXUSR;
+		close(fd);
+	}
+}
+#endif
+	return st.st_mode & S_IXUSR;
+}
+
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
diff --git a/run-command.h b/run-command.h
index 4fa8f65ad..3932420ec 100644
--- a/run-command.h
+++ b/run-command.h
@@ -51,6 +51,7 @@ struct child_process {
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
 void child_process_clear(struct child_process *);
+extern int is_executable(const char *name);
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
-- 
2.13.0.rc0.306.g87b477812d-goog

