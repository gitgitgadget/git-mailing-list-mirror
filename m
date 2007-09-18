From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/5] builtin-fetch: Don't segfault on "fetch +foo"
Date: Tue, 18 Sep 2007 04:54:48 -0400
Message-ID: <20070918085448.GA5390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYru-0001jx-7R
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbXIRIyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbXIRIyx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:54:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52369 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbXIRIyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYqy-00067Y-LH; Tue, 18 Sep 2007 04:54:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 108B120FBAE; Tue, 18 Sep 2007 04:54:48 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58548>

If we are fetching something and were configured to do a forced
fetch and have no local ref to store the fetched object into we
cannot mark the local ref as having a forced update.  Instead we
should just silently discard the + request.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 73a34c9..af3c46b 100644
--- a/remote.c
+++ b/remote.c
@@ -875,8 +875,7 @@ int get_fetch_map(struct ref *remote_refs,
 					 refspec->src : "HEAD");
 
 		ref_map->peer_ref = get_local_ref(refspec->dst);
-
-		if (refspec->force)
+		if (ref_map->peer_ref && refspec->force)
 			ref_map->peer_ref->force = 1;
 	}
 
-- 
1.5.3.1.1000.g7319b
