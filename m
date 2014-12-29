From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 4/9] receive-pack.c: simplify execute_commands
Date: Mon, 29 Dec 2014 13:35:10 -0800
Message-ID: <1419888915-31760-5-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyO-0001Yf-NW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaL2Vf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:29 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:52660 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaL2Vf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:27 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so12915354igi.5
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeDIXBi5CO2c0pE56gQUnztXHf4eKc3VIAAcELHTFpk=;
        b=AtSWmfcfWFu8KPimK2It3n4LGfkpwMWJEhBCbZkb7UDpt6I3AHfYoUh4GTcuvQwQO1
         aJfgcO5yK7p9MtPd5CL2KB7E6Zx3JOUV3LepK+uY7zbIshyaZjXdkEZiru001fbt+p30
         OULNYNpXJmUi5hf1l93mEsxHqoR1MxCljnL+Ws4/P+LAheHbwjCddqGLVhOGl4jwOqVd
         MJ0viDGhU0ltxTk5FnROHSIeASA3gTNje5/SsABW4/i+jn5W/eC3reUGO62SadGTBnTF
         RFY1HlIfK3LbdXwjv02qadG/ZWSP77pWX1mIzSfS8NaDnzaFkIMwqXkdt6bdxdcp/ZIV
         /IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeDIXBi5CO2c0pE56gQUnztXHf4eKc3VIAAcELHTFpk=;
        b=b1ZNYyTuY3I5QfdWahzs7d6gG2NlB4nIlA+JvCQ4h0Km9rGeNuMKKmH7Mhky54YsU/
         LTQaH+wvv9Wrm5+vDr1nkQArLgd8pUD2x1p8omDSuC4ALzSRg0pEWc/JioLDpeTWjoK6
         ZdmPbw9tWB4XJNIoWVccnpFq7j1NgYkZHIULEt5nBajUZpNRV5KZsqh9FhIOvGziQwoW
         eZGikr8jAMk/YV2DkLJK+/52yt4TVJb7fBNQ6EYiodpX8Fc6VgjNIQ0oNBHqsMeRA7Rx
         JQR08Me+MUFHX670c5GGlTRwLcl12ImNPGJjFoOSwXj2Z/Gpc2xeB3ZBMMeo+UFqbhwZ
         dH0g==
X-Gm-Message-State: ALoCoQleJXmWkyTUuLbssjKfLvRd3oPhSuthaRY16WO9gcmfUUJm8gFILRLp3iwAkhACMNugSLlP
X-Received: by 10.107.132.210 with SMTP id o79mr52345846ioi.50.1419888926955;
        Mon, 29 Dec 2014 13:35:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id qn6sm1344926igb.22.2014.12.29.13.35.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:26 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261882>

No functional changes intended.

This commit shortens execute_commands by moving some parts of the code
to extra functions.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
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
