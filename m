From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/45] revert/cherry-pick: add --quiet option
Date: Sun,  9 Jun 2013 11:40:25 -0500
Message-ID: <1370796057-25312-14-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliic-0006mJ-0k
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab3FIQnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:43 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:55445 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FIQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:28 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so9035492obc.34
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3JP+WIGkB5O85tTcrDZJ3EvWVpEJmFEjBL/JLY6yV+A=;
        b=nuJiL+pvBpwvm6RH4BcDomtBLADp5AMasel2IXvqRSuaziT+qE+zUZXkJRKLxDA6eN
         rmpk3EvPuh18WR4YP5FWq6ltyIqwu78IU9Lj0ZQnpr6tti4W2AuVIQQBvqc5SwGPo+RG
         pOlRcCesmFCKsPuKCanes8ZzJHxqrcMLAburKAT7giGrvqhWipDjuHKotXSyuhwAsRNp
         101nrbEyziguCA67rWmAkDIZsZf0rMU1F8Fy7cJQN9BrPxn0qn1FpwO1UydnB3PE0Dlu
         J2It6O4rfkpmu7rK+Q3scwWStNkF+/V9Fg5HMr4zZL9Jg2ufUlUyoSflyE6e1cJFzBnD
         UiIQ==
X-Received: by 10.60.117.170 with SMTP id kf10mr1128300oeb.44.1370796208023;
        Sun, 09 Jun 2013 09:43:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm15181656oem.3.2013.06.09.09.43.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226988>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt | 6 +++++-
 Documentation/git-revert.txt      | 6 +++++-
 builtin/revert.c                  | 1 +
 builtin/sequencer.c               | 3 +++
 builtin/sequencer.h               | 1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

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
index 5a8453d..ec83748 100644
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
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 56551bb..0f50942 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -305,6 +305,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
@@ -539,6 +541,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	if (opts->skip_empty && is_index_unchanged() == 1) {
+		if (!opts->quiet)
 			warning(_("skipping %s... %s"),
 				find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 				msg.subject);
diff --git a/builtin/sequencer.h b/builtin/sequencer.h
index 86e2eee..e45411c 100644
--- a/builtin/sequencer.h
+++ b/builtin/sequencer.h
@@ -33,6 +33,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int skip_empty;
+	int quiet;
 
 	int mainline;
 
-- 
1.8.3.698.g079b096
