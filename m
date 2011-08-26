From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/5] git-branch: introduce missing long forms for the options
Date: Fri, 26 Aug 2011 16:05:13 +0200
Message-ID: <c79179fa3476629ce47556c219719495c213f5f9.1314367414.git.git@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx2T-0007ZO-HL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab1HZOF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:05:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47888 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755137Ab1HZOFY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:05:24 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BCC1F20993;
	Fri, 26 Aug 2011 10:05:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 26 Aug 2011 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=FO
	gEppOw9ah62smO0Xp53R9y5vA=; b=KJtnVo1yuTYE1ssTLQGAhPYF1rej5FWkaQ
	nu4hnzjWH8CE6R3GlxyIysAyaQfc+eCKfv9DuaBhgfSAGVZWY9dRqV5hAheEZP+T
	PA/C5kT000KnG58Y/JgCrSRNGPNke2LtqQLUnCMQKtBU9eNZM1CbStCLGqUEukDj
	BTB3OJAGk=
X-Sasl-enc: h7cTaXPgUGiAL51eZySyY5uZEx0ta7S3MBtyDbN3HR6A 1314367523
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F28FB00094;
	Fri, 26 Aug 2011 10:05:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180170>

Long forms are better to memoize, and more reliably uniform across
commands.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'm somewhat torn between --move and --rename for -m. We have no real precedent
besides "git remote rename".

I left out -M and -D because I feel they should really be -m -f resp. -d -f.
---
 Documentation/git-branch.txt |    5 +++++
 builtin/branch.c             |   10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 507b8d0..4c64ac9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -64,6 +64,7 @@ way to clean up all obsolete remote-tracking branches.
 OPTIONS
 -------
 -d::
+--delete::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
 	`--track` or `--set-upstream`.
@@ -72,6 +73,7 @@ OPTIONS
 	Delete a branch irrespective of its merged status.
 
 -l::
+--create-reflog::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
@@ -84,6 +86,7 @@ OPTIONS
 	already. Without `-f` 'git branch' refuses to change an existing branch.
 
 -m::
+--move::
 	Move/rename a branch and the corresponding reflog.
 
 -M::
@@ -100,9 +103,11 @@ OPTIONS
 	Same as `--color=never`.
 
 -r::
+--remotes::
 	List or delete (if used with -d) the remote-tracking branches.
 
 -a::
+--all::
 	List both remote-tracking branches and local branches.
 
 -v::
diff --git a/builtin/branch.c b/builtin/branch.c
index aa705a0..94e41ae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -624,7 +624,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT__COLOR(&branch_use_color, "use colored output"),
-		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
+		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
 		{
 			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
@@ -641,13 +641,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
-		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
+		OPT_SET_INT('a', "all", &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
-		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
+		OPT_BIT('d', "delete", &delete, "delete fully merged branch", 1),
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
-		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
+		OPT_BIT('m', "move", &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
-		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
+		OPT_BOOLEAN('l', "create-reflog", &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
-- 
1.7.6.845.gc3c05
