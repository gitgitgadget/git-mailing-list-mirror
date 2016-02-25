From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 06/11] run-command: expose default_{start_failure, task_finished}
Date: Thu, 25 Feb 2016 15:08:23 -0800
Message-ID: <1456441708-13512-7-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ52B-0008Fv-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbcBYXJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:12 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34764 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcBYXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:06 -0500
Received: by mail-pf0-f180.google.com with SMTP id x65so40602263pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvCdp4S4HwLahP21ct3uMjFDIejPx52HXPUXQXmvmWg=;
        b=HbqgZ8INK2MBgZ2z+h3LNjgoRPdpWBEcwmL0yOvlzgmnGPMlkz//iWgw1MiEr5yP24
         p6MEg5vJVZXJmJA76/rtLIm914tQp4khhG5OvxI7VdkfQJ6VH5sMd4NKFNN4+XM9qclp
         6m8lXQGnouR3dpooGPrjaVowjIiANgBwNpTqwtkpIz7F5wfNLFQmN0mokv9vXUnC67TB
         gc94dwWDGaSiDaI4dd34IGhTz9/yhjL8Lovn5DgdHyLFTmFG3RN7ZbR3KbeTlqQeqDKm
         xopFgsEYTS7sIxW0fAiNX8bNaMC8lnkOPdMJqww+tVdoSTzXYUKYU4CfRUy42VsOJV9i
         IJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvCdp4S4HwLahP21ct3uMjFDIejPx52HXPUXQXmvmWg=;
        b=YtndCvV9ESSc1V+jplfWPn4OJnhROMsJi1d5KMGRQbR470bM1mv5YgfVlINt4V7G5N
         Et4efUMxZ7I9kb8g+kOf+egKp5gVf0xZ1Lvsbc0umjo59uXZ/fbFzO/vZpz41lzm+j4a
         9uLUUs5jsrE6PzbjLmiWbaiSvNSzm2jQs4Vi9paDlIGr/7EetyoJWgB4v7wOWNn+RhtG
         CLGn/jftLSuuOfQKMb2kMCA3PfV4kcSov9cCHkNjRL/aF8NKAaFo9eK7xjU1Sn3o8xbm
         seA/f5w8whLSOns6Ow7hgfj6j9W35uF2r9zAtU5MK2ZEdpFKO7qIWQQCbvcxoNdD6Pd+
         cXiQ==
X-Gm-Message-State: AG10YOSMmtuaWK9JjoXxpGC8jIvd9Hsb4aBdGU1nZbFerukHUiYuA79LHvGZLTmRJiBDKdK9
X-Received: by 10.98.89.215 with SMTP id k84mr67081394pfj.66.1456441745951;
        Thu, 25 Feb 2016 15:09:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id h66sm14487415pfd.91.2016.02.25.15.09.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:05 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287477>

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
2.7.0.rc0.36.g75877e4.dirty
