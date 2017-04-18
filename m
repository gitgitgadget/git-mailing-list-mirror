Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BDE207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758072AbdDRXS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:27 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33186 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbdDRXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:22 -0400
Received: by mail-pg0-f53.google.com with SMTP id 63so3627973pgh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ar72qPy8QBS1Abtf2FZUNFKRCioNzWk/L2qpfhUhfw4=;
        b=Vyn/QQNGK1gzz6vMRIqQIS7y8oaM39ZJkEzd0OdiGmMHZEQOyxvWCXlC03W2TOR/l1
         05/RHQLued67RLEcHA6ZiInvxApZcyNi2x/hb43rJ8LtV/NE3/ELSxCj05wBufRmBc/b
         FAsjtxsABgHC7TJxgkQdcD2D9vHP8+KyQV/Gyr/ClayuYKmg5od9YktQ0hi3pEjPUfY+
         9RGB565l3jYxJ9ktyggQ0tlpbcXRHPv+w3WKmDTQ+mYzMlvHfTQWpu4gSKUZnUID2bVB
         fgZy+T1viCIlM7YJIPm0uSO3m0jQCCn6cwYWeE+HAdFQep7pJ4/LkKWFZ4pj+78Lgddi
         9wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ar72qPy8QBS1Abtf2FZUNFKRCioNzWk/L2qpfhUhfw4=;
        b=rVfPr36GUoMSH799TEW9lDyLx7cyuYemSutMUNd5e+iXDRsWd4JlVyR5ZugNzO7lT+
         ks+L6W7wJI7eBgthuXMsyCFkdxU4M4w4jXCpPikMjnX9MFC6SbOpVpN67AgEeADAcSbP
         73ijC8rVYi8AC8EbAX7oDNZpS+7KcNWd8h0xbySZ/b3Y9iHlvG0rUj2OmiNAceS+EvHf
         d21jdH4SMfWQEa7vq3qet+cI2MeMwp2BVPVTiR9IYVWcLkjTbfeOprkQ/pTumfNeOi/I
         zAFgGid+tyngUxEBCbunMMeIX1PEkitzPWAclEb9lwc3R2FRK3maxgpUHAKw67YswiKA
         FJ/A==
X-Gm-Message-State: AN3rC/5N/bq/EcdnFeX7O9s4nMqRb2VHFEyGX0QKYDzWXzz0TajoXIpj
        85ogF16IUW+UrIbQ
X-Received: by 10.98.31.141 with SMTP id l13mr20381814pfj.259.1492557501168;
        Tue, 18 Apr 2017 16:18:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 07/11] run-command: don't die in child when duping /dev/null
Date:   Tue, 18 Apr 2017 16:18:01 -0700
Message-Id: <20170418231805.61835-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 15e2e74a7..b3a35dd82 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,18 +117,6 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
-		die_errno(_("open /dev/null failed"));
-	if (dup2(fd, to) < 0)
-		die_errno(_("dup2(%d,%d) failed"), fd, to);
-	close(fd);
-}
-#endif
-
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
@@ -444,12 +432,20 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
+		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC);
+		if (null_fd < 0)
+			die_errno(_("open /dev/null failed"));
+		set_cloexec(null_fd);
+	}
+
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 
@@ -473,7 +469,7 @@ int start_command(struct child_process *cmd)
 		atexit(notify_parent);
 
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(null_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -483,7 +479,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(null_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
@@ -493,7 +489,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -553,6 +549,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (null_fd >= 0)
+		close(null_fd);
 	argv_array_clear(&argv);
 	free(childenv);
 }
-- 
2.12.2.816.g2cccc81164-goog

