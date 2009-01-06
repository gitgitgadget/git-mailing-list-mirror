From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] diff --no-index: test for pager after option parsing
Date: Wed,  7 Jan 2009 00:56:03 +0100
Message-ID: <1231286163-9422-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 00:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKLnV-0004nu-Dg
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 00:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZAFXz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZAFXz5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 18:55:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:55135 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbZAFXz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 18:55:56 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 00:55:55 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 00:55:55 +0100
X-Mailer: git-send-email 1.6.1.229.g1af75.dirty
X-OriginalArrivalTime: 06 Jan 2009 23:55:55.0033 (UTC) FILETIME=[501EC090:01C9705A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104739>

We need to parse options before we can see if --exit-code was
provided.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

I noticed this while working on the earlier patch for diff --no-index.
It seems like the right thing to do (and passes tests), but I don't
have a clue about git's normal setup sequences, so I'm flagging it
RFC.


 diff-no-index.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index b60d345..f655f64 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -198,13 +198,6 @@ void diff_no_index(struct rev_info *revs,
 		die("git diff %s takes two paths",
 		    no_index ? "--no-index" : "[--no-index]");
 
-	/*
-	 * If the user asked for our exit code then don't start a
-	 * pager or we would end up reporting its exit code instead.
-	 */
-	if (!DIFF_OPT_TST(&revs->diffopt, EXIT_WITH_STATUS))
-		setup_pager();
-
 	diff_setup(&revs->diffopt);
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -222,6 +215,13 @@ void diff_no_index(struct rev_info *revs,
 		}
 	}
 
+	/*
+	 * If the user asked for our exit code then don't start a
+	 * pager or we would end up reporting its exit code instead.
+	 */
+	if (!DIFF_OPT_TST(&revs->diffopt, EXIT_WITH_STATUS))
+		setup_pager();
+
 	if (prefix) {
 		int len = strlen(prefix);
 
-- 
tg: (e9b8523..) t/diff-no-index-status (depends on: origin/master)
