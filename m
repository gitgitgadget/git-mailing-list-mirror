From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: show detached HEAD if --all is specified
Date: Tue,  9 Sep 2014 10:29:16 +0300
Message-ID: <1410247756-10879-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 09:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRFsF-00023q-EH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 09:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbaIIH34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 03:29:56 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:57410
	"EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754035AbaIIH3z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2014 03:29:55 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-07.prod.phx3.secureserver.net with 
	id ovVk1o00S3gsSd601vVsAp; Tue, 09 Sep 2014 00:29:55 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256687>

If HEAD is detached, 'gitk --all' does not show it. This is inconvenient
for frontend program, and for example git log does show the detached HEAD.

gitk uses git rev-parse to find a list of branches to show.
Apparently, the command does not include detached HEAD to output if
--all argument is specified. This has been discussed in [1] and stated
as expected behavior. So rev-parse's parameters should be tuned in gitk.

[1] http://thread.gmane.org/gmane.comp.version-control.git/255996

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk b/gitk
index c8df35d..a5d98bf 100755
--- a/gitk
+++ b/gitk
@@ -294,6 +294,8 @@ proc parseviewrevs {view revs} {
 
     if {$revs eq {}} {
 	set revs HEAD
+    } elseif {[lsearch -exact $revs --all] >= 0} {
+	lappend revs HEAD
     }
     if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
 	# we get stdout followed by stderr in $err
-- 
2.0.1.1697.g73c6810
