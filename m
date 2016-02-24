From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv15 1/5] run-command: expose default_{start_failure, task_finished}
Date: Tue, 23 Feb 2016 19:20:13 -0800
Message-ID: <1456284017-26141-2-git-send-email-sbeller@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:22:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQ22-0006kB-M9
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbcBXDWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:22:15 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33491 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbcBXDWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:22:12 -0500
Received: by mail-pf0-f171.google.com with SMTP id q63so4375800pfb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JjgZHp74Ovjn08M9qQge8vZKrjnuvwZG4Ft+xhTpRco=;
        b=JJXOQS3t1tBGhyxIW6eXAcI9y1LhBLiYecgu+YJ8yitlBQoZXLuaIKKu0fJ3DT7Yt9
         uJkFywD5VUsJh2OXma9Qc940EpGQi5d6Zns3nkai1SFM+xZ6kLa2K7hp/KhDKRopm5+/
         Flfv6+5nDN9E60D3KN1xLUex3IB/3oUU+SzLbrnCOX58TKK6lnVcgk+vma/HiFf5oXr6
         /Dbu7f/S9/r8+IwwpFgODenkMw4PdtjeycNb5zG1RVFdSc2/IOrUc+oHQ2Pebk8kbDHS
         Fq7o+PuRYPgMTPFexx+j4xtz++xhzoZaqTmMDXLsCgHkRROHpScLjvsAG64kwmEweIvw
         sDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JjgZHp74Ovjn08M9qQge8vZKrjnuvwZG4Ft+xhTpRco=;
        b=NWLfTlJOZRGOZdWcIwOXbBusH2PMcSspZt5+zC+owukAkKjbn3RjdoZi8ysSZ4IFRh
         i/jz2e20KkpN5kwsjL6TRwznn31g5bCt+/PmWQwHXNSd8SJoKfwdXpK8JkJOpXVpUpBA
         jqusC0Le94B/YBmmSA5F2a9u+M53jydRFeE4wDzT5wjmsJbuWV2ZzLWCa2HKjA7m1qrd
         Bnb2A/doMgK8tWP6Z9TwACgK3Fl/kBFnvuzb+iV8z7Is4B0dZabQePFyS2mjxPTZpibV
         bK/oaiPzqZ9thkjKc/VGodyJaGvFyXVzN9UDEhHCkdC8RTnWtY52hsSG+KH9MV378/qS
         puFg==
X-Gm-Message-State: AG10YOR5G3Xi8fZc9buSVA24Ug9Mp4KSeZma6s4Ek7AWuisSdHlkvDA0Rwlomeoy2mYjp6sf
X-Received: by 10.98.67.92 with SMTP id q89mr51528687pfa.137.1456284131839;
        Tue, 23 Feb 2016 19:22:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id tp6sm725730pab.25.2016.02.23.19.22.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:22:11 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456284017-26141-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287165>

We want to reuse the error reporting facilities in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 18 +++++++++---------
 run-command.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 51fd72c..d03ecaa 100644
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
2.7.0.rc0.34.ga06e0b3.dirty
