Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382041FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbcLSX3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:29:45 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34893 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbcLSX2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:49 -0500
Received: by mail-io0-f180.google.com with SMTP id h30so166004705iod.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R0zGQI69dmKQsfTTnr73hrRwTm0jwFm0YBVa7PXKqso=;
        b=OnWPV3/aZXavsLAEYgsdoXq0cGImX8czx5quNQcNf9Fo7Co7zfPiGmcCgig8dwrgI+
         pBXZlvmksCAyiZqhvdogAxsqIGh04xdgLyoj50VphzvnD+zuC5Fe10vmWQpZyqTO7xGL
         KPmmFak24gCLEK2seMetzZBQN96SSYS0/GYR94KEGO7pJZXwq9MTKt6AC0NXg9xcUvg0
         8Aznc7/5yWn8g2ivkE52MAL3c9usNAgjfIFsoxAdPKDNeVtb3lYw9jOWaHGe43jOMnPY
         SJmx57nGFely+Inp3Z4tQESfa+ClP2ByJf3RtxUJrP6vOzyul86KUhBsuGLO49gpNpVU
         r5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R0zGQI69dmKQsfTTnr73hrRwTm0jwFm0YBVa7PXKqso=;
        b=WK5FBwSztNWIscr7IQGB/L0rjK0tE47VjpYCcfKqswdeYZREkEYh9KzdEmUNoj1n7R
         nquSM3+n/mmVGfWAqtog4u1q4EHilkmy9zDJzJhDLmEOnxPklER/qOmyQ+8dr3gWg4iG
         mDHJq3EYLydDRke8DatJSMdT1E6xj4H4PrrP1vKjoSZdnzQl8AaSBL/QQ+h2El//pxSP
         LOIOfQKpD3BTEg6qI5SMTuvtShV2VJbCW58rMpvAh1yK25xVm8ErL9BHZXwYSHRyodgj
         QsMsEpXLeDttvRrmy2Kolp4+7/1R6bnugieeopKydacwzHw7YjdIFlEzN1xx5Dou+TVK
         CTOg==
X-Gm-Message-State: AKaTC01q+CmBKy3MOfAHlp8fPjI4lYbpXhG3h8KOAaZo8XION51aDgKVzmbwZbG5oUMHExnF
X-Received: by 10.107.10.20 with SMTP id u20mr18146164ioi.187.1482190127969;
        Mon, 19 Dec 2016 15:28:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id o138sm2318115itc.18.2016.12.19.15.28.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
Date:   Mon, 19 Dec 2016 15:28:26 -0800
Message-Id: <20161219232828.5075-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to report the exact command that we run in the
error message. Add a convenient way to the run command API that runs the
given command or reports the exact command as failure.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 28 ++++++++++++++++++++++++++++
 run-command.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/run-command.c b/run-command.c
index ca905a9e80..a0587db334 100644
--- a/run-command.c
+++ b/run-command.c
@@ -279,6 +279,17 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	return code;
 }
 
+static void report_and_die(struct child_process *cmd, const char *action)
+{
+	int i;
+	struct strbuf err = STRBUF_INIT;
+	if (cmd->git_cmd)
+		strbuf_addstr(&err, "git ");
+	for (i = 0; cmd->argv[i]; )
+		strbuf_addf(&err, "'%s'", cmd->argv[i]);
+	die(_("could not %s %s"), action, err.buf);
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -546,6 +557,12 @@ int start_command(struct child_process *cmd)
 	return 0;
 }
 
+void start_command_or_die(struct child_process *cmd)
+{
+	if (start_command(cmd))
+		report_and_die(cmd, "start");
+}
+
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
@@ -558,6 +575,11 @@ int finish_command_in_signal(struct child_process *cmd)
 	return wait_or_whine(cmd->pid, cmd->argv[0], 1);
 }
 
+void finish_command_or_die(struct child_process *cmd)
+{
+	if (finish_command(cmd))
+		report_and_die(cmd, "finish");
+}
 
 int run_command(struct child_process *cmd)
 {
@@ -592,6 +614,12 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
+void run_command_or_die(struct child_process *cmd)
+{
+	if (finish_command(cmd))
+		report_and_die(cmd, "run");
+}
+
 #ifndef NO_PTHREADS
 static pthread_t main_thread;
 static int main_thread_set;
diff --git a/run-command.h b/run-command.h
index dd1c78c28d..e4585885c5 100644
--- a/run-command.h
+++ b/run-command.h
@@ -56,6 +56,10 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);
 
+void start_command_or_die(struct child_process *);
+void finish_command_or_die(struct child_process *);
+void run_command_or_die(struct child_process *);
+
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
-- 
2.11.0.rc2.53.gb7b3fba.dirty

