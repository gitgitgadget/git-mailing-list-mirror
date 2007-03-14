From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff-files --quick
Date: Wed, 14 Mar 2007 11:24:06 -0700
Message-ID: <7vveh38z09.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 19:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRY94-00058R-G5
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 19:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbXCNSYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbXCNSYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 14:24:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65505 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbXCNSYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 14:24:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314182407.HITH2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 14:24:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aiQ61W00Y1kojtg0000000; Wed, 14 Mar 2007 14:24:07 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42219>

This teaches git-diff-files backend to exit early under --quick option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * And as an example, this converts diff-files.  Other backends
   will follow, but the most interesting one would be tree-diff.

 diff-lib.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f9a1a10..3ef5d76 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -324,6 +324,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
+		if (revs->diffopt.quick && diff_queued_diff.nr)
+			break;
+
 		if (!ce_path_match(ce, revs->prune_data))
 			continue;
 
-- 
1.5.0.3.1036.g6baf1
