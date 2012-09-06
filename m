From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/4] merge: --no-verify to bypass pre-commit hook
Date: Thu,  6 Sep 2012 16:25:57 +0200
Message-ID: <526ce72df2e65572cbbbc72d3f93b4a917562ead.1346939542.git.git@drmicha.warpmail.net>
References: <50487F8A.4050803@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d2G-0002Lq-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab2IFO0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:26:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59856 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756046Ab2IFO0G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:26:06 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C3FB420A2D;
	Thu,  6 Sep 2012 10:26:05 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 06 Sep 2012 10:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=8i
	o93HNBML1WWgNQLDRQmzZ+Dxk=; b=p8Tsn6QlFZPZZSYTVqz9Kd3wDy9/X/btvX
	UPsmyKG/M+hzwSW3g/odqv83RxjH75cYrfgBD8EUqD4JrDl7tveahQibYjxFNZ1I
	gz/XCiG8yI/RW9TwpGuXiVwle6mwbzoojGDu01A2hJ1BaIer8qMc7UnBjaNz3iOt
	jMeSl13gI=
X-Sasl-enc: n3wwD1KyNuUHLDin1iN/VTPcTKguPzVyzBUxQ958Nm8G 1346941565
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5EAD64825F2;
	Thu,  6 Sep 2012 10:26:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <50487F8A.4050803@alum.mit.edu>
In-Reply-To: <cover.1346939542.git.git@drmicha.warpmail.net>
References: <cover.1346939542.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204888>

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-commit hook. The shorthand '-n' is taken by the (non-existing)
'--no-stat' already.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/githooks.txt      | 1 +
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3501ae2..363fbea 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>]
+	[--no-verify] [-s <strategy>] [-X <strategy-option>]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d62e02d..c734e2c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -88,6 +88,7 @@ to modify the commit message.
 
 If the configuration option `merge.usePreCommitHook` is set to `true`
 then 'git merge' invokes this hook whenever it creates a new commit.
+It can be bypassed with the `\--no-verify` option. 
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0bcbe0a..5695fc6 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -70,6 +70,10 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 
+--no-verify::
+	This option bypasses the pre-commit hook.
+	See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin/merge.c b/builtin/merge.c
index a2590a9..58a848f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -60,6 +60,7 @@ static const char *branch;
 static char *branch_mergeoptions;
 static int option_renormalize;
 static int verbosity;
+static int no_verify;
 static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
@@ -199,6 +200,7 @@ static struct option builtin_merge_options[] = {
 		N_("allow fast-forward (default)")),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		N_("abort if fast-forward is not possible")),
+	OPT_BOOLEAN(0, "no-verify", &no_verify, "bypass pre-merge hook"),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
@@ -904,7 +906,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	const char *comment = _(merge_editor_comment);
 	const char *index_file = get_index_file();
 
-	if (use_pre_commit_hook && run_hook(index_file, "pre-commit", NULL))
+	if (use_pre_commit_hook && !no_verify && run_hook(index_file, "pre-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-commit hook could have updated it,
-- 
1.7.12.406.gafd3f81
