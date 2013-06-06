From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/9] revert/cherry-pick: add --quiet option
Date: Thu,  6 Jun 2013 03:59:02 -0500
Message-ID: <1370509144-31974-8-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4Z-0006NP-Lo
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab3FFJBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:23 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:48310 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab3FFJBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:18 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so4199819obc.41
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZpOmbpRuOxhWjxbiluwMPFav0oqzHev01pwMTONjOTU=;
        b=aAw91FMpmy/XDDkf3hX0RfDIIxp+U2bZebOINESHSZoa6WQtxmoK/uVtAwdhjXX29v
         IY73bM9k9eltz2IieP3H6DBxJho7MDl3ZzNRXFE9LK1GMtfk/hc9S0YVvQSD3a3qAlid
         2Jf8AviAni54viwYfi1FWZo3oyoRfhXjJyWkEsxvZNChAMwqOzxRJTCmKH6fGKplGlwY
         CrW25HSYuSqxl8QEdr7Kkj7/lACn6C93qHzGWllHyYChROXJ03HNqF63/4WM7VRvqdMk
         VK3fkldJjW5JJgVtVxzqLZ+Z3hMaOjSu9WxVB6ER/8iwyTBkLwyruL5ioJNpHTpnC7tl
         Gpqw==
X-Received: by 10.60.162.70 with SMTP id xy6mr17900046oeb.117.1370509278271;
        Thu, 06 Jun 2013 02:01:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm57267011obx.9.2013.06.06.02.01.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226493>

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
diff --git a/sequencer.c b/sequencer.c
index 6d13e63..4b91bd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -472,6 +472,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	if (opts->quiet)
+		argv_array_push(&array, "-q");
 
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
@@ -711,9 +713,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
index 84b9957..6fc416d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -36,6 +36,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int skip_empty;
+	int quiet;
 
 	int mainline;
 
-- 
1.8.3.698.g079b096
