From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Wed,  6 Mar 2013 22:32:57 +0200
Message-ID: <1362601978-16911-2-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 22:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLs4-0002Wz-HC
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab3CFV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:27:05 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:59624 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753936Ab3CFV1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:27:04 -0500
X-Greylist: delayed 3242 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 16:27:04 EST
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id EE8E8DC15A2
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 21:44:05 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 6 Mar 2013 22:33:47 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 6 Mar 2013 22:33:45 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc2.5.g1a80410.dirty
In-Reply-To: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 12117216273725427935
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -48
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -48
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217548>

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
making the resulting diff clearer.  Whereas if you use blue as the
current branch, then there is no single colour highlighting changes -
a green line in the result could be a change, but it could also be
something already in the current branch that isn't changed by the merge.

There is no need to swap LOCAL/REMOTE order for difftool; P4Merge is
symmetrical in this case, and a 0- or 1-revision difftool invocation
already gives the working tree ("ours") on the right in green, matching
Perforce's equivalent "Diff Against Have Revision". And you couldn't
swap it anyway, as it would make 2-revision difftool invocation
back-to-front.

Note that P4Merge now shows "ours" on the right for both diff and merge,
unlike other diff/mergetools, which always have REMOTE on the right.
But observe that REMOTE is the working tree (ie "ours") for a diff,
while it's another branch (ie "theirs") for a merge.

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
1.8.2.rc2.5.g1a80410.dirty
