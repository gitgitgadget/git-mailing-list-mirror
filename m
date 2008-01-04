From: Jeff King <peff@peff.net>
Subject: [PATCH] add--interactive: allow diff colors without interactive
	colors
Date: Fri, 4 Jan 2008 03:35:21 -0500
Message-ID: <20080104083521.GB3354@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAi26-0008NN-3l
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbYADIfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbYADIfZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:35:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1909 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbYADIfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:35:24 -0500
Received: (qmail 15892 invoked by uid 111); 4 Jan 2008 08:35:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:35:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:35:21 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69561>

Users with color.diff set to true/auto will not see color in
"git add -i" unless they also set color.interactive.

However, some users may want just one without the other, so
there's no reason to tie them together.

Note that there is now no way to have color on for "git
diff" but not for diffs from "git add -i"; such a
configuration seems unlikely, though.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0cdd800..aaa9b24 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -22,16 +22,16 @@ if ($use_color) {
 	$header_color = $repo->get_color("color.interactive.header", "bold");
 	$help_color = $repo->get_color("color.interactive.help", "red bold");
 	$normal_color = $repo->get_color("", "reset");
+}
 
-	# Do we also set diff colors?
-	$diff_use_color = $repo->get_colorbool('color.diff');
-	if ($diff_use_color) {
-		$new_color = $repo->get_color("color.diff.new", "green");
-		$old_color = $repo->get_color("color.diff.old", "red");
-		$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
-		$metainfo_color = $repo->get_color("color.diff.meta", "bold");
-		$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");
-	}
+# Do we also set diff colors?
+$diff_use_color = $repo->get_colorbool('color.diff');
+if ($diff_use_color) {
+	$new_color = $repo->get_color("color.diff.new", "green");
+	$old_color = $repo->get_color("color.diff.old", "red");
+	$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
+	$metainfo_color = $repo->get_color("color.diff.meta", "bold");
+	$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");
 }
 
 sub colored {
-- 
1.5.4.rc2.1122.g6954-dirty
