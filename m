From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] revert/cherry-pick: add --quiet option
Date: Tue, 28 May 2013 07:59:06 -0500
Message-ID: <1369745947-19416-3-git-send-email-felipe.contreras@gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJWR-0005cc-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933987Ab3E1NA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:00:58 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33879 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933906Ab3E1NAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:00:55 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so5818531obc.34
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HaP+DRf14qDl/T4d32LXQ4Dv9iJmYMUHlAMOtVswaQQ=;
        b=MWZY7I9rPTT3I4l2SShlGh34lAbquQ4osF9pPYIIVdj2FTJZrgS1wpEiGlIJs10Y+i
         jhYP9XtV+zriQtFCk5Mbuv5KZ1HYVpba5ODtWufXsRhKk49TpR8YaCsfC5BwduQpIPPQ
         fiMbUQij29s8Ix7bT5FlJgAxkwD6Y/tbD8z5zJMEmzBOGzBNuvqnUqounahuKyPzKV96
         EG2GyVvH2x3zuPr0YFQwb7ByxKuX8kE/gkmtXew3OpylpBpinKb6NbzG7eE1SWpmLPHw
         z80kEiaPtlVBDa46Hou/H53mA2hqGytWyoTlxe6lQBDQD0tDTEFapXfsa6cem51Juz8d
         mD4A==
X-Received: by 10.60.83.103 with SMTP id p7mr20339117oey.130.1369746055304;
        Tue, 28 May 2013 06:00:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm34452172obb.13.2013.05.28.06.00.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:00:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225642>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt | 6 +++++-
 Documentation/git-revert.txt      | 6 +++++-
 builtin/revert.c                  | 1 +
 sequencer.c                       | 2 ++
 sequencer.h                       | 1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fccd936..da0bd81 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,7 +8,7 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 [verse]
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' [-q] [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --continue
 'git cherry-pick' --quit
 'git cherry-pick' --abort
@@ -51,6 +51,10 @@ OPTIONS
 	feed all <commit>... arguments to a single revision walk
 	(see a later example that uses 'maint master..next').
 
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
 -e::
 --edit::
 	With this option, 'git cherry-pick' will let you edit the commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f79c9d8..98a8e7a 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [-q] [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
@@ -40,6 +40,10 @@ OPTIONS
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
 
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
 -e::
 --edit::
 	With this option, 'git revert' will let you edit the commit
diff --git a/builtin/revert.c b/builtin/revert.c
index b977124..d63b4a6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -100,6 +100,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	int contin = 0;
 	int rollback = 0;
 	struct option options[] = {
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick sequence")),
diff --git a/sequencer.c b/sequencer.c
index 35a84ad..b4e395a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -435,6 +435,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
diff --git a/sequencer.h b/sequencer.h
index 6cc072c..41e19d0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -37,6 +37,7 @@ struct replay_opts {
 	int keep_redundant_commits;
 	int skip_empty;
 	int copy_notes;
+	int quiet;
 
 	int mainline;
 
-- 
1.8.3.rc3.312.g47657de
