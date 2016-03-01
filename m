From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 06/10] run_processes_parallel: rename parameters for the callbacks
Date: Mon, 29 Feb 2016 18:07:16 -0800
Message-ID: <1456798040-30129-7-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZix-0002xr-1f
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbcCACHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:35 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35180 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcCACHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj10so33179696pad.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VHKdTJcOs92EqTWuyWiR7et/704MSJtbolquC5Coxyw=;
        b=XFoadzo+PcDJmmY+ywuySAG2w/p054450iOnFf4yaKPlv0BHRShS0+TU9uU4zJwIMe
         eUiqBQHd664QIIUzdwi5Gyl8UPkX9dDnD7jsha8V+fzboaqsXtbq0CyWfS6fYVxlae+b
         fkdweHE5jc880rRoTfJyE1PBN9xztSCcHgiW9uKxSYOzpuGz/K3mzFNFMjZ0D3c9jW6y
         KtsGPE0xzrJTLobk8rMLxQamyKtV5bXoiKoSbcUIks8qovMnZeCgFVoxhpjgwSwVL/ig
         d4qsph0LPqB/jnJ1mGo7vJCG+BWp1cOVDWDFUMlCBqV34Q7kliU3hPm8kJv7XmZR/8Sj
         Z6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VHKdTJcOs92EqTWuyWiR7et/704MSJtbolquC5Coxyw=;
        b=Y27+Gwju2k1iA/wm7Vuaw8cebpCmc7XKJY8kJXY6h0JQh8wUdyGCzh1jz3SqVge773
         vfrb6Kz6dZSwBANeEuZ23f/lUX7LqyoY36rMcrfAq6Elw7y00d1KXWLJCy2IpM/fgQG2
         i6/IWxIjRtMg+p7qcYHs5Y1AVM/d3ZpQUbdlCaTF2eAlCoHQ1lrxp1/gqdIaa54STC5L
         L7XPW4i4fXnFhIP+RFo2rCvR197nB6HguxTcQ1uumCRYSVtdn5SXknvADqdQ+9hdR50R
         Cqqc3fhK5bfLVWR08sucb1+nnnHBg4xVQ2vy1zOpPXDZOGnQtomzTpDIzj+Dv9fPTTLr
         Rttg==
X-Gm-Message-State: AD7BkJIsrZqBIBd7IAsR4q3wz8LGkQjKBdv4rvfM0135meTRGX+57Rk9Sdk1R9Df+sIP2c7R
X-Received: by 10.66.66.198 with SMTP id h6mr26330710pat.112.1456798053540;
        Mon, 29 Feb 2016 18:07:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id ko9sm40969796pab.37.2016.02.29.18.07.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:33 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287985>

The refs code has a similar pattern of passing around 'struct strbuf *err',
which is strictly used for error reporting. This is not the case here,
as the strbuf is used to accumulate all the output (whether it is error
or not) for the user. Rename it to 'out'.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c |  4 ++--
 run-command.h | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index bdda940..62c6721 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,7 +902,7 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-static int default_start_failure(struct strbuf *err,
+static int default_start_failure(struct strbuf *out,
 				 void *pp_cb,
 				 void *pp_task_cb)
 {
@@ -910,7 +910,7 @@ static int default_start_failure(struct strbuf *err,
 }
 
 static int default_task_finished(int result,
-				 struct strbuf *err,
+				 struct strbuf *out,
 				 void *pp_cb,
 				 void *pp_task_cb)
 {
diff --git a/run-command.h b/run-command.h
index 05dec41..05cde5f 100644
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
@@ -158,7 +158,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * To send a signal to other child processes for abortion, return
  * the negative signal number.
  */
-typedef int (*start_failure_fn)(struct strbuf *err,
+typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -166,7 +166,7 @@ typedef int (*start_failure_fn)(struct strbuf *err,
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf err instead, which will be printed without
+ * message to the strbuf out instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
@@ -177,7 +177,7 @@ typedef int (*start_failure_fn)(struct strbuf *err,
  * the negative signal number.
  */
 typedef int (*task_finished_fn)(int result,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
-- 
2.8.0.rc0.1.g68b4e3f
