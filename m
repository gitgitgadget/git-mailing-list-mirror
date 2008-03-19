From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin-gc.c: allow disabling all auto-gc'ing by assigning
 0 to gc.auto
Date: Wed, 19 Mar 2008 16:53:20 -0500
Message-ID: <47E18B50.2080402@nrlssc.navy.mil>
References: <47E18540.4020908@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <jens.axboe@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6Gr-0000Fh-MV
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939187AbYCSVyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939180AbYCSVyb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:54:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55611 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbYCSVy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:54:27 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2JLrLcR002726;
	Wed, 19 Mar 2008 16:53:21 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 19 Mar 2008 16:53:20 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47E18540.4020908@nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Mar 2008 21:53:20.0875 (UTC) FILETIME=[A5AA8BB0:01C88A0B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15792001
X-TM-AS-Result: : Yes--2.486000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzc4OC03MDAx?=
	=?us-ascii?B?OTQtNzA2NzI1LTcwOTU4NC03MDMxNzYtNzAzNzg4LTcwMjA0NC03?=
	=?us-ascii?B?MDQ5ODMtNzA5MDA5LTcwMTU5NC03MDQ5MjctNzA4MzM5LTEwNTA0?=
	=?us-ascii?B?MC03MDAxNjAtNzA0MjU3LTE4ODAxOS03MDYyOTAtNzEwMjA3LTMw?=
	=?us-ascii?B?MDAxNS03MDI5MTEtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77565>

The gc.auto configuration variable is somewhat ambiguous now that there
is also a gc.autopacklimit setting. Some users may assume that it controls
all auto-gc'ing. Also, now users must set two configuration variables to
zero when they want to disable autopacking. Since it is unlikely that users
will want to autopack based on some threshold of pack files when they have
disabled autopacking based on the number of loose objects, be nice and allow
a setting of zero for gc.auto to disable all autopacking.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 95917d7..509bb9c 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -160,10 +160,10 @@ static int too_many_packs(void)
 static int need_to_gc(void)
 {
 	/*
-	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
-	 * disable the automatic gc.
+	 * Setting gc.auto to 0 or negative can disable the
+	 * automatic gc.
 	 */
-	if (gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0)
+	if (gc_auto_threshold <= 0)
 		return 0;
 
 	/*
-- 
1.5.4.4.481.g5075
