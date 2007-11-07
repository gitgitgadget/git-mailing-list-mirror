From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] git-stash: Fix listing stashes
Date: Wed,  7 Nov 2007 15:10:27 -0600
Message-ID: <1194469827-17037-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: gitster@pobox.com, nanako3@bluebottle.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 22:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpsM3-00021w-Lo
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXKGVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbXKGVWQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:22:16 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:44474 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbXKGVWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:22:16 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lA7LLaIF027325;
	Wed, 7 Nov 2007 14:21:36 -0700 (MST)
Received: from emmedve1-12.am.freescale.net ([10.82.124.180])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA7LLZt4027816;
	Wed, 7 Nov 2007 15:21:35 -0600 (CST)
Received: by emmedve1-12.am.freescale.net (Postfix, from userid 1000)
	id 7B192449CE5; Wed,  7 Nov 2007 15:10:27 -0600 (CST)
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63861>

Commit bc9e7399af3790918140c30a5b2c85bf9a8f1ad3 "reverted" commit
f12e925ac23ad6169e046cfe05b8438a1611ad58

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 git-stash.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index e556f42..534eb16 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -22,7 +22,7 @@ no_changes () {
 clear_stash () {
 	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
 	then
-		git update-ref -d refs/stash $current
+		git update-ref -d $ref_stash $current
 	fi
 }
 
@@ -93,6 +93,10 @@ save_stash () {
 		clear_stash || die "Cannot initialize stash"
 
 	create_stash "$stash_msg"
+
+	# Make sure the reflog for stash is kept.
+	: >>"$GIT_DIR/logs/$ref_stash"
+
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
 	printf >&2 'Saved "%s"\n' "$stash_msg"
-- 
1.5.3.GIT
