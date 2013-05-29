From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Tue, 28 May 2013 22:56:27 -0500
Message-ID: <1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXX4-00035O-FB
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934997Ab3E2D6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:31 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:46109 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934944Ab3E2D63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:29 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so3105807obc.13
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T0d8tQr6rpHpyHJU+PHwEWFjcOW3LsVD7YIirroTD4U=;
        b=npGRnEheVeKEvZyWnRtCDCLOdtTDnFBZ7yNssdTBrIQut875EHbilyeSRKIfI1HMly
         S9hbOJl/yZdkoD0xm/yBi5qljscdpe6cEmmSUTUJcuyZhRmcAWiWaJmveWbkG86FcLAY
         Sw1efvBy/o4pWaiBnC0zRL4JLQYlosth3VfIKsoI+ALttkcYE9wFchgdEB7j/uZZbi2s
         PKdIs+gNYjH7YoiLE2ygXqbPKTcrJhTWRxJOsqFsIVAMa65bCT0lIrY0Quli1kAUdYRT
         X3V+6/kT8JZErqN/odTXJxLzzDEKKkfAJxw+7yiWxmqS8ndPR5Y2/kJppksXJUAhkD/3
         KOzg==
X-Received: by 10.182.39.226 with SMTP id s2mr505166obk.46.1369799909235;
        Tue, 28 May 2013 20:58:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm38357802obc.0.2013.05.28.20.58.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225721>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt | 6 +++++-
 Documentation/git-revert.txt      | 6 +++++-
 builtin/revert.c                  | 1 +
 sequencer.c                       | 9 ++++++---
 sequencer.h                       | 1 +
 5 files changed, 18 insertions(+), 5 deletions(-)

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
index cc9c2bc..b7391d6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -466,6 +466,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
@@ -705,9 +707,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
