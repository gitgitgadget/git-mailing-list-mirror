From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix clone not to ignore depth when performing a local clone
Date: Tue, 11 Dec 2007 06:47:31 +0000
Message-ID: <20071211064731.GA30525@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 09:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J20Oa-0000YV-LN
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 09:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbXLKIWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 03:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXLKIWz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 03:22:55 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:34006 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbXLKIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 03:22:55 -0500
X-Greylist: delayed 5720 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2007 03:22:55 EST
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1J1ytw-0003kf-UB
	for git@vger.kernel.org; Tue, 11 Dec 2007 06:47:33 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBB6lWTn030849
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 06:47:32 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBB6lWwJ030848
	for git@vger.kernel.org; Tue, 11 Dec 2007 06:47:32 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67823>

When git-clone detects that it can perform a local clone it
follows a path that silently ignores the depth parameter.

Presumably if the user explicitly requests a shallow clone they
have a reason to prefer a space efficient clone of just the recent
history so bypass the local magic if the user specifies the depth
parameter.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-clone.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index ecf9d89..fb124d8 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -205,7 +205,10 @@ fi
 # it is local
 if base=$(get_repo_base "$repo"); then
 	repo="$base"
-	local=yes
+	if test -z "$depth"
+	then
+		local=yes
+	fi
 fi
 
 dir="$2"
-- 
1.5.3.7.2242.gcc945-dirty
