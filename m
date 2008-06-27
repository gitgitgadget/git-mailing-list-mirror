From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] show_stats(): fix stats width calculation
Date: Fri, 27 Jun 2008 02:18:48 +0200
Message-ID: <1214525928-31025-1-git-send-email-dkr+ml.git@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 02:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC1gW-0004os-1T
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 02:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbYF0ASb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 20:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755482AbYF0ASb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:18:31 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:51092 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbYF0ASa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:18:30 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 825C012B6BA;
	Fri, 27 Jun 2008 02:18:29 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 530B712B6B1;
	Fri, 27 Jun 2008 02:18:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.77.gf9a08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86508>

From: Olivier Marin <dkr@freesurf.fr>

Before this patch, name_width becomes negative or null for width values
less than 15 and name_width values greater than 25 (default: 50). This
leads to output random data.

This patch checks for minimal width and name_width values.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 diff.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 44e8790..a85c8ca 100644
--- a/diff.c
+++ b/diff.c
@@ -830,12 +830,12 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
 	 */
-	if (width < name_width + 15) {
-		if (name_width <= 25)
-			width = name_width + 15;
-		else
-			name_width = width - 15;
-	}
+	if (width < 25)
+		width = 25;
+	if (name_width < 10)
+		name_width = 10;
+	else if (width < name_width + 15)
+		name_width = width - 15;
 
 	/* Find the longest filename and max number of changes */
 	reset = diff_get_color_opt(options, DIFF_RESET);
-- 
1.5.6.1.141.ge3ab.dirty
