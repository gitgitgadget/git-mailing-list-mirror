From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 5/6] format-patch: add format.cover-letter configuration
Date: Sun,  7 Apr 2013 12:46:23 -0500
Message-ID: <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOthi-0004LT-3w
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934223Ab3DGRsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:48:19 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47408 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934193Ab3DGRsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:48:18 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so5060847obb.27
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BIXS9lkLXmnbLgK+4alfs1JANRQcvT3qY6RMjKHhU18=;
        b=eJ9kc8lI5dHhENoYH/Xdm6YozdDJ5X2u6IyZF5F7zA9wL9dNXLDNrTidpvT8PE1jx0
         3pnfzNaU8/sv/3HpgUOtMMTB1OaMnAr5iCtmtGpJO37Y935pwyu8jkwjgKfY2SPZ0GAs
         L5pumfeblOjN1B/g8KzZ/+XCzNx3rfyRAtSfneeeZJCjMs0s9FHLR/Dwq0KmHEKHjn8J
         h0zXx0dd296+6Bypc3mhGDZlKLQHJBQc8QDkkcK+/Kppr8HGqrYT0SGyrvjinqC3zaY7
         hguJcpiSe1jP0Yihuz1lrBftsh8+pr+WE2flZpg9osRVlCX2e0rz8Qz2ia/Nsr9QnOR1
         M2SQ==
X-Received: by 10.60.29.161 with SMTP id l1mr13458261oeh.111.1365356897440;
        Sun, 07 Apr 2013 10:48:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm21542461oeb.5.2013.04.07.10.48.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:48:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220346>

Also, add a new option: 'auto', so if there's more than one patch, the
cover letter is generated, otherwise it's not.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt           |  5 +++++
 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 32 ++++++++++++++++++++++++++------
 t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c8e2178..670094f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1092,6 +1092,11 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+format.coverLetter::
+	A boolean that controls whether to generate a cover-letter when
+	format-patch is invoked, but in addition can be set to "auto", to
+	generate a cover-letter only when there's more than one patch.
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3a62f50..3911877 100644
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
+	coverletter = auto
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 488a254..cf09a81 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -619,6 +619,14 @@ static void add_header(const char *value)
 static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
+static int config_cover_letter;
+
+enum {
+	COVER_UNSET,
+	COVER_OFF,
+	COVER_ON,
+	COVER_AUTO
+};
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -680,6 +688,14 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
+	if (!strcmp(var, "format.coverletter")) {
+		if (value && !strcasecmp(value, "auto")) {
+			config_cover_letter = COVER_AUTO;
+			return 0;
+		}
+		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1071,7 +1087,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int start_number = -1;
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
-	int cover_letter = 0;
+	int cover_letter = -1;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
@@ -1317,11 +1333,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
@@ -1362,6 +1373,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
+	if (cover_letter == -1) {
+		if (config_cover_letter == COVER_AUTO)
+			cover_letter = (total > 1);
+		else
+			cover_letter = (config_cover_letter == COVER_ON);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -1373,6 +1391,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
+		if (!branch_name)
+			branch_name = find_branch_name(&rev);
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, head, branch_name, quiet);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 71b35e7..01c2a47 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1026,4 +1026,32 @@ test_expect_success 'cover letter with nothing' '
 	test_line_count = 0 actual
 '
 
+test_expect_success 'cover letter auto' '
+	mkdir -p tmp &&
+	test_when_finished "rm -rf tmp;
+		git config --unset format.coverletter" &&
+
+	git config format.coverletter auto &&
+	git format-patch -o tmp -1 >list &&
+	test_line_count = 1 list &&
+	git format-patch -o tmp -2 >list &&
+	test_line_count = 3 list
+'
+
+test_expect_success 'cover letter auto user override' '
+	mkdir -p tmp &&
+	test_when_finished "rm -rf tmp;
+		git config --unset format.coverletter" &&
+
+	git config format.coverletter auto &&
+	git format-patch -o tmp --cover-letter -1 >list &&
+	test_line_count = 2 list &&
+	git format-patch -o tmp --cover-letter -2 >list &&
+	test_line_count = 3 list &&
+	git format-patch -o tmp --no-cover-letter -1 >list &&
+	test_line_count = 1 list &&
+	git format-patch -o tmp --no-cover-letter -2 >list &&
+	test_line_count = 2 list
+'
+
 test_done
-- 
1.8.2
