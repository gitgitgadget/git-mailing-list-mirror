From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Avoid a floating point exception in merge-recursive.
Date: Sun, 14 Jan 2007 03:11:23 -0500
Message-ID: <20070114081123.GA19566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 09:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H60Sg-0004W9-M3
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 09:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXANIL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 03:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbXANIL2
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 03:11:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50528 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbXANIL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 03:11:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H60Sa-00042s-4F; Sun, 14 Jan 2007 03:11:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3BB720FBAE; Sun, 14 Jan 2007 03:11:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36796>

If we have no files selected for processing yet but we try to
produce a status output this would cause a division by zero error
when computing the percent done.  Last time I talked to a user,
crashing a program over performing an undefined operation isn't
very nice.  So instead lets set the percentage done to 0.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is on top of the merge-recursive series I just sent.
 You may already have it fixed in your tree, or maybe not.

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c4e21bc..2a89461 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -182,7 +182,7 @@ static void setup_progress_signal(void)
 
 static void display_progress()
 {
-	unsigned percent = merged_cnt * 100 / total_cnt;
+	unsigned percent = total_cnt ? merged_cnt * 100 / total_cnt : 0;
 	if (progress_update || percent != last_percent) {
 		fprintf(stderr, "%4u%% (%u/%u) done\r",
 			percent, merged_cnt, total_cnt);
-- 
1.5.0.rc1.g4494
