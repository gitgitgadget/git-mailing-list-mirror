From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 03/10] receive-pack.c: move iterating over all commands outside execute_commands
Date: Wed,  7 Jan 2015 19:23:17 -0800
Message-ID: <1420687404-13997-4-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hw-0000cP-Bb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbbAHDYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:24:17 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:48779 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbAHDXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:47 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so889238igd.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJSfGAlB3StX/N1WM4Z4ByqlY5anA2mz6RsSGjx9yT4=;
        b=nJmjvmT+3p+OO3OSHW4My0nw23rWPTwn1HrO9uqk+dZQP+Cw2eSnLHjQsWX81Qti+L
         vXQAPfi9NLxmuIwcEVJ7XEB4uZv0FwmI8i5w3NvaH3dnXREzxRKYwm4IM0UvNZe4Wh6d
         14F9/ksAhIRWk/L2vSWySbmcPWsgZ0B08l0anlAz786cKGJ1axygr5OvaOiwhY/XYKI7
         Ppx8/fcLQBuzfMe0BVuTSsrvZceJnTFBnrc5hzhEfdlCbpGOYcqVs69FCnzFOosFR2W8
         MItQhqOJRD2/R6jPg6GGLWotla7SZUnv1wrSCxQyM2tJyzf/qwI+lT5/grFcJB/2rcFR
         11Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QJSfGAlB3StX/N1WM4Z4ByqlY5anA2mz6RsSGjx9yT4=;
        b=X5+LS/XIDAPrGJ1Q/Ob0NlsvgAbna2qcomU48fxUvnLyOcp3rBLGECYkYibnZAVJba
         uhOM4hAokzrxEwadXgVHWk8VxvGVQarYo3oq3V6P8fYikHdGh98hgfoJCNR1fRxmSwOb
         ZLPbX9wDKiBjLYYfKfamVIqTDms/b3OMUImzwxmAsUZv4m6CjrI/yg+0ZstgnpuJPvUB
         am798m8+By8DOJB3n7u0V59QdwZARdu/OMUWzsdMb/Tt8BGI5ryWYBXXThuf56qli1EV
         SRUuNVoUQSqmw5dO0nSTUZanaHN1WJwvGDaU0hurHaye/JVGChRvcPPOiFZpqzekM4YL
         66Gg==
X-Gm-Message-State: ALoCoQkQ9ZGp+2CDxhRRPYdnkH202BNSYpTgO8OFADkUff2KnA3MW4LHWUOqvVyl2F9oFqBuSKTq
X-Received: by 10.43.143.3 with SMTP id jk3mr5312536icc.62.1420687427240;
        Wed, 07 Jan 2015 19:23:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id kt1sm7448608igb.20.2015.01.07.19.23.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:46 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262180>

This commit allows us in a later patch to easily distinguish between
the non atomic way to update the received refs and the atomic way which
is introduced in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10, v11, v12:
    no changes
    
    v9:
     new and shiny. But makes the next patch easier to review.

 builtin/receive-pack.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3bdb158..0ccfb3d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1064,6 +1064,18 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
 		die("BUG: connectivity check skipped???");
 }
 
+static void execute_commands_non_atomic(struct command *commands,
+					struct shallow_info *si)
+{
+	struct command *cmd;
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		cmd->error_string = update(cmd, si);
+	}
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
@@ -1098,12 +1110,7 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
-
-		cmd->error_string = update(cmd, si);
-	}
+	execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
 		warn_if_skipped_connectivity_check(commands, si);
-- 
2.2.1.62.g3f15098
