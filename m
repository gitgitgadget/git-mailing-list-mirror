From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid set-but-not-used warning
Date: Fri, 29 Apr 2011 11:42:41 +0200
Message-ID: <874o5hv1f2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 11:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFkDw-0007DK-AU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab1D2Jmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 05:42:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:40242 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab1D2Jmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:42:50 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3AFDD9401F5
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 11:42:43 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A8AE660110; Fri, 29 Apr 2011 11:42:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172443>

I noticed this on master (also applies to next), compiling with gcc-4.6:

    diffcore-rename.c: In function 'diffcore_rename':
    diffcore-rename.c:501:18: warning: variable 'num_src' set but not used \
      [-Wunused-but-set-variable]

Here's the fix:

-- >8 --
Subject: [PATCH] avoid set-but-not-used warning

* diffcore-rename.c (diffcore_rename): Remove declaration and set.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 diffcore-rename.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f62587e..3d65bb3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -498,7 +498,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, num_src, dst_cnt;
+	int num_create, dst_cnt;
 	struct progress *progress = NULL;

 	if (!minimum_score)
@@ -554,7 +554,6 @@ void diffcore_rename(struct diff_options *options)
 	 * files still remain as options for rename/copies!)
 	 */
 	num_create = (rename_dst_nr - rename_count);
-	num_src = rename_src_nr;

 	/* All done? */
 	if (!num_create)
--
1.7.5.452.gcf2d0
