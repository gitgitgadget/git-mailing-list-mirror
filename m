From: David Turner <dturner@twopensource.com>
Subject: [PATCH 36/43] run-command: track total number of commands run
Date: Wed,  2 Sep 2015 21:55:06 -0400
Message-ID: <1441245313-11907-37-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlO-0006a7-8U
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbbICB41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:27 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36317 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbbICB4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:20 -0400
Received: by qgx61 with SMTP id 61so18643675qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvIGhMjF/NVL3I23n4hDsTiUZHluqXiLrWXA+70RMCw=;
        b=DeCdqQRV/irDi7kGXEiZbJZq+CSqHsSy3EI49evOSdBhk4wToKXAB9o0rSy5KVGugk
         PlEj4xY4s1KvHaU77YHcy5QQ9/MSNqZInQBFixVeaCn424imsHt+YUJ8k7iLQMmSlmBB
         jQSPH+Flq/JrdHJGawvGn0U4wyLZ7aPPwpwAaNosnEHXbQ7bUgeuEUBYNSiTx9VblrOr
         hiWoRUwbgh4aPjLqWSyP3NOy2PBM3H+XAdnlAohkSctE3VNZLKjaiByqt3miUldJeuaW
         s9+ByJBb4fPKB1VnSPH9TBrgQULM0Yngxw/2s8/oP8/iMuD6wedEm8SzGGzoGr6yW24V
         XB2A==
X-Gm-Message-State: ALoCoQmvxVeCcJWlswiH+V4koxsoO9N533SDwt9u87MSt1HDvKkMhVr/xKXwTIqVkb0XH2kw4mlF
X-Received: by 10.140.234.78 with SMTP id f75mr5183230qhc.20.1441245379353;
        Wed, 02 Sep 2015 18:56:19 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277155>

Soon, the db refs backend will use this to restart read transactions
after subcommands which might have modified the refs database.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 run-command.c | 2 ++
 run-command.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/run-command.c b/run-command.c
index 02aab3f..dc4882e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -332,6 +332,7 @@ fail_pipe:
 		cmd->err = fderr[0];
 	}
 
+	total_commands_run ++;
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 	fflush(NULL);
 
@@ -542,6 +543,7 @@ int finish_command(struct child_process *cmd)
 	return ret;
 }
 
+int total_commands_run = 0;
 int run_command(struct child_process *cmd)
 {
 	int code;
diff --git a/run-command.h b/run-command.h
index 5b4425a..3d5ffa5 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,5 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+extern int total_commands_run;
 #endif
-- 
2.0.4.315.gad8727a-twtrsrc
