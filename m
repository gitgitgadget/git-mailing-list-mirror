From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] run-command: expose default_{start_failure, task_finished}
Date: Wed, 24 Feb 2016 17:42:00 -0800
Message-ID: <1456364525-21190-3-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwb-0000DG-O8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102AbcBYBmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:14 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35680 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbcBYBmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:11 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so23915820pfc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sYjMJg6sH303oSqezCN35d68aOlT5Q1pdlPpCaVc4Dc=;
        b=mBd58FrkBh0RFm3OxVV2NZSMNpdGNzL2Zye0fc9BcxuWxRZn/oWtGJ+JcNYGNPh5qb
         JHor0NryI1k6BVA2lIpZXi/r4wVA0Kd8ISPMdP1EbpavT9aMkxbxVJVCUPzVO1cu17aQ
         BOwNIT/eOY4pwpEeTfLtHWNOUdbQOiyygGonsutx8kNky+cY6urvgU30tfh4qYKLI7aX
         qjNhvLzdHqrOIn0zmUCWWNfVGF9S2USe/WSQTnm5Z9G7hyFO+q66g/GIunfKNCwNX+u3
         zRx07iSyVI/wls9G6dYFwZn9v1Tu3SMJc3gP1EwE5bvyuImCv5NNWXsXv6vVmWD0Ury3
         7WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sYjMJg6sH303oSqezCN35d68aOlT5Q1pdlPpCaVc4Dc=;
        b=GdtWOpFQwH/kXu9uM0h390djQdz4KohXEh/TT61KBocniqDvw+FGPqIYsxlWEHITXt
         d9dQTi/eclc/SLQA4AhNFxxjkZhabM8lGBh5Us/SxdtCbX4Qu11ylroxcJUg6V0qVhrm
         LP32afNAta7wfZIbFsXY5EtWvqA6XcMr+9ny5A7+1IeMj1+8l88Kz95kT55jBeNDpNSe
         +mJ/3IRxOwnqCh6Op5GatpMu07klLsYZYgaMFtAm+OGiQOI2RGt5T/h0dIDAHtrLxFOA
         bGW0xWxSStHHoKktKzZC/hpBuvn8/RWCeXO1Hjl1h7xuxYqrUzePvPdz72ExaXc8ewKj
         +2Ig==
X-Gm-Message-State: AG10YOQ61GKTYQDJcIgDlha2ioJdkTl3pU/mqIo6rGLrKLmQ1bJ3ZZ6/yq9TweysctnXdooF
X-Received: by 10.98.15.19 with SMTP id x19mr59514350pfi.60.1456364530994;
        Wed, 24 Feb 2016 17:42:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id u64sm7699892pfa.86.2016.02.24.17.42.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:10 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287302>

We want to reuse the error reporting facilities in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 18 +++++++++---------
 run-command.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1f86728..71abafb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,10 +902,10 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-static int default_start_failure(struct child_process *cp,
-				 struct strbuf *err,
-				 void *pp_cb,
-				 void *pp_task_cb)
+int default_start_failure(struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb)
 {
 	int i;
 
@@ -916,11 +916,11 @@ static int default_start_failure(struct child_process *cp,
 	return 0;
 }
 
-static int default_task_finished(int result,
-				 struct child_process *cp,
-				 struct strbuf *err,
-				 void *pp_cb,
-				 void *pp_task_cb)
+int default_task_finished(int result,
+			  struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb)
 {
 	int i;
 
diff --git a/run-command.h b/run-command.h
index d5a57f9..a054fa6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -164,6 +164,15 @@ typedef int (*start_failure_fn)(struct child_process *cp,
 				void *pp_task_cb);
 
 /**
+ * If a command fails to start, then print an error message stating the
+ * exact command which failed.
+ */
+int default_start_failure(struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb);
+
+/**
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
@@ -184,6 +193,16 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_task_cb);
 
 /**
+ * If the child process returns with a non zero error code, print
+ * an error message of the exact command which failed.
+ */
+int default_task_finished(int result,
+			  struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb);
+
+/**
  * Runs up to n processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
-- 
2.7.2.335.g3f96d05
