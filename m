Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F54920986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbcJDNA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36451 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbcJDM75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:59:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so19579838wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oAd0zkwN7G1S3Q+id4ZS/GuBCUvVFy0XQYfq6kfV6EM=;
        b=vUtwYauSs5+BNzW18XmJ/Pnbkshczla5SxeFvylCOMB4OF9nsaFv7oADQVKAonE97i
         +ZPq7iDRULoa5OlcmPawj09Dm+CxH8UpKAdKPHIjDLubwe4dP4HbVu6+o383UxztzPS8
         lmyen7zx5jzLIZbc1g0IFvgJ8gz4GBVNUcLgSNW5+D1rp/nDYCdHLmc7Tk8WazYT+G+P
         EdndciKzrcWfK+z14YUn5U6b6iY0k/GbQjv/pJncfNibw+owhG6mHtUPPewCsYpBtqIr
         /tImacUePl45xc361SWIvpxfiiEbzGOO1HTn2LVPTJNBekLsdGY95LobCyTqv9i4bXdX
         nxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oAd0zkwN7G1S3Q+id4ZS/GuBCUvVFy0XQYfq6kfV6EM=;
        b=haVSiKtTQZH7Ka5EBu5XRFjjyke/h4r+gkj6nXgPoXnWi7xHXRcF1w78S2v8hqkS6A
         XWkaaOXtBsdkeVT0N90wqT/Fb/0mihbhMv8KS3pseH/z8oN7YOjb7MyY5eZDy04ok9fc
         gF33ugKfhwFn8ieTAH0T3ckT+JcOz9muroQJir8sL3BWIpLh+A1MWKYhbaWH+s5IU3jW
         kwwbXLb4x9ybp+9hw7Us6xYoW530KVQOohl02G/Q9Ld4U4jB/zlkd4aGTMPWCY5XRIDn
         pszaVsXsoM76LlCTlXoX1OhDCERfNBPA57XZ6yVROXnHC3he6q8cfdPoBR2GflrZoAtB
         cUWw==
X-Gm-Message-State: AA6/9RnYBbDK/cKRzha5Ak60ApqMb+0snHuq+69GiBxRwJGl+71yplq/HDxi4xII9LDHiA==
X-Received: by 10.28.191.85 with SMTP id p82mr9840995wmf.33.1475585995387;
        Tue, 04 Oct 2016 05:59:55 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:54 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 04/14] run-command: add wait_on_exit
Date:   Tue,  4 Oct 2016 14:59:37 +0200
Message-Id: <20161004125947.67104-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The flag 'clean_on_exit' kills child processes spawned by Git on exit.
A hard kill like this might not be desired in all cases.

Add 'wait_on_exit' which closes the child's stdin on Git exit and waits
until the child process has terminated.

The flag is used in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 run-command.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
 run-command.h |  3 +++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3269362..96c54fe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,9 @@ void child_process_clear(struct child_process *child)

 struct child_to_clean {
 	pid_t pid;
+	char *name;
+	int stdin;
+	int wait;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -28,12 +31,33 @@ static int installed_child_cleanup_handler;

 static void cleanup_children(int sig, int in_signal)
 {
+	int status;
+	struct child_to_clean *p = children_to_clean;
+
+	/* Close the the child's stdin as indicator that Git will exit soon */
+	while (p) {
+		if (p->wait)
+			if (p->stdin > 0)
+				close(p->stdin);
+		p = p->next;
+	}
+
 	while (children_to_clean) {
-		struct child_to_clean *p = children_to_clean;
+		p = children_to_clean;
 		children_to_clean = p->next;
+
+		if (p->wait) {
+			fprintf(stderr, _("Waiting for '%s' to finish..."), p->name);
+			while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
+				;	/* nothing */
+			fprintf(stderr, _("done!\n"));
+		}
+
 		kill(p->pid, sig);
-		if (!in_signal)
+		if (!in_signal) {
+			free(p->name);
 			free(p);
+		}
 	}
 }

@@ -49,10 +73,16 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }

-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int wait)
 {
 	struct child_to_clean *p = xmalloc(sizeof(*p));
 	p->pid = pid;
+	p->wait = wait;
+	p->stdin = stdin;
+	if (name)
+		p->name = xstrdup(name);
+	else
+		p->name = "process";
 	p->next = children_to_clean;
 	children_to_clean = p;

@@ -63,6 +93,13 @@ static void mark_child_for_cleanup(pid_t pid)
 	}
 }

+#ifdef NO_PTHREADS
+static void mark_child_for_cleanup_no_wait(pid_t pid, const char *name, int timeout, int stdin)
+{
+	mark_child_for_cleanup(pid, NULL, 0, 0);
+}
+#endif
+
 static void clear_child_for_cleanup(pid_t pid)
 {
 	struct child_to_clean **pp;
@@ -421,8 +458,9 @@ int start_command(struct child_process *cmd)
 	}
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
-	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+	else if (cmd->clean_on_exit || cmd->wait_on_exit)
+		mark_child_for_cleanup(
+			cmd->pid, cmd->argv[0], cmd->in, cmd->wait_on_exit);

 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -482,8 +520,9 @@ int start_command(struct child_process *cmd)
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
-	if (cmd->clean_on_exit && cmd->pid >= 0)
-		mark_child_for_cleanup(cmd->pid);
+	if ((cmd->clean_on_exit || cmd->wait_on_exit) && cmd->pid >= 0)
+		mark_child_for_cleanup(
+			cmd->pid, cmd->argv[0], cmd->in, cmd->clean_on_exit_timeout);

 	argv_array_clear(&nargv);
 	cmd->argv = sargv;
@@ -765,7 +804,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}

-	mark_child_for_cleanup(async->pid);
+	mark_child_for_cleanup_no_wait(async->pid);

 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index cf29a31..f7b9907 100644
--- a/run-command.h
+++ b/run-command.h
@@ -42,7 +42,10 @@ struct child_process {
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
+	 /* kill the child on Git exit */
 	unsigned clean_on_exit:1;
+	/* close the child's stdin on Git exit and wait until it terminates */
+	unsigned wait_on_exit:1;
 };

 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
--
2.10.0

