From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] am/pull/rebase/stash: cd_to_toplevel before require_work_tree
Date: Wed, 14 Jul 2010 14:55:21 +0200
Message-ID: <96abf622ca2cf92998ce4ed393ccaa75d95dd9a8.1279112025.git.git@drmicha.warpmail.net>
References: <4C3DB396.2040109@drmicha.warpmail.net>
Cc: Alexander Gladysh <agladysh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 14:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ1Vk-0007EF-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 14:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab0GNM4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 08:56:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38993 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703Ab0GNM4X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 08:56:23 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EB64916EB7D;
	Wed, 14 Jul 2010 08:56:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Jul 2010 08:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=l4LDfHl1vqTCXO2Yy5cDMJPjzzY=; b=ob5hik6J2U+GRtujKlNUOElzDugDJO7xi9Lqg0felKpxR9Hbtbyu9ggY8052nwF8Qg34lHcXjOriELc6CNr2cDb6XpE91WDPtOnIyzcihsIFtX66r0xFWMloxSwsl+s7l3xYilSE/iD4K1gshxh2Q0LFBITP5s8iv7KIdMcuLp0=
X-Sasl-enc: dAijMn9k23V7wjDZnTInobRzQwQxeDckhyuRk/2xsMZD 1279112182
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5AFFD4DED78;
	Wed, 14 Jul 2010 08:56:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
In-Reply-To: <4C3DB396.2040109@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150986>

Currently, "cd_to_toplevel" comes right after "require_work_tree" for
these commands.

Put "cd_to_toplevel" before "require_work_tree" so that these commands
do not die fatally when called with --work-tree or GIT_WORK_TREE
properly set from outside of the work tree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-am.sh     |    2 +-
 git-pull.sh   |    2 +-
 git-rebase.sh |    2 +-
 git-stash.sh  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e7f008c..bf81030 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -39,8 +39,8 @@ rebasing*       (internal use for git-rebase)"
 . git-sh-setup
 prefix=$(git rev-parse --show-prefix)
 set_reflog_action am
-require_work_tree
 cd_to_toplevel
+require_work_tree
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
diff --git a/git-pull.sh b/git-pull.sh
index a09a44e..83c25b9 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -10,8 +10,8 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 set_reflog_action "pull $*"
-require_work_tree
 cd_to_toplevel
+require_work_tree
 
 
 die_conflict () {
diff --git a/git-rebase.sh b/git-rebase.sh
index ab4afa7..96dd34f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -31,8 +31,8 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 set_reflog_action rebase
-require_work_tree
 cd_to_toplevel
+require_work_tree
 
 LF='
 '
diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..4564892 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -13,8 +13,8 @@ USAGE="list [<options>]
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
-require_work_tree
 cd_to_toplevel
+require_work_tree
 
 TMP="$GIT_DIR/.git-stash.$$"
 trap 'rm -f "$TMP-*"' 0
-- 
1.7.2.rc1.212.g850a
