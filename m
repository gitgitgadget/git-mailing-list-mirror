From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Mon, 29 Dec 2014 18:36:42 -0800
Message-ID: <1419907007-19387-5-git-send-email-sbeller@google.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mgw-0002J6-IK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbaL3Chn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:43 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38219 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbaL3ChH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:07 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so12949774iec.22
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPZPOkYgnmLqqwyXOLBSgl2xMdlrnFt/zKUIMWDxgTg=;
        b=V0qW0xHa9o//8g/cyr6bUS+fCdo4X1T5ai4eXgo4YgYeKq9qDhRzOagD5Zm5iYj3Oo
         m2diYc6lYPPjv5l98a0kac+/ZHDRjVhlTrnh+c2/jliw5DbYLkzYYlRopt/UC7GpkWfn
         sfizSCy1iHok7fOkpy1KQEzJ6d8Ks5ES7dYnG6UOoqzcExOMRbF0UTE85iG/K4ueVR6r
         Z62CUoJHyENTWVIa+Z2adPH+hvgYPcmCvito02nX7jhmtQwlDpb2AGN7rYOZBWNkMvb4
         hZOGpErVRezsFIrLuXorv5aR+cuSZXSyJdx7YEa+TP78O0LYnsXMh59Cv15nsxt2yC0U
         ELyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPZPOkYgnmLqqwyXOLBSgl2xMdlrnFt/zKUIMWDxgTg=;
        b=Ltf/BrIYFBQHiLFbo3FQY50Y7RaHvNOlQQbZWRKVFFR6mM1bmmPLAGJ/PCmatoSoWh
         aJV6usj6ZiTmr+jv7dTeFuovVR0De07zBOy5legoI9Q9A2NwxUFQD5UIx+ErQfMl5HPU
         SvLD5zh3WEQ7oHBFcMiMmCnuRWszv3PYSY3HhZ9yKQ4pGyedRBVdVm1ZZjxhRp33eKyV
         33lwG0WtmIID56AE3n1CpmiH5y6TJB9VsjRxtWF8iI2lQGVnGf0KLfy5v1y9aB3RH41g
         QLGblPX+aQOiZ7npjNeK2q0KMTpQRjTFg8FV4wNrFokiN4dFzN8DdydqiHW6AznwdvWL
         3XCw==
X-Gm-Message-State: ALoCoQnmS0CtfshTfRjmVedix5BqGQ4wcCTEkxGxh5FyaDa9lMJ1lPTgrBEzORpv72ZMNYd29HCQ
X-Received: by 10.42.207.129 with SMTP id fy1mr14287700icb.17.1419907026872;
        Mon, 29 Dec 2014 18:37:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id k6sm15085867igm.4.2014.12.29.18.37.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:06 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419907007-19387-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261910>

No functional changes intended.

This commit shortens execute_commands by moving some parts of the code
to extra functions.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v8: no change
    
    v7:
     new in v7 as in v7 I'd split up the previous
     [PATCH 4/7] receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
     as suggested by Eric.
    
     This is pretty much
    > patch 1: Factor out code into helper functions which will be needed by
    > the upcoming atomic and non-atomic worker functions. Example helpers:
    > 'cmd->error_string' and cmd->skip_update' check; and the
    > 'si->shallow_ref[cmd->index]' check and handling.

 builtin/receive-pack.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4e8eaf7..06eb287 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1043,11 +1043,40 @@ static void reject_updates_to_hidden(struct command *commands)
 	}
 }
 
+static int should_process_cmd(struct command *cmd)
+{
+	if (cmd->error_string)
+		return 0;
+	if (cmd->skip_update)
+		return 0;
+	return 1;
+}
+
+static void check_shallow_bugs(struct command *commands,
+			       struct shallow_info *si)
+{
+	struct command *cmd;
+	int checked_connectivity = 1;
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		if (shallow_update && si->shallow_ref[cmd->index]) {
+			error("BUG: connectivity check has not been run on ref %s",
+			      cmd->ref_name);
+			checked_connectivity = 0;
+		}
+	}
+	if (shallow_update && !checked_connectivity)
+		error("BUG: run 'git fsck' for safety.\n"
+		      "If there are errors, try to remove "
+		      "the reported refs above");
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
 {
-	int checked_connectivity;
 	struct command *cmd;
 	unsigned char sha1[20];
 	struct iterate_data data;
@@ -1078,27 +1107,13 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	checked_connectivity = 1;
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string)
-			continue;
-
-		if (cmd->skip_update)
+		if (!should_process_cmd(cmd))
 			continue;
 
 		cmd->error_string = update(cmd, si);
-		if (shallow_update && !cmd->error_string &&
-		    si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
-		}
 	}
-
-	if (shallow_update && !checked_connectivity)
-		error("BUG: run 'git fsck' for safety.\n"
-		      "If there are errors, try to remove "
-		      "the reported refs above");
+	check_shallow_bugs(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
