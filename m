From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH] Add the option to not sync after a submitting to Perforce.
Date: Fri,  4 Jun 2010 13:33:04 -0400
Message-ID: <1275672784-16371-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 19:39:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKars-00024A-4i
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 19:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0FDRjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 13:39:35 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:43018
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab0FDRje (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 13:39:34 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 13:39:34 EDT
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id Ro9G1e00627AodY54tZfPj; Fri, 04 Jun 2010 17:33:39 +0000
Received: from ben-laptop.rim.net ([71.192.50.29])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id RtZd1e00M0dnthT3ftZebJ; Fri, 04 Jun 2010 17:33:39 +0000
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148431>

When p4->git syncing occurs not on the users machine, but on a central
mirror server there is no local remote.  When a user performs a
'git p4 submit' in this configuration after successfully applying the
patches the p4 submit command will then output a failure because it could
not p4 sync.  This causes users to think their submit failed when in
fact it was successful.

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 contrib/fast-import/git-p4 |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d42b865..2a9771b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -823,6 +823,9 @@ class P4Submit(Command):
             print "All changes applied!"
             chdir(self.oldWorkingDirectory)
 
+            if gitConfig("git-p4.syncAfterSubmit") == "false":
+                return True
+
             sync = P4Sync()
             sync.run([])
 
-- 
1.7.1
