From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 07/11] run_processes_parallel: rename parameters for the callbacks
Date: Thu, 25 Feb 2016 15:48:35 -0800
Message-ID: <1456444119-6934-8-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5ea-0008Ca-79
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcBYXs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:58 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33100 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcBYXs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:57 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so40271543pad.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GlGUO33X20k/NKkorvnLlV/Js71YlXK4zWBEn+x9GvY=;
        b=IUbo+sHEhFojCP/yGWXYz/T8pz+/4fjE2bNshhoCTWiZqPwYfYZlJpjLSnT3Mt7yG3
         aQRpySi9v1c1p1VOR/vtWFLZzCjoeoMntmU5E8EFV9bPtLrT+2qMsgtQIqYDclJWhV7S
         DaLF4TpiNiam0A68LJTPB4hMBVTLeMQEmQBfZvSBeuJcTuqQK8zHE9kHO3fL1HBSF9x2
         CCObSpY/4TP4vGM+YE1ZSy/aJg7FFrLcVSD6xx5ATfXldidUip9zCvKuNoxXZiqdIpJ8
         MuVu+Zinkmr4sbLuOa43SiwJpvKVMmxaOSc3Ivpa+AX3gdVpVU5P0Te8HHRnZKj66Ig5
         cp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GlGUO33X20k/NKkorvnLlV/Js71YlXK4zWBEn+x9GvY=;
        b=XiNx+V1dCfiCtw0gR5qc2a5zXFi+HjBFrEZg+v1bHH4DXmh6zWFfAI9Im9GvzB97WO
         GVYr26Vsjr+pFXXVKSVMWSHyzwoL0Fx3JGEW6/NXUN1MyICUVoeDZuVYAKu1rMEClMB+
         uS01cplr6gpgPqu0sAtoBxDw5ByP5P42w0dJdyw04kHTlqfvgdDAsSzywAj0TRG+QPa3
         kqv4LF5SCm42SL3HaQAftIWD4S5c+WPbt5RJCSdcTTZaoqakbBzVg/xzsztpIOi1/Oa7
         M58WvvH01XlK3BhA9WpQt79/4vaZBrTrlYaVXB+/12VI6vuP9YI2YCoGo5jIYoSVYY5z
         bsbg==
X-Gm-Message-State: AG10YOQDt/mHh1m/EjgVkaYTk5ozh2zioXKzYJ+E4I9PIIs812l/i0B/GzIYdo73+m2tI8lG
X-Received: by 10.66.246.234 with SMTP id xz10mr67024138pac.49.1456444136492;
        Thu, 25 Feb 2016 15:48:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id n78sm14595026pfb.53.2016.02.25.15.48.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:55 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287499>

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
2.7.0.rc0.36.g75877e4.dirty
