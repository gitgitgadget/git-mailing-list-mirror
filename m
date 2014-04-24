From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 03/12] revert/cherry-pick: add --quiet option
Date: Wed, 23 Apr 2014 21:44:42 -0500
Message-ID: <1398307491-21314-4-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pi-00085H-N2
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaDXC4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:56:14 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:62598 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaDXCz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:29 -0400
Received: by mail-ob0-f182.google.com with SMTP id uy5so2035923obc.13
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9d2KkcyN8gTQObJlN/Yg3ZPIJaoRUX7E0gm3oWtKTs4=;
        b=XK6ht+RWrVb+pXQ9bcTnzjFkDn/O7FIwN8tVL4g09wcauTvlsJ8L11ZsEuzpN/ti1b
         T6wWXKqxL5V/fdA3zERJHZJ7xuDZFsJdmOloqKp+MV2HPSLaakH1P8j8x8EvzzLTU8ae
         fPNb9UQTZhQ858nhzAQsPWlvJT5jPO/v2Voyb7Pu5wznzCjvG55iObzyhs58fJSvDBCB
         XE2gHSO2f+m7kyuoYPIo0NQgyyQ/iZwqYKDmyZPj5c1FRiPLepmaqyQ+SCbUP4hlurj5
         55I70ZaafbrHIDLb2VpoPHMVV/omYeNAeuHvhT+yWHwEz6+yqBA84fcTZ0YYwAOOCQfk
         ZGFA==
X-Received: by 10.182.144.194 with SMTP id so2mr40603906obb.31.1398308128604;
        Wed, 23 Apr 2014 19:55:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm5753501obm.2.2014.04.23.19.55.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246927>

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
index 2de67a5..2b51136 100644
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
index 9946ecd..c8149ca 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -77,6 +77,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char *me = action_name(opts);
 	int cmd = 0;
 	struct option options[] = {
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
diff --git a/sequencer.c b/sequencer.c
index 951f51d..e8239ac 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -396,6 +396,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
@@ -635,9 +637,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
@@ -667,7 +670,7 @@ static void prepare_revs(struct replay_opts *opts)
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
1.9.2+fc1.2.gfbaae8c
