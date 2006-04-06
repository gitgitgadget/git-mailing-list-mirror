From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] gitk: Fix Tcl error when merge has interesting diffs.
Date: Thu, 06 Apr 2006 13:16:33 +0100
Message-ID: <20060406121633.22307.12482.stgit@ponder.ncipher.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Apr 06 14:16:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRTPh-0004Rn-7y
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 14:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWDFMQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 08:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDFMQf
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 08:16:35 -0400
Received: from mail.ncipher.com ([82.108.130.24]:41907 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S1751055AbWDFMQe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 08:16:34 -0400
Received: from ponder.ncipher.com ([172.23.135.197])
	by mail.ncipher.com with smtp (Exim 3.34 #1)
	id 1FRTPd-00029C-00
	for git@vger.kernel.org; Thu, 06 Apr 2006 13:16:33 +0100
Received: (qmail 22315 invoked from network); 6 Apr 2006 12:16:33 -0000
Received: from localhost (HELO ponder.ncipher.com) (127.0.0.1)
  by localhost with SMTP; 6 Apr 2006 12:16:33 -0000
To: git@vger.kernel.org
User-Agent: StGIT/0.8-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18469>

From: Mark Wooding <mdw@distorted.org.uk>

If a merge commit with nontrivial diffs is selected, gitk reports a Tcl
error:

wrong # args: should be "getmergediffline mdf id np"
    while executing
"getmergediffline file7 9fdb62af92c741addbea15545f214a6e89460865"

Change 79b2c75e... introduced the `np' argument to getmergediffline, but
failed to pass it when the function detaches and reattaches to the file
to make way for an update.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 26fa79a..3b92820 100755
--- a/gitk
+++ b/gitk
@@ -2700,7 +2700,7 @@ proc getmergediffline {mdf id np} {
 	incr nextupdate 100
 	fileevent $mdf readable {}
 	update
-	fileevent $mdf readable [list getmergediffline $mdf $id]
+	fileevent $mdf readable [list getmergediffline $mdf $id $np]
     }
 }
 
