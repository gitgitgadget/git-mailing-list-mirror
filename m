From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-gc --auto: simplify "repack" command line building
Date: Wed, 10 Oct 2007 20:00:27 -0500
Message-ID: <470D75AB.2050404@nrlssc.navy.mil>
References: <470D6509.5020607@nrlssc.navy.mil> <Pine.LNX.4.64.0710110106160.4174@racer.site> <Pine.LNX.4.64.0710101918060.30020@torch.nrlssc.navy.mil> <Pine.LNX.4.64.0710110149100.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 03:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfmPy-0002Lz-A6
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 03:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257AbXJKBAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 21:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbXJKBAl
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 21:00:41 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41606 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250AbXJKBAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 21:00:40 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9B10R2g005481;
	Wed, 10 Oct 2007 20:00:28 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Oct 2007 20:00:27 -0500
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <Pine.LNX.4.64.0710110149100.4174@racer.site>
X-OriginalArrivalTime: 11 Oct 2007 01:00:27.0644 (UTC) FILETIME=[1CD5CBC0:01C80BA2]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--2.418700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ2MDA4LTE1MDY0NC0xNTA2?=
	=?us-ascii?B?NzMtMTA2NDIwLTcwNzQ1MS03MDgxNzktNzA0NDIxLTcwMzc4OC03?=
	=?us-ascii?B?MDAxNjAtNzA0MjU3LTE4ODAxOS03MDYyOTAtNzEwMjA3LTcwMTU3?=
	=?us-ascii?B?Ni03MDI5MTEtNzA0OTgzLTcwNjI0OS03MDk1ODQtNzA1MTAyLTcw?=
	=?us-ascii?B?NDkyNy03MDAzMjQtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60577>

Since "-a" is removed from the base repack command line,
we can simplify how we add additional options to this
command line when using --auto.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 6323e0d..956c32d 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -143,8 +143,6 @@ static int too_many_packs(void)
 
 static int need_to_gc(void)
 {
-	int ac = 0;
-
 	/*
 	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
 	 * disable the automatic gc.
@@ -158,14 +156,10 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	argv_repack[ac++] = "repack";
 	if (too_many_packs())
-		argv_repack[ac++] = "-A";
+		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
-	argv_repack[ac++] = "-d";
-	argv_repack[ac++] = "-l";
-	argv_repack[ac++] = NULL;
 	return 1;
 }
 
-- 
1.5.3.4.208.g729c0
