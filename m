From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun,  7 Apr 2013 01:10:30 -0600
Message-ID: <1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjlV-0000Xz-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151Ab3DGHLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:11:42 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:59485 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab3DGHLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:11:41 -0400
Received: by mail-ob0-f176.google.com with SMTP id er7so4764403obc.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+oSbprw/e7S79OT+1o8gaB91JOg0FLafbtXvULR4TOw=;
        b=MOfMWc/6qsqOAmrglR2hLovKexP2NlSoHp5jX7+mvKJYU9dm9+6OeHpAvb2LC/iJ8i
         0qyWTCHGBQTwfvB2nNZTpc5pCUevEfSrErMyqMalFUFrrl8QsO90vaz2KMSW6omDrVYh
         5FA43U2VCqSGv8Gy+v6DjuMbCjjr67lP2lZkQs5fLH6MWPC7nqFA3R2zeNbSBTKVxYkm
         8AR8TOHh4ySyt0ABIM8J2SqcNT0qSN1G+zuq5T1g44GhPBTVmgD+md0OKyQ5NgXGdMcM
         YPs//PXt+HMAZkTjPiuDADJ7LB7smCbXdQ8EiyDyk3yObUGkS/7RGZqN26lyS4INV+kr
         E6Gw==
X-Received: by 10.182.156.20 with SMTP id wa20mr12334060obb.59.1365318700970;
        Sun, 07 Apr 2013 00:11:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 4sm19153145obj.7.2013.04.07.00.11.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:11:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220286>

Also, add a new option: 'auto', so if there's more than one patch, the
cover letter is generated, otherwise it's not.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt           |  6 ++++++
 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 22 ++++++++++++++++------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c8e2178..c10195c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1092,6 +1092,12 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+format.cover-letter::
+	Allows to configure the --cover-letter option of format-patch by
+	default. In addition, you can set it to 'auto' to automatically
+	determine based on the number of patches (generate if there's more than
+	one).
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3a62f50..e1f5730 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -195,7 +195,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
---cover-letter::
+--[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
@@ -260,6 +260,7 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signoff = true
+	cover-letter = auto
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index e4fb3c8..fab7998 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -618,6 +618,7 @@ static void add_header(const char *value)
 #define THREAD_DEEP 2
 static int thread;
 static int do_signoff;
+static int cover_letter;
 static const char *signature = git_version_string;
 
 static int git_format_config(const char *var, const char *value, void *cb)
@@ -680,6 +681,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
+	if (!strcmp(var, "format.cover-letter")) {
+		if (cover_letter != -1)
+			/* user overrode it */
+			return 0;
+		if (value && !strcasecmp(value, "auto")) {
+			cover_letter = -1;
+			return 0;
+		}
+		cover_letter = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1071,7 +1083,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int start_number = -1;
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
-	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
@@ -1317,11 +1328,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 */
 	rev.show_root_diff = 1;
 
-	if (cover_letter) {
-		if (!branch_name)
-			branch_name = find_branch_name(&rev);
-	}
-
 	if (ignore_if_in_upstream) {
 		/* Don't say anything if head and upstream are the same. */
 		if (rev.pending.nr == 2) {
@@ -1360,6 +1366,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
+	if (cover_letter == -1)
+		cover_letter = (total > 1);
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -1371,6 +1379,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
+		if (!branch_name)
+			branch_name = find_branch_name(&rev);
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, head, branch_name, quiet);
 		total++;
-- 
1.8.2
