From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] diff: allow showing a warning message before the diff.
Date: Wed, 11 Apr 2007 13:58:13 -0700
Message-ID: <7vbqhuocgq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 22:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbjtS-000233-J4
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 22:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbXDKU6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXDKU6P
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 16:58:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47342 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030339AbXDKU6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 16:58:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411205814.HNFZ1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 16:58:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lwyD1W00c1kojtg0000000; Wed, 11 Apr 2007 16:58:14 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44255>

This allows the caller to add an informational message at the
beginning of the diff, when output is produced by diff_flush().
It (ab)uses the WHITESPACE color; we should probably have named
that as WARNING color instead, as the existing use is already
about warnings.

Nobody uses this yet, but the next one does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |    7 +++++++
 diff.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index d8f9242..3cdb47a 100644
--- a/diff.c
+++ b/diff.c
@@ -2796,6 +2796,13 @@ void diff_flush(struct diff_options *options)
 	if (!q->nr)
 		goto free_queue;
 
+	if (options->warning) {
+		const char *reset, *set;
+		set = diff_get_color(options->color_diff, DIFF_WHITESPACE);
+		reset = diff_get_color(options->color_diff, DIFF_RESET);
+		printf("%s%s%s\n", set, options->warning, reset);
+	}
+
 	if (output_format & (DIFF_FORMAT_RAW |
 			     DIFF_FORMAT_NAME |
 			     DIFF_FORMAT_NAME_STATUS |
diff --git a/diff.h b/diff.h
index a0d2ce1..2fc86eb 100644
--- a/diff.h
+++ b/diff.h
@@ -48,6 +48,7 @@ struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
+	const char *warning;
 	unsigned recursive:1,
 		 tree_in_recursive:1,
 		 binary:1,
-- 
1.5.1.777.gd14d3
