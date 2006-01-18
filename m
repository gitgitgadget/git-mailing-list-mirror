From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-fetch-pack: really do not ask for funny refs
Date: Thu, 19 Jan 2006 00:24:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601190023390.15298@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 19 00:24:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzMev-00048J-Ec
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 00:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWARXYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWARXYG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 18:24:06 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16361 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161049AbWARXYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 18:24:05 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A06341412FC; Thu, 19 Jan 2006 00:24:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 939191C9D;
	Thu, 19 Jan 2006 00:24:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 784D61874;
	Thu, 19 Jan 2006 00:24:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5FCFC1412FC; Thu, 19 Jan 2006 00:24:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14870>


If git-fetch-pack was called with out any refspec, it would ask the server
for funny refs. That cannot work, since the funny refs are not marked
as OUR_REF by upload-pack, which just exits with an error.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

718ad2d76a6c7d350d63c0660aeb69518b765310
diff --git a/fetch-pack.c b/fetch-pack.c
index d34f322..27f5d2a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -262,9 +262,6 @@ static void filter_refs(struct ref **ref
 {
 	struct ref *prev, *current, *next;
 
-	if (!nr_match)
-		return;
-
 	for (prev = NULL, current = *refs; current; current = next) {
 		next = current->next;
 		if ((!memcmp(current->name, "refs/", 5) &&
-- 
1.1.3.g0bf8-dirty
