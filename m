From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 3/7] Ensure tail pointer gets setup correctly when we fetch HEAD only
Date: Sat, 1 Mar 2008 00:24:59 -0500
Message-ID: <20080301052459.GC27300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKE9-0004rx-5G
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbYCAFZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYCAFZE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:25:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48524 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbYCAFZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:25:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVKDU-0000rX-FR; Sat, 01 Mar 2008 00:25:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 88A4A20FBAE; Sat,  1 Mar 2008 00:24:59 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75614>

If we ever decided to append onto the end of this list the tail
pointer must be looking at the right memory cell at the end of
the HEAD ref_map.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 1348a0e..5bce20f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -157,6 +157,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			if (!ref_map)
 				die("Couldn't find remote ref HEAD");
 			ref_map->merge = 1;
+			tail = &ref_map->next;
 		}
 	}
 	ref_remove_duplicates(ref_map);
-- 
1.5.4.3.409.g88113

