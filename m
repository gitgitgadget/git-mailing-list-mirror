From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 07/11] run_processes_parallel: rename parameters for the callbacks
Date: Wed, 24 Feb 2016 19:06:54 -0800
Message-ID: <1456369618-18127-8-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHH-000116-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759911AbcBYDHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:34 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34849 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759901AbcBYDHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:18 -0500
Received: by mail-pf0-f169.google.com with SMTP id c10so25160830pfc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9k/fVV+jdOJSxCrV4PqNUgmJU/lPPoUBnDsCFD6BP5k=;
        b=kLHdnKYkkrmDFzTHoAckb1usW3pzAOP8qUJVOxXUv5/xxToyEw85/q9xS2jEoJ9KJQ
         2WFL3CC6hgjQtpHYh7UmdNiqBFS9BmOP16RizojdeBcTNTg7fzS9qh1cPgQB25HcZmEj
         KMzJ5JW6TqtJkkV3gDgOghv6Vow7ftQqCAhyXexDXAoce7sfbDpgo1R9Gargi/yJu+PA
         TiabHrFWC0g6yOnKk8XotkCYb4pR8V01DiCgQMaqdRAwjd2CQyqWItyVEl9yrxBmCvIU
         IOyJqww84JDuRge85nDifKsa3UrQlnC/V6hj/6XmB8PQ8vtDejZCVCqU2U3B+1WB0ntK
         Cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9k/fVV+jdOJSxCrV4PqNUgmJU/lPPoUBnDsCFD6BP5k=;
        b=BZTSfvWmpB9x42v9hG+6+83G9MPMKpSrIkk1yY5VC1ZwyReNL7FoD9KFuI8oNldW9L
         i/k779UM5nkbZU9MQgJ87l0vTHdiwEYQ7RwYnTXo/1Kzj8LP65zdg6GY1HrTUktcYVv0
         BNhhBLrkbJRPAEfWuqwIB/dHq1Mh/NewdGlNhqbdWaXK798cv734ZXb5C5hAgkiLqO+W
         zLBwzKKF/5A8oXvm8KUxKZmn0AZtQiJZsKLk+/Vd75XlQE75doI0hPvDgUz9R5KXKoyy
         xgAEcfQ/H7Z3CDcqjyoB2KPmPXWGakQsbXo02gMG1edu2rZoWar8VvZnDopRCQOufzCT
         KQXQ==
X-Gm-Message-State: AG10YOQK8N3QY3xhXWsLpPdc8eSTT0Zv1cX9ShzaQZ0cScwi31+JC2i6YDy0pCjndXD045Vk
X-Received: by 10.98.16.198 with SMTP id 67mr59767457pfq.21.1456369632992;
        Wed, 24 Feb 2016 19:07:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id tn5sm7967380pac.32.2016.02.24.19.07.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:12 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287320>

The refs code has a similar pattern of passing around 'struct strbuf *err',
which is strictly used for error reporting. This is not the case here,
as the strbuf is used to accumulate all the output (whether it is error
or not) for the user. Rename it to 'out'.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.7.2.373.g1655498.dirty
