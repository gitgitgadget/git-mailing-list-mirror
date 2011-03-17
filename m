From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFD 1/2] revision.c: rename --merges to --merges-only
Date: Thu, 17 Mar 2011 12:33:57 +0100
Message-ID: <2505df2aeeedd22a9918bf242a9ebeada9fe8adb.1300359256.git.git@drmicha.warpmail.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 12:37:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0BWJ-0007TZ-DD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1CQLhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 07:37:33 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52276 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910Ab1CQLhb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 07:37:31 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AFEF920A8A
	for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:37:30 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Mar 2011 07:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=pWdLEN1D1Eu5h3LCMXHWWzRdFa8=; b=J6QTCRAaGCC0pvDLZhtWFvgfbgg5H76p/ltH57PtbvKdy0eS8V5Nqid9syJHu+DOyway5oa+jsl04OiUdWzW2dqVG6Ur3PaT1Z6LyHhzh87vmSiwtY/ukhZwTcejZgqLtfzhy8I+5Wx/LDPl/AyD2FztworCbl3KMOfk/KAGcMo=
X-Sasl-enc: Fl4QisGzmQqIOAqQhGIRP7Qum9kpYnGl/11l7DWfeqMi 1300361850
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 02B0A4024BE;
	Thu, 17 Mar 2011 07:37:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <cover.1300359256.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169238>

Users have a right to expect that --no-foo is the opposite of --foo and
undoes its effect. Since "--no-merges" means "exclude merges" it is
natural to expect that "--merges" means "include merges", but in fact it
means "merges only". Rename it accordingly.

As a side effect, this makes the option name coincide with the rev->flag
(modulo - -> _).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    2 +-
 Documentation/git-stash.txt            |    2 +-
 Documentation/rev-list-options.txt     |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 revision.c                             |    2 +-
 submodule.c                            |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index b08dfbc..020e585 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	     [ \--max-age=<timestamp> ]
 	     [ \--min-age=<timestamp> ]
 	     [ \--sparse ]
-	     [ \--merges ]
+	     [ \--merges-only ]
 	     [ \--no-merges ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 79abc38..eccafcb 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -246,7 +246,7 @@ repository, but not reachable any more:
 ----------------------------------------------------------------
 git fsck --unreachable |
 grep commit | cut -d\  -f3 |
-xargs git log --merges --no-walk --grep=WIP
+xargs git log --merges-only --no-walk --grep=WIP
 ----------------------------------------------------------------
 
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5c6850f..78ea305 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -70,7 +70,7 @@ endif::git-rev-list[]
 
 	Stop when a given path disappears from the tree.
 
---merges::
+--merges-only::
 
 	Print only merge commits.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ccdc172..298dddc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1570,7 +1570,7 @@ _git_ls_tree ()
 __git_log_common_options="
 	--not --all
 	--branches --tags --remotes
-	--first-parent --merges --no-merges
+	--first-parent --merges-only --no-merges
 	--max-count=
 	--max-age= --since= --after=
 	--min-age= --until= --before=
diff --git a/revision.c b/revision.c
index e96c281..bd2fedd 100644
--- a/revision.c
+++ b/revision.c
@@ -1276,7 +1276,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_all = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
-	} else if (!strcmp(arg, "--merges")) {
+	} else if (!strcmp(arg, "--merges-only")) {
 		revs->merges_only = 1;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->no_merges = 1;
diff --git a/submodule.c b/submodule.c
index e9f2b19..6cae159 100644
--- a/submodule.c
+++ b/submodule.c
@@ -423,7 +423,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	int contains_another;
 
 	char merged_revision[42];
-	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
+	const char *rev_args[] = { "rev-list", "--merges-only", "--ancestry-path",
 				   "--all", merged_revision, NULL };
 	struct rev_info revs;
 	struct setup_revision_opt rev_opts;
-- 
1.7.4.1.464.gf81ff
