From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-stash: use git rev-parse -q
Date: Tue,  2 Dec 2008 01:56:09 +0100
Message-ID: <1228179369-3766-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 01:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Ja9-0008BE-Iy
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 01:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYLBA4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 19:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYLBA4N
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 19:56:13 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43920 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYLBA4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 19:56:12 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 70BEA446CDA;
	Tue,  2 Dec 2008 01:56:10 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9F47D19D92A; Tue,  2 Dec 2008 01:56:09 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102084>

Don't redirect stderr to /dev/null, use -q to suppress the output on
stderr.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-stash.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index b9ace99..c0532e8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -30,7 +30,7 @@ clear_stash () {
 	then
 		die "git stash clear with parameters is unimplemented"
 	fi
-	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=$(git rev-parse -q --verify $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -129,7 +129,7 @@ save_stash () {
 }
 
 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse -q --verify $ref_stash >/dev/null
 }
 
 list_stash () {
@@ -229,16 +229,16 @@ drop_stash () {
 	fi
 	# Verify supplied argument looks like a stash entry
 	s=$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+	git rev-parse -q --verify "$s:"   > /dev/null &&
+	git rev-parse -q --verify "$s^1:" > /dev/null &&
+	git rev-parse -q --verify "$s^2:" > /dev/null ||
 		die "$*: not a valid stashed state"
 
 	git reflog delete --updateref --rewrite "$@" &&
 		echo "Dropped $* ($s)" || die "$*: Could not drop stash entry"
 
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
+	git rev-parse -q --verify "$ref_stash@{0}" > /dev/null || clear_stash
 }
 
 apply_to_branch () {
-- 
1.6.0.4
