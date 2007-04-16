From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Have sample update hook not refuse deleting a branch through push.
Date: Mon, 16 Apr 2007 08:31:35 +0000
Message-ID: <20070416083135.7528.qmail@3626b961fc9db3.315fe32.mid.smarden.org>
References: <20070416083042.7415.qmail@5f69bf745847ea.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 10:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMcJ-0006KP-DB
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXDPIbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbXDPIbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:31:16 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46412 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965044AbXDPIbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:31:15 -0400
Received: (qmail 7529 invoked by uid 1000); 16 Apr 2007 08:31:35 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070416083042.7415.qmail@5f69bf745847ea.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44623>

source ref might be 0000...0000 to delete a branch through git-push,
'git <remote> push :<branch>'.  The update hook should not decline this.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--update |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 0dcb1ad..9d3795c 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -41,7 +41,12 @@ if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file t
 fi
 
 # --- Check types
-newrev_type=$(git-cat-file -t $newrev)
+# if $newrev is 0000...0000, it's a commit to delete a branch
+if [ -z "${newrev##0*}" ]; then
+	newrev_type=commit
+else
+	newrev_type=$(git-cat-file -t $newrev)
+fi
 
 case "$refname","$newrev_type" in
 	refs/tags/*,commit)
-- 
1.5.1.1
