From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 06/11] run-command: expose default_{start_failure, task_finished}
Date: Wed, 24 Feb 2016 19:06:53 -0800
Message-ID: <1456369618-18127-7-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmH0-0000mq-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbcBYDHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:16 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33507 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759882AbcBYDHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:12 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so24323266pfb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TCNLQpQsH7z2kFMzLhA5s/0SKBmxZnXH718Y3Ym84e0=;
        b=pPdhqyGSu1bOIAwVtaGRnuYraaqFUHTjarMx+NFP8/xbk5+PqZ2DeRdMXNmoC/Jx82
         AQIo4KELA/ehywJRiz87ekU6f2zBlFnjdaHoH7SYvXVL9NUCXuNPKY2lWzhg3Wmt8wAS
         Bz2Xq68LwRbThtp+5uVlHw11bKgG2HOdjI5UIsjxmt6O86WwqCDV1kOuf+RQSVpdgbuw
         bVnnx8IlxZeuhqZ4L+E4Z/SOGllxouFiwDYW8OVtHRHgs3gonHoFK5jBCeTiHC8e25PU
         sgLfpunfqmhU+8ZUYhZrP+e2ol0/2iEVy0/Xx/dOM63eHf+oEB/Znm7SZ/kjn7Zz3kbk
         aogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TCNLQpQsH7z2kFMzLhA5s/0SKBmxZnXH718Y3Ym84e0=;
        b=KLpZa2Hqfr9uwFh/prDKVJwYixmbIY6I06QD5Bung99jM5ZLunvYQA8XuhSsbgYHmr
         kT2Vu2DevEiibIX501F+QO+uWDas7HUz+b1EEVXhks2B0SwFr9YGEH/UGXi6fW0mbMyu
         zC/ZC9ZUYFWy9RjFGcSfV8u3BWNQar/627v+8dwmI2TVaOO9DEY2VEiMehHsIT2hSf6Q
         L62X/HOsIdbxsbB7aKmIdrW86NgawHz45aSSeP5mrl5iCKR7yXjQQC+sTJs9vDmo2Z8n
         zu7WCsTbig8VAQJjWBfM+P5dX3kTFoezmkKY1H6k67V3B8GDce3I8WLHiHHFk7uJKKnq
         oVyw==
X-Gm-Message-State: AG10YOSBDA5FBXJUC7fdX88wRBvmCYp6pKFWRoGKj+vYQBfvrP6fXo1k07ov6ksVqHwQnpcF
X-Received: by 10.98.87.202 with SMTP id i71mr1394pfj.63.1456369631742;
        Wed, 24 Feb 2016 19:07:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id xa9sm7960624pab.44.2016.02.24.19.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:11 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287317>

We want to reuse the error reporting facilities in a later patch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 18 +++++++++---------
 run-command.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2f8f222..c9b13cf 100644
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
2.7.2.373.g1655498.dirty
