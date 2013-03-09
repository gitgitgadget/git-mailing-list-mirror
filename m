From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 1/3] mergetools/p4merge: swap LOCAL and REMOTE
Date: Sat,  9 Mar 2013 21:20:58 +0200
Message-ID: <1362856860-15205-2-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362856860-15205-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 20:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPLC-000693-OA
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab3CITVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:21:31 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:38268 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750798Ab3CITVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:21:30 -0500
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id EEA07FF9140
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 20:32:44 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 9 Mar 2013 21:21:25 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 9 Mar 2013 21:21:23 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.7.g77aeedb
In-Reply-To: <1362856860-15205-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 10066389593716199647
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -60
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
X-Spam-Check: DONE|U 0.500001/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -60
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217739>

Reverse LOCAL and REMOTE when invoking P4Merge as a mergetool, so that
the incoming branch is now in the left-hand, blue triangle pane, and the
current branch is in the right-hand, green circle pane.

This change makes use of P4Merge consistent with its built-in help, its
reference documentation, and Perforce itself. But most importantly, it
makes merge results clearer. P4Merge is not totally symmetrical between
left and right; despite changing a few text labels from "theirs/ours" to
"left/right" when invoked manually, it still retains its original
Perforce "theirs/ours" viewpoint.

Most obviously, in the result pane P4Merge shows changes that are common
to both branches in green. This is on the basis of the current branch
being green, as it is when invoked from Perforce; it means that lines in
the result are blue if and only if they are being changed by the merge,
making the resulting diff clearer.

Note that P4Merge now shows "ours" on the right for both diff and merge,
unlike other diff/mergetools, which always have REMOTE on the right.
But observe that REMOTE is the working tree (ie "ours") for a diff,
while it's another branch (ie "theirs") for a merge.

Ours and theirs are reversed for a rebase - see "git help rebase".
However, this does produce the desired "show the results of this commit"
effect in P4Merge - changes that remain in the rebased commit (in your
branch, but not in the new base) appear in blue; changes that do not
appear in the rebased commit (from the new base, or common to both) are
in green. If Perforce had rebase, they'd probably not swap ours/theirs,
but make P4Merge show common changes in blue, picking out our changes in
green. We can't do that, so this is next best.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 mergetools/p4merge | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/p4merge b/mergetools/p4merge
index 8a36916..46b3a5a 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -22,7 +22,7 @@ diff_cmd () {
 merge_cmd () {
 	touch "$BACKUP"
 	$base_present || >"$BASE"
-	"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
+	"$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
 	check_unchanged
 }
 
-- 
1.8.2.rc3.7.g77aeedb
