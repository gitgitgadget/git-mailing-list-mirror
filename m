From: Geoffrey Thomas <geofft@mit.edu>
Subject: [PATCH] diffcore-order: Default the order file to .git/info/order.
Date: Sat, 12 Sep 2009 19:49:48 -0400
Message-ID: <1252799388-16295-1-git-send-email-geofft@mit.edu>
Cc: Geoffrey Thomas <geofft@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 02:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmcgR-000544-KW
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 02:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZIMALD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 20:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbZIMALC
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 20:11:02 -0400
Received: from JIS.MIT.EDU ([18.7.21.84]:53196 "EHLO jis.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbZIMALB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 20:11:01 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Sep 2009 20:11:01 EDT
Received: from localhost.localdomain (DR-WILY.MIT.EDU [18.181.0.233])
	by jis.mit.edu (8.12.8p2/8.12.8) with ESMTP id n8CNoKpN019882;
	Sat, 12 Sep 2009 19:50:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc0.11.g0c3d3.dirty
Spam-Alum-Prob: 0.000027
Spam-Alum-Time: 1.999598
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128320>

Since order files tend to be useful for all operations in the
project/repository, add a default location for the order file, so that
you don't have to specify -O<orderfile> on every diff or similar
operation.

Signed-off-by: Geoffrey Thomas <geofft@mit.edu>
---
 diff.c           |    3 +--
 diffcore-order.c |    6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e1be189..148342c 100644
--- a/diff.c
+++ b/diff.c
@@ -3461,8 +3461,7 @@ void diffcore_std(struct diff_options *options)
 		diffcore_merge_broken();
 	if (options->pickaxe)
 		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
-	if (options->orderfile)
-		diffcore_order(options->orderfile);
+	diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..d116dc9 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -109,6 +109,12 @@ void diffcore_order(const char *orderfile)
 	if (!q->nr)
 		return;
 
+	if (!orderfile) {
+		orderfile = git_path("info/order");
+		if (access(orderfile, R_OK) != 0)
+			return;
+	}
+
 	o = xmalloc(sizeof(*o) * q->nr);
 	prepare_order(orderfile);
 	for (i = 0; i < q->nr; i++) {
-- 
1.5.6.5
