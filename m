From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 12:39:54 -0500
Message-ID: <20070125173954.GA13276@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8a1-0007gT-Kl
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXAYRkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbXAYRkF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:40:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41327 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030477AbXAYRkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:40:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA8Zl-0008KL-Ln; Thu, 25 Jan 2007 12:39:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 102D920FBAE; Thu, 25 Jan 2007 12:39:55 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37747>

Junio C Hamano <junkio@cox.net>:
> However, I suspect that we could do better with Shawn's new
> fangled describe implementation that actually counts the
> distance between what is described and the tag.  We could add
> "number of commits since the tag" somewhere, to describe:
>
>   v2.6.20-rc5-256-g419dd83
>   v2.6.20-rc5-217-gde14569
>
> to say that the first one has 256 commits accumulated since the
> given tag "v2.6.20-rc5" and the second one has only 217
> commits, to get the sense of how busy the development activity
> is.
>
> Is it useful?  That is something I am not sure.

Yes, its very useful.  If you get two different describes at different
times from a non-rewinding branch and they both come up with the same
tag name, you can tell which is the 'newer' one by distance.  This is
rather common in practice, so its incredibly useful.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index e7b8f95..d8ff621 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -189,7 +189,8 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	printf("%s-g%s\n", all_matches[0].name->path,
+	printf("%s-%i-g%s\n", all_matches[0].name->path,
+		   all_matches[0].depth,
 		   find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
-- 
1.5.0.rc2.g18af
