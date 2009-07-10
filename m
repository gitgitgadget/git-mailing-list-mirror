From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 1/5] unpack-trees.c: work around run-time array initialization flaw on IRIX 6.5
Date: Fri, 10 Jul 2009 12:10:43 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdb-0004l6-MJ
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbZGJRLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbZGJRLq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:11:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57227 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbZGJRLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:46 -0400
Received: by mail.nrlssc.navy.mil id n6AHBjCa023477; Fri, 10 Jul 2009 12:11:45 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 17:11:44.0458 (UTC) FILETIME=[80126AA0:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123066>

The c99 MIPSpro Compiler version 7.4.4m on IRIX 6.5 does not properly
initialize run-time initialized arrays.  An array which is initialized with
fewer elements than the length of the array should have the unitialized
elements initialized to zero.  This compiler only initializes the remaining
elements when the last element is a static parameter.  So work around it
by adding a "NULL" initialization parameter.
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 05d0bb1..7894c07 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -128,7 +128,7 @@ static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_o
 
 static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	struct cache_entry *src[5] = { ce, };
+	struct cache_entry *src[5] = { ce, NULL, };
 
 	o->pos++;
 	if (ce_stage(ce)) {
-- 
1.6.4.rc0.5.g76f7cf
