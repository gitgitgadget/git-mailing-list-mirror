From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Remove unnecessary found variable from describe.
Date: Thu, 25 Jan 2007 12:40:03 -0500
Message-ID: <20070125174003.GB13276@spearce.org>
References: <2d9c5cd428a8962a64628a4e429263576bc46762.1169746766.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8a9-0007jS-QZ
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbXAYRkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXAYRkK
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:40:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41333 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030479AbXAYRkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:40:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA8Zu-0008NG-N0; Thu, 25 Jan 2007 12:40:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED12920FBAE; Thu, 25 Jan 2007 12:40:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <2d9c5cd428a8962a64628a4e429263576bc46762.1169746766.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37748>

Junio added the found variable to enforce commit date order when two
tags have the same distance from the requested commit.  Except it is
unnecessary as match_cnt is already used to record how many possible
tags have been identified thus far.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index d8ff621..14c712a 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -101,7 +101,6 @@ static void describe(const char *arg, int last_one)
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
-	int found = 0;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -137,7 +136,7 @@ static void describe(const char *arg, int last_one)
 				t->name = n;
 				t->depth = seen_commits - 1;
 				t->flag_within = 1u << match_cnt;
-				t->found_order = found++;
+				t->found_order = match_cnt;
 				c->object.flags |= t->flag_within;
 				if (n->prio == 2)
 					annotated_cnt++;
-- 
1.5.0.rc2.g18af
