From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Cleanup unnecessary break in remote.c
Date: Tue, 25 Sep 2007 00:13:19 -0400
Message-ID: <20070925041319.GB11363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia1no-0000qK-Bj
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 06:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXIYENX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 00:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbXIYENX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 00:13:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45079 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbXIYENW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 00:13:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ia1nU-00073p-TI; Tue, 25 Sep 2007 00:13:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5C35020FBAE; Tue, 25 Sep 2007 00:13:19 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59089>

This simple change makes the body of "case 0" easier to read; no
matter what the value of matched_src is we want to break out of
the switch and not fall through.  We only want to display an error
if matched_src is NULL, as this indicates there is no local branch
matching the input.

Also modified the default case's error message so it uses one less
line of text.  Even at 8 column per tab indentation we still don't
break 80 columns with this new formatting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index ac354f3..2166a2b 100644
--- a/remote.c
+++ b/remote.c
@@ -598,15 +598,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		 * way to delete 'other' ref at the remote end.
 		 */
 		matched_src = try_explicit_object_name(rs->src);
-		if (matched_src)
-			break;
-		error("src refspec %s does not match any.",
-		      rs->src);
+		if (!matched_src)
+			error("src refspec %s does not match any.", rs->src);
 		break;
 	default:
 		matched_src = NULL;
-		error("src refspec %s matches more than one.",
-		      rs->src);
+		error("src refspec %s matches more than one.", rs->src);
 		break;
 	}
 
-- 
1.5.3.2.124.g2456-dirty
