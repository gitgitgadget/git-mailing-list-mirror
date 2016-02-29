From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 07/12] run_processes_parallel: rename parameters for the callbacks
Date: Mon, 29 Feb 2016 11:14:05 -0800
Message-ID: <1456773250-5510-8-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTHK-0005nN-0f
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbcB2TOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:32 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36857 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcB2TO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:27 -0500
Received: by mail-pf0-f171.google.com with SMTP id t66so31167624pfb.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xWp3XAjwaKNilPNmlsHgxZFzms9rfwhwuANU8MZ4Ta0=;
        b=G9zOkMjpQ1AFcpMSozdmph4G6DbaQxJ01zQMm7vWPR09zT2oaT3l9WnxYRzwBYoZ6U
         t29T+lri+jXVaqie5Gq1jBOJXv0t5YyHisRE9MQKyG6abnPgDcWh8s/Kah9nzHDGeZzO
         AKsDYNturJ0Igy3fTFmIRxXYhuj4bNjnKmYqso1bqfyLCSbFegpgtWPkI2oMwU1JOuAZ
         G/m8IrS8CqkhL9DxJDDqYFWiQU0DsHVvO8t2FuwtUw6vF3XTp1WIh4hSvW2bzye3RVs7
         +++hjqqvdI01wRTU2XTpRPzmUjCzFkc72GMrolTo5k0YeUZYkTHJiJNcQA4mJsg89ZfH
         SbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWp3XAjwaKNilPNmlsHgxZFzms9rfwhwuANU8MZ4Ta0=;
        b=CH8rKkVJvTZ2OT0xMVgQcQ00oHJSiR0XU/uIJa8UzMAxXocAPPstrXvLa7Yl9oY2qf
         cU8tBtqvm59BLhp80NF//b5Sb+ZY412l/yVloNgvtF0opTTGSZrs/V6j1XmguafMapea
         grnSGQsDwuaX3A8o9Mm1pc0j8BZzxcUoqRrh+fC6o4ZAo0Rm9VZZLPEX+oDduIp6NbDl
         3AG9Xhn6RwpWsNF/sgZJr5LasVubhl7+6Y+NHF5oaUc5K+xydpIInW06TgGc85sc9ktq
         vzVcxsfttCP4q1JxS2kYBkfSr76Ap9j+42B4JOvJmJk0guhTaL/BJTR2h29Xyg+CtNrU
         ORNQ==
X-Gm-Message-State: AD7BkJIEOo6nvJfhNiL+MEZtszlWiHX4hvxTxdZPT9D6LMOPRliZ6DMcxrQDphUlEfExuDEc
X-Received: by 10.98.80.10 with SMTP id e10mr24395113pfb.141.1456773266294;
        Mon, 29 Feb 2016 11:14:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id t12sm39871644pfa.54.2016.02.29.11.14.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287880>

The refs code has a similar pattern of passing around 'struct strbuf *err',
which is strictly used for error reporting. This is not the case here,
as the strbuf is used to accumulate all the output (whether it is error
or not) for the user. Rename it to 'out'.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 12 ++++++------
 run-command.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index c9b13cf..d2964e1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -903,22 +903,22 @@ struct parallel_processes {
 };
 
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
 	int i;
 
-	strbuf_addstr(err, "Starting a child failed:");
+	strbuf_addstr(out, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
 
 	return 0;
 }
 
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
@@ -927,9 +927,9 @@ int default_task_finished(int result,
 	if (!result)
 		return 0;
 
-	strbuf_addf(err, "A child failed with return code %d:", result);
+	strbuf_addf(out, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
 
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index a054fa6..2bd8fee 100644
--- a/run-command.h
+++ b/run-command.h
@@ -139,7 +139,7 @@ int in_async(void);
  * return the negative signal number.
  */
 typedef int (*get_next_task_fn)(struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void **pp_task_cb);
 
@@ -148,7 +148,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * a new process.
  *
  * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf err instead, which will be printed without
+ * message to the strbuf out instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
@@ -159,7 +159,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -168,7 +168,7 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * exact command which failed.
  */
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
@@ -176,7 +176,7 @@ int default_start_failure(struct child_process *cp,
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf err instead, which will be printed without
+ * message to the strbuf out instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
@@ -188,7 +188,7 @@ int default_start_failure(struct child_process *cp,
  */
 typedef int (*task_finished_fn)(int result,
 				struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -198,7 +198,7 @@ typedef int (*task_finished_fn)(int result,
  */
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
-- 
2.7.0.rc0.37.gb7b9e8e
