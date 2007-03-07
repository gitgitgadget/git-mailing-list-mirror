From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/9] Display the null SHA-1 as the base for an OBJ_OFS_DELTA.
Date: Tue, 6 Mar 2007 20:44:08 -0500
Message-ID: <20070307014408.GB26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlED-00070d-IN
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbXCGBoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbXCGBoW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49194 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161158AbXCGBoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCB-0003oZ-1m; Tue, 06 Mar 2007 20:43:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 56C4E20FBAE; Tue,  6 Mar 2007 20:44:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41635>

Because we are currently cheating and never supplying the delta base
for an OBJ_OFS_DELTA we get a random SHA-1 in the delta base field.
Instead lets clear the hash out so its at least all 0's.  This is
somewhat more obvious that something fishy is going on, like we
don't actually have the SHA-1 of the base handy.  :)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6d0a72e..c13ef66 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1200,6 +1200,7 @@ const char *packed_object_info_detail(struct packed_git *p,
 			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
 			if (*delta_chain_length == 0) {
 				/* TODO: find base_sha1 as pointed by curpos */
+				hashclr(base_sha1);
 			}
 			break;
 		case OBJ_REF_DELTA:
-- 
1.5.0.3.863.gf0989
