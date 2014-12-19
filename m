From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] receive-pack: move execute_commands_non_atomic before execute_commands
Date: Fri, 19 Dec 2014 11:38:59 -0800
Message-ID: <1419017941-7090-6-git-send-email-sbeller@google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23Oc-0005fi-So
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbaLSTjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:25 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46409 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbaLSTjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:19 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so1290053ier.6
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r04tvt/39OFnGRPKPPP4SWYnLW/lkXFgdqJGW7McgdU=;
        b=nj8HksO7y/4K5D7/FWzRjP9LJWNvdfBACbglyupB+6KjL1i4hCqkmiV/PIRSTZsex1
         1kcPpkiDcgz47tCULM0lUfE4SLLUeV2d3wvIrRvVCIO5J82nAgrB+H+uaJD5/Wq3mBUM
         iPWUZRtjBqbvB2TkQxydi/08q5UjFf18MP021b47FTgMTsDfpFkhM27ev5fSPMeCxOmR
         4gFk1bYWd2ZSy+95K0qLtHruiKewaibBGKq8FinlOxT0q4gP8U2DedLl5ic7D9Rl7oF0
         qe0eWMDehJmh5Hc/NCJpGMkmeQbOPg8qytj0mb08Yi5fX7WL51FZ3zBQkDazerXtI9b5
         qx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r04tvt/39OFnGRPKPPP4SWYnLW/lkXFgdqJGW7McgdU=;
        b=nMbUDb5ROeQhKtHHq8gewpLe7Z4o08veUuDuEHjPRmPye6LQJ9213FTx/tNsOWj8w4
         7ohjIi+szE6RED6HWFgPu4KSuItALPYVPSOJfZvhMz/1yUCkRSzKycM2/SvSIrJdUixj
         0fwN4+v7XgHKrYL0ypGPt11glCuSkpagAzJx32kCZtIW4zCqytCGVEy4nw9BDB1+i+ul
         rR1h4Jr0991seDmRaBq5mI5lG9iwhzV0JvZPS5IS64fivIfrVFmF/yDAN2oxMK4oeQWi
         iaD+SV3DZlaeQ8sk+xvB31wATVCKlEGQws3KGk+bpzG2kFfWsA+qHkX5rMhn/Dzk5udT
         d67w==
X-Gm-Message-State: ALoCoQlwcVog23GmxlbMLC0o4+1xIXisxd44+YABguNihlIVv+WBoXfePcC2JjsooYSW/MHn2bSp
X-Received: by 10.107.8.149 with SMTP id h21mr9129886ioi.74.1419017958242;
        Fri, 19 Dec 2014 11:39:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id c204sm4940114ioc.16.2014.12.19.11.39.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:17 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261589>

This way we don't need to declare the function first and implement it
later, but rather we put the implementation directly at the place where
the function was declared.

The reason I did not move it up in the first place is better readability
of the diff as the execute_commands_non_atomic function is taking lots of
code that was once in execute_commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This patch is new with v6 of the series
    
    As execute_commands_non_atomic is larger than execute_commands, the diff
    is not moving around execute_commands_non_atomic, but execute_commands.
    These two functions were one after the other and switch places that way.

 builtin/receive-pack.c | 86 ++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 710cd7f..d47e73b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1047,10 +1047,6 @@ static void reject_updates_to_hidden(struct command *commands)
 	}
 }
 
-static void execute_commands_non_atomic(struct command *commands,
-				    struct shallow_info *si);
-
-
 static void execute_commands_atomic(struct command *commands,
 				    struct shallow_info *si)
 {
@@ -1109,47 +1105,6 @@ failure:
 		      "the reported refs above");
 }
 
-static void execute_commands(struct command *commands,
-			     const char *unpacker_error,
-			     struct shallow_info *si)
-{
-	struct command *cmd;
-	unsigned char sha1[20];
-	struct iterate_data data;
-
-	if (unpacker_error) {
-		for (cmd = commands; cmd; cmd = cmd->next)
-			cmd->error_string = "unpacker error";
-		return;
-	}
-
-	data.cmds = commands;
-	data.si = si;
-	if (check_everything_connected(iterate_receive_command_list, 0, &data))
-		set_connectivity_errors(commands, si);
-
-	reject_updates_to_hidden(commands);
-
-	if (run_receive_hook(commands, "pre-receive", 0)) {
-		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (!cmd->error_string)
-				cmd->error_string = "pre-receive hook declined";
-		}
-		return;
-	}
-
-	check_aliased_updates(commands);
-
-	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
-
-	if (use_atomic) {
-		execute_commands_atomic(commands, si);
-	} else {
-		execute_commands_non_atomic(commands, si);
-	}
-}
-
 static void execute_commands_non_atomic(struct command *commands,
 					struct shallow_info *si)
 {
@@ -1195,6 +1150,47 @@ static void execute_commands_non_atomic(struct command *commands,
 	strbuf_release(&err);
 }
 
+static void execute_commands(struct command *commands,
+			     const char *unpacker_error,
+			     struct shallow_info *si)
+{
+	struct command *cmd;
+	unsigned char sha1[20];
+	struct iterate_data data;
+
+	if (unpacker_error) {
+		for (cmd = commands; cmd; cmd = cmd->next)
+			cmd->error_string = "unpacker error";
+		return;
+	}
+
+	data.cmds = commands;
+	data.si = si;
+	if (check_everything_connected(iterate_receive_command_list, 0, &data))
+		set_connectivity_errors(commands, si);
+
+	reject_updates_to_hidden(commands);
+
+	if (run_receive_hook(commands, "pre-receive", 0)) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!cmd->error_string)
+				cmd->error_string = "pre-receive hook declined";
+		}
+		return;
+	}
+
+	check_aliased_updates(commands);
+
+	free(head_name_to_free);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
+
+	if (use_atomic) {
+		execute_commands_atomic(commands, si);
+	} else {
+		execute_commands_non_atomic(commands, si);
+	}
+}
+
 static struct command **queue_command(struct command **tail,
 				      const char *line,
 				      int linelen)
-- 
2.2.1.62.g3f15098
