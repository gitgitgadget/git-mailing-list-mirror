From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Allow abbreviations in the first refspec to be merged
Date: Fri, 28 Sep 2007 19:34:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709281932550.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbPLn-0003dI-Ja
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 01:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbXI1XeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 19:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbXI1XeT
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 19:34:19 -0400
Received: from iabervon.org ([66.92.72.58]:43573 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbXI1XeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 19:34:19 -0400
Received: (qmail 14512 invoked by uid 1000); 28 Sep 2007 23:34:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 23:34:17 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59431>

The config item for a refspec side and the ref name that it matches
aren't necessarily character-for-character identical. We actually want
to merge a ref by default if: there is no per-branch config, it is the
found result of looking for the match for the first refspec, and the
first refspec is not a pattern. Beyond that, anything that
get_fetch_map() thinks matches is fine.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This fixes the configuration you gave for me, and passes all the 
usual tests.

 builtin-fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 2f639cc..ac68ff5 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -102,7 +102,7 @@ static struct ref *get_ref_map(struct transport *transport,
 				    remote->fetch[i].dst[0])
 					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
-				    !strcmp(remote->fetch[0].src, ref_map->name))
+				    !remote->fetch[0].pattern)
 					ref_map->merge = 1;
 			}
 			if (has_merge)
-- 
1.5.3.2.1107.ge9eab8-dirty
