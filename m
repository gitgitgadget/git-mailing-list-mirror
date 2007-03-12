From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/7] Use RUN_GIT_CMD to run push backends
Date: Mon, 12 Mar 2007 19:00:15 -0400
Message-ID: <20070312230015.GC16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtVd-0006JJ-4d
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbXCLXAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbXCLXAV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:00:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58227 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbXCLXAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:00:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtUt-0004Pf-5A; Mon, 12 Mar 2007 19:00:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02E9020FBAE; Mon, 12 Mar 2007 19:00:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42088>

If we hand run_command RUN_GIT_CMD rather than 0 it will use
the execv_git_cmd path rather than execvp at the OS level.
This is typically the preferred way of running another Git
utility.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 6ab9a28..70b1168 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -323,10 +323,10 @@ static int do_push(const char *repo)
 		int dest_refspec_nr = refspec_nr;
 		const char **dest_refspec = refspec;
 		const char *dest = uri[i];
-		const char *sender = "git-send-pack";
+		const char *sender = "send-pack";
 		if (!prefixcmp(dest, "http://") ||
 		    !prefixcmp(dest, "https://"))
-			sender = "git-http-push";
+			sender = "http-push";
 		else if (thin)
 			argv[dest_argc++] = "--thin";
 		argv[0] = sender;
@@ -336,7 +336,7 @@ static int do_push(const char *repo)
 		argv[dest_argc] = NULL;
 		if (verbose)
 			fprintf(stderr, "Pushing to %s\n", dest);
-		err = run_command_v_opt(argv, 0);
+		err = run_command_v_opt(argv, RUN_GIT_CMD);
 		if (!err)
 			continue;
 		switch (err) {
-- 
1.5.0.3.985.gcf0b4
