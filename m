From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 03/28] revert/cherry-pick: add --quiet option
Date: Fri, 30 Aug 2013 00:55:57 -0500
Message-ID: <1377842182-18724-4-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHlk-000788-I3
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab3H3GBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:09 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:45659 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3H3GBI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:08 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so1450370obc.40
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vo6dATx0hFCTzq1QiwgErf0mbC2QCq21NY4owSJ4gBQ=;
        b=ss6dDfe0fcBfmhLAhoZOWJKuEnNRq5nP39PAXaopW+shlwceeDqFPiO+ODHCqKA7Tx
         ugHVWGj23R78Z9JXDasfaj51Gdpln1ZDbEepbQzRI4Yoj6zk5/O01Oc44caq14Um2EHe
         H9g/uDw7tV0sPIykavwW3GXDEcs7qlxOLTjN8DTE+wCmS+ERu1YU3LtdoknHjNtSqYCl
         H05CxrxApnGIrzP2RDH+1kHPO0l8hAlK5WSy8YvxlLud33poMI0yoin9mQ0RZi4fCuFd
         rnT0crWLzcLUzUWkxPUJHp36xBsIpL+bXYk5bYRIxUs/grKiF/m/I/JdIa23BrkVE1WW
         FbVg==
X-Received: by 10.182.50.137 with SMTP id c9mr5639570obo.28.1377842467741;
        Thu, 29 Aug 2013 23:01:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id pt4sm35789363obb.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233398>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt |  6 +++++-
 Documentation/git-revert.txt      |  6 +++++-
 builtin/revert.c                  |  1 +
 sequencer.c                       | 11 +++++++----
 sequencer.h                       |  1 +
 5 files changed, 19 insertions(+), 6 deletions(-)

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
index 6e7cb2a..7a7fde6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -102,6 +102,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	int contin = 0;
 	int rollback = 0;
 	struct option options[] = {
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick sequence")),
diff --git a/sequencer.c b/sequencer.c
index c387828..d6199e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -395,6 +395,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
@@ -634,9 +636,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	if (opts->skip_empty && is_index_unchanged() == 1) {
-		warning(_("skipping %s... %s"),
-			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
-			msg.subject);
+		if (!opts->quiet)
+			warning(_("skipping %s... %s"),
+				find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+				msg.subject);
 		goto leave;
 	}
 	allow = allow_empty(opts, commit);
@@ -666,7 +669,7 @@ static void prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
+	if (!opts->revs->commits && !opts->quiet)
 		error(_("empty commit set passed"));
 }
 
diff --git a/sequencer.h b/sequencer.h
index 3b04844..d37c003 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -35,6 +35,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int skip_empty;
+	int quiet;
 
 	int mainline;
 
-- 
1.8.4-fc
