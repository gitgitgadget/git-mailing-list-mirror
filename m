From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t9113-*.sh: provide user feedback when test skipped
Date: Wed, 09 Jul 2008 00:18:26 +0100
Message-ID: <4873F5C2.2030605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdgD-0004eO-I5
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYGIRlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbYGIRlK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:41:10 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:62603 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864AbYGIRlI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 13:41:08 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1KGdf9-00027T-Oq; Wed, 09 Jul 2008 17:41:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87901>


Currently this test simply exits without providing any
feedback at all.  Tell user if the test is being skipped
and provide a hint as to how the test may be enabled.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9113-git-svn-dcommit-new-file.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 31c929b..8da8ce5 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -7,12 +7,18 @@
 # I don't like the idea of taking a port and possibly leaving a
 # daemon running on a users system if the test fails.
 # Not all git users will need to interact with SVN.
-test -z "$SVNSERVE_PORT" && exit 0
 
 test_description='git-svn dcommit new files over svn:// test'
 
 . ./lib-git-svn.sh
 
+if test -z "$SVNSERVE_PORT"
+then
+	say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
+	test_done
+	exit
+fi
+
 start_svnserve () {
 	svnserve --listen-port $SVNSERVE_PORT \
 	         --root "$rawsvnrepo" \
-- 
1.5.6
