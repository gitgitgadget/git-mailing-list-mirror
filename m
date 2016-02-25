From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] run_processes_parallel: rename parameters for the callbacks
Date: Wed, 24 Feb 2016 17:42:01 -0800
Message-ID: <1456364525-21190-4-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwm-0000Lz-4v
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758424AbcBYBmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:23 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35031 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbcBYBmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:13 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so23289001pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Pok0l+ROthd941vZUgp4JObsZQuObbw45/82CqkNOQ=;
        b=BhdGYg+nC7XY3E7NDUhYMAX4Mv9WpoS047DI963NSclBnzrXOa8sfj7HOj6zv/yYR1
         Pzi+teRV1GPHkqqwb4bACqacrbK+kCQIOFVaJUaDehF1bwBf7vJUAnSvohUs6WaugA3R
         a2iZcFl8q7Uvl/SS7GD+x8BMQ+XJo+2L7Cuw0mmnh6qfmBQlm3dKeiS8SMW+rOeH4tTp
         5WrUAM8I/EaoSuQHeDAMG8mB/rW0ArgoWniO4P4ndXURsqTaQyEAGXJ5A+L7rtQCMJr/
         6M0jPB1IykCxwiN4oQtrzDPBQ+1ByFONEsZ4NIiIKTj14k88ho08O+2dyaPeXq3kXMI9
         /u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Pok0l+ROthd941vZUgp4JObsZQuObbw45/82CqkNOQ=;
        b=S8alwZMHS5MS+0EpT9UKIOg/INd3y90FjY3fh2Xdzu5AVrbUGNgs79niQ2yKwxv4ND
         9SrENO8qF27KQn4+TlH7W9jfr3iCI7yLIN/LtCMqQ6XLNqCkmkSqvS1jZd/LQLklOt8G
         oj/3ZJGCZYEDgx8uugM/hnNd/o5tvL1AYA+J1DU12iU7esIkPSrBSeOjyrH7I36xKgNF
         4jDJJuUOlzQQLZIVaC76fGmrk4xr6lXG2DgMVvPaZM+TYXT5NgLcsfFW1u9ZYfOA6Yea
         nrknv6ICkCgr8134WrZEw2qM/hcJMqpQrCXeaMqi/jzaP0T04TG+BWLuhXxQ20hz1CiW
         DtQQ==
X-Gm-Message-State: AG10YOQ2dEbybIbneoGiILMpuHkkV5PZZrZv3QB9Hs8cwwFCpmLC+C2wsUix4sozYz75lz5w
X-Received: by 10.66.190.168 with SMTP id gr8mr59101372pac.23.1456364532196;
        Wed, 24 Feb 2016 17:42:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id r77sm7713095pfa.47.2016.02.24.17.42.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:11 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287305>

The refs code has a similar pattern of passing around 'struct strbuf *err',
which is strictly used for error reporting. This is not the case here,
as the strbuf is used to accumulate all the output (whether it is error
or not) for the user. Rename it to 'out'.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 12 ++++++------
 run-command.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 71abafb..20489c8 100644
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
index a054fa6..c8c64bb 100644
--- a/run-command.h
+++ b/run-command.h
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
2.7.2.335.g3f96d05
